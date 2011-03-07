

;; Pet BIRD CLIPS Program

;; ORIGINAL CLIPS Program

;; Global variables

; Threshold CF 
(defglobal ?*threshold-cf* = 0.0)

;; Templates


(deftemplate bird
	(slot BreedName)
	(slot BreedDisplayName)

	(slot time-and-attention
		(type SYMBOL)
		(allowed-symbols na lot significant independent)
		(default na))
	(slot appearance
		(type SYMBOL)
		(allowed-symbols na attractive-colourful cute-no-so-colourful normal-plain no-pref)
		(default na))
	(slot weight
		(type SYMBOL)
		(allowed-symbols na light-weight medium-weight heavy-weight)
		(default na))
	(slot voice-level
		(type SYMBOL)
		(allowed-symbols na loud mild quiet)
		(default na))
		
	(slot flying-ability
		(type SYMBOL)
		(allowed-symbols na long-fly short-fly no-fly)
		(default na))
	(multislot special-features
		(type SYMBOL)
		(allowed-symbols na talk mimic dance tricks)
		(default na))
	(slot longevity
		(type SYMBOL)
		(allowed-symbols na short-life med-life long-life very-long-life)
		(default na))
	(slot harmness
		(type SYMBOL)
		(allowed-symbols na harm-less harm-medium harm-high)
		(default na))
	(slot social-life
		(type SYMBOL)
		(allowed-symbols na single pair small-group large-group)
		(default na))
	(slot interaction
		(type SYMBOL)
		(allowed-symbols na high moderate low)
		(default na))
		
	(slot attachment
		(type SYMBOL)
		(allowed-symbols na very-quick reasonably-quick slow very-slow)
		(default na))
	(slot caging
		(type SYMBOL)
		(allowed-symbols na move-freely move-restricted move-prohibit)
		(default na))
	(slot availability
		(type SYMBOL)
		(allowed-symbols na limited common local import no-pref)
		(default na))
	(slot popularity
		(type SYMBOL)
		(allowed-symbols na very-popular known-to-pet-lovers less-known no-pref)
		(default na))

	(slot time-and-attention-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot appearance-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot weight-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot voice-level-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	
	(slot flying-ability-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot special-features-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot longevity-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot harmness-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot social-life-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	
	(slot interaction-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot attachment-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot caging-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot availability-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
	(slot popularity-flag
		(type SYMBOL)
		(allowed-symbols yes no)
		(default no))
		
	(slot is-recommended
		(type SYMBOL)
		(allowed-symbols na yes no)
		(default na))
	(slot cf
		(type FLOAT)
		(default 0.0))	;; All birds are recommended with the same recommendation level by default
)

(deftemplate userprefbird
	(slot BreedName)
	(slot BreedDisplayName)
	
	(slot time-allocation
		(type SYMBOL)
		(allowed-symbols na plenty as-necessary very-less)
		(default na))
	(slot appearance
		(type SYMBOL)
		(allowed-symbols na attractive-colourful cute-no-so-colourful normal-plain no-pref)
		(default na))
	(slot weight
		(type SYMBOL)
		(allowed-symbols na light-weight medium-weight heavy-weight)
		(default na))
	(slot voice-level
		(type SYMBOL)
		(allowed-symbols na loud mild quiet)
		(default na))
		
	(slot flying-ability
		(type SYMBOL)
		(allowed-symbols na long-fly short-fly no-fly)
		(default na))
	(multislot special-features
		(type SYMBOL)
		(allowed-symbols na talk mimic dance tricks no-pref)
		(default na))
	(slot longevity
		(type SYMBOL)
		(allowed-symbols na harm-less harm-medium harm-high)
		(default na))
	(slot harmness
		(type SYMBOL)
		(allowed-symbols na single pair small-group large-group)
		(default na))
	(slot social-life
		(type SYMBOL)
		(allowed-symbols na high moderate low)
		(default na))
		
	(slot interaction
		(type SYMBOL)
		(allowed-symbols na very-quick reasonably-quick slow very-slow)
		(default na))
	(slot attachment
		(type SYMBOL)
		(allowed-symbols na move-freely move-restricted move-prohibit)
		(default na))
	(slot caging
		(type SYMBOL)
		(allowed-symbols na lot significant independent)
		(default na))
	(slot availability
		(type SYMBOL)
		(allowed-symbols na limited common local import no-pref)
		(default na))
	(slot popularity
		(type SYMBOL)
		(allowed-symbols na very-popular known-to-pet-lovers less-known no-pref)
		(default na))
)


;; NOTE::: FROM PET - Phase-1 Starts
;; NOT REQUIRED in Real Time

;(deftemplate Pet-Owner
;	(slot PetName)(slot cf)
;)

;; End of phase-1
;(deffacts phase-1-response-list 
;	(Pet-Owner (PetName Dog)(cf 0.3))	;; some dummy CF
;	(Pet-Owner (PetName Fish)(cf 0.7))
;	(Pet-Owner (PetName Bird)(cf 0.9))
;	(Pet-Owner (PetName Rabbit)(cf 0.5))
;	
;	(cost NotConcerned)
;)

;; NOTE::: FROM PET - Phase-1 Ends

(deftemplate bird-user-entry
	(slot factor-key
		(type SYMBOL)
		(allowed-values time-allocation appearance weight voice-level
			flying-ability special-features longevity harmness social-life
			interaction attachment caging availability popularity))
	(slot factor-value
		(type SYMBOL)
		(allowed-symbols 
			plenty as-necessary very-less
			attractive-colourful cute-no-so-colourful normal-plain no-pref
			light-weight medium-weight heavy-weight 
			loud mild quiet ;no-pref
			long-fly short-fly no-fly
			talk mimic dance tricks
			short-life med-life long-life very-long-life
			harm-less harm-medium harm-high
			single pair small-group large-group
			high moderate low
			very-quick reasonably-quick slow very-slow
			move-freely move-restricted move-prohibit
			limited common local import ;no-pref
			very-popular known-to-pet-lovers less-known ;no-pref
		))
	(multislot factor-values
		(type SYMBOL)
		(allowed-symbols talk mimic dance tricks no-pref))
)

(deftemplate bird-recom-by-factor
	(slot factor-key
		(type SYMBOL)
		(allowed-values time-and-attention appearance weight voice-level
			flying-ability special-features longevity harmness social-life
			interaction attachment caging availability popularity))
	(slot factor-value
		(type SYMBOL)
		(allowed-symbols 
			plenty as-necessary very-less
			attractive-colourful cute-no-so-colourful normal-plain no-pref
			light-weight medium-weight heavy-weight 
			loud mild quiet ;no-pref
			long-fly short-fly no-fly
			talk mimic dance tricks
			short-life med-life long-life very-long-life
			harm-less harm-medium harm-high
			single pair small-group large-group
			high moderate low
			very-quick reasonably-quick slow very-slow
			move-freely move-restricted move-prohibit
			limited common local import ;no-pref
			very-popular known-to-pet-lovers less-known ;no-pref
		))
	(slot bird-recomm-cf)
)

(deffacts bird-recom-by-availability-list
	(bird-recom-by-factor (factor-key availability) (factor-value limited) (bird-recomm-cf 0.3))
	(bird-recom-by-factor (factor-key availability) (factor-value common) (bird-recomm-cf 0.5))
	(bird-recom-by-factor (factor-key availability) (factor-value local) (bird-recomm-cf 0.6))
	(bird-recom-by-factor (factor-key availability) (factor-value import) (bird-recomm-cf 0.4))
)

(deffacts bird-recom-by-popularity-list
	(bird-recom-by-factor (factor-key popularity) (factor-value very-popular) (bird-recomm-cf 0.6))
	(bird-recom-by-factor (factor-key popularity) (factor-value known-to-pet-lovers) (bird-recomm-cf 0.4))
	(bird-recom-by-factor (factor-key popularity) (factor-value less-known) (bird-recomm-cf 0.3))
)

;; template to hold the new CF values (arising from new rule firings)

(deftemplate recommendation (slot recommendedbird) (slot cf))

;; Define default facts

(deffacts the-birds-list 
	;;(bird (BreedName "BIRD-01") (BreedDisplayName "BIRD A")(voice-level loud) (availability limited) (popularity known-to-pet-lovers) (time-and-attention lot) (special-features talk mimic))
	;;(bird (BreedName "BIRD-02") (BreedDisplayName "BIRD B")(voice-level mild) (availability import) (popularity less-known) (time-and-attention significant) (special-features na))
	;;(bird (BreedName "BIRD-03") (BreedDisplayName "BIRD C")(voice-level quiet) (availability na) (popularity na) (time-and-attention independent)(special-features dance tricks))

	(bird (BreedName "BIRD-01") (BreedDisplayName "Cockatiels") (time-and-attention lot) (appearance normal-plain) (weight light-weight) (voice-level mild) (flying-ability long-fly) (special-features talk tricks) (longevity med-life) (harmness harm-less) (social-life pair) (interaction high) (attachment very-quick) (caging move-freely) (availability common) (popularity very-popular))
	(bird (BreedName "BIRD-02") (BreedDisplayName "Umbrella Cockatoos") (time-and-attention lot) (appearance normal-plain) (weight medium-weight) (voice-level quiet) (flying-ability short-fly) (special-features dance) (longevity med-life) (harmness harm-less) (social-life pair) (interaction high) (attachment reasonably-quick) (caging move-restricted) (availability common) (popularity very-popular))
	(bird (BreedName "BIRD-03") (BreedDisplayName "Galah Cockatoos") (time-and-attention independent) (appearance cute-no-so-colourful) (weight light-weight) (voice-level quiet) (flying-ability short-fly) (special-features talk tricks) (longevity med-life) (harmness harm-less) (social-life pair) (interaction moderate) (attachment reasonably-quick) (caging move-restricted) (availability common) (popularity very-popular))
	(bird (BreedName "BIRD-04") (BreedDisplayName "Goffin's Cockatoos ") (time-and-attention independent) (appearance normal-plain) (weight light-weight) (voice-level loud) (flying-ability short-fly) (special-features mimic) (longevity short-life) (harmness harm-less) (social-life single) (interaction high) (attachment very-quick) (caging move-freely) (availability limited) (popularity known-to-pet-lovers))
	(bird (BreedName "BIRD-05") (BreedDisplayName "Palm Cockatoos") (time-and-attention significant) (appearance normal-plain) (weight medium-weight) (voice-level quiet) (flying-ability short-fly) (special-features na) (longevity med-life) (harmness harm-less) (social-life single) (interaction moderate) (attachment reasonably-quick) (caging move-restricted) (availability limited) (popularity known-to-pet-lovers))
	(bird (BreedName "BIRD-06") (BreedDisplayName "Moluccan Cockatoos ") (time-and-attention significant) (appearance cute-no-so-colourful) (weight medium-weight) (voice-level mild) (flying-ability short-fly) (special-features talk tricks) (longevity med-life) (harmness harm-less) (social-life single) (interaction moderate) (attachment very-quick) (caging move-freely) (availability import) (popularity less-known))
	(bird (BreedName "BIRD-07") (BreedDisplayName "Little Corellas") (time-and-attention lot) (appearance normal-plain) (weight light-weight) (voice-level mild) (flying-ability short-fly) (special-features talk tricks dance) (longevity med-life) (harmness harm-less) (social-life pair) (interaction high) (attachment very-quick) (caging move-freely) (availability local) (popularity less-known))
	(bird (BreedName "BIRD-08") (BreedDisplayName "Sulphur-crested Cockatoos") (time-and-attention significant) (appearance normal-plain) (weight light-weight) (voice-level mild) (flying-ability short-fly) (special-features talk tricks) (longevity med-life) (harmness harm-less) (social-life single) (interaction low) (attachment very-slow) (caging move-restricted) (availability local) (popularity very-popular))
	(bird (BreedName "BIRD-11") (BreedDisplayName "Blue-and-yellow Macaw / Blue-and-gold Macaw") (time-and-attention independent) (appearance attractive-colourful) (weight heavy-weight) (voice-level loud) (flying-ability short-fly) (special-features talk) (longevity very-long-life) (harmness harm-medium) (social-life single) (interaction moderate) (attachment reasonably-quick) (caging move-prohibit) (availability common) (popularity very-popular))
	(bird (BreedName "BIRD-12") (BreedDisplayName "Alexandrine Parakeet ") (time-and-attention independent) (appearance attractive-colourful) (weight light-weight) (voice-level loud) (flying-ability long-fly) (special-features mimic) (longevity long-life) (harmness harm-medium) (social-life small-group) (interaction low) (attachment slow) (caging move-freely) (availability limited) (popularity known-to-pet-lovers))
	(bird (BreedName "BIRD-13") (BreedDisplayName "Malabar Parakeet / Blue Winged Parakeets") (time-and-attention significant) (appearance attractive-colourful) (weight medium-weight) (voice-level loud) (flying-ability long-fly) (special-features talk) (longevity long-life) (harmness harm-medium) (social-life small-group) (interaction low) (attachment slow) (caging move-restricted) (availability import) (popularity very-popular))
	(bird (BreedName "BIRD-14") (BreedDisplayName "Superb Parrot") (time-and-attention significant) (appearance attractive-colourful) (weight light-weight) (voice-level loud) (flying-ability long-fly) (special-features talk) (longevity long-life) (harmness harm-medium) (social-life small-group) (interaction high) (attachment very-quick) (caging move-freely) (availability import) (popularity very-popular))
)

(deftemplate Next-Question-Bird
	(slot QuestionKey)
	(slot grp-no)
)

;; CF - related facts - mappings

(deftemplate cf-map
	(slot owner-factor-key
		(type SYMBOL)
		(allowed-values time-allocation appearance weight voice-level
			flying-ability special-features longevity harmness social-life
			interaction attachment caging availability popularity))
	(slot pet-factor-key
		(type SYMBOL)
		(allowed-values time-and-attention appearance weight voice-level
			flying-ability special-features longevity harmness social-life
			interaction attachment caging availability popularity))
	(slot owner-factor-value
		(type SYMBOL)
		(allowed-symbols 
			plenty as-necessary very-less
			attractive-colourful cute-no-so-colourful normal-plain no-pref
			light-weight medium-weight heavy-weight 
			loud mild quiet ;no-pref
			long-fly short-fly no-fly
			talk mimic dance tricks
			short-life med-life long-life very-long-life
			harm-less harm-medium harm-high
			single pair small-group large-group
			high moderate low
			very-quick reasonably-quick slow very-slow
			move-freely move-restricted move-prohibit
			limited common local import ;no-pref
			very-popular known-to-pet-lovers less-known ;no-pref
		))
	(slot pet-factor-value
		(type SYMBOL)
		(allowed-symbols 
			lot significant independent
			attractive-colourful cute-no-so-colourful normal-plain no-pref
			light-weight medium-weight heavy-weight 
			loud mild quiet ;no-pref
			long-fly short-fly no-fly
			talk mimic dance tricks
			short-life med-life long-life very-long-life
			harm-less harm-medium harm-high
			single pair small-group large-group
			high moderate low
			very-quick reasonably-quick slow very-slow
			move-freely move-restricted move-prohibit
			limited common local import ;no-pref
			very-popular known-to-pet-lovers less-known ;no-pref
		))
	(slot map-cf
		(type FLOAT)
		(default 0.0))
)

;; Function to determine the CF (expert's view) for Client's Time Allocation and Bird's time-and-attention requirement

(deffacts facts-time-mapping-cf-map
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value plenty) (pet-factor-value lot) (map-cf 0.7))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value plenty) (pet-factor-value significant) (map-cf 0.3))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value plenty) (pet-factor-value independent) (map-cf -0.1))

	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value as-necessary) (pet-factor-value lot) (map-cf -0.3))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value as-necessary) (pet-factor-value significant) (map-cf 0.7))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value as-necessary) (pet-factor-value independent) (map-cf 0.1))
	
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value very-less) (pet-factor-value lot) (map-cf -0.6))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value very-less) (pet-factor-value significant) (map-cf -0.2))
	(cf-map (owner-factor-key time-allocation) (pet-factor-key time-and-attention) (owner-factor-value very-less) (pet-factor-value independent) (map-cf 0.6))
)

