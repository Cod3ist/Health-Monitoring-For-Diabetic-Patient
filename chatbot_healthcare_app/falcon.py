#falcon.py
import os
from langchain import HuggingFaceHub, PromptTemplate, LLMChain

API = "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"
os.environ["HUGGINGFACE_API_TOKEN"] = API

def chatbot(question):
    repo_id = "tiiuae/falcon-7b-instruct"
    llm = HuggingFaceHub(
        huggingfacehub_api_token = API,
        repo_id = repo_id,
        model_kwargs = {"temperature":0.5, "max_new_tokens":1300}
    )

    template = """
    You are a conversational AI assistant for diabetic patients, provide the answer for their question asked in a friendly way.
    
    {query}
    Answer:
    """

    prompt = PromptTemplate(template=template, input_variables=["question"])
    llm_chain  = LLMChain(prompt = prompt, llm = llm)

    result = llm_chain.run(question+'(asked by a diabetic patient)')
    return result.split('Answer:')[1]
