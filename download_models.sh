#!/bin/bash

# Ensure the CivitAI API token is set before running the script
if [[ -z "$CIVITAI_TOKEN" ]]; then
    echo "Error: CIVITAI_TOKEN is not set. Please export it before running the script."
    exit 1
fi

# Define download function
download_model() {
    local url="$1"
    local folder="$2"

    # Ensure target directory exists
    mkdir -p "$folder"

    echo "Downloading: $url to $folder..."

    # Use curl with -J to respect server-sent filenames
    curl -L -H "Authorization: Bearer $CIVITAI_TOKEN" -J -O --output-dir "$folder" "$url"

    if [[ $? -eq 0 ]]; then
        echo "✅ Successfully downloaded: $url"
    else
        echo "❌ Failed to download: $url"
    fi
}

# Define directories
CKPT_DIR="/workspace/storage/stable_diffusion/models/ckpt"
LORA_DIR="/workspace/storage/stable_diffusion/models/lora"

# Download Checkpoint Models
CKPT_MODELS=(
    "https://civitai.com/api/download/models/1422871?type=Model&format=SafeTensor&size=pruned&fp=fp16"
    "https://civitai.com/api/download/models/1372996"
    "https://civitai.com/api/download/models/1485344"
    "https://civitai.com/api/download/models/1443129"
    "https://civitai.com/api/download/models/1413921"
    "https://civitai.com/api/download/models/1471829"
)

# Download Lora Models
LORA_MODELS=(
    "https://civitai.com/api/download/models/424720"
    "https://civitai.com/api/download/models/424706"
    "https://civitai.com/api/download/models/652659"
)

echo "🚀 Starting model downloads..."

# Loop through and download Checkpoint models
for url in "${CKPT_MODELS[@]}"; do
    download_model "$url" "$CKPT_DIR"
done

# Loop through and download Lora models
for url in "${LORA_MODELS[@]}"; do
    download_model "$url" "$LORA_DIR"
done

echo "🎉 All downloads completed!"
