#!/bin/bash

# Prompt user for input
echo "Enter commit type (e.g., feat, fix, docs, style, refactor, perf, test, chore):"
read type

echo "Enter optional scope (e.g., component or file name) or leave blank:"
read scope

echo "Enter a brief description of the change (imperative mood, max 50 chars):"
read description

echo "Enter a detailed description of the change. Press Enter to skip."
echo "Detailed description: "
read body
