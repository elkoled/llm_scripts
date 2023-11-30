# llm_scripts
This is a collection of scripts related to local LLM execution.

# llama_cpp.bat
- download latest version of [llama.cpp](https://github.com/ggerganov/llama.cpp/releases)
- you need `cudart-llama-bin-win-cu12.x.x-x64.zip` and `llama-xxxxx-bin-win-cublas-cu12.x.x-x64.zip`
- Extract both zip files to folder `llama_cpp`
- It should now contain several .exe and .dll files

### Usage
- Start `llama_cpp.bat`
- It will query a few questions about what model to use, how much context to use and to what percentage to use GPU
- Models will be downloaded automatically
