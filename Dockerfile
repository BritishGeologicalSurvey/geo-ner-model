FROM java:jre-alpine

# Original by Moti Zilberman <motiz88@gmail.com>
# https://hub.docker.com/r/motiz88/corenlp/~/dockerfile/

RUN apk add --update --no-cache \
     unzip \
     wget

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
#COPY stanford-corenlp-full-2018-10-05.zip /

RUN unzip stanford-corenlp-full-2018-10-05.zip && \
    rm stanford-corenlp-full-2018-10-05.zip

WORKDIR /stanford-corenlp-full-2018-10-05/models/ner/
COPY bgs.3class.geo.crf.ser.gz .

WORKDIR /stanford-corenlp-full-2018-10-05

COPY server.properties .

# English model referred to in server.properties is in this jar
RUN unzip stanford-corenlp-3.9.2-models.jar

RUN export CLASSPATH="`find . -name '*.jar'`:.*"

ENV PORT 9000

EXPOSE $PORT

# Add our models into the container and to the classpath
CMD java -cp "*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -serverProperties server.properties -loadClassifier models/ner/bgs.3class.geo.crf.ser.gz

