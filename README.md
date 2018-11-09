# Stratigraphic NER using Stanford NER

Instructions and link to download the current library to train a model are at https://nlp.stanford.edu/software/CRF-NER.html


## Files

1. bgs.3class.geo-training-data.txt : Data used to train the NER model. Three classes it recognises are as follows.
   - LEXICON : Entities specified in the BGS Lexicon of Named Rock Units http://data.bgs.ac.uk/doc/Lexicon.html
   - CHRONOSTRAT: Entities in the BGS geochronology and chronostratigraphy http://data.bgs.ac.uk/doc/Geochronology.html
   - BIOZONE: A handful of a biozones identified in the training data. These are very few and the model is not expected to perform well on this class.
   
2. bgs.3class.geo-testing-data.txt : Testing data for the NER model. It contains 70 CHRONOSTRAT and 425 LEXICON entities making a total of 495 entities in about 594 sentences. There are no biozones in the testing data!

3. bgs.3class.geo-all-data.txt : Combines training and test data above. Training and testing data were generated from separate source so this is expected to generate an even better model.

4. bgs.3class.geo.prop : Properties file for building the NER model. Description of parameters are at https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/ie/NERFeatureFactory.html

5. vocab.gaz.txt : List of terms from both vocabularies used. This is also used in generating the NER model as specified in bgs.3class.geo.prop.


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