(deffacts facts-appearance-cf-map
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value attractive-colourful) (pet-factor-value attractive-colourful) (map-cf 0.6))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value attractive-colourful) (pet-factor-value cute-no-so-colourful) (map-cf 0.2))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value attractive-colourful) (pet-factor-value normal-plain) (map-cf -0.2))

	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value cute-no-so-colourful) (pet-factor-value attractive-colourful) (map-cf 0.2))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value cute-no-so-colourful) (pet-factor-value cute-no-so-colourful) (map-cf 0.5))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value cute-no-so-colourful) (pet-factor-value normal-plain) (map-cf -0.1))
	
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value normal-plain) (pet-factor-value attractive-colourful) (map-cf -0.3))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value normal-plain) (pet-factor-value cute-no-so-colourful) (map-cf -0.1))
	(cf-map (owner-factor-key appearance) (pet-factor-key appearance) (owner-factor-value normal-plain) (pet-factor-value normal-plain) (map-cf 0.3))
)

(deffacts facts-weight-cf-map
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value light-weight) (pet-factor-value light-weight) (map-cf 0.4))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value light-weight) (pet-factor-value medium-weight) (map-cf 0.1))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value light-weight) (pet-factor-value heavy-weight) (map-cf -0.3))

	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value medium-weight) (pet-factor-value light-weight) (map-cf 0.1))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value medium-weight) (pet-factor-value medium-weight) (map-cf 0.4))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value medium-weight) (pet-factor-value heavy-weight) (map-cf -0.2))
	
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value heavy-weight) (pet-factor-value light-weight) (map-cf -0.3))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value heavy-weight) (pet-factor-value medium-weight) (map-cf -0.1))
	(cf-map (owner-factor-key weight) (pet-factor-key weight) (owner-factor-value heavy-weight) (pet-factor-value heavy-weight) (map-cf 0.4))
)

