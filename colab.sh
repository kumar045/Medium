#!/bin/bash

# Default values for pyspark, spark-nlp, and SPARK_HOME
SPARKNLP="5.5.3"
PYSPARK="3.5.0"  # Change default to a compatible version

while getopts s:p:g option
do
  case "${option}"
  in
    s) SPARKNLP=${OPTARG};;
    p) PYSPARK=${OPTARG};;
    g) GPU="true";;
  esac
done

export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Set PySpark version based on input argument
if [[ "$PYSPARK" == "3.6"* ]]; then
  PYSPARK="3.6.0"
  echo "Installing PySpark $PYSPARK and Spark NLP $SPARKNLP"
elif [[ "$PYSPARK" == "3.5"* ]]; then
  PYSPARK="3.5.0"
  echo "Installing PySpark $PYSPARK and Spark NLP $SPARKNLP"
else
  PYSPARK="3.5.0"  # Default to 3.5.0 to avoid conflicts
  echo "Installing PySpark $PYSPARK and Spark NLP $SPARKNLP"
fi

echo "Setting up Colab for PySpark $PYSPARK and Spark NLP $SPARKNLP"

# Install dependencies for GPU (optional)
if [[ "$GPU" == "true" ]]; then
  echo "Upgrading libcudnn8 to 8.1.0 for GPU"
  apt install -qq --allow-change-held-packages libcudnn8=8.1.0.77-1+cuda11.2 -y &> /dev/null
fi

# Install pyspark and spark-nlp with the specified versions
pip install --upgrade -q pyspark==$PYSPARK spark-nlp==$SPARKNLP findspark
