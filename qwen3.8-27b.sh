#!/bin/bash
MODEL_DIR=/home/lm00/.cache/huggingface/hub/models--unsloth--Qwen3.8-27B-GGUF/snapshots/f1bfb127c64f7072bdd2cad55f258b9c8b2910fe
CUDA_VISIBLE_DEVICES=0,1 llama-server \
  -m "$MODEL_DIR/Qwen3.8-27B-Q4_K_S.gguf" \
  --mmproj "$MODEL_DIR/mmproj-BF16.gguf" \
  --alias qwen3.8-27b \
  --n-gpu-layers 60 \
  --threads 16 \
  --ctx-size 131072 \
  --batch-size 2048 \
  --ubatch-size 512 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  --tensor-split 50,20 \
  --parallel 1 \
  --jinja \
  --chat-template-file "$(dirname "$0")/qwen3.8-fixed.jinja" \
  --flash-attn on \
  --host 0.0.0.0 \
  --port 11434 \
  --temperature 0.6 \
  --top-p 0.95 \
  --repeat-penalty 1.1 \
  --image-min-tokens 1024