(deffacts facts-voice-level-cf-map
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value loud) (pet-factor-value loud) (map-cf 0.6))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value loud) (pet-factor-value mild) (map-cf 0.3))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value loud) (pet-factor-value quiet) (map-cf -0.2))

	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value mild) (pet-factor-value loud) (map-cf -0.2))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value mild) (pet-factor-value mild) (map-cf 0.4))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value mild) (pet-factor-value quiet) (map-cf -0.1))
	
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value quiet) (pet-factor-value loud) (map-cf -0.4))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value quiet) (pet-factor-value mild) (map-cf -0.1))
	(cf-map (owner-factor-key voice-level) (pet-factor-key voice-level) (owner-factor-value quiet) (pet-factor-value quiet) (map-cf 0.4))
)


(deffacts facts-flying-ability-cf-map
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value long-fly) (pet-factor-value long-fly) (map-cf 0.4))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value long-fly) (pet-factor-value short-fly) (map-cf 0.1))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value long-fly) (pet-factor-value no-fly) (map-cf -0.4))

	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value short-fly) (pet-factor-value long-fly) (map-cf -0.1))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value short-fly) (pet-factor-value short-fly) (map-cf 0.4))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value short-fly) (pet-factor-value no-fly) (map-cf -0.1))
	
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value no-fly) (pet-factor-value long-fly) (map-cf -0.4))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value no-fly) (pet-factor-value short-fly) (map-cf -0.1))
	(cf-map (owner-factor-key flying-ability) (pet-factor-key flying-ability) (owner-factor-value no-fly) (pet-factor-value no-fly) (map-cf 0.3))
)

