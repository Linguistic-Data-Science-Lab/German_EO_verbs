# German_EO_verbs

This repository contains a set of annotations on German sentences containing an experiencer-object (EO) verb as well as scripts and materials for publications that relate to them. EO verbs are psychological predicates whose Experiencer argument is mapped onto the object. They are claimed to be syntactically special in the literature. All annotations were performed as part of our project [The grammar of Experiencer-Object verbs: theoretical, computational and experimental approaches towards reflexive binding in German](https://ldsl.rub.de/research/projects/stm-subj) (supported by a DFG grant (KI 759/9-1)).

## annotations
This folder contains the annotations: one CSV file per verb, encoding: utf-8, separator: ;
Data points go by rows, annotations by columns. The columns:
* NZZ_ID: Unique identifier of sentence
* Token_ID: position of verb in sentence
* not_of_interest: X or empty, should data point be excluded?
* non-psych: X or empty, does the verb have a psych reading in this sentence?
* X-STM_V_Y-EXP -- tough: X or empty, syntactic pattern
* Stimulus_type: character string or empty, type of stimulus
* Stimulus_PP: character string or empty, form of eventual stimulus PP
* Control: X or empty, is the verb embedded under a control predicate?
* Other_stimulus_adjunct: X or empty, is there another kind of stimulus indicating adjunct?
* Comment: string or empty, obligatory comments
* Misc: X or empty, comments by annotator
* Misc2: X or empty, comments by adjudicator

## Quasy_2021
Materials for (Poppek, Masloch, Robrecht & Kiss, 2021): A Quantitative Approach towards German Experiencer-Object Verbs
