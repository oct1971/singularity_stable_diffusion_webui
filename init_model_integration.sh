#!/bin/bash
mkdir data_dir
mkdir outputs
mkdir imputs
mkdir log
cd data_dir
mkdir models
mkdir models/ESRGAN
mkdir models/SwinIR
mkdir models/Stable-diffusion
mkdir realesrgan-weight
mkdir weights-codeformer
mkdir weights-facelib
mkdir weights
mkdir embeddings
echo '{}' > config.json
echo '{}' > ui-config.json
