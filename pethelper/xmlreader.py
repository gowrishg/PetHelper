import pprint
import xml.dom.minidom
from xml.dom.minidom import Node
from os.path import normpath, join
from turbogears import config
from pethelper import model
from model import Question

static_dir = config.get('static_filter.dir', path="/static")
XML_FILENAME = join(normpath(static_dir), "pethelper_questions.xml")
doc = xml.dom.minidom.parse(XML_FILENAME)

ALL_QUESTIONS = {}

for question in doc.getElementsByTagName("q"):
	q_key = question.getAttribute("q_key")
	q_value = question.getAttribute("q_value")
	q = Question()
	q.q = { q_key : q_value }
	q.a = []
	answers = question.getElementsByTagName("a")
	for answer in answers:
		a_key = answer.getAttribute("a_key")
		a_value = answer.getAttribute("a_value")
		q.a.append( { a_key : a_value } )
	
	ALL_QUESTIONS[q_key] = q
	print '999999999999999999:::', len(ALL_QUESTIONS)

