# German_EO_verbs

This repository contains a set of annotations on German sentences containing an experiencer-object (EO) verb as well as scripts and materials for publications that relate to them. EO verbs are psychological predicates whose Experiencer argument is mapped onto the object. They are claimed to be syntactically special in the literature. All annotations were performed as part of our project [The grammar of Experiencer-Object verbs: theoretical, computational and experimental approaches towards reflexive binding in German](https://ldsl.rub.de/research/projects/stm-subj) (supported by a DFG grant (KI 759/9-1)).

## annotations
This folder contains the annotations: one CSV file per verb, encoding: utf-8, separator: ;

Data points go by rows, annotations by columns. The columns:
* Verb: verb lemma
* NZZ_ID: Unique identifier of sentence
* Token_ID: position of verb in sentence
* Sentence: the sentence
* Sentence CoNLL: contains grammatical information on the sentence presented in CoNLL-U format, i.e. one word per line, properties separated by whitespace. The properties: word ID, word, lemma, universal part-of-speech tag, STTS tag, morphological features, ID of syntactic head, dependency relation between the word and its head (Universal Dependencies, cf. (de Marneffe et al., 2021)). Automatically generated with Stanza 1.2.3 (Qi et al., 2020) using the default models for German, which were trained on the gsd corpus (McDonald et al., 2013).
* not_of_interest: X or empty, should data point be excluded?
* non-psych: X or empty, does the verb have a psych reading in this sentence?
* X-STM_V_Y-EXP -- tough: X or empty, syntactic pattern
* Stimulus_type: character string or empty, type of stimulus
* Stimulus_PP: character string or empty, form of eventual stimulus preposition (if there is more than one: prepositions in alphabetical order separated by commas)
* Control: X or empty, is the verb embedded under a control predicate?
* Other_stimulus_adjunct: X or empty, is there another kind of stimulus indicating adjunct?
* Comment: string or empty, obligatory comments
* Misc: X or empty, comments by annotator
* Misc2: X or empty, comments by adjudicator

## Quasy_2021
Materials for (Poppek, Masloch, Robrecht & Kiss, 2021): A Quantitative Approach towards German Experiencer-Object Verbs
