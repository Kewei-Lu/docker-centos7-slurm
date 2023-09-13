import openai
import sys
# to get proper authentication, make sure to use a valid key that's listed in
# the --api-keys flag. if no flag value is provided, the `api_key` will be ignored.
openai.api_key = "EMPTY"
openai.api_base = "http://localhost:8000/v1"

model = "Chinese-Alpaca-13B-HF"
prompt = "you are an emotional professor, please answer the questions"

def test_chat_completion(content):
    completion = openai.ChatCompletion.create(
        model=model, messages=[{"role": "user", "content": content}]
    )
    print(completion.choices[0].message.content)


def test_chat_completion_stream(content, path):
    messages = [{"role": "user", "content": content}]
    completion = openai.Completion.create(
        model=model, prompt=prompt, max_tokens=128, stream=True
    )
    res = openai.ChatCompletion.create(model=model, messages=messages, stream=True)
    with open(path,"w") as file: 
        for chunk in res:
            content = chunk["choices"][0]["delta"].get("content", "")
            print(content, end="", flush=True)
            file.write(content)
            file.flush()
    print()

# create a chat completion
if __name__ == '__main__':
    content = sys.argv[1]
    path = sys.argv[2]
# test_chat_completion(content)
    test_chat_completion_stream(content, path)


