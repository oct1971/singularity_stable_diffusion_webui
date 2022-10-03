#!/bin/bash
mkdir data_dir
mkdir outputs
mkdir log
cd data_dir
mkdir models
mkdir models/ESRGAN
mkdir models/SwinIR
mkdir realesrgan-weight
mkdir weights-codeformer
mkdir weights-facelib
mkdir weights
echo '{}' > config.json
echo '{}' > ui-config.json
