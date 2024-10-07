echo "Creating new virtual environment [.venv]"
python3 -m venv .venv
source .venv/bin/activate

cd modules
rm -rf OpenVoice MeloTTS
echo "Cloning [OpenVoice] project"
git clone git@github.com:myshell-ai/OpenVoice.git
echo "Cloning [MeloTTS] project"
git clone git@github.com:myshell-ai/MeloTTS.git

cd ..
echo "Starting setup for [OpenVoice]"
pip install -e ../modules/OpenVoice
echo "Starting setup for [MeloTTS]"
pip install -e ../modules/MeloTTS

echo "Installing unidic package for [MeloTTS]"
pip install unidic
python -m unidic download
pip install "typer[all]<0.12"
python -m nltk.downloader averaged_perceptron_tagger
python -m nltk.downloader averaged_perceptron_tagger_eng


echo "Downloading base checkpoints for [OpenVoice]"
curl -LO https://myshell-public-repo-host.s3.amazonaws.com/openvoice/checkpoints_v2_0417.zip
echo "Unziping base checkpoints for [OpenVoice]"
unzip checkpoints_v2_0417.zip
rm -rf checkpoints_v2_0417.zip
echo "Moving base checkpoints for [OpenVoice] to ./modules/OpenVoice"
mv ./checkpoints_v2 ./modules/OpenVoice


mkdir checkpoints
cd checkpoints
echo "Downloading base checkpoints for [MeloTTS]"
curl -LO https://huggingface.co/myshell-ai/MeloTTS-English-v2/resolve/main/checkpoint.pth?download=true
echo "Downloading base config for [MeloTTS]"
curl -LO https://huggingface.co/myshell-ai/MeloTTS-English-v2/resolve/main/config.json?download=true
echo "Moving [MeloTTS] base checkpoints to ./modules/MeloTTS"
cd ..
mv checkpoints modules/MeloTTS
echo "Adding [MeloTTS] base checkpoints to .gitignore"
echo "/checkpoints/checkpoint.pth" >> modules/MeloTTS/.gitignore
echo "/checkpoints/config.json" >> modules/MeloTTS/.gitignore