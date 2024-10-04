import gpt_scraper

def run():
   # create instance
    chat_instance = gpt_scraper.ChatGPT(
        hidden=True
    )  # give argument 'hidden=True' if you want to open chrome in headless mode. Default in non-headless
    chat_instance.set_credentials("youremail", "youropenaipassword")

   # login
    try:
        chat_instance.login()
    except gpt_scraper.InvalidCredentialsError as e:  # if credentails were invalid
        return
    except (
        TimeoutError
    ):  # if something else goes wrong during login (like if a button was not found after repeated tries)
        return

   # query
    question = 'Hey, how are you?'
    try:
        response = chat_instance.query(question)
        print(f"Response: {response}")
    except (
        TimeoutError
    ):  # if a button or web-element was not found after repeated tries. This exception is also raised by the query() method if ChatGPT gave an empty string ('') as reponse (rare)
        return
    except (
        RuntimeError
    ):  # if something goes wrong while getting the response. See error section below for more help
        return

   # logout
    try:
      if chat_instance.logged_in():
        chat_instance.logout(
            clear_chats=False
        )  # to not clear all chats before logging out. Default is True
    except TimeoutError:  # Exceptions can occur if clear_chats was set to True
        pass
run()