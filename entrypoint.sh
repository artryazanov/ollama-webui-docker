#!/bin/bash
set -euo pipefail

/bin/ollama serve &
pid=$!

# Wait for Ollama server to be ready
tries=0
until ollama ps >/dev/null 2>&1; do
  tries=$((tries+1))
  if [ "$tries" -ge 120 ]; then
    echo "Ollama server did not become ready in time" >&2
    exit 1
  fi
  sleep 1
done

MODEL_NAME="${OLLAMA_MODEL:-${MODEL:-${DEFAULT_MODEL:-llama3.2:1b}}}"

echo "> Download LLM: $MODEL_NAME"
ollama pull "$MODEL_NAME"

# Keep the server process in the foreground
wait $pid
