;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFTEMPLATE;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; Final Output Template for Rabbit Breeds
(deftemplate RabbitBreed
	(slot BreedName)
	(slot cf)
)

(deftemplate WorkingRabbitBreed
	(slot BreedName)
	(slot cf)
)

(deftemplate RabbitAllowedBreeds
	(multislot Name)
)
(deftemplate Next-Question-Rabbit
	(slot QuestionKey)
)

(deffunction RabbitAssignCFForBreed
	(?breeds ?cf)
	(foreach ?val ?breeds
		(assert (WorkingRabbitBreed (BreedName ?val)(cf ?cf)))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFINING RULES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)
;; Here,,, cf(cf1,cf2) = (cf1 + cf2)/2

(defrule combine-positive-cf-Rabbit
 	?f1 <- (RabbitBreed (BreedName ?pet1)(cf ?cf1))
	?f2 <- (WorkingRabbitBreed (BreedName ?pet2)(cf ?cf2))
	(test (eq ?pet1 ?pet2))
	=>
	(retract ?f2)
	(modify ?f1 (cf =(/ (+ ?cf2 ?cf1) 2)))
	;(modify ?f1 (cf =(+ ?cf2 ?cf1)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on Cost;;;;;;;;;;;;;;;
(defrule RabbitBreedCostCF
	(RabbitAllowedBreeds (Name $?d))
	(cost ?c)
	=>
	(if (eq ?c Concerned)
		then 
			(bind ?selectedBreedsOne (create$ rabbit_calif rabbit_nd_dwarf rabbit_dwarf_lop rabbit_std_rex rabbit_himalayan rabbit_giant_angora rabbit_satin_angora))
			(bind ?selectedBreedsTwo (create$ rabbit_chinchilla))
			(bind ?selectedBreedsThree (create$ rabbit_fl_giant rabbit_havana))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.2)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.5)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1.0)
	)
	(if (eq ?c Reasonable)
		then
			(bind ?selectedBreedsOne (create$ rabbit_fl_giant rabbit_havana))
			(bind ?selectedBreedsTwo (create$ rabbit_giant_angora rabbit_calif))
			(bind ?selectedBreedsThree (create$ rabbit_chinchilla rabbit_nd_dwarf rabbit_dwarf_lop rabbit_std_rex rabbit_himalayan rabbit_satin_angora))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.1)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.5)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1.0)
	)
	(if  (eq ?c NotConcerned)
	    	then
			(RabbitAssignCFForBreed ?d 1.0)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on home;;;;;;;;;;;;;;;
(defrule RabbitBreedHomeCF
	(RabbitAllowedBreeds (Name $?d))
	(home ?h)
	=>
	(if (eq ?h  HDB )
		then 
			(bind ?selectedBreedsOne (create$ rabbit_fl_giant))
			(bind ?selectedBreedsTwo (create$ rabbit_chinchilla rabbit_dwarf_lop))
			(bind ?selectedBreedsThree (create$ rabbit_havana rabbit_std_rex rabbit_himalayan rabbit_giant_angora rabbit_satin_angora))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.0)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.2)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1.0)
	)
	(if (eq ?h Individual)
		then
			(bind ?selectedBreedsOne (create$ rabbit_fl_giant))
			(bind ?selectedBreedsTwo (create$ rabbit_dwarf_lop))
			(bind ?selectedBreedsThree (create$ rabbit_calif rabbit_chinchilla rabbit_nd_dwarf rabbit_havana rabbit_std_rex rabbit_himalayan rabbit_giant_angora  rabbit_satin_angora ))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.8)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1.0)
	)
		
	(if  (eq ?h , Bungalow)
	    	then
			(RabbitAssignCFForBreed ?d 1.0)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on grooming;;;;;;;;;;;;;;;
(defrule RabbitBreedGroomCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_grooming ?g)
	=>
	(if (eq ?g  yes )
		then 
			(bind ?selectedBreedsOne (create$ rabbit_calif rabbit_dwarf_lop rabbit_giant_angora rabbit_satin_angora ))
			(bind ?selectedBreedsTwo (create$ rabbit_havana rabbit_std_rex rabbit_himalayan))
			(bind ?selectedBreedsThree (create$ rabbit_chinchilla rabbit_nd_dwarf rabbit_fl_giant))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.2)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.8)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1.0)
	)
	(if (eq ?g no)
		then
			(RabbitAssignCFForBreed ?d 1.0)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on fur coat;;;;;;;;;;;;;;;
(defrule RabbitBreedFurCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_fur ?f)
	=>
	(if (eq ?f normal)
		then 
			(bind ?selectedBreeds (create$ rabbit_calif rabbit_chinchilla rabbit_himalayan))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?f fancy)
		then 
			(bind ?selectedBreeds (create$ rabbit_nd_dwarf rabbit_dwarf_lop rabbit_fl_giant))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?f satin)
		then 
			(bind ?selectedBreeds (create$ rabbit_havana rabbit_satin_angora))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?f rex)
		then 
			(bind ?selectedBreeds (create$ rabbit_std_rex rabbit_giant_angora ))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on size;;;;;;;;;;;;;;;
