FROM java:jre-alpine

# Download the latest CoreNLP distribution
# Add and train our custom NER model during build
# Original by Moti Zilberman <motiz88@gmail.com>
# https://hub.docker.com/r/motiz88/corenlp/~/dockerfile/

RUN apk add --update --no-cache \
     unzip \
     wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-latest.zip

RUN unzip stanford-corenlp-latest.zip && \
    rm stanford-corenlp-latest.zip

WORKDIR /stanford-corenlp-4.1.0

COPY bgs.3class.geo* ./
COPY vocab.gaz.txt ./
COPY server.properties ./

RUN java -cp stanford-corenlp-4.1.0.jar edu.stanford.nlp.ie.crf.CRFClassifier -prop bgs.3class.geo.prop

# English model referred to in server.properties is in this jar
RUN unzip stanford-corenlp-4.1.0-models.jar
RUN export CLASSPATH="`find . -name '*.jar'`:.*"
EXPOSE 9000

# Add our models into the container and to the classpath
CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -serverProperties server.properties -loadClassifier models/ner/bgs.3class.geo.crf.ser.gz
