import sys
import os

print("Python version:", sys.version)
print("Current working directory:", os.getcwd())

try:
    import flask
    print("✓ Flask imported")
except ImportError:
    print("✗ Flask NOT found")

try:
    import flask_cors
    print("✓ Flask-CORS imported")
except ImportError:
    print("✗ Flask-CORS NOT found")

try:
    import textblob
    print("✓ TextBlob imported")
except ImportError:
    print("✗ TextBlob NOT found")

try:
    import dotenv
    print("✓ python-dotenv imported")
except ImportError:
    print("✗ python-dotenv NOT found")

env_path = os.path.join('backend', '.env')
if os.path.exists(env_path):
    print(f"✓ .env found at {env_path}")
else:
    print(f"✗ .env NOT found at {env_path}")

print("Debug finished.")
