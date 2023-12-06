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

### Model overview
**openhermes-2.5-neural-chat-7b-v3-1-7b**
- Specializes in mimicking human conversation, ideal for chatbot applications.

**deepseek-coder-6.7b-instruct**
- Focused on coding and programming assistance, fine-tuned on instruction data.

**zephyr-7b-beta**
- Versatile language model with high accuracy in text generation, suitable for various tasks, comparable to OpenAI GPT-4 in some areas.

**pivot-0.1-evil-a**
- Unique in response variety, fine-tuned from the Mistral 7B model, suitable for creative applications.

**dolphin-2.2.1-mistral-7b**
- Known for enhanced conversation and empathy, designed for engaging and personal interactions.

**starling-lm-7b-alpha**
- Trained by AI feedback, excelling in education, STEM, humanities, writing, and role play, versatile across multiple fields.