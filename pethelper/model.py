from os.path import normpath, join
from turbogears import config
import random
import clips
import sqlite3
import jsonpickle 

import pprint
import xml.dom.minidom
from xml.dom.minidom import Node
import StringIO

class QuestionGroup:
	def __init__(self):
		self.qg_no = 0
		self.desc = "Personal questions"
		self.q_list = []
		self.pet_list = []

class Question:
	def __init__(self):
		self.q = {}
		self.img = ""
		self.q_no = 0
		self.a = {}
		self.sel_multi_a = []
		self.check_yes = 0

class Pet:
	def __init__(self):
		self.pet_name = ""
		self.score = 0
		self.breed_list = []

class Breed:
	def __init__(self):
		self.pet_name = ""
		self.breed_name = ""
		self.breed_key = ""
		self.score = 0

class ChartPlot:
	def __init__(self):
		self.label = ""
		self.data = []


class PetHelper():

	def __init__(self):
		self.init_all_questions()
		self.init_questions()
		self.init_CLIPS()
		self.top_pet_list = []
		qg = self.full_qg_list[0]
		self.qg_list = []
		self.qg_list.append(qg)

	def reformat_chart(self):
		chartplot_bypet = {}
		qg_no = 0
		for qg in self.qg_list:
			qg_no = qg_no + 1
			for pet_detail in qg.pet_list:
					pet_name = pet_detail.pet_name
					pet = ChartPlot()
					if pet_name in chartplot_bypet:
						pet = chartplot_bypet[pet_name]
					pet.label = pet_name
					pet_score = pet_detail.score 
					pet.data.append( [qg_no, pet_score] )
					chartplot_bypet[pet_name] = pet
		chartplot_list = []
		for chartplot_key, chartplot_value in chartplot_bypet.iteritems():
			chartplot_list.append(chartplot_value)
		chartplot = jsonpickle.encode(chartplot_list)
		print "ChartPlot : " + chartplot
		return chartplot

	def set_score(self, cur_qg_no):
		pet_list= self.exe_CLIPS()
		self.qg_list[cur_qg_no-1].pet_list= pet_list

	#method to retrieve question from clip engine
	def get_q_pet(self, cur_qg_no):
		qg = self.full_qg_list[cur_qg_no]
		self.qg_list.append(qg)
	
	def get_top_pets(self, top_no):
		pet_list = self.qg_list[-1].pet_list
		pet_list_sorted = sorted(pet_list, key=lambda pets: pets.score, reverse=True)
		pet_list_sorted = pet_list_sorted[:top_no]
		for pet in pet_list_sorted:
			self.top_pet_list.append(pet.pet_name)
		print "Pet list :" + str(self.top_pet_list)
		pet_list_str = ','.join(self.top_pet_list)
		return pet_list_str

	def get_top_breeds(self, top_no):
		pet_list = self.qg_list[-1].pet_list
		pet_list_sorted = sorted(pet_list, key=lambda pets: pets.score, reverse=True)
		pet_list_sorted = pet_list_sorted[0]
		top_breed_list = []
		for breed in pet_list_sorted.breed_list:
			top_breed_list.append(breed.breed_key)
		breed_list_str = ','.join(top_breed_list)
		return breed_list_str

	def pet_list_sorted(self, qg_no):
		pet_list_sorted = []
		if len(self.qg_list) > 1:
			temp_pet_list_score = self.qg_list[qg_no-1].pet_list
			pet_list_sorted = sorted(temp_pet_list_score, key=lambda pets: pets.score, reverse=True)
		return pet_list_sorted

	def init_CLIPS(self):
		"""init CLIPS rules and facts"""
		static_dir = config.get('static_filter.dir', path="/static")
		CLIPS_FILENAME = join(normpath(static_dir), "pethelper.clp")
		DOG_CLIPS_FILENAME = join(normpath(static_dir), "dogbreed.clp")
		RABBIT_CLIPS_FILENAME = join(normpath(static_dir), "rabbitbreed.clp")
		FISH_CLIPS_FILENAME = join(normpath(static_dir), "fishbreed.clp")
		BIRD_CLIPS_FILENAME = join(normpath(static_dir), "birdbreed.clp")
		clips.Clear()
		clips.BatchStar(CLIPS_FILENAME)
		clips.BatchStar(DOG_CLIPS_FILENAME)
		clips.BatchStar(RABBIT_CLIPS_FILENAME)
		clips.BatchStar(FISH_CLIPS_FILENAME)
		clips.BatchStar(BIRD_CLIPS_FILENAME)
		clips.Reset()

	def restart(self):
		del self.top_pet_list[:]
		del self.full_qg_list[:]
		del self.qg_list[:]
		self.__init__()

	def exe_CLIPS(self):
		qg = self.qg_list[-1]
		assert_stmt = ""
		for q in qg.q_list:
			assert_stmt = "("
			for q_key, q_value in q.q.iteritems():
				assert_stmt =  assert_stmt + q_key
			for answer in q.sel_multi_a :
				assert_stmt = assert_stmt + " " + answer
			assert_stmt = assert_stmt + ")"
			if len(q.sel_multi_a) > 0:
				print "Asserted -----------" , assert_stmt
				clips.Assert(assert_stmt)
		clips.Run()
		pet_list= []
		pet_list_score = clips.Eval("(find-all-facts ((?f Pet-Owner)) TRUE)")
		for pet in pet_list_score:
			temp_pet = Pet()
			temp_pet.pet_name = str(pet.Slots["PetName"])
			temp_pet.score = pet.Slots["cf"]
			temp_pet.score = round(temp_pet.score,2) * 100

			#identify the score of each breed of pet
			breed_list= []
			try:
				breed_list_score = []
				if temp_pet.pet_name == "Bird":
					breed_list_score = clips.Eval("(get-bird-list)")
				else:
					breed_list_score = clips.Eval("(find-all-facts ((?f " + temp_pet.pet_name+"Breed)) TRUE)")
				for breed in breed_list_score:
					temp_breed = Breed()
					temp_breed.pet_name = temp_pet.pet_name
					temp_breed.breed_key = str(breed.Slots["BreedName"])
					temp_breed.breed_name = self.ALL_BREEDS[temp_breed.breed_key]
					temp_breed.score = breed.Slots["cf"]
					temp_breed.score = round(temp_breed.score,2) * 100
					breed_list.append(temp_breed)
			except:
				print "No breeds found for the pet yet"
			breed_list_sorted = sorted(breed_list, key=lambda breeds: breeds.score, reverse=True)
			breed_list_sorted = breed_list_sorted[:3]
			temp_pet.breed_list = breed_list_sorted
			pet_list.append(temp_pet)

		return pet_list

	# (Next-Question-Bird (QuestionKey q1))
	# (Next-Question-Bird (QuestionKey q2))
	def get_q_breed(self):
		is_next_question = False 
		if len(self.top_pet_list) > 0:
			try:
				fact_str = ""
				fact_str = "(find-all-facts ((?f Next-Question-"+self.top_pet_list[0]+")) TRUE)"
				print "Fact String = " + fact_str
				results = clips.Eval(fact_str)
				if len(results) > 0:
					q_key_list = []
					for result in results:
						q_key = str(result.Slots["QuestionKey"])
						q_key_list.append(q_key)
					desc = self.top_pet_list[0] + " - breed selection"
					qg = self.get_questions(desc, q_key_list) 
					qg.qg_no = len(self.qg_list) + 1
					self.qg_list.append(qg)
					is_next_question = True
				else:
					is_next_question = False
					del self.top_pet_list[0]
					is_next_question = self.get_q_breed()
			except:
				print "Exception in finding Next-Question"
				is_next_question = False 
				del self.top_pet_list[0]
				is_next_question = self.get_q_breed()
		return is_next_question

	def init_questions(self):
		self.full_qg_list = []

		#group1 questions
		desc = "Lets begin"
		q_key_list = [ "preference" ]
		qg = self.get_questions(desc, q_key_list) 
		qg.qg_no = len(self.full_qg_list) + 1
		self.full_qg_list.append(qg)

		#group2 questions
		desc = "About yourself"
		q_key_list = ["time", "patience" , "children", "cost"]
		qg = self.get_questions(desc, q_key_list) 
		qg.qg_no = len(self.full_qg_list) + 1
		self.full_qg_list.append(qg)

		#qroup3 questions
		desc = "About your pet?"
		q_key_list = ["size", "nature" , "veg"]
		qg = self.get_questions(desc, q_key_list) 
		qg.qg_no = len(self.full_qg_list) + 1
		self.full_qg_list.append(qg)

		#qroup4 questions
		desc = "About your home environment"
		q_key_list = ["home", "landscaping" , "otherpets"]
		qg = self.get_questions(desc, q_key_list) 
		qg.qg_no = len(self.full_qg_list) + 1
		self.full_qg_list.append(qg)

	def get_questions(self, qg_desc, q_key_list):
		#group1 questions
		qg = QuestionGroup()
		qg.desc = qg_desc
		for q_key in q_key_list:
			q = self.ALL_QUESTIONS[q_key]
			q.q_no = len(qg.q_list) + 1
			qg.q_list.append(q)
		return qg

	def init_all_questions(self):
		static_dir = config.get('static_filter.dir', path="/static")
		XML_FILENAME = join(normpath(static_dir), "pethelper.xml")
		doc = xml.dom.minidom.parse(XML_FILENAME)

		self.ALL_QUESTIONS = {}
		self.ALL_PETS = {}
		self.ALL_BREEDS = {}

		for question in doc.getElementsByTagName("q"):
			q_key = question.getAttribute("q_key")
			q_value = question.getAttribute("q_value")
			q_check_yes = question.getAttribute("check_yes")
			q = Question()
			if len(q_check_yes) > 0:
				q.check_yes = int(q_check_yes)
			q.q = { q_key : q_value }
			q.a = []
			answers = question.getElementsByTagName("a")
			for answer in answers:
				a_key = answer.getAttribute("a_key")
				a_value = answer.getAttribute("a_value")
				q.a.append( { a_key : a_value } )
			
			self.ALL_QUESTIONS[q_key] = q

		for pet in doc.getElementsByTagName("pet"):
			pet_key = pet.getAttribute("pet_key")
			pet_value = pet.getAttribute("pet_value")
			self.ALL_PETS[pet_key] = pet_value

		for breed in doc.getElementsByTagName("breed"):
			breed_key = breed.getAttribute("breed_key")
			breed_value = breed.getAttribute("breed_value")
			self.ALL_BREEDS[breed_key] = breed_value