(deffacts facts-longevity-cf-map
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value short-life) (pet-factor-value short-life) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value short-life) (pet-factor-value med-life) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value short-life) (pet-factor-value long-life) (map-cf -0.2))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value short-life) (pet-factor-value very-long-life) (map-cf -0.4))

	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value med-life) (pet-factor-value short-life) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value med-life) (pet-factor-value med-life) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value med-life) (pet-factor-value long-life) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value med-life) (pet-factor-value very-long-life) (map-cf -0.3))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value long-life) (pet-factor-value short-life) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value long-life) (pet-factor-value med-life) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value long-life) (pet-factor-value long-life) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value long-life) (pet-factor-value very-long-life) (map-cf 0.1))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-long-life) (pet-factor-value short-life) (map-cf -0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-long-life) (pet-factor-value med-life) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-long-life) (pet-factor-value long-life) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-long-life) (pet-factor-value very-long-life) (map-cf 0.4))	
)

(deffacts facts-harmness-cf-map
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-less) (pet-factor-value harm-less) (map-cf 0.4))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-less) (pet-factor-value harm-medium) (map-cf 0.1))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-less) (pet-factor-value harm-high) (map-cf -0.4))

	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-medium) (pet-factor-value harm-less) (map-cf -0.3))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-medium) (pet-factor-value harm-medium) (map-cf 0.4))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-medium) (pet-factor-value harm-high) (map-cf -0.1))
	
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-high) (pet-factor-value harm-less) (map-cf 0.2))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-high) (pet-factor-value harm-medium) (map-cf 0.3))
	(cf-map (owner-factor-key harmness) (pet-factor-key harmness) (owner-factor-value harm-high) (pet-factor-value harm-high) (map-cf 0.4))
)

(deffacts facts-social-life-cf-map
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value single) (pet-factor-value single) (map-cf 0.5))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value single) (pet-factor-value pair) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value single) (pet-factor-value small-group) (map-cf -0.2))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value single) (pet-factor-value large-group) (map-cf -0.4))

	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value pair) (pet-factor-value single) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value pair) (pet-factor-value pair) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value pair) (pet-factor-value small-group) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value pair) (pet-factor-value large-group) (map-cf -0.3))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value small-group) (pet-factor-value single) (map-cf -0.3))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value small-group) (pet-factor-value pair) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value small-group) (pet-factor-value small-group) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value small-group) (pet-factor-value large-group) (map-cf 0.1))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value large-group) (pet-factor-value single) (map-cf -0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value large-group) (pet-factor-value pair) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value large-group) (pet-factor-value small-group) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value large-group) (pet-factor-value large-group) (map-cf 0.4))	
)



(deffacts facts-interaction-cf-map
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value high) (pet-factor-value high) (map-cf 0.5))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value high) (pet-factor-value moderate) (map-cf 0.1))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value high) (pet-factor-value low) (map-cf -0.3))

	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value moderate) (pet-factor-value high) (map-cf 0.1))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value moderate) (pet-factor-value moderate) (map-cf 0.4))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value moderate) (pet-factor-value low) (map-cf -0.1))
	
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value low) (pet-factor-value high) (map-cf -0.4))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value low) (pet-factor-value moderate) (map-cf -0.1))
	(cf-map (owner-factor-key interaction) (pet-factor-key interaction) (owner-factor-value low) (pet-factor-value low) (map-cf 0.3))
)

