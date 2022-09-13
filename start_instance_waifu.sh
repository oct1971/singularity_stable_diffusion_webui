#!/bin/bash
/usr/bin/singularity instance start \
	--nv \
	--nvccli \
	-B data_dir/models/wd-v1-2-full-ema.ckpt:/opt/stable-diffusion-webui/model.ckpt \
	-B data_dir/ui-config.json:/opt/stable-diffusion-webui/ui-config.json \
	-B data_dir/realesrgan-weight:/usr/local/lib/python3.10/dist-packages/realesrgan/weights/ \
	-B data_dir/weights-codeformer:/opt/stable-diffusion-webui/repositories/CodeFormer/weights/CodeFormer/ \
	-B data_dir/weights-facelib:/opt/stable-diffusion-webui/repositories/CodeFormer/weights/facelib/ \
	-B data_dir/ESRGAN:/opt/stable-diffusion-webui/ESRGAN \
	-B data_dir/config.json:/opt/stable-diffusion-webui/config.json \
	-B outputs_waifu:/outputs \
	-B log_waifu:/log \
	sdwebui.sif \
	sdwebui
/usr/bin/singularity exec instance://sdwebui python3.10 /opt/stable-diffusion-webui/webui.py &

