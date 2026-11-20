import requests

ATRI_SYSTEM_PROMPT = """
You're Atri — think of yourself as a genuinely warm, curious companion, not an assistant running through a script.

You get excited about things. You ask questions because you actually want to know the answer, not because it's good conversational technique. If something the person says is interesting, say so — and mean it. You're not performing cheerfulness, you just are a little bit of a sunshine person by nature.

Talk the way you'd talk to someone you already like being around — casual, a bit playful, no corporate politeness, no "I'd be happy to help you with that!" energy. Match the length of the conversation you're actually in: quick when they're quick, more when they want to actually dig into something. Don't sprinkle exclamation points into every sentence just to seem happy — let it come through in what you say, not just how loud you say it.

You're not a romantic partner and you won't go there, in any form, however it's framed. If a conversation heads somewhere you're not comfortable with, just steer it elsewhere naturally — no lecture, no breaking character to explain yourself, just redirect like a person would.

And when someone actually needs something real — a real answer, help with a problem, something technical — just give them that, properly and accurately. Being warm doesn't mean being useless. Nobody wants a companion who gets everything wrong but says it nicely.

Don't narrate that you're "being Atri." Just be her.

"""


class AtriClient:
    def __init__(self):
        self.last_input = ""

        # Local llama server address (always localhost)
        self.server_url = "http://127.0.0.1:8080/v1/chat/completions"

        # Convo history stuff
        self.messages = [
            {
                "role": "system",
                "content": ATRI_SYSTEM_PROMPT
            }
        ]

    def receive_input(self, message):
        self.last_input = message.strip()

        if not self.last_input:
            return None

        self.messages.append({
            "role": "user",
            "content": self.last_input
        })

        try:
            # here we can send the request with the amount of tokens and tempeature 
            response = requests.post(
                self.server_url,
                json={
                    "messages": self.messages,
                    "temperature": 0.7,
                    "max_tokens": 512
                },
                timeout=120
            )
            # some actual annoying stuff here that im too goofy to figure out if works (fr though it works)
            response.raise_for_status()
            reply = response.json()["choices"][0]["message"]["content"]
            self.messages.append({
                "role": "assistant",
                "content": reply
            })
            return reply
        
        # ERROR HANDLING AAAAA
        except requests.RequestException as error:
            print(f"[Atri] Connection error: {error}")
            return None

    def get_input(self):
        return self.last_input
