@echo off
SETLOCAL EnableDelayedExpansion

REM Define model names and URLs
SET "models[1]=openhermes-2.5-neural-chat-7b-v3-1-7b"
SET "models[2]=deepseek-coder-6.7b-instruct"
SET "models[3]=zephyr-7b-beta"
SET "models[4]=pivot-0.1-evil-a"
SET "models[5]=dolphin-2.2.1-mistral-7b"
SET "models[6]=starling-lm-7b-alpha"
SET "models[7]=llama2-13b-tiefighter"
SET "models[8]=pygmalion-2-13b"
SET "models[9]=mythomax-l2-13b"
SET "models[10]=psymedrp-v1-20b"
SET "models[11]=llama2-13b-psyfighter2"

REM Define base URLs for each model
SET "baseURLs[1]=https://huggingface.co/TheBloke/OpenHermes-2.5-neural-chat-7B-v3-1-7B-GGUF/resolve/main/"
SET "baseURLs[2]=https://huggingface.co/TheBloke/deepseek-coder-6.7B-instruct-GGUF/resolve/main/"
SET "baseURLs[3]=https://huggingface.co/TheBloke/zephyr-7B-beta-GGUF/resolve/main/"
SET "baseURLs[4]=https://huggingface.co/TheBloke/PiVoT-0.1-Evil-a-GGUF/resolve/main/"
SET "baseURLs[5]=https://huggingface.co/TheBloke/dolphin-2.2.1-mistral-7B-GGUF/resolve/main/"
SET "baseURLs[6]=https://huggingface.co/TheBloke/Starling-LM-7B-alpha-GGUF/resolve/main"
SET "baseURLs[7]=https://huggingface.co/TheBloke/llama2-13B-tiefighter-GGUF/resolve/main/"
SET "baseURLs[8]=https://huggingface.co/TheBloke/pygmalion-2-13B-GGUF/resolve/main/"
SET "baseURLs[9]=https://huggingface.co/TheBloke/mythomax-l2-13B-GGUF/resolve/main/"
SET "baseURLs[10]=https://huggingface.co/TheBloke/psymedrp-v1-20B-GGUF/resolve/main/"
SET "baseURLs[11]=https://huggingface.co/TheBloke/llama2-13B-psyfighter2-GGUF/resolve/main/"

:select_model
ECHO Select a model:
FOR /L %%i IN (1,1,11) DO ECHO %%i. !models[%%i]!
ECHO.
SET /P modelChoice="Enter your choice (1-11): "
IF "!modelChoice!"=="" GOTO select_model

REM Validate model choice
SET modelName=!models[%modelChoice%]!
SET baseURL=!baseURLs[%modelChoice%]!
IF "!modelName!"=="" (
    ECHO Invalid choice, please try again.
    GOTO select_model
)

:select_quality
ECHO Select the model quality, high Q requires more (V)RAM usage, choose highest quality possible for your GPU. Size only applies only for ~7B Models
ECHO 1. Q2 - [~3 GB model, lowest quality]
ECHO 2. Q3 - [~3 GB model, low quality]
ECHO 3. Q4 - [~4 GB model, medium quality]
ECHO 4. Q5 - [~5 GB model, high quality]
ECHO 5. Q6 - [~6 GB model, very high quality]
ECHO.
SET /P qualityChoice="Enter your choice (1-5): "
IF "!qualityChoice!"=="" GOTO select_quality

REM Determine file suffix based on quality
SET "suffix=.Q2_K.gguf"
IF "%qualityChoice%"=="2" SET "suffix=.Q3_K_M.gguf"
IF "%qualityChoice%"=="3" SET "suffix=.Q4_K_M.gguf"
IF "%qualityChoice%"=="4" SET "suffix=.Q5_K_M.gguf"
IF "%qualityChoice%"=="5" SET "suffix=.Q6_K.gguf"

:select_context
ECHO Select the context size - how many words the Language Model can "remember" (Higher values require more (V)RAM):
ECHO 1. 512  (~384  words)
ECHO 2. 1024 (~768  words)
ECHO 3. 2048 (~1536 words)
ECHO 4. 4096 (~3072 words)
ECHO 5. 8129 (~6144 words)
ECHO.
SET /P contextChoice="Enter your choice (1-5): "
IF "!contextChoice!"=="" GOTO select_context

REM Determine context size based on choice
SET "contextSizes[1]=512"
SET "contextSizes[2]=1024"
SET "contextSizes[3]=2048"
SET "contextSizes[4]=4096"
SET "contextSizes[5]=8129"
SET contextSize=!contextSizes[%contextChoice%]!

REM Validate context size choice
IF "!contextSize!"=="" (
    ECHO Invalid choice, please try again.
    GOTO select_context
)

:select_gpu_usage
ECHO Select the percentage of GPU usage (Higher percentage requires more VRAM, 100% GPU is fastest):
ECHO 1. CPU only
ECHO 2. 50% GPU
ECHO 3. 100% GPU
ECHO.
SET /P gpuChoice="Enter your choice (1-3): "
IF "!gpuChoice!"=="" GOTO select_gpu_usage

REM Determine number of layers based on GPU usage choice
SET "nglValue=0" REM Example: 0 layers for CPU only
IF "%gpuChoice%"=="2" SET "nglValue=25" REM Example: 25 layers for 50% usage
IF "%gpuChoice%"=="3" SET "nglValue=50" REM Example: 40 layers for 100% usage

REM Construct model file path and download URL
SET modelFile=!modelName!!suffix!
SET modelPath=.\models\!modelFile!
SET downloadURL=!baseURL!!modelFile!

REM Check if the model exists and download if not
IF NOT EXIST "!modelPath!" (
    ECHO Model file not found. Downloading...
    curl -L "!downloadURL!" -o "!modelPath!"
    ECHO Download complete.
) ELSE (
    ECHO Model file found.
)

REM Start the server with the selected model, context size, and GPU usage
.\llama_cpp\server.exe -c !contextSize! -ngl !nglValue! -m "!modelPath!"

ENDLOCAL
