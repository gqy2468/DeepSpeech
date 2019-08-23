#!/bin/bash
 
set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;
 
prefix="thchs30"
 
DATA_DIR="/home/guoqiya/Documents/DeepSpeech/data_thchs30"
ALPHABET="$DATA_DIR/$prefix-alphabet.txt"
LM_BINARY="$DATA_DIR/$prefix-lm.binary"
LM_TRIE="$DATA_DIR/$prefix-trie"
COMPUTE_KEEP_DIR="/home/guoqiya/Documents/DeepSpeech/thchs30-models"
 
if [ -d "${COMPUTE_KEEP_DIR}" ]; then
    checkpoint_dir=$COMPUTE_KEEP_DIR
else
    checkpoint_dir=$(python -c "from xdg import BaseDirectory as xdg; print(xdg.save_data_path(\"deepspeech/$prefix\"))")
fi
 
python3 -u DeepSpeech.py \
  --alphabet_config_path $ALPHABET \
  --lm_binary_path $LM_BINARY \
  --lm_trie_path $LM_TRIE \
  --notrain \
  --nodev \
  --notest \
  --n_hidden 512 \
  --learning_rate 0.0001 \
  --epoch 50 \
  --checkpoint_dir "$checkpoint_dir" \
  --export_dir "$DATA_DIR" \
  --log_level 0 \
  --summary_secs 3 \
  "$@"