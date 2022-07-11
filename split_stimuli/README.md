# split_stimuli

Materials for our talk on so-called "Split Stimuli" at Grammar and Corpora 2022 in Ghent. The term "split stimulus" has been used in the literature for cases in which the semantic stimulus of the experiencer’s emotion appears to be "split up" between an NP and another phrase (usually a PP).

Files:
* GaC_Presentation_final.pdf: Slides for the presentation we delivered at Grammar and Corpora 2022 in Ghent.
* semantics_annotation.Rmd: R Markdown that generates the plots for the presentation
* gloss_verbs.csv: Translations of the German verbs in GerEO
* annotation_guidelines.pdf: Annotation guidelines used to generate the data in full_pp_annotation.csv
* full_pp_annotation.csv: Annotations on a subset of GerEO regarding the semantic nature of the subject and the prepositions internal argument in sentences containing a "split stimulus". All sentences from GerEO in which the verb occurred in either the transitive or the intransitive (object-drop) pattern containing a relevant preposition. See below.

## full_pp_annotation.csv

csv file, encoding: utf-8, separator: comma (,), simple quotes (") used to mark text where necessary

Data points go by rows, annotations by columns. The columns:
* Verb: verb lemma (taken over from GerEO)
* NZZ_ID: Unique identifier of sentence (taken over from GerEO)
* Token_ID: position of verb in sentence (taken over from GerEO)
* Sentence: the sentence (taken over from GerEO)
* pattern: syntactic pattern (character string). See GerEO manual. (taken over from GerEO)
* Stimulus_type: character string or empty, type of stimulus (taken over from GerEO)
* Stimulus_PP: character string or empty, form of eventual stimulus preposition (if there is more than one: prepositions in alphabetical order separated by commas) (taken over from GerEO)
* Comment: string or empty, obligatory comments (taken over from GerEO)
* sem_class_subj: character string, semantic class of the head noun of the subject NP
* sem_class_PP_int: character string, semantic class of the head noun of the internal argument of the stimulus preposition
* interpr_sem_class_PP_int: character string or empty, semantic semantic class of the head noun of the internal argument of the stimulus preposition in the context of the sen-
tence
* det_PP_int: character string or empty, special properties of internal argument's determiner?
* Comment_PP: character string or empty, comments by annotators
