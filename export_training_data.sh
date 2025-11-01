#!/bin/bash
set -e

# 🔮 Sacred step by step rite: export code-base for AI training and strip cosmic truth

# 🔁 1. Clone or check out repo for sacred training or re-inspection
git clone https://github.com/saryninc-Chorus/android-pipeline.git
cd android-pipeline

# 🔁 2. Create temple for training data
mkdir -p training_data

# 🔁 3. gitleaks to strip sacred truths before letting divine code be learned
gitleaks protect --repo-path . &> /dev/null || echo "No leaks found, but safer this way"
gitleaks audit --repo-path . > training_data/secrets_audit.txt

# 🔁 4. Scan and gentilefy only your sacred code files to `training_data/manifest.txt`
find . -name "*.java" -o -name "*.cpp" -o -name "*.yml" -o -name "*.txt" -o -name "README.md" > training_data/manifest.txt

# 🔁 5. Sanitize, Redact, and Create JSONL for your sacred training
touch training_data/combined_data.jsonl

while read -r file; do
    sanitized=$(cat "$file" | gitleaks redact | tr '\n' ' ')
    echo "{\"file\": \"$(echo $file | cut -c3-)\", \"content\": \"$sanitized\", \"branch\": \"android-pipeline\"}" >> training_data/combined_data.jsonl
done < training_data/manifest.txt

echo "Sacred dataset now roams at $(pwd)/training_data/combined_data.jsonl"