(deffacts facts-attachment-cf-map
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-quick) (pet-factor-value very-quick) (map-cf 0.5))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-quick) (pet-factor-value reasonably-quick) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-quick) (pet-factor-value slow) (map-cf -0.2))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-quick) (pet-factor-value very-slow) (map-cf -0.4))

	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value reasonably-quick) (pet-factor-value very-quick) (map-cf 0.3))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value reasonably-quick) (pet-factor-value reasonably-quick) (map-cf 0.5))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value reasonably-quick) (pet-factor-value slow) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value reasonably-quick) (pet-factor-value very-slow) (map-cf -0.3))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value slow) (pet-factor-value very-quick) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value slow) (pet-factor-value reasonably-quick) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value slow) (pet-factor-value slow) (map-cf 0.4))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value slow) (pet-factor-value very-slow) (map-cf 0.1))
	
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-slow) (pet-factor-value very-quick) (map-cf -0.3))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-slow) (pet-factor-value reasonably-quick) (map-cf -0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-slow) (pet-factor-value slow) (map-cf 0.1))
	(cf-map (owner-factor-key longevity) (pet-factor-key longevity) (owner-factor-value very-slow) (pet-factor-value very-slow) (map-cf 0.3))	
)

(deffacts facts-caging-cf-map
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-freely) (pet-factor-value move-freely) (map-cf 0.4))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-freely) (pet-factor-value move-restricted) (map-cf -0.1))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-freely) (pet-factor-value move-prohibit) (map-cf -0.3))

	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-restricted) (pet-factor-value move-freely) (map-cf -0.1))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-restricted) (pet-factor-value move-restricted) (map-cf 0.3))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-restricted) (pet-factor-value move-prohibit) (map-cf 0.1))
	
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-prohibit) (pet-factor-value move-freely) (map-cf -0.4))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-prohibit) (pet-factor-value move-restricted) (map-cf 0.1))
	(cf-map (owner-factor-key caging) (pet-factor-key caging) (owner-factor-value move-prohibit) (pet-factor-value move-prohibit) (map-cf 0.3))
)

;; CF - related functions

;; More Functions

(deffunction check-special-features
	(?all ?pre)
	(bind ?ret FALSE)
	(foreach ?val ?pre
		(if (eq ?val ?all)
			then (bind ?ret TRUE)
		)
	)
	(return ?ret)
)

;; Sort birds based on their Recommended CF
;; Sort bird facts based on the input values - Overall recommended CF here

(deffunction bird-sort (?w1 ?w2)
	(< (fact-slot-value ?w1 cf)
	(fact-slot-value ?w2 cf)))


;; Get the sorted list of bird facts

