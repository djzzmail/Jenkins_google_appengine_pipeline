FROM google/cloud-sdk:alpine


# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

#    /builder/google-cloud-sdk/bin/gcloud -q components update && \
RUN mkdir -p /depl
WORKDIR /depl
COPY app.yaml .
COPY main.py .
COPY requirements.txt .
COPY jenkins-sa-key.json .

RUN gcloud auth activate-service-account --key-file jenkins-sa-key.json
RUN gcloud config set project vernal-tiger-346023
RUN gcloud -q app deploy app.yaml

#RUN  gcloud components list 
RUN gcloud --version
#    # Clean up
#    rm -rf /var/lib/apt/lists/*
