;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PET-OWNER DEFTEMPLATE;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; The Output template for Phase - 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; The answers will be of the form (Pet-Owner (Cat  0.7)) 
(deftemplate Pet-Owner
	(slot PetName)(slot cf)
)

(deftemplate Working-Pet-Owner
	(slot PetName)(slot cf)
)

(deftemplate AllowedPets
	(multislot names)
)

(deffunction CheckPreferences 
	(?all ?pre)
	(bind ?ret FALSE)
	(foreach ?val ?pre
		(if (eq ?val ?all)
			then (bind ?ret TRUE)
		)
	)
	(return ?ret)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFINING RULES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)
;; Here,,, cf(cf1,cf2) = (cf1 + cf2)/2

(defrule combine-positive-cf
 	?f1 <- (Pet-Owner (PetName ?pet1)(cf ?cf1))
	?f2 <- (Working-Pet-Owner (PetName ?pet2)(cf ?cf2))
	(test (eq ?pet1 ?pet2))
	=>
	(retract ?f2)
	(modify ?f1 (cf =(/ (+ ?cf2 ?cf1) 2)))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR PREFERENCES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule PreferencesRule
	(AllowedPets (names $?ns))
	(preference $?p)
	(test (neq ?p No))
	=>
	(foreach ?allowed ?ns
		(bind ?returnResult(CheckPreferences ?allowed ?p))
		(if (eq ?returnResult TRUE)
			then (assert (Pet-Owner (PetName ?allowed)(cf 1.0)))
		)
		(if (eq ?returnResult FALSE)
			then (assert (Pet-Owner (PetName ?allowed)(cf 0.0)))
		)
	)	
)

(defrule NoPreferencesRule
	(preference $?p)
	(test (eq ?p No))
	=>
	(assert (Pet-Owner (PetName Dog)(cf 0.0)))
	(assert (Pet-Owner (PetName Fish)(cf 0.0)))
	(assert (Pet-Owner (PetName Bird)(cf 0.0)))
	(assert (Pet-Owner (PetName Rabbit)(cf 0.0)))			
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR TIME COMMITMENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule TimeCommitmentCFAssign
	(time ?t)
	=>
	(if (eq ?t High)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.3)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
	(if (eq ?t Medium)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.8)))				
	)
	(if (eq ?t Low)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.2)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.0)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR TIME COMMITMENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule PatienceCFAssign
	(patience ?t)
	=>
	(if (eq ?t Yes)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
	(if (eq ?t No)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.2)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR PATIENCE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule ChildrenCFAssign
	(children ?c)
	=>
	(if (eq ?c Yes)
		then 	(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.3)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.1)))		
	)
	(if (eq ?c No)
		then 	(assert (Working-Pet-Owner (PetName Dog)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.9)))		
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR COST CONCERNED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule CostCFAssign
	(cost ?e)
	=>
	(if (eq ?e Concerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.5)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.5)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.2)))				
	)
	(if (eq ?e Reasonable)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.7)))				
	)
	(if (eq ?e NotConcerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR SIZE CONCERNED;;;;;;;;;;;;;;;;;;;;;
(defrule SizeCFAssign
	(size ?s)
	=>
	(if (eq ?s Small)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.6)))				
	)
	(if (eq ?s Medium)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.3)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.9)))				
	)
	(if (eq ?s Large)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.2)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.2)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR NATURE OF PET;;;;;;;;;;;;;;;;;;;;;
(defrule NatureOfPetCFAssign
	(nature ?n)
	=>
	(if (eq ?n Energetic)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.4)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.7)))				
	)
	(if (eq ?n Quiet)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.5)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.9)))				
	)
	(if (eq ?n NotConcerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR VEGETARIAN;;;;;;;;;;;;;;;;;;;;;
(defrule VegetarianCFAssign
	(veg ?v)
	=>
	(if (eq ?v Yes)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
	(if (eq ?v NotConcerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR LANDSCAPING CONCERNS;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule HOMECFAssign
	(home ?h)
	=>
	(if (eq ?h HDB)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.9)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.4)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.4)))				
	)
	(if (eq ?h Individual)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.9)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.9)))				
	)
	(if (eq ?h Bungalow)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.9)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR LANDSCAPING CONCERNS;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule LandScapingCFAssign
	(landscaping ?l)
	=>
	(if (eq ?l NT)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.3)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.8)))				
	)
	(if (eq ?l OA)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.6)))				
	)
	(if (eq ?l NotConcerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR OTHER PETS;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule OtherPetsCFAssign
	(otherpets ?a)
	=>
	(if (eq ?a YesAquarium)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
	(if (eq ?a YesBirds)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.7)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.8)))				
	)
	(if (eq ?a YesBig)
			then
				(assert (Working-Pet-Owner (PetName Dog)(cf 0.8)))
				(assert (Working-Pet-Owner (PetName Fish)(cf 0.5)))
				(assert (Working-Pet-Owner (PetName Bird)(cf 0.6)))
				(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.2)))				
	)
	(if (eq ?a No)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR COMMITMENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule ActivityLevelCFAssign
	(activity ?a)
	=>
	(if (eq ?a DND)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.2)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.4)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.4)))				
	)
	(if (eq ?a Playful)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.2)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 0.8)))				
	)
	(if (eq ?a NotConcerned)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.8)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULE FOR ELDERLY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ElderlyCFAssign
	(elderly ?e)
	=>
	(if (eq ?e Yes)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 0.1)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 0.6)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
	(if (eq ?e No)
		then
			(assert (Working-Pet-Owner (PetName Dog)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Fish)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Bird)(cf 1.0)))
			(assert (Working-Pet-Owner (PetName Rabbit)(cf 1.0)))				
	)
)
(deffacts FactsSample
	(AllowedPets (names Dog Fish Bird Rabbit))
)

