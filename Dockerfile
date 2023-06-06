# Dockerfile

# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.7.1/ubuntu2204/devel/cudnn8/Dockerfile
# FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04
# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.7.1/ubuntu2204/base/Dockerfile
FROM nvidia/cuda:11.7.1-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libgl1 libglib2.0-0 wget git git-lfs python3-pip python-is-python3 && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' user
RUN mkdir /content && chown -R user:user /content
WORKDIR /content
USER user

RUN pip3 install --upgrade pip
RUN pip install --pre triton
RUN pip install numexpr

# PR approving alwayson_scripts (later than the version 1.9 of the webui fork) https://github.com/AUTOMATIC1111/stable-diffusion-webui/pull/8187
RUN git clone -b v2.2 https://github.com/camenduru/stable-diffusion-webui
RUN git clone -b v1.9 https://github.com/camenduru/sd-webui-additional-networks /content/stable-diffusion-webui/extensions/sd-webui-additional-networks
RUN git clone https://github.com/Mikubill/sd-webui-controlnet.git /content/stable-diffusion-webui/extensions/sd-webui-controlnet
RUN cd stable-diffusion-webui && git reset --hard

RUN sed -i -e '''/    prepare_environment()/a\    os.system\(f\"""sed -i -e ''\"s/dict()))/dict())).cuda()/g\"'' /content/stable-diffusion-webui/repositories/stable-diffusion-stability-ai/ldm/util.py""")''' /content/stable-diffusion-webui/launch.py
RUN sed -i -e 's/fastapi==0.90.1/fastapi==0.89.1/g' /content/stable-diffusion-webui/requirements_versions.txt
RUN sed -i -e 's/    start()/    #start()/g' /content/stable-diffusion-webui/launch.py
RUN cd stable-diffusion-webui && python launch.py --skip-torch-cuda-test

RUN pip install --pre xformers==0.0.16

ADD --chown=user download_models_if_missing.sh /content/stable-diffusion-webui/download_models_if_missing.sh
RUN chmod +x /content/stable-diffusion-webui/download_models_if_missing.sh

ADD --chown=user download_models_if_missing.sh /content/stable-diffusion-webui/download_models_if_missing.sh
RUN chmod +x /content/stable-diffusion-webui/download_models_if_missing.sh

WORKDIR /content/stable-diffusion-webui

EXPOSE 7860

CMD cd /content/stable-diffusion-webui