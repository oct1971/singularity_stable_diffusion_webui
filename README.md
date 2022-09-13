# singularity_stable_diffusion_webui
stable-diffusion-webui(AUTOMATIC1111版) をインストールしたsingularity imageを作成・実行するためのシェルスクリプトです。
## WSL2, ubuntu20.04, singularity 3.9のインストール
以下のページの手順に従ってWindows10/11にWSL2, ubuntu20.04, NVIDIA driver, libnvidia-container-tools, singularity3.9をインストールします。

https://sylabs.io/2022/03/wsl2-gpu/
## 本リポジトリのclone
```
$ git clone https://github.com/oct1971/singularity_stable_diffusion_webui
$ cd singularity_stable_diffusion_webui
```
## singularity imageのbuild
### base imageのbuild
ubuntu 20.04にpython3.10, cuda11.3をインストールしたイメージを作成します。
```
$ sudo bash create_base_image.sh
```
### repository imageのbuild
base imageにstable-diffusion-webuiで使用するリポジトリ等をインストールしたイメージを作成します。
```
$sudo bash create_repositories_image.sh
```
### sdwebui imageのbuild
stable-diffusion-webui(AUTOMATIC1111版) をインストールしたイメージを作成します。
```
$ sudo bash create_sdwebui_image.sh
```
更新頻度の高いstable-diffusion-webuiのインストールを分離していますので、更新があった場合は通常sdwebui imageのbuildのみ再実行します。
stable-diffusion-webuiが内部で使用しているリポジトリの追加等があった場合はSingularity.repositoriesを修正してrepositories.sifのbuildが必要になります。

## 初期設定の実行
singularityで実行されるコンテナ内は一部を除いて書き込み禁止であるため、stable-diffusion-webuiの実行後にダウンロードされるファイルの保存場所やファイルサイズの大きいmodelファイルはコンテナ実行時にコンテナ内にディレクトリ・ファイルをバインドするようになっています。それらのディレクトリ・ファイルの準備を行います。
```
$ bash init.sh
```
## modelの配置
modelファイルは別途用意し、data_dir/models/ に配置してください。
## stable-diffusion-webuiの起動
### 本家modelでの起動
使用するmodelごとに画像の出力先を切り替えるようになっています。
```
$ bash start_instance_sd.sh
```
### stable-diffusion-webuiの初期設定
