#!/bin/bash

# Check if the files exist
if [ ! -f models/Stable-diffusion/oilPainting_oilPaintingV10.safetensors ]; then
    # Download the file
    echo "Downloading Sorolla Model..."
    wget https://civitai.com/api/download/models/23979 -O models/Stable-diffusion/oilPainting_oilPaintingV10.safetensors
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
