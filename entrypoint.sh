#!/bin/bash

/bin/ollama serve &
pid=$!

sleep 5

echo "> Download deepseek model..."
ollama pull deepseek-r1:1.5b

wait $pid
