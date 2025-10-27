#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh

# Packages are installed after nodes so we can fix them...

#DEFAULT_WORKFLOW="https://..."

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/rgthree/rgthree-comfy",
    "https://github.com/pythongosssss/ComfyUI-WD14-Tagger",
    "https://github.com/cubiq/ComfyUI_essentials",
    "https://github.com/ZHO-ZHO-ZHO/ComfyUI-BRIA_AI-RMBG",
    "https://github.com/spacepxl/ComfyUI-Image-Filters",
    "https://github.com/comfyanonymous/ComfyUI_experiments.git"
)

CHECKPOINT_MODELS=(
    # "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    # "https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    # "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
)

UNET_MODELS=(

)

LORA_MODELS=(

)

VAE_MODELS=(
    # "https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.safetensors"
    # "https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
)

ESRGAN_MODELS=(
    #"https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    #"https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    #"https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
)

CONTROLNET_MODELS=(
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors?download"
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_depth-fp16.safetensors"
    # "https://huggingface.co/kohya-ss/ControlNet-diff-modules/resolve/main/diff_control_sd15_depth_fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_hed-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_mlsd-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_normal-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_seg-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_color-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_keypose-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_seg-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors"
    # "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_style-fp16.safetensors"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
    download_custom_models
    provisioning_print_end
}

function pip_install() {
    if [[ -z $MAMBA_BASE ]]; then
            "$COMFYUI_VENV_PIP" install --no-cache-dir "$@"
        else
            micromamba run -n comfyui pip install --no-cache-dir "$@"
        fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip_install ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/opt/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip_install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip_install -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > /opt/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

function download_custom_models() {
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
    download_model "https://civitai.com/api/download/models/1736657?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "Realism_Illustrious_By_Stable_Yogi.safetensors"
    download_model "https://civitai.com/api/download/models/1485344" "$CKPT_DIR/illustrious" "Unholy_Desire_Mix_Sinister_Aesthetic.safetensors"
    download_model "https://civitai.com/api/download/models/1443129" "$CKPT_DIR/illustrious" "PerfectRSBmix.safetensors"
    download_model "https://civitai.com/api/download/models/1413921" "$CKPT_DIR/illustrious" "Uncanny_Valley.safetensors"
    download_model "https://civitai.com/api/download/models/1471829" "$CKPT_DIR/illustrious" "CyberIllustrious_CyberRealistic.safetensors"
    download_model "https://civitai.com/api/download/models/1757828?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "iLstMix.safetensors"
    download_model "https://civitai.com/api/download/models/1527952?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "Diving-Illustrious_Semi-Real.safetensors"
    download_model "https://civitai.com/api/download/models/1732686?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "Diving-Illustrious_Anime.safetensors"
    download_model "https://civitai.com/api/download/models/1794965?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "BismuthIllustriousMix.safetensors"
    download_model "https://civitai.com/api/download/models/1387129?type=Model&format=SafeTensor&size=pruned&fp=fp16" "$CKPT_DIR/illustrious" "Be-Mix-Illustrious.safetensors"
    
    # Download Upscalers
    # wget https://huggingface.co/Kim2091/UltraSharp/blob/main/4x-UltraSharp.safetensors /workspace/ComfyUI/models/upscale_models/
    # wget https://huggingface.co/Kim2091/AnimeSharp/blob/main/4x-AnimeSharp.safetensors /workspace/ComfyUI/models/upscale_models/
    
    # Download Lora Models with Explicit Paths
    download_model "https://civitai.com/api/download/models/424720" "$LORA_DIR/sdxl" "LCM_Model_1.safetensors"
    download_model "https://civitai.com/api/download/models/424706" "$LORA_DIR/sd15" "LCM_Model_2.safetensors"
    download_model "https://civitai.com/api/download/models/652659" "$LORA_DIR/pony" "Pony_LCM.safetensors"

    # Download the preview models
    # wget https://github.com/madebyollin/taesd/blob/main/taesdxl_decoder.pth /workspace/ComfyUI/models/vae_approx/
    # wget https://github.com/madebyollin/taesd/blob/main/taesdxl_encoder.pth /workspace/ComfyUI/models/vae_approx/    

    # Download BRIA background remover model
    git clone https://huggingface.co/briaai/RMBG-1.4 /workspace/ComfyUI/custom_nodes/ComfyUI-BRIA_AI-RMBG/RMBG-1.4

    # Download deepseek
    # git clone https://huggingface.co/deepseek-ai/Janus-Pro-7B /workspace/ComfyUI/models/Janus-Pro/
    
    echo "🎉 All downloads completed!"
}

provisioning_start
