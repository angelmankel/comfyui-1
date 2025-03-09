#!/bin/bash

# Ensure the CivitAI API token is set before running the script
if [[ -z "$CIVITAI_TOKEN" ]]; then
    echo "Error: CIVITAI_TOKEN is not set. Please export it before running the script."
    exit 1
fi

# Define download function with explicit filenames and folder paths
download_model() {
    local url="$1"
    local folder="$2"
    local filename="$3"

    # Ensure target directory exists
    mkdir -p "$folder"

    echo "Downloading: $filename to $folder..."
    
    # Use curl with authentication
    curl -L -H "Authorization: Bearer $CIVITAI_TOKEN" -o "$folder/$filename" "$url"

    if [[ $? -eq 0 ]]; then
        echo "✅ Successfully downloaded: $filename"
    else
        echo "❌ Failed to download: $filename"
    fi
}

# Define base directories
BASE_DIR="/workspace/storage/stable_diffusion/models"
CKPT_DIR="$BASE_DIR/ckpt"
LORA_DIR="$BASE_DIR/lora"

# Download Checkpoint Models with Explicit Paths
download_model "https://civitai.com/api/download/models/1422871?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/sdxl" "SDXL_Realism_By_Stable_Yogi.safetensors"
download_model "https://civitai.com/api/download/models/1372996" "$CKPT_DIR/illustrious" "Illustrious_Realism_By_Stable_Yogi.safetensors"
download_model "https://civitai.com/api/download/models/1485344" "$CKPT_DIR/illustrious" "Unholy_Desire_Mix_Sinister_Aesthetic.safetensors"
download_model "https://civitai.com/api/download/models/1443129" "$CKPT_DIR/illustrious" "PerfectRSBmix.safetensors"
download_model "https://civitai.com/api/download/models/1413921" "$CKPT_DIR/illustrious" "Uncanny_Valley.safetensors"
download_model "https://civitai.com/api/download/models/1471829" "$CKPT_DIR/illustrious" "CyberIllustrious_CyberRealistic.safetensors"

# Download Lora Models with Explicit Paths
download_model "https://civitai.com/api/download/models/424720" "$LORA_DIR/sdxl" "LCM_Model_1.safetensors"
download_model "https://civitai.com/api/download/models/424706" "$LORA_DIR/sd15" "LCM_Model_2.safetensors"
download_model "https://civitai.com/api/download/models/652659" "$LORA_DIR/pony" "Pony_LCM.safetensors"

echo "🎉 All downloads completed!"