class PetDetails:
	"""details about the pet"""
	def __init__(self):
		self.petrank = 0
 		self.pettype = ""
		self.petbreed = ""
		self.petfeatures = []
		self.petimage = ""
		self.aboutpet = StringIO.StringIO()
		self.pethouse = StringIO.StringIO()
		self.pettrain = StringIO.StringIO()
		self.petfood = StringIO.StringIO()
		self.petgroom = StringIO.StringIO()
		self.petbuy = StringIO.StringIO()
		self.petproc = StringIO.StringIO()
		self.petothers = StringIO.StringIO()
		self.petlink = ""
		self.petkey = ""


class SummaryData:
	def details(self, pets):
		pd = PetDetails()
		pd.petkey = pets
		static_dir = config.get('static_filter.dir', path="/static")
		SQLITE_FILENAME = join(normpath(static_dir), "petdatabase.db")
		
		sql_ft = "select features from pet_features where key = '" + pets + "' "
		sql_det = "select animal, breed, image, about, link, housing, training, food, grooming, buy, procedure, others from pet_details where key = '" + pets + "' "

		con = sqlite3.connect(SQLITE_FILENAME)
		con.row_factory = sqlite3.Row
		cur = con.cursor()
		features = []
		format_string = "<pkml> {0} </pkml>"
		try:
			cur.execute(sql_ft)
			for row in cur:
				temp_features = row['features']
				features.append(temp_features)
			cur.execute(sql_det)
			for row in cur:
				pd.pettype = row['animal']
				pd.petbreed = row['breed']
				pd.petfeatures = features
				pd.aboutpet.write(format_string.format(row['about']))
				pd.petimage = row['image']
				pd.pethouse.write(format_string.format(row['housing']))
				pd.pettrain.write(format_string.format(row['training']))
				pd.petfood.write(format_string.format(row['food']))
				pd.petgroom.write(format_string.format(row['grooming']))
				pd.petbuy.write(format_string.format(row['buy']))
				pd.petproc.write(format_string.format(row['procedure']))
				pd.petothers.write(format_string.format(row['others']))
				pd.petlink = row['link']
		except Exception, msg:
			print msg
		finally:
			con.close()
		return pd

	def suggest(self, pets):
		suggest_list = []
		pet_list = pets.split(',')
		for pet_key in pet_list:
			pet_details = self.details(pet_key)
			print "About pet : " + pet_details.aboutpet.getvalue()
			suggest_list.append(pet_details)
		return suggest_list
