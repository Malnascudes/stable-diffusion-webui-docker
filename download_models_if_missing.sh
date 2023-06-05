#!/bin/bash

# Check if the files exist
if [ ! -f models/Stable-diffusion/oilPainting_oilPaintingV10.safetensors ]; then
    # Download the file
    echo "Downloading Sorolla Model..."
    wget https://civitai.com/api/download/models/23979 -O models/Stable-diffusion/oilPainting_oilPaintingV10.safetensors
    echo "Successfuly downloaded Sorolla Model"
fi

if [ ! -f models/Lora/01-03-v4-sd1.5.safetensors ]; then
    # Download the file
    echo "Downloading Sorolla Lora..."
    # https://stackoverflow.com/questions/37453841/download-a-file-from-google-drive-using-wget
    wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?id=1JALDHvCOLHV0p1CBEX9zmz0gCPrrCEax&export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=FILEID' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1JALDHvCOLHV0p1CBEX9zmz0gCPrrCEax" -O models/Lora/01-03-v4-sd1.5.safetensors && rm -rf /tmp/cookies.txt
    echo "Successfuly downloaded Sorolla Model"
fi

if [ ! -f extensions/sd-webui-controlnet/models/control_v11p_sd15_canny.pth ]; then
    echo "Downloading Controlnet Canny Model..."
    # Download the file
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth -O extensions/sd-webui-controlnet/models/control_v11p_sd15_canny.pth
    echo "Successfuly downloaded Controlnet Canny Model"
fi

if [ ! -f extensions/sd-webui-controlnet/models/control_v11p_sd15_canny.yaml ]; then
    # Download the file
    echo "Downloading Controlnet Canny Model config..."
    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.yaml -O extensions/sd-webui-controlnet/models/control_v11p_sd15_canny.yaml
    echo "Successfuly downloaded Controlnet Canny Model config"
fi