(defrule RabbitBreedSizeCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_size ?s)
	=>
	(if (eq ?s small)
		then 
			(bind ?selectedBreeds (create$ rabbit_nd_dwarf rabbit_havana rabbit_himalayan))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?s medium)
		then 
			(bind ?selectedBreeds (create$ rabbit_calif rabbit_dwarf_lop rabbit_std_rex rabbit_satin_angora ))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?s large)
		then 
			(bind ?selectedBreeds (create$ rabbit_chinchilla rabbit_fl_giant rabbit_giant_angora ))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on purpose;;;;;;;;;;;;;;;
(defrule RabbitBreedPurposeCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_purpose ?p)
	=>
	(if (eq ?p  shows )
		then 
			(bind ?selectedBreedsOne (create$ rabbit_calif ))
			(bind ?selectedBreedsTwo (create$ rabbit_chinchilla rabbit_nd_dwarf rabbit_himalayan))
			(bind ?selectedBreedsThree (create$ rabbit_dwarf_lop rabbit_fl_giant rabbit_havana rabbit_std_rex))
			(bind ?selectedBreedsFour (create$ rabbit_giant_angora rabbit_satin_angora ))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.1)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.2)
			(RabbitAssignCFForBreed ?selectedBreedsThree  0.8)
			(RabbitAssignCFForBreed ?selectedBreedsFour  0.9)

	)
	(if (eq ?p love)
		then
			(bind ?selectedBreedsOne (create$ rabbit_giant_angora rabbit_satin_angora ))
			(bind ?selectedBreedsTwo (create$ rabbit_dwarf_lop rabbit_fl_giant rabbit_havana rabbit_std_rex))
			(bind ?selectedBreedsThree (create$ rabbit_calif rabbit_nd_dwarf rabbit_himalayan))
			(bind ?selectedBreedsFour (create$ rabbit_chinchilla))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.1)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.2)
			(RabbitAssignCFForBreed ?selectedBreedsThree  0.8)
			(RabbitAssignCFForBreed ?selectedBreedsFour  0.9)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on region;;;;;;;;;;;;;;;
(defrule RabbitBreedRegionCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_region ?r)
	=>
	(if (eq ?r american)
		then 
			(bind ?selectedBreeds (create$ rabbit_calif rabbit_chinchilla))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?r european)
		then 
			(bind ?selectedBreeds (create$ rabbit_nd_dwarf rabbit_dwarf_lop rabbit_fl_giant rabbit_havana rabbit_std_rex rabbit_himalayan rabbit_giant_angora rabbit_satin_angora))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?r nopreference)
		then
			(RabbitAssignCFForBreed ?d 1.0)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on breed type;;;;;;;;;;;;;;;
