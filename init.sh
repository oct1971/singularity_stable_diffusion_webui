#!/bin/bash
mkdir data_dir
mkdir outputs_sd
mkdir outputs_waifu
mkdir outputs_trinart2_60
mkdir outputs_trinart2_95
mkdir outputs_trinart2_115
mkdir log_sd
mkdir log_waifu
mkdir log_trinart2_60
mkdir log_trinart2_95
mkdir log_trinart2_115
cd data_dir
mkdir ESRGAN
mkdir models
mkdir realesrgan-weight
mkdir weights-codeformer
mkdir weights-facelib
mkdir weights
mkdir SwinIR
echo '{}' > config.json
echo '{}' > ui-config.json
