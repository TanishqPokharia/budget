from ctransformers import AutoModelForCausalLM
from flask import Flask, request, jsonify
import os
from langchain_community.document_loaders import PyMuPDFLoader
from LoadLLM import Loadllm
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.chains import ConversationalRetrievalChain

DB_FAISS_PATH = 'vectorstore/db_faiss'

app = Flask(__name__)

@app.route('/')
def home():
    return "API Server Running"


@app.route('/PromptBuddy', methods=['GET', 'POST'])
def PromptLLM():
    pdf_file = request.files['file']
    pdf_name = pdf_file.filename
    user_prompt = request.form.get('query')
    pdf_file.save(pdf_name)


    loader = PyMuPDFLoader(file_path=pdf_name)
    data = loader.load()


    # Create embeddings using Sentence Transformers
    embeddings = HuggingFaceEmbeddings(model_name='sentence-transformers/all-MiniLM-L6-v2')

    # Create a FAISS vector store and save embeddings
    db = FAISS.from_documents(data, embeddings)
    db.save_local(DB_FAISS_PATH)

    # Load the language model
    llm = Loadllm.load_llm()

    # Create a conversational chain
    chain = ConversationalRetrievalChain.from_llm(llm=llm, retriever=db.as_retriever())

    result = chain({"question": user_prompt, "chat_history":''})
    return result["answer"]


if __name__ == '__main__':
    app.run(debug=True)
