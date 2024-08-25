#!/bin/bash

# Check if the project name argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Define project name from the argument
PROJECT_NAME="$1"

# Create project directory and subdirectories
mkdir -p "$PROJECT_NAME/app/static/css"
mkdir -p "$PROJECT_NAME/app/static/js"
mkdir -p "$PROJECT_NAME/app/static/images"
mkdir -p "$PROJECT_NAME/app/templates"
mkdir -p "$PROJECT_NAME/migrations"
mkdir -p "$PROJECT_NAME/tests"

# Create __init__.py
cat <<EOL > "$PROJECT_NAME/app/__init__.py"
from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_mail import Mail

# Initialize extensions
db = SQLAlchemy()
migrate = Migrate()
mail = Mail()

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    # Initialize extensions
    db.init_app(app)
    migrate.init_app(app, db)
    mail.init_app(app)

    # Register blueprints
    from app.routes import main
    app.register_blueprint(main)

    # Add additional configurations or setup if needed
    from app.errors import handle_errors
    app.register_error_handler(404, handle_errors.not_found)
    app.register_error_handler(500, handle_errors.server_error)

    app.logger.info('Flask app started')

    return app
EOL

# Create routes.py
cat <<EOL > "$PROJECT_NAME/app/routes.py"
from flask import Blueprint, render_template

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return render_template('index.html')
EOL

# Create config.py
cat <<EOL > "$PROJECT_NAME/config.py"
import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', 'you-will-never-guess')
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL', 'sqlite:///mydatabase.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    MAIL_SERVER = 'smtp.example.com'
    MAIL_PORT = 587
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
EOL

# Create run.py
cat <<EOL > "$PROJECT_NAME/run.py"
from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)
EOL

# Create requirements.txt
cat <<EOL > "$PROJECT_NAME/requirements.txt"
flask
flask_sqlalchemy
flask_migrate
flask_mail
EOL

# Create .flaskenv
cat <<EOL > "$PROJECT_NAME/.flaskenv"
FLASK_APP=run.py
FLASK_ENV=development
EOL

# Create error handlers
mkdir -p "$PROJECT_NAME/app/errors"
cat <<EOL > "$PROJECT_NAME/app/errors.py"
from flask import render_template

def not_found(e):
    return render_template('404.html'), 404

def server_error(e):
    return render_template('500.html'), 500
EOL

# Create empty files for common structures
touch "$PROJECT_NAME/app/models.py"          # For SQLAlchemy models
touch "$PROJECT_NAME/app/forms.py"           # For WTForms forms
touch "$PROJECT_NAME/app/static/css/styles.css"  # Sample CSS file
touch "$PROJECT_NAME/app/static/js/scripts.js"   # Sample JavaScript file
touch "$PROJECT_NAME/app/static/images/placeholder.png" # Sample image file

# Create an empty __init__.py in static to make it a package (if needed)
touch "$PROJECT_NAME/app/static/__init__.py"

echo "Flask project '$PROJECT_NAME' created successfully."
