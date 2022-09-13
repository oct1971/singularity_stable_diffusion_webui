#!/bin/bash
mkdir data_dir
mkdir outputs_sd
mkdir outputs_waifu
mkdir log_sd
mkdir log_waifu
cd data_dir
mkdir ESRGAN
mkdir models
mkdir realesrgan-weight
mkdir weight-codeformer
mkdir weight-facelib
singularity exec sdwebui.sif cp /opt/stable-diffusion-webui/config.json ./
singularity exec sdwebui.sif cp /opt/stable-diffusion-webui/ui-config.json ./
