# singularity_stable_diffusion_webui
[stable-diffusion-webui(AUTOMATIC1111版)](https://github.com/AUTOMATIC1111/stable-diffusion-webui) をインストールしたsingularity imageを作成・実行するためのsingularity定義ファイルとシェルスクリプトです。
## WSL2, ubuntu20.04, singularity 3.9のインストール
以下のページの手順に従ってWindows10/11にWSL2, ubuntu20.04, NVIDIA driver, libnvidia-container-tools, singularity3.9をインストールします。

Linuxで使用する場合はNVIDIA driver, singularity3.9のインストールを行ってください。

https://sylabs.io/2022/03/wsl2-gpu/

また、コマンドラインの実行用にMicrosoft StoreからWindows Termnalをインストールしておくことをお勧めします。

以下のコマンドはWSL2のインストール時に同時にインストールされたUbuntu on WindowsやWindows Terminalで開いたubuntuのシェルで実行します。
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
stable-diffusion-webuiが内部で使用しているリポジトリの追加等があった場合は[Manual Installation](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Install-and-Run-on-NVidia-GPUs#manual-installation)の内容を参考にSingularity.repositoriesを修正し、repositories.sifを再buildする必要があります。

## 初期設定の実行
singularityで実行されるコンテナ内は一部を除いて書き込み禁止であるため、stable-diffusion-webuiの実行後にダウンロードされるファイルの保存場所はコンテナ実行時にコンテナ内にディレクトリをバインドします。また、ファイルサイズの大きいmodelファイルもイメージ内に入れないようにしています。それらのディレクトリ・ファイルの準備を行います。

※data_dir以外に ~/.cache 以下にダウンロードされるファイルもあります。

※lattent-diffusionがダウンロードするファイルは、コンテナを起動したディレクトリにrepositoriesディレクトリが作成され、その中にダウンロードされます。

stable-diffusion-webui(AUTOMATIC1111版) にて画像出力先にmodelのhash値のサブディレクトリを使えるようになったため、modelごとの出力先の作成が不要になりました。init_model_integration.sh はmodel別の出力先を生成しません。
```
$ bash init_model_integration.sh
```
## modelの配置
modelファイルは別途用意し、data_dir/models/Stable-diffusion/ にリネームせずに配置してください。
- [本家model](https://huggingface.co/CompVis/stable-diffusion-v-1-4-original): sd-v1-4.ckpt
- [waifu-diffuion model](https://huggingface.co/hakurei/waifu-diffusion): wd-v1-2-full-ema.ckpt
    - Original PyTorch Model Download Link よりダウンロード
- [trinart2 model](https://huggingface.co/naclbit/trinart_stable_diffusion_v2): trinart2_step60000.ckpt, trinart2_step95000.ckpt, trinart2_step115000.ckpt

## ESRGANのmodelの配置（オプション）
ESRGANのmodelは data_dir/models/ESRGAN/ に配置してください。

## SwinIRのmodelの配置（オプション）
SwinIRのmodelは data_dir/models/SwinIR/ に配置してください。

## stable-diffusion-webuiの起動
生成された画像はoutputsディレクトリに、セーブした画像はlogディレクトリに保存されます。

※この後のstable-diffusion-webuiの初期設定で 'Save images to a subdirectory', 'Save grids to subdirectory' にチェックを入れ、 'Directory name pattern' を '[model_hash]' とすると使用しているmodelごとにサブディレクトリが作成されます。
```
$ bash start_instance.sh
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
- Save images to a subdirectory: チェック
- Save grids to subdirectory: チェック
- Directory name pattern: [model_hash]

設定内容は data_dir/ui-config.json, data_dir/config.json に書き込まれますので、Batch countの上限変更等はこちらのファイルを修正してください。

※当環境では、"Apply color correction to img2img results to match original colors." にチェックが入っているとSD upscaleでの出力時に黒ずんだ色になってしまいました。その場合はこちらのチェックを外してください。

## stable-diffusion-webuiの停止
以下のコマンドで停止させてください。
```
$ singularity instance stop sdwebui
```
## Windowsのエクスプローラからstable-diffusion-webuiで生成した画像へのアクセス
エクスプローラのアドレスバーに `\\wsl\Ubuntu\home\<あなたのアカウント名>\<本リポジトリをcloneした場所>`を入力して開いてください。
