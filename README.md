# create-python-flask-app
a bash script for initiating a flask project (create-python-flask-app)
README.md

# Create Python Flask App

This is a Bash script to initialize a new Python Flask project. The script sets up a basic Flask application with virtual environment, installs required packages, and creates essential files and directories.

## Prerequisites

- Python 3 installed
- `pip` (Python package manager) installed
- `virtualenv` installed (can be installed using `pip install virtualenv`)
- Bash shell (commonly available on Unix/Linux systems)

## Usage

1. Clone this repository or download the script.
2. Make the script executable:
 
   chmod +x create-python-flask-app.sh
Run the script, providing a name for your Flask project:
 
./create-python-flask-app.sh my-flask-app
Replace my-flask-app with your desired project name.

What the Script Does
Creates a project directory with the provided name.
Initializes a Python virtual environment inside the project directory.
Installs Flask in the virtual environment.
Creates a basic Flask application structure:
app.py: The main application file.
static/: Directory for static files (CSS, JavaScript, images).
templates/: Directory for HTML templates.
requirements.txt: Lists project dependencies.
Project Structure
After running the script, your project directory will look like this:
 
my-flask-app/
├── app.py
├── static/
├── templates/
├── venv/
└── requirements.txt
Starting the Flask App
Navigate to your project directory:
 
cd my-flask-app
Activate the virtual environment:
 
source venv/bin/activate
Run the Flask app:
 
flask run
Your Flask app will be available at http://127.0.0.1:5000/.

License
This project is open-source and available under the MIT License.
