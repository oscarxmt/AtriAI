# ya gotta run it with venv
# sun we gotta add this to the readme file


# adding venv to the actual file
# python -m venv .venv

# run it venv: .venv\Scripts\Activate.ps1

# pip install -r requirements.txt

# install the actual project (basically just this nosense we writing here OWWW MY HEAD HURT)

# pip install -e .

# with in venv do this to run.  python src/AtriAI/main.py


# also for your api key made a .env file in the root of the project and add this line to it.  API_KEY=your_api_key_here

from dotenv import load_dotenv
#load_dotenv()  Load environment variables from .env file im too scared too keep this uncommeted
from AtriAI.avatar.window import AtriWindow

if __name__ == "__main__":
    AtriWindow().run()