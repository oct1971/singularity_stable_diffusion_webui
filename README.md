# singularity_stable_diffusion_webui
[stable-diffusion-webui(AUTOMATIC1111版)](https://github.com/AUTOMATIC1111/stable-diffusion-webui) をインストールしたsingularity imageを作成・実行するためのsingularity定義ファイルとシェルスクリプトです。
## WSL2, ubuntu20.04, singularity 3.9のインストール
以下のページの手順に従ってWindows10/11にWSL2, ubuntu20.04, NVIDIA driver, libnvidia-container-tools, singularity3.9をインストールします。

Linuxで使用する場合はNVIDIA driver, singularity3.9のインストールを行ってください。

https://sylabs.io/2022/03/wsl2-gpu/

また、コマンドラインの実行用にMicrosoft StoreからWindows Termnalをインストールしておくことをお勧めします。以下のコマンドはWSL2のインストール時に同時にインストールされたUbuntu on WindowsやWindows Terminalで開いたubuntuのシェルで実行します。
## 本リポジトリのclone
cloneする場所はどこでも構いません。
```
$ git clone https://github.com/oct1971/singularity_stable_diffusion_webui
$ cd singularity_stable_diffusion_webui
```
## singularity imageのbuild
singularity imageのbuildは管理者権限が必要なため、sudoを付けて実行してください。
### base imageのbuild
ubuntu 20.04にpython3.10, cuda11.3をインストールしたイメージを作成します。
```
$ sudo bash build_base_image.sh
```
### repositories imageのbuild
base imageにstable-diffusion-webuiで使用するリポジトリ等をインストールしたイメージを作成します。
```
$ sudo bash build_repositories_image.sh
```
### sdwebui imageのbuild
stable-diffusion-webui(AUTOMATIC1111版) をインストールしたイメージを作成します。
```
$ sudo bash build_sdwebui_image.sh
```
更新頻度の高いstable-diffusion-webuiのインストールを分離していますので、更新があった場合は通常sdwebui imageのbuildのみ再実行します。
stable-diffusion-webuiが内部で使用しているリポジトリの追加等があった場合はSingularity.repositoriesを修正してrepositories.sifのbuildが必要になります。

## 初期設定の実行
singularityで実行されるコンテナ内は一部を除いて書き込み禁止であるため、stable-diffusion-webuiの実行後にダウンロードされるファイルの保存場所はコンテナ実行時にコンテナ内にディレクトリをバインドします。また、ファイルサイズの大きいmodelファイルもイメージ内に入れないようにしています。それらのディレクトリ・ファイルの準備を行います。
```
$ bash init.sh
```
## modelの配置
modelファイルは別途用意し、data_dir/models/ にリネームせずに配置してください。
- [本家model](https://huggingface.co/CompVis/stable-diffusion-v-1-4-original): sd-v1-4.ckpt
- [waifu-diffuion model](https://huggingface.co/hakurei/waifu-diffusion): wd-v1-2-full-ema.ckpt
- [trinart2 model](https://huggingface.co/naclbit/trinart_stable_diffusion_v2): trinart2_step60000.ckpt, trinart2_step95000.ckpt, trinart2_step115000.ckpt
## ESRGANのmodelの配置（オプション）
ESRGANのmodelは data_dir/ESRGAN/ に配置してください。
## stable-diffusion-webuiの起動
### 本家modelでの起動
本家modelで起動した場合、生成された画像はoutputs_sdディレクトリに、セーブした画像はlog_sdディレクトリに保存されます。
```
$ bash start_instance_sd.sh
```
### waifu-diffusion modelでの起動
waifu-diffusion modelで起動した場合、生成された画像はoutputs_waifuディレクトリに、セーブした画像はlog_waifuディレクトリに保存されます。
```
$ bash start_instance_waifu.sh
```
## stable-diffusion-webuiの初期設定
Settingsタブで以下の設定を行い、Apply settingsをクリックして設定を保存してください。
- Output directory for txt2img images: /outputs/txt2img-images
- Output directory for img2img images: /outputs/img2img-images
- Output directory for images from extras tab: /outputs/extras-images
- Output directory for txt2img grids: /outputs/txt2img-grids
- Output directory for img2img grids: /outputs/img2img-grids
- Directory for saving images using the Save button: /log/images
- Font for image grids that have text: /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
## stable-diffusion-webuiの停止
以下のコマンドで停止させてください。
```
$ singularity instance stop sdwebui
```
