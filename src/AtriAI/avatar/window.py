import customtkinter as ctk
from PIL import Image
import os

# this will be useful later indeed ;3 
EXE_DIR = os.path.dirname(os.path.abspath(__file__))

class AtriWindow:
    def __init__(self):
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")
        # Window setup :)
        self.root = ctk.CTk()
        self.root.title("AtriAI")
        self.root.geometry("400x90")
        self.root.attributes("-alpha", 0.92)  # here we set the transparency I learned this from Davinci reslove :3
        
        # making input box
        self.input_box = ctk.CTkEntry(self.root, width=260, placeholder_text="Say something...")
        self.input_box.pack(side="left", padx=(10, 5), pady=(0, 10))
        self.input_box.bind("<Return>", self.on_submit)

        # button design :)
        send_button = ctk.CTkButton(
            self.root,
            text="Send",
            command=self.on_submit,
            width=90,
            height=32,
            corner_radius=16,
            fg_color="#00BCFF",
            hover_color="#5CD3FF",
            font=ctk.CTkFont(size=13, weight="bold"),
        )
        send_button.pack(side="left", padx=5, pady=(0, 10))

    def on_submit(self, event=None): # event needs to be none so that pressing enter on input works
        user_text = self.input_box.get()
        if not user_text.strip():
            return
        self.input_box.delete(0, "end")
        
        # TODO: pass user_text to brain.client, then route the reply to voice + avatar

    def run(self):
        self.root.mainloop()

# hey sun if you are reading this we got a bit of choice when it comes to design either we start one window only or we have the chat window and atri as seprate. 
if __name__ == "__main__":
    AtriWindow().run()