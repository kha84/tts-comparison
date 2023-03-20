#!/bin/bash

# configuration parameters
phrase_to_say='This is a test using one of many voices'

# list of models we will be assessing
# you can compose your own list, by running "tts --list_models"
models_to_check=('tts_models/en/ljspeech/tacotron2-DDC' 'tts_models/en/ljspeech/tacotron2-DDC_ph' 'tts_models/en/ljspeech/glow-tts' 'tts_models/en/ljspeech/speedy-speech' 'tts_models/en/ljspeech/tacotron2-DCA' 'tts_models/en/ljspeech/vits' 'tts_models/en/ljspeech/fast_pitch' 'tts_models/en/vctk/vits' 'tts_models/en/vctk/fast_pitch' 'tts_models/en/sam/tacotron-DDC' 'tts_models/en/blizzard2013/capacitron-t2-c50' 'tts_models/en/blizzard2013/capacitron-t2-c150')

# loop through all the models, one by one, generating a wav file and log file for each
if [ -z '$1' ] ; then prefix=""; else prefix=".$1"; fi
for mod_name in ${models_to_check[@]}
do
  file_base_name=$(echo $mod_name | tr '/' '-')${prefix}
  speaker_list=${file_base_name}.speakers.txt

  # for some of the TTS models we might have ones, which REQUIRES us to provide a speaker id
  # otherwise they will just not generate anything
  # find out, if the one we're looking at, is of that kind
  if [[ "$mod_name" =~ ^tts ]]; then
    # if the speakers list file is not there - let's generate it
    if [[ ! -f "${speaker_list}" ]]; then
      echo "## DEBUG ## speakers list file does not exist for model $mod_name"
      tts --model_name "$mod_name" --list_speaker_idxs > ${speaker_list}.raw
      ec=$?
      # if the result of previous command was successfull, we have captured speakers from the current model
      # given it is a garbage unformatted output from python, we need to do some preprocessing
      if [ $ec -eq 0 ]; then
        cat ${speaker_list}.raw | grep -oE "^\{.*\}" | grep -oE "'[^']*'" | tr -d "'" > ${speaker_list}
        echo "## DEBUG ## model $mod_name does support speakers. Created file with list of speakers"
      # if TTS model doesn't support speakers we'll just create an empty file 
      else
        touch ${speaker_list}
        echo "## DEBUG ## model $mod_name doesn't support speakers. Created an empty file"
      fi
    fi
  fi
  
  if [ -s ${speaker_list} ]; then
        # speaker-list file is not-empty. loop through its lines
        echo "## DEBUG ## speaker-list file is not-empty. loop through its lines"
        while read speaker; do
          file_name="${file_base_name}-${speaker}"
          tts --text "$phrase_to_say" --out_path ${file_name}.wav --model_name $mod_name --speaker_idx $speaker 2>&1 | tee ${file_name}.log
        done <${speaker_list}
  else
        # The file is empty. run TTS without giving a speaker
        tts --text "$phrase_to_say" --out_path ${file_base_name}.wav --model_name $mod_name 2>&1 | tee ${file_base_name}.log
  fi 
  
done
echo "## DEBUG ## Script has finished"
