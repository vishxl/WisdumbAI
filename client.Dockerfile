FROM ubuntu:18.04
MAINTAINER "vishxl [vishalsingh7x@gmail.com]"

COPY tr2enkey .

RUN chmod 400 tr2enkey

RUN apt-get update && \        
     apt-get install -y \
     git \
     curl \
     python3-distutils

RUN apt-get install python3 -y

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python3 get-pip.py && \
	rm get-pip.py

RUN mkdir /app && \      
           cd /app \              

RUN cat tr2enkey

RUN mkdir /root/.ssh && chmod 0700 /root/.ssh

RUN eval $(ssh-agent) && \
    ssh-add tr2enkey && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && \
    git clone --single-branch --branch tr_male_frontend git@github.com:vishxl/WisdumbAI.git /app
    
WORKDIR /app

RUN python3 -m pip install --upgrade pip &&\
    pip install --default-timeout=100 --no-cache-dir -r requirements.txt

EXPOSE 56789

CMD ["python3", "app.py"]
