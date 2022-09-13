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
mkdir weights-codeformer
mkdir weights-facelib
echo '{}' > config.json
echo '{}' > ui-config.json