;; Get only those birds meeting the threshold CF for bird recommedation
(deffunction get-bird-list ()
	(bind ?facts (find-all-facts ((?f bird))
		;;(and (eq ?f:is-recommended yes)	;; Select only recommended yes birds
		(and (or (eq ?f:is-recommended yes) (eq ?f:is-recommended na))	;; Select All birds where recommended is not NO
			(>= ?f:cf ?*threshold-cf*))))
	(sort bird-sort ?facts))

;; Bird Selecter Rules

;; Basic CF Rules

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine POSITIVE certainty factors for multiple conclusions
;cf(cf1,cf2) = cf1 + cf2 * (1- cf1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule bird-combine-positive-cf
	(declare (salience 9998))
	?birdx <- (bird (BreedName ?BreedName) (BreedDisplayName ?birdname) (is-recommended na|yes) (cf ?birdcf&:(>= ?birdcf 0.0)))
	?recommendationx <- (recommendation (recommendedbird ?BreedName) (cf ?newcf&:(>= ?newcf 0.0)))
=>
	(printout t "combine CF both positive" crlf)
	(retract ?recommendationx)
	(modify ?birdx (cf =(+ ?birdcf (* ?newcf (- 1 ?birdcf))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine NEGATIVE cf
;cf(cf1,cf2) = cf1 + cf2 * (1 + cf1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule bird-combine-neg-cf
	(declare (salience 9997))
	?birdx <- (bird (BreedName ?BreedName) (BreedDisplayName ?birdname) (is-recommended na|yes) (cf ?birdcf&:(<= ?birdcf 0.0)))
	?recommendationx <- (recommendation (recommendedbird ?BreedName) (cf ?newcf&:(<= ?newcf 0.0)))
=>
	(printout t "combine CF both negative" crlf)
	(retract ?recommendationx)
	(modify ?birdx (cf =(+ ?birdcf (* ?newcf (+ 1 ?birdcf))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;combine one POSITIVE and one NEGATIVE
;cf(cf1,cf2) = (cf1 + cf2) / 1 - MIN[abs(cf1),abs(cf2)]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule bird-neg-pos-cf
	(declare (salience 9996))
	?birdx <- (bird (BreedName ?BreedName) (BreedDisplayName ?birdname) (is-recommended na|yes) (cf ?birdcf))
	?recommendationx <- (recommendation (recommendedbird ?BreedName) (cf ?newcf))
	(test (< (* ?birdcf ?newcf) 0))
=>
	(printout t "combine CF one positive and one negative" crlf)
	(retract ?recommendationx)
	(modify ?birdx (cf =(/ (+ ?birdcf ?newcf) (- 1 (min (abs ?birdcf) (abs ?newcf)))))))


;; Generic CF Map trigger




; Initial Rule - Welcome the Pet Bird Lover!!!

(defrule welcome_rule
	(declare (salience 10000))
	(initial-fact)
=>
	(printout t "Welcome to Pet Bird Selecter !!!" crlf)
)

;; Interaction with Client


;;======================================
;;Group-1 - basics / physical features
;;======================================

;; Time-allocation and Time-and-attention Rules

; Q-BG1-01
; Ask Client for Self-assessed Time Allocation capacity

(defrule client-time-allocation-ask
	(declare (salience 6900))
	(not(bird-user-entry (factor-key time-allocation) (factor-value ?val)))
	(not(Next-Question-Bird (QuestionKey Q-BG1-01)))
=>
	(printout t "How much time you can dedicate to take care of your pet bird?? ...[plenty as-necessary very-less]" crlf)
	;(bind ?time-ans (read))
	;(assert (bird-user-entry (factor-key time-allocation) (factor-value ?time-ans)))
	(assert (Next-Question-Bird (QuestionKey Q-BG1-01) (grp-no 1)))
)

(defrule client-time-allocation-ans
	(declare (salience 6900))
	(not(bird-user-entry (factor-key time-allocation) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG1-01))
	(Q-BG1-01 ?ans)
=>
	(assert (bird-user-entry (factor-key time-allocation) (factor-value ?ans)))
	(retract ?q)
)

(defrule client-time-allocation-cf-assign
	(declare (salience 6901))
	?bird-user-entry-x <- (bird-user-entry (factor-key time-allocation) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (time-and-attention ?bird-factor-val&~na) (time-and-attention-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (time-and-attention-flag yes))	
)

;;Appearance

;Q-BG1-02
;I would like to own a bird that 

(defrule appearance-ask
	(declare (salience 6900))
	(not(bird-user-entry (factor-key appearance) (factor-value ?val)))
	(not(Next-Question-Bird (QuestionKey Q-BG1-02)))
=>
	(printout t "I would like to own a bird that?? ...[attractive-colourful cute-no-so-colourful normal-plain no-pref]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG1-02) (grp-no 1)))
)

(defrule appearance-ans
	(declare (salience 6900))
	(not(bird-user-entry (factor-key appearance) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG1-02))
	(Q-BG1-02 ?ans)
=>
	(assert (bird-user-entry (factor-key appearance) (factor-value ?ans)))
	(retract ?q)
)

(defrule appearance-cf-assign
	(declare (salience 6901))
	?bird-user-entry-x <- (bird-user-entry (factor-key appearance) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (appearance ?bird-factor-val&~na) (appearance-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (appearance-flag yes))	
)


;;Weight
;Q-BG1-03
;I would like to  

(defrule weight-ask
	(declare (salience 6900))
	(not(bird-user-entry (factor-key weight) (factor-value ?val)))
	(not(Next-Question-Bird (QuestionKey Q-BG1-03)))
=>
	(printout t "I would like to?? ...[light-weight medium-weight heavy-weight]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG1-03) (grp-no 1)))
)

(defrule weight-ans
	(declare (salience 6900))
	(not(bird-user-entry (factor-key weight) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG1-03))
	(Q-BG1-03 ?ans)
=>
	(assert (bird-user-entry (factor-key weight) (factor-value ?ans)))
	(retract ?q)
)

(defrule weight-cf-assign
	(declare (salience 6901))
	?bird-user-entry-x <- (bird-user-entry (factor-key weight) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (weight ?bird-factor-val&~na) (weight-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (weight-flag yes))	
)


;;Voice
;Q-BG1-04
;I would like to own a bird that 

(defrule voice-level-ask
	(declare (salience 6900))
	(not(bird-user-entry (factor-key voice-level) (factor-value ?val)))
	(not(Next-Question-Bird (QuestionKey Q-BG1-04)))
=>
	(printout t "I would like to own a bird that?? ...[loud mild quiet no-pref]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG1-04) (grp-no 1)))
)

(defrule voice-level-ans
	(declare (salience 6900))
	(not(bird-user-entry (factor-key voice-level) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG1-04))
	(Q-BG1-04 ?ans)
=>
	(assert (bird-user-entry (factor-key voice-level) (factor-value ?ans)))
	(retract ?q)
)

(defrule voice-level-cf-assign
	(declare (salience 6901))
	?bird-user-entry-x <- (bird-user-entry (factor-key voice-level) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (voice-level ?bird-factor-val&~na) (voice-level-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (voice-level-flag yes))	
)

;=============================
;Group - 2 - bird's Abilities
;=============================

;Flying ability

;Q-BG2-01
;The bird is

(defrule flying-ability-ask
	(declare (salience 5900))
	(not(bird-user-entry (factor-key flying-ability) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird (QuestionKey Q-BG2-01)))
=>
	(printout t "The bird is?? ...[long-fly short-fly no-fly]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG2-01) (grp-no 2)))
)

(defrule flying-ability-ans
	(declare (salience 5900))
	(not(bird-user-entry (factor-key flying-ability) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG2-01))
	(Q-BG2-01 ?ans)
=>
	(assert (bird-user-entry (factor-key flying-ability) (factor-value ?ans)))
	(retract ?q)
)

(defrule flying-ability-cf-assign
	(declare (salience 5901))
	?bird-user-entry-x <- (bird-user-entry (factor-key flying-ability) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (flying-ability ?bird-factor-val&~na) (flying-ability-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (flying-ability-flag yes))	
)

;Special Features
;Q-BG2-02
;I prefer a bird that is able to / capable of learning to (Check Boxes)

(defrule special-features-ask
	(declare (salience 5900))
	(not(bird-user-entry (factor-key special-features) (factor-values ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird (QuestionKey Q-BG2-02)))
=>
	(printout t "I prefer a bird that is able to / capable of learning to (Check Boxes)?? ...[talk mimic dance tricks no-pref]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG2-02) (grp-no 2)))
)

(defrule special-features-ans
	(declare (salience 5900))
	(not(bird-user-entry (factor-key special-features) (factor-values ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG2-02))
	(Q-BG2-02 ?ans)
=>
	(assert (bird-user-entry (factor-key special-features) (factor-values ?ans)))
	(retract ?q)
)

(defrule special-features-Rule
	(declare (salience 5901))
	(bird-user-entry (factor-key special-features) (factor-values $?p))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (special-features $?bird-factor-vals) (special-features-flag no) (is-recommended na|yes) (cf ?cf))
	(test (neq ?p no-pref))
	(test (eq 1 2))
	=>
	(foreach ?allowed ?bird-factor-vals
		(bind ?returnResult(check-special-features ?allowed ?p))
		(if (eq ?returnResult TRUE)
			then (assert (recommendation (recommendedbird ?BreedName) (cf 0.2)))
		)
		(if (eq ?returnResult FALSE)
			then (assert (recommendation (recommendedbird ?BreedName) (cf -0.1)))
		)
	)
)

;Longevity
;Q-BG2-03
;I'm looking for a bird

(defrule longevity-ask
	(declare (salience 5900))
	(not(bird-user-entry (factor-key longevity) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird (QuestionKey Q-BG2-03)))
=>
	(printout t "I'm looking for a bird?? ...[short-life med-life long-life very-long-life]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG2-03) (grp-no 2)))
)

(defrule longevity-ans
	(declare (salience 5900))
	(not(bird-user-entry (factor-key longevity) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG2-03))
	(Q-BG2-03 ?ans)
=>
	(assert (bird-user-entry (factor-key longevity) (factor-value ?ans)))
	(retract ?q)
)

(defrule longevity-cf-assign
	(declare (salience 5901))
	?bird-user-entry-x <- (bird-user-entry (factor-key longevity) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (longevity ?bird-factor-val&~na) (longevity-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (longevity-flag yes))	
)


;Can cause Harm?
;Q-BG2-04
;Are you alright, if the bird causes harm to your family members / damages household properties?

(defrule harmness-ask
	(declare (salience 5900))
	(not(bird-user-entry (factor-key harmness) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird (QuestionKey Q-BG2-04)))
=>
	(printout t "Are you alright, if the bird causes harm to your family members / damages household properties??? ...[harm-less harm-medium harm-high]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG2-04) (grp-no 2)))	
)

(defrule harmness-ans
	(declare (salience 5900))
	(not(bird-user-entry (factor-key harmness) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG2-04))
	(Q-BG2-04 ?ans)
=>	
	(assert (bird-user-entry (factor-key harmness) (factor-value ?ans)))
	(retract ?q)
)

(defrule harmness-cf-assign
	(declare (salience 5901))
	?bird-user-entry-x <- (bird-user-entry (factor-key harmness) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (harmness ?bird-factor-val&~na) (harmness-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (harmness-flag yes))	
)


;Ability to live with Alone/Pairs/Groups
;Q-BG2-05
;I prefer to have

(defrule social-life-ask
	(declare (salience 5900))
	(not(bird-user-entry (factor-key social-life) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird (QuestionKey Q-BG2-05)))
=>
	(printout t "I prefer to have?? ...[single pair small-group large-group]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG2-05) (grp-no 2)))
)

(defrule social-life-ans
	(declare (salience 5900))
	(not(bird-user-entry (factor-key social-life) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG2-05))
	(Q-BG2-05 ?ans)
=>
	(assert (bird-user-entry (factor-key social-life) (factor-value ?ans)))
	(retract ?q)	
)

(defrule social-life-cf-assign
	(declare (salience 5901))
	?bird-user-entry-x <- (bird-user-entry (factor-key social-life) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (social-life ?bird-factor-val&~na) (social-life-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (social-life-flag yes))	
)


;=================================
;Group-3 - Owner nature and more
;=================================

;Interaction
;Q-BG3-01
;My bird should support (entertain us)

(defrule interaction-ask
	(declare (salience 4900))
	(not(bird-user-entry (factor-key interaction) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird  (grp-no 2)))
	(not(Next-Question-Bird (QuestionKey Q-BG3-01)))
=>
	(printout t "I prefer to have?? ...[high moderate low]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG3-01) (grp-no 3)))
)

(defrule interaction-ans
	(declare (salience 4900))
	(not(bird-user-entry (factor-key interaction) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG3-01))
	(Q-BG3-01 ?ans)	
=>
	(assert (bird-user-entry (factor-key interaction) (factor-value ?ans)))
	(retract ?q)
)

(defrule interaction-cf-assign
	(declare (salience 4901))
	?bird-user-entry-x <- (bird-user-entry (factor-key interaction) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (interaction ?bird-factor-val&~na) (interaction-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (interaction-flag yes))	
)

;Attachment - Attachment to pet-owners / children
;Q-BG3-02
;The new pet bird must attach with me and my family

(defrule attachment-ask
	(declare (salience 4900))
	(not(bird-user-entry (factor-key attachment) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird  (grp-no 2)))
	(not(Next-Question-Bird (QuestionKey Q-BG3-02)))
=>
	(printout t "The new pet bird must attach with me and my family?? ...[very-quick reasonably-quick slow very-slow]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG3-02) (grp-no 3)))
)

(defrule attachment-ans
	(declare (salience 4900))
	(not(bird-user-entry (factor-key attachment) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG3-02))
	(Q-BG3-02 ?ans)	
=>
	(assert (bird-user-entry (factor-key attachment) (factor-value ?ans)))
	(retract ?q)
)

(defrule attachment-cf-assign
	(declare (salience 4901))
	?bird-user-entry-x <- (bird-user-entry (factor-key attachment) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (attachment ?bird-factor-val&~na) (attachment-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (attachment-flag yes))	
)


;Caging
;Q-BG3-03
;I think that I will

(defrule caging-ask
	(declare (salience 4900))
	(not(bird-user-entry (factor-key caging) (factor-value ?val)))
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird  (grp-no 2)))
	(not(Next-Question-Bird (QuestionKey Q-BG3-03)))
=>
	(printout t "I think that I will?? ...[move-freely move-restricted move-prohibit]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG3-03) (grp-no 3)))
)

(defrule caging-ans	
	(declare (salience 4900))
	(not(bird-user-entry (factor-key caging) (factor-value ?val)))
	?q <- (Next-Question-Bird (QuestionKey Q-BG3-03))
	(Q-BG3-03 ?ans)	
=>
	(assert (bird-user-entry (factor-key caging) (factor-value ?ans)))
	(retract ?q)
)

(defrule caging-cf-assign
	(declare (salience 4901))
	?bird-user-entry-x <- (bird-user-entry (factor-key caging) (factor-value ?owner-factor-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (caging ?bird-factor-val&~na) (caging-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (cf-map (owner-factor-key ?owner-factor-key) (pet-factor-key ?bird-factor-key) (owner-factor-value ?owner-factor-val) (pet-factor-value ?bird-factor-val) (map-cf ?expertviewcf))
=>
	(assert (recommendation (recommendedbird ?BreedName) (cf ?expertviewcf)))
	(modify ?sysbird (caging-flag yes))	
)

;; Availability is displayed only for owners with HIGH spending ability
;; Availability in Market/World

; Q-BG3-04
; I'm looking for a bird with.... (Availability)

(defrule bird-availability-ask
	(declare (salience 1900))
	(not(bird-user-entry (factor-key availability) (factor-value ?val)))
	?pet-costx <- (cost NotConcerned)
	(not(Next-Question-Bird  (grp-no 1)))
	(not(Next-Question-Bird  (grp-no 2)))
	(not(Next-Question-Bird (QuestionKey Q-BG3-04)))
=>
	(printout t "I'm looking for a bird with?? [limited common local import]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG3-04) (grp-no 3)))
)

(defrule bird-availability-ans
	(declare (salience 1900))
	(not(bird-user-entry (factor-key availability) (factor-value ?val)))
	?pet-costx <- (cost NotConcerned)
	?q <- (Next-Question-Bird (QuestionKey Q-BG3-04))
	(Q-BG3-04 ?ans)
=>
	(assert (bird-user-entry (factor-key availability) (factor-value ?ans)))
	(retract ?q)
)

;; Availability based CF Rules

(defrule bird-availability-cf-rule
	(declare (salience 1901))
	?bird-user-entry-x <- (bird-user-entry (factor-key availability) (factor-value ?availability-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (availability ?availability-val) (availability-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (bird-recom-by-factor (factor-key availability) (factor-value ?availability-val) (bird-recomm-cf ?expertviewcf))
	(not (recommendation (recommendedbird ?BreedName) (cf ?newcf)))
=>
	(printout t "Bird Recomm CF for " ?sysbirdname " is " ?expertviewcf crlf)
	;; assert the new recommendation CF for this bird based on the Client's Preference
	;; It is 1.0, because the premise is certain with CF 1.0.
	;; i.e. Client's preference is considered to definitely certain. Sure about his decisions.
	(assert (recommendation (recommendedbird ?BreedName) (cf (* ?expertviewcf 1.0))))
	(modify ?sysbird (availability-flag yes))	
)


;Popularity  - Sought-after, Friendliness, Affectionate and	Dominance
;; Popularity is displayed only for owners with HIGH or MEDIUM spending ability

; Q-BG3-05
; I want to go for a bird that is... (Popularity)

(defrule bird-popularity-ask
	(declare (salience 1900))
	(not(bird-user-entry (factor-key popularity) (factor-value ?val)))
	?pet-costx <- (cost NotConcerned|Reasonable)
	(not(Next-Question-Bird  (grp-no 1|2)))
	(not(Next-Question-Bird (QuestionKey Q-BG3-05)))
=>
	(printout t "I want to go for a bird that is?? [very-popular known-to-pet-lovers less-known no-pref]" crlf)
	(assert (Next-Question-Bird (QuestionKey Q-BG3-05) (grp-no 3)))
)

(defrule bird-popularity-ans
	(declare (salience 1900))
	(not(bird-user-entry (factor-key popularity) (factor-value ?val)))
	?pet-costx <- (cost NotConcerned|Reasonable)
	?q <- (Next-Question-Bird (QuestionKey Q-BG3-05))
	(Q-BG3-05 ?ans)
=>
	(assert (bird-user-entry (factor-key popularity) (factor-value ?ans)))
	(retract ?q)
)

;; Popularity based CF Rules

(defrule bird-popularity-cf-rule
	(declare (salience 1901))
	?bird-user-entry-x <- (bird-user-entry (factor-key popularity) (factor-value ?popularity-val))
	?sysbird <- (bird (BreedName ?BreedName) (BreedDisplayName ?sysbirdname) (popularity ?popularity-val) (popularity-flag no) (is-recommended na|yes) (cf ?cf))
	?expertview <- (bird-recom-by-factor (factor-key popularity) (factor-value ?popularity-val) (bird-recomm-cf ?expertviewcf))
	(not (recommendation (recommendedbird ?BreedName) (cf ?newcf)))
=>
	(printout t "Bird Recomm CF for " ?sysbirdname " is " ?expertviewcf crlf)
	;; assert the new recommendation CF for this bird based on the Client's Preference
	;; It is 1.0, because the premise is certain with CF 1.0.
	;; i.e. Client's preference is considered to definitely certain. Sure about his decisions.
	(assert (recommendation (recommendedbird ?BreedName) (cf (* ?expertviewcf 1.0))))
	(modify ?sysbird (popularity-flag yes))	
)



