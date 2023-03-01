from transformers import pipeline
from flask import Flask, request, jsonify

# Chargez le modèle ChatGPT pré-entraîné
generator = pipeline('text-generation', model='EleutherAI/gpt-neo-2.7B')

# Créez une fonction qui utilise le modèle pour générer une réponse
def generate_response(input_text):
    response = generator(input_text, max_length=50)[0]['generated_text']
    return response.strip()

# Initialisez Flask
app = Flask(__name__)

# Définissez une route pour la requête HTTP POST
@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    input_text = data['input_text']
    response = generate_response(input_text)
    return jsonify({'response': response})

# Lancez l'application Flask
if __name__ == '__main__':
    app.run(debug=True)
