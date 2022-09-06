#!/bin/sh
if [ -z '$1' ] ; then prefix=""; else prefix=".$1"; fi
phrase_to_say='This is a test using one of many voices'
models_to_check=('tts_models/en/ljspeech/tacotron2-DDC' 'tts_models/en/ljspeech/tacotron2-DDC_ph' 'tts_models/en/ljspeech/glow-tts' 'tts_models/en/ljspeech/speedy-speech' 'tts_models/en/ljspeech/tacotron2-DCA' 'tts_models/en/ljspeech/vits' 'tts_models/en/ljspeech/fast_pitch' 'tts_models/en/vctk/vits' 'tts_models/en/vctk/fast_pitch' 'tts_models/en/sam/tacotron-DDC' 'tts_models/en/blizzard2013/capacitron-t2-c50' 'tts_models/en/blizzard2013/capacitron-t2-c150')
for mod_name in ${models_to_check[@]}
do
  file_base_name=$(echo $mod_name | tr '/' '-')${prefix}
  tts --text "$phrase_to_say" --out_path ${file_base_name}.wav --model_name $mod_name 2>&1 | tee ${file_base_name}.log
done
