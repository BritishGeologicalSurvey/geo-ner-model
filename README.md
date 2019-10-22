# Stratigraphic Named Entity Recognition with Stanford CoreNLP

## Introduction

This project provides training data and instructions for building a model to do named entity recognition (NER) of geological properties, namely chronostratigraphy and rock formation names.

We include around 2500 sentences extracted from publications of the British Geological Survey, with technical terms from BGS Geochronostratigraphy vocabulary and its Lexicon of Named Rock Units annotated with a custom named entity type (`CHRONOSTRAT` and `LEXICON` respectively).

The dataset was prepared by Dr Ike N'kisi Orji, supervised in BGS by Rachel Heaven, during his Doctoral Training Programme co-funded by BGS (BGS University Funding Initiative no. S291) and Robert Gordon University (School of Computing Science and Digital Media). The labelled sentences were extracted from an earlier collection of annotated publications known as Textbase 2000. The model has been used in text mining the BGS archives and linking documents and metadata to entities in the BGS Linked Data vocabularies.

## Building the model

Instructions and download information for the latest Stanford CoreNLP library to train a model are based on this data at [https://nlp.stanford.edu/software/CRF-NER.html](https://nlp.stanford.edu/software/CRF-NER.html)


## Files

1. `bgs.3class.geo-training-data.txt` : Data used to train the NER model. Three classes it recognises are as follows.
   - LEXICON : Entities specified in the BGS Lexicon of Named Rock Units http://data.bgs.ac.uk/doc/Lexicon.html
   - CHRONOSTRAT: Entities in the BGS geochronology and chronostratigraphy http://data.bgs.ac.uk/doc/Geochronology.html
   - BIOZONE: A handful of a biozones identified in the training data. These are very few and the model is not expected to perform well on this class.

2. `bgs.3class.geo-testing-data.txt` : Testing data for the NER model. It contains 70 CHRONOSTRAT and 425 LEXICON entities making a total of 495 entities in about 594 sentences. There are no biozones in the testing data!

3. `bgs.3class.geo-all-data.txt` : Combines training and test data above. Training and testing data were generated from separate source so this is expected to generate an even better model.

4. `bgs.3class.geo.prop` : Properties file for building the NER model. Description of parameters are at https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/ie/NERFeatureFactory.html

5. `vocab.gaz.txt` : List of terms from both vocabularies used. This is also used in generating the NER model as specified in bgs.3class.geo.prop.


## Training

### Train the NER model:

  * `wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip ; unzip stanford-corenlp-full-2018-10-05.zip`

  * Edit `bgs.3class.geo.prop` if needed to point `trainFile` to the training file and `gazette` to file specifying entity names (vocab.gaz.txt). Use of gazetter made very minimal impact in our testing (slightly improved for CHRONOSTRAT and worsened for LEXICON).

  *	Train the model: `java -cp stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar edu.stanford.nlp.ie.crf.CRFClassifier -prop bgs.3class.geo.prop`

  * The default `bgs.3class.geo.prop` we have supplied here includes both the training and testing data for the CoreNLP model (combined into `bgs.3class.geo-all-data.txt`)

### Test the NER  model

Testing gives precision, recall and f-measure scores.

  * `java -cp stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier bgs.3class.geo.crf.ser.gz -testFile bgs.3class.geo-testing-data.txt`

### Model Evaluation

Performance results obtained using the training, testing and properties files specified here are as follows.

|Entity    		|Precision	|Recall     	|F1  		|TP  	|FP   	|FN |
|---------------|-----------|---------------|-----------|-------|-------|---|
|CHRONOSTRAT    	|0.9722  	|1.0000  	|0.9859  	|70      |2      | 0|
|LEXICON    		|0.8794  	|0.8753  	|0.8774  	372     |51      |53|
|Totals    		|0.8929  	|0.8929  	|0.8929  	|442     |53      |53|


## Contributing


Contributors to this project, as part of the broader Geosemantics efforts within BGS, include:

 * Ike N'kisi Orji
 * Rachel Heaven
 * Robert McIntosh
 * Jo Walsh
 * Robert
 * James Passmore
 * Marcus Sen

We welcome any contributions, including improvements to the annotations training data and any associated code building on the trained model. We make this available in the format required by [CoreNLP](https://stanfordnlp.github.io/CoreNLP/) but have also translated it into the [spacy](https://spacy.io) training format, producing models with some success but not yet such good performance. Please contact us through this repository or via enquiries@bgs.ac.uk

## Licence

The contents of this repository are made available under the [Creative Commons Attribution-ShareAlike](https://creativecommons.org/licenses/by-sa/4.0/) license.
Copyright ©BGS/Robert Gordon University 2018

## References

 * [BGS Geochronology Linked Data](http://data.bgs.ac.uk/doc/Geochronology.html)
 * [BGS Lexicon of Named Rock Units Linked Data](http://data.bgs.ac.uk/doc/Lexicon.html)
 * [BGS Publication Viewer](https://www.bgs.ac.uk/data/publications/pubs.cfc?method=viewHome)


