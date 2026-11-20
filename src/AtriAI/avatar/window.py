from AtriAI.avatar.layout import COLORS, FONTS, WINDOW_SIZE, WINDOW_TRANSPARENCY # importing from layout config python file 
from AtriAI.brain.client import AtriClient
import customtkinter as ctk


class AtriWindow: 
    def __init__(self):
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")
        # Window setup :)
        self.root = ctk.CTk()
        self.client = AtriClient()
        self.root.title("AtriAI")
        self.root.geometry(f"{WINDOW_SIZE[0]}x{WINDOW_SIZE[1]}") # I HAD TO GOOGLE HERE I HAVE NO IDEA HOW THIS WORKS LOL (width to height btw)
        self.root.attributes("-alpha", WINDOW_TRANSPARENCY)  # here we set the transparency I learned this from Davinci reslove :3

        self.response_label = ctk.CTkLabel(self.root, text="Atri is ready!", wraplength=350)
        self.response_label.pack(padx=10, pady=10)

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

            fg_color=COLORS["send_fg"],

            hover_color=COLORS["send_hover"],

            font=ctk.CTkFont(*FONTS["button"]),
        )
        send_button.pack(side="left", padx=5, pady=(0, 10))

    # Your on_submit function
    def on_submit(self, event=None):
        user_text = self.input_box.get()

        if not user_text.strip():
            return

        self.input_box.delete(0, "end")

        reply = self.client.receive_input(user_text)

        if reply:
            self.response_label.configure(text=reply)
        else:
            self.response_label.configure(text="Couldn't connect to Atri's local model :(")
    def run(self):
        self.root.mainloop()

# hey sun if you are reading this we got a bit of choice when it comes to design either we start one window only or we have the chat window and atri as seprate. 
if __name__ == "__main__":
    AtriWindow().run()