FROM nvidia/cuda:9.2-base-ubuntu18.04

# Copy directories
COPY . /tracktor 

# Install core packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential checkinstall software-properties-common llvm cmake wget git nano zip unzip pkg-config 
RUN apt-get install -y python3.6 python-pip

# Install Python requirements 
RUN pip install -r /tracktor/requirements.txt


