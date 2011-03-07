# -*- coding: utf-8 -*-
"""This module contains the controller classes of the application."""

# symbols which are imported by "from pethelper.controllers import *"
__all__ = ['Root']

# standard library imports
# import logging
import datetime
from turbogears import redirect
import HTMLParser as html
import StringIO


# third-party imports
from turbogears import controllers, expose, flash
import httplib
from pethelper import model 
from model import PetHelper
from model import SummaryData 
import sqlite3

# project specific imports
# from pethelper import model
# from pethelper import json
import cherrypy
# log = logging.getLogger("pethelper.controllers")


class Root(controllers.RootController):
	"""The root controller of the application."""

	global PHASE_1_Q, PHASE_2_Q
	PHASE_1_Q = 4
	PHASE_2_Q = 4

	def __init__(self):
		self.session_list = {}

	@expose(template="pethelper.templates.welcome")
	def index(self):
		pethelper = self.getcur_pethelper()
		pethelper.restart()
		return dict()

	@expose(template="pethelper.templates.pethelper")
	def pethelper(self, preview=0, over=0, qg_no=0):
		""""Show the welcome page."""

		session_id = cherrypy.session.get('_id')

		preview = int(preview)
		qg_no = int(qg_no)
		over = int(over)

		pethelper = self.getcur_pethelper()
		qg_list = pethelper.qg_list
		qg = qg_list[-1]
		cur_qg_no = len(qg_list)
		if over == 0:
			pet_list_sorted = pethelper.pet_list_sorted(cur_qg_no - 1)
		else:
			pet_list_sorted = pethelper.pet_list_sorted(cur_qg_no)

		if preview == 1:
			qg = qg_list[qg_no-1]
			cur_qg_no = qg_no
		chartplot = pethelper.reformat_chart()
		return dict(PHASE_1_Q = PHASE_1_Q, qg=qg, pet_list_sorted = pet_list_sorted ,cur_qg_no=cur_qg_no, preview=preview, chartplot = chartplot)

	@expose(template="pethelper.templates.phase1_summary")
	def phase1_summary(self, pets=""):
		pet_list = pets.split(',')		
		pethelper = self.getcur_pethelper()
		chartplot = pethelper.reformat_chart()
		pet_list_sorted = pethelper.pet_list_sorted(PHASE_1_Q)
		return dict(pet_list=pet_list,PHASE_1_Q = PHASE_1_Q,  chartplot = chartplot, pet_list_sorted = pet_list_sorted)

	@expose()
	def next(self, qg_no=0, cur_qg_no=0, action="preview", cont=0, over=0):

		cur_qg_no = int(cur_qg_no) 
		cont = int(cont)
		token = ""
		pethelper = self.getcur_pethelper()
		retURL = "/pethelper"
		if action == "next":
			pethelper.set_score(cur_qg_no)
			if cur_qg_no == PHASE_1_Q:
				pet_list_str = pethelper.get_top_pets(2)
				retURL = "/phase1_summary?pets=" + pet_list_str

			is_next_question = True
			if cur_qg_no < PHASE_1_Q:
				pethelper.get_q_pet(cur_qg_no)
			else:
				is_next_question = pethelper.get_q_breed()

			if not is_next_question:
				breed_list_str = pethelper.get_top_breeds(2)
				retURL = "/suggest?pets=" + breed_list_str 
		elif action == "restart":
			pethelper.restart()
		elif action == "preview":
			token = "?preview=1&qg_no=" + str(qg_no) + "&over="+ str(over)
			

		redirect(retURL + token)

	@expose(template="pethelper.templates.about")
	def about(self):
		""""Show the about page."""
		return dict()

	@expose(format="json")
	def single_answer(self, sel_a=None, q_no=None, qg_no=None):
		q_no = int(q_no)
		qg_no = int(qg_no)
		print "Sel answer qg_no: " + str(qg_no) + ", q_no: " +  str(q_no) + ", sel_a: " + sel_a
		pethelper = self.getcur_pethelper()
		pethelper.qg_list[qg_no-1].q_list[q_no-1].sel_multi_a = [sel_a]
		return dict() 

	@expose(format="json")
	def multi_answer(self, sel_a=None, q_no=None, qg_no=None):
		q_no = int(q_no)
		qg_no = int(qg_no)
		print "Sel answer qg_no: " + str(qg_no) + ", q_no: " +  str(q_no) + ", sel_a: " + sel_a
		pethelper = self.getcur_pethelper()
		sel_multi_a = pethelper.qg_list[qg_no-1].q_list[q_no-1].sel_multi_a
		if sel_a in sel_multi_a:
			pass
		else:
			sel_multi_a.append(sel_a)
		return dict() 

	@expose(format="json")
	def deselect_answer(self, sel_a=None, q_no=None, qg_no=None):
		q_no = int(q_no)
		qg_no = int(qg_no)
		pethelper = self.getcur_pethelper()
		pethelper.qg_list[qg_no-1].q_list[q_no-1].sel_multi_a.remove(sel_a)

	def getcur_pethelper(self):
		pethelper = None
		session_id = str(cherrypy.session.get('_id'))
		if session_id in self.session_list:
			print "retrieving sessionID : " + session_id 
			pethelper = self.session_list[session_id]
		else:
			print "adding sessionID : " + session_id 
			pethelper = PetHelper()
			self.session_list[session_id] = pethelper 
		return pethelper

	@expose(template="pethelper.templates.suggest")
	def suggest(self, pets="rabbit_calif,rabbit_chinchilla,rabbit_nd_dwarf"):
		pethelper = self.getcur_pethelper()
		summary = SummaryData()
		suggest_list = summary.suggest(pets)
		chartplot = pethelper.reformat_chart()
		pet_list_sorted = pethelper.pet_list_sorted(len(pethelper.qg_list))
		return dict(over=1, suggest_list=suggest_list, PHASE_1_Q = PHASE_1_Q, chartplot = chartplot, pet_list_sorted = pet_list_sorted)

	@expose(template="pethelper.templates.details")
	def details(self,pets=""):
		"""retrieves the list with all scores details"""
		pethelper = self.getcur_pethelper()
		summary = SummaryData()
		details = summary.details(pets)
		chartplot = pethelper.reformat_chart()
		pet_list_sorted = pethelper.pet_list_sorted(len(pethelper.qg_list))
		return dict(over=1, details=details, PHASE_1_Q = PHASE_1_Q, chartplot = chartplot, pet_list_sorted = pet_list_sorted)

