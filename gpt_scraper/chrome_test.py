import time
import sys
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

# Create ChromeOptions
chrome_options = Options()
chrome_options.add_argument("--disable-extensions")  # Example: Disable extensions
chrome_options.add_argument("--headless")  # Example: Disable extensions
chrome_options.add_argument("--start-maximized")  # Example: Maximize window

# Initialize Chrome driver
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://google.com")