(defrule RabbitBreedTypeCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_breedtype ?b)
	=>
	(if (eq ?b pure)
		then 
			(bind ?selectedBreeds (create$ rabbit_chinchilla rabbit_dwarf_lop rabbit_std_rex rabbit_giant_angora))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	(if (eq ?b mixed)
		then 
			(bind ?selectedBreeds (create$ rabbit_calif rabbit_nd_dwarf rabbit_fl_giant rabbit_havana rabbit_himalayan rabbit_satin_angora))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Defrule for Rabbit Breed CF based on climate;;;;;;;;;;;;;;;
(defrule RabbitBreedClimateCF
	(RabbitAllowedBreeds (Name $?d))
	(rabbit_climate ?c)
	=>
	(if (eq ?c cold)
		then
			(RabbitAssignCFForBreed ?d 1.0)
	)
	(if (eq ?c hot)
		then
			(bind ?selectedBreedsOne (create$ rabbit_himalayan))
			(bind ?selectedBreedsTwo (create$ rabbit_giant_angora rabbit_satin_angora))
			(bind ?selectedBreedsThree (create$ rabbit_calif rabbit_chinchilla rabbit_nd_dwarf rabbit_dwarf_lop rabbit_fl_giant rabbit_havana rabbit_std_rex))
			(RabbitAssignCFForBreed ?selectedBreedsOne 0.0)
			(RabbitAssignCFForBreed ?selectedBreedsTwo 0.3)
			(RabbitAssignCFForBreed ?selectedBreedsThree  1)
	)
	(if (eq ?c extreme)
		then 
			(bind ?selectedBreeds (create$ rabbit_calif))
			(foreach ?value ?d
				(if (not (member$ ?value ?selectedBreeds))
					then (RabbitAssignCFForBreed (create$ ?value) 0.0)
				)
			)
			(RabbitAssignCFForBreed ?selectedBreeds 1.0)
	)
	
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE TO RETRACT 4 QUESTION AND INSERT NEXT 3 QUESTIONS;;;;;;
(defrule RabbitInsertQuestionRule1
	(rabbit_grooming ?grm)
	(rabbit_fur ?fur)
	(rabbit_size ?size)
	(rabbit_purpose ?pur)
	?a <- (Next-Question-Rabbit (QuestionKey rabbit_grooming))
	?b <- (Next-Question-Rabbit (QuestionKey rabbit_fur))
	?c <- (Next-Question-Rabbit (QuestionKey rabbit_size))
	?d <- (Next-Question-Rabbit (QuestionKey rabbit_purpose))
	=>
	(retract ?a ?b ?c ?d)
	(assert (Next-Question-Rabbit (QuestionKey rabbit_region)))
	(assert (Next-Question-Rabbit (QuestionKey rabbit_breedtype)))
	(assert (Next-Question-Rabbit (QuestionKey rabbit_climate)))
	
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE TO RETARCT ALL QUESTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule RabbitRetractAllQuestions
	(rabbit_region ?reg)
	(rabbit_breedtype ?typ)
	(rabbit_climate ?cli)
	?a <- (Next-Question-Rabbit (QuestionKey rabbit_region))
	?b <- (Next-Question-Rabbit (QuestionKey rabbit_breedtype))
	?c <- (Next-Question-Rabbit (QuestionKey rabbit_climate))
	=>
	(retract ?a ?b ?c)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFFACTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deffacts RabbitSample
		;;;;;;;;;;;;;;;;; FROM PETS ;;;;;;;;;;;;;;
				
	;(cost NotConcerned)		        ;; Possible Values - Concerned , Reasonable, NotConcerned
	;;(home Individual)			;; Possible Values - HDB, Individual, Bungalow


		;;;;;;;;;;;;;;;;;RABBIT SPECIFIC ;;;;;;;;;;;;
	;;(rabbit_grooming yes)			;; Possible Values - yes,no 
	;;(rabbit_fur normal)			;; Possible Values - normal, satin, rex, fancy
	;;(rabbit_size small)			;; Possible Values - small, medium, large
	;;(rabbit_purpose shows)			;; Possible Values - shows, love
	;;(rabbit_region american)		;; Possible Values - american, european, nopreference
	;;(rabbit_breedtype pure)			;; Possible Values - pure , mixed
	;;(rabbit_climate cold)			;; Possible Values - cold , hot, extreme

	
	(RabbitAllowedBreeds (Name 
				rabbit_calif
				rabbit_chinchilla
				rabbit_nd_dwarf
				rabbit_dwarf_lop
				rabbit_fl_giant
				rabbit_havana
				rabbit_std_rex
				rabbit_himalayan
				rabbit_giant_angora 
				rabbit_satin_angora 
			)
	)
	(RabbitBreed (BreedName rabbit_calif)(cf 0.0))
	(RabbitBreed (BreedName rabbit_chinchilla)(cf 0.0))
	(RabbitBreed (BreedName rabbit_nd_dwarf)(cf 0.0))
	(RabbitBreed (BreedName rabbit_dwarf_lop)(cf 0.0))
	(RabbitBreed (BreedName rabbit_fl_giant)(cf 0.0))
	(RabbitBreed (BreedName rabbit_havana)(cf 0.0))
	(RabbitBreed (BreedName rabbit_std_rex)(cf 0.0))
	(RabbitBreed (BreedName rabbit_himalayan)(cf 0.0))
	(RabbitBreed (BreedName rabbit_giant_angora )(cf 0.0))
	(RabbitBreed (BreedName rabbit_satin_angora )(cf 0.0))
	
	(Next-Question-Rabbit (QuestionKey rabbit_grooming))
	(Next-Question-Rabbit (QuestionKey rabbit_fur))
	(Next-Question-Rabbit (QuestionKey rabbit_size))
	(Next-Question-Rabbit (QuestionKey rabbit_purpose))
	
)	
