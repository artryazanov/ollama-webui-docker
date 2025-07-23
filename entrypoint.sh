#!/bin/bash

/bin/ollama serve &
pid=$!

sleep 5

echo "> Download LLM..."
ollama pull gemma3n:e4b

wait $pid
