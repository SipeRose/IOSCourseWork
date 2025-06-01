from flask import Flask, request, jsonify
from flask_cors import CORS
from sqlalchemy import create_engine, text

app = Flask(__name__)
CORS(app)

# Подключение к PostgreSQL
engine = create_engine('postgresql+psycopg2://postgres:52@localhost:5432/postgres')


@app.route('/data', methods=['POST'])
def add_data():
    data = request.json
    with engine.connect() as conn:
        conn.execute(
            text("INSERT INTO mobile_app.alarms_from_repeller (app_id, danger_type) VALUES (:app_id, :danger_type)"),
            {"app_id": data["app_id"], "danger_type": data["danger_type"]}
        )
        conn.commit()
    return jsonify({"status": "ok"}), 201


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)  # Доступен в локальной сети
