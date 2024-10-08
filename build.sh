NO_FORMAT="\033[0m"
C_GREY0="\033[38;5;16m"
C_YELLOW="\033[48;5;11m"
C_SPRINGGREEN3="\033[38;5;41m"
echo "${C_GREY0}${C_YELLOW}Make sure you are in a venv${NO_FORMAT}"


echo "${C_SPRINGGREEN3}> Installing requirements.txt${NO_FORMAT}"
pip install -r requirements.txt

cd modules
rm -rf OpenVoice MeloTTS
echo "${C_SPRINGGREEN3}> Cloning [OpenVoice] project${NO_FORMAT}"
git clone git@github.com:myshell-ai/OpenVoice.git
rm -rf OpenVoice/.git
echo "${C_SPRINGGREEN3}> Cloning [MeloTTS] project${NO_FORMAT}"
git clone git@github.com:myshell-ai/MeloTTS.git
rm -rf MeloTTS/.git

echo "${C_SPRINGGREEN3}> Starting setup for [OpenVoice]${NO_FORMAT}"
pip install -e OpenVoice
echo "${C_SPRINGGREEN3}> Starting setup for [MeloTTS]${NO_FORMAT}"
pip install -e MeloTTS

cd ..
echo "${C_SPRINGGREEN3}> Installing unidic package for [MeloTTS]${NO_FORMAT}"
pip install unidic
python -m unidic download
pip install "typer[all]<0.12"
python -m nltk.downloader averaged_perceptron_tagger
python -m nltk.downloader averaged_perceptron_tagger_eng


echo "${C_SPRINGGREEN3}> Downloading base checkpoints for [OpenVoice]${NO_FORMAT}"
curl -LO https://myshell-public-repo-host.s3.amazonaws.com/openvoice/checkpoints_v2_0417.zip
echo "${C_SPRINGGREEN3}> Unziping base checkpoints for [OpenVoice]${NO_FORMAT}"
unzip checkpoints_v2_0417.zip
rm -rf checkpoints_v2_0417.zip
echo "${C_SPRINGGREEN3}> Moving base checkpoints for [OpenVoice] to ./modules/OpenVoice${NO_FORMAT}"
mv ./checkpoints_v2 ./modules/OpenVoice


mkdir checkpoints
cd checkpoints
echo "${C_SPRINGGREEN3}> Downloading base checkpoints for [MeloTTS]${NO_FORMAT}"
curl -LO https://huggingface.co/myshell-ai/MeloTTS-English-v2/resolve/main/checkpoint.pth?download=true
echo "${C_SPRINGGREEN3}> Downloading base config for [MeloTTS]${NO_FORMAT}"
curl -LO https://huggingface.co/myshell-ai/MeloTTS-English-v2/resolve/main/config.json?download=true
echo "${C_SPRINGGREEN3}> Moving [MeloTTS] base checkpoints to ./modules/MeloTTS${NO_FORMAT}"
cd ..
mv checkpoints modules/MeloTTS

echo "${C_SPRINGGREEN3}> Moving voices to ./modules/OpenVoice/resources${NO_FORMAT}"
cp -a voices/. modules/OpenVoice/resources/
