from voice import VoiceService

vs = VoiceService( output_dir='outputs'  )
text = """
Wake up to reality... Nothing ever goes as planned in this accursed world!
"""

# vs.openvoice_v2()
# vs.openvoice( text, reference_speaker='modules/OpenVoice/resources/example_reference.mp3' )
vs.melotts( text )