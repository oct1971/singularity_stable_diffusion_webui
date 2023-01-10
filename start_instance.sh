#!/bin/bash
/usr/bin/singularity instance start \
	--nv \
	--nvccli \
	-B data_dir/models:/opt/stable-diffusion-webui/models \
	-B data_dir/ui-config.json:/opt/stable-diffusion-webui/ui-config.json \
	-B data_dir/realesrgan-weight:/usr/local/lib/python3.10/dist-packages/realesrgan/weights/ \
	-B data_dir/weights-codeformer:/opt/stable-diffusion-webui/repositories/CodeFormer/weights/CodeFormer/ \
	-B data_dir/weights-facelib:/opt/stable-diffusion-webui/repositories/CodeFormer/weights/facelib/ \
	-B data_dir/weights:/usr/local/lib/python3.10/dist-packages/weights/ \
	-B data_dir/config.json:/opt/stable-diffusion-webui/config.json \
	-B data_dir/embeddings:/opt/stable-diffusion-webui/embeddings \
	-B data_dir/extensions:/opt/stable-diffusion-webui/extensions \
	-B data_dir/tmp:/opt/stable-diffusion-webui/tmp \
	-B outputs:/outputs \
	-B log:/log \
	sdwebui.sif \
	sdwebui
/usr/bin/singularity exec instance://sdwebui python3.10 /opt/stable-diffusion-webui/webui.py --xformers &
