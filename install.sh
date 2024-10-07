python3 -m venv venv
source venv/bin/activate

rm -rf MeloTTS
git clone https://github.com/myshell-ai/MeloTTS.git
pip install -e ./MeloTTS
pip install unidic
python -m unidic download
pip install "typer[all]<0.12"
python -m nltk.downloader averaged_perceptron_tagger
python -m nltk.downloader averaged_perceptron_tagger_eng