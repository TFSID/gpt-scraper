import undetected_chromedriver as uc 
import time 
 
options = uc.ChromeOptions() 
options.headless = False  # Set headless to False to run in non-headless mode

driver = uc.Chrome(use_subprocess=True, options=options) 
driver.get("https://www.g2.com/products/asana/reviews") 
driver.maximize_window() 

time.sleep(20) 
driver.save_screenshot("datacamp.png") 
driver.close()
