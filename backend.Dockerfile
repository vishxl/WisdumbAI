FROM python:3.6

MAINTAINER "vishxl [vishalsingh7x@gmail.com]"

COPY ss_gl_rsa .

RUN chmod 400 ss_gl_rsa

RUN apt-get update && \        
     apt-get install -y \
     git \
     curl

RUN apt-get install libsndfile1 -y

RUN mkdir /app && \      
           cd /app \    
          
RUN cp ../ss_gl_rsa /app

RUN cat ss_gl_rsa

RUN mkdir /root/.ssh && chmod 0700 /root/.ssh

RUN eval $(ssh-agent) && \
    ssh-add ss_gl_rsa && \
    ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts && \
    git clone git@gitlab.com:vsalsngh/WisdumbAI.git /app

WORKDIR /app

RUN python3 -m pip install --upgrade pip &&\
    pip install --default-timeout=100 --no-cache-dir -r requirements.txt && \
    
    pip install git+https://github.com/TensorSpeech/TensorflowTTS.git
    
    #cat requirements.txt | xargs -n 1 pip install 
 
EXPOSE 51324

CMD ["python3", "app4.py"]
