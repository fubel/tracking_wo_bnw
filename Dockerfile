FROM nvidia/cuda:9.2-devel-ubuntu18.04

# Copy directories
COPY . /tracktor 

# Install core packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential checkinstall software-properties-common llvm cmake wget git nano zip unzip pkg-config 
RUN apt-get install -y python3.6 python3-pip

# Create symbolic link for Python
RUN ln -s /usr/bin/python3.6 /usr/bin/python

# Install Python requirements 
RUN python -m pip install -r /tracktor/requirements.txt

# Install and compile FPN and FRCNN, install Tracktor
WORKDIR /tracktor
ENV CUDA_PATH=/usr/local/cuda-9.2/include
RUN python -m pip install -e src/fpn
RUN python -m pip install -e src/frcnn
RUN python -m pip install -e .
RUN python -m pip install https://download.pytorch.org/whl/cu90/torch-0.3.1-cp36-cp36m-linux_x86_64.whl
RUN ["chmod", "+x", "src/fpn/fpn/make.sh"]
RUN ["chmod", "+x", "src/frcnn/frcnn/make.sh"]
RUN src/fpn/fpn/make.sh
RUN src/frcnn/frcnn/make.sh 




