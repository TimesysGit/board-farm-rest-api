from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.alert import Alert
import unittest
import os
import time

DEFAULT_IPADDR="192.168.1.2"
DEFAULT_PORT = "9090"


class AddressBook(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome('./chromedriver')
        self.driver.maximize_window()
        IPADDR=os.environ.get("IPADDR", DEFAULT_IPADDR)
        PORT= os.environ.get("PORT", DEFAULT_PORT)
        URL="http://%s:%s/AddressBook.html" % (IPADDR, PORT)
        self.driver.get(URL)
        self.driver.implicitly_wait(10)

    ##############################********************(test_add_user)**********************####################################
    def test_add_user(self):
        user_info = {' Forename':'ELC',
            ' Surname':'Demo',
            ' Email':'elc.demo@timesys.com',
            ' Phone':'0000000000'}

	# manual wait for visibility during demo run
        time.sleep(2)

        # Click on Adduser button
        addbutton = self.driver.find_element(By.ID, "addButton")
        addbutton.click()

        # manual wait for visibility during demo run
        time.sleep(2)
        rowsintable = self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")
        numberofusers = (len(rowsintable)) 

	# manual wait for visibility during demo run
        time.sleep(2)

        # Fill new user details
        self.driver.find_element(By.ID, "forenameEdit").send_keys(user_info[" Forename"])
        self.driver.find_element(By.ID, "surnameEdit").send_keys(user_info[" Surname"])
        self.driver.find_element(By.ID, "emailEdit").send_keys(user_info[" Email"])
        self.driver.find_element(By.ID, "phoneEdit").send_keys(user_info[" Phone"])

        # manual wait for visibility during demo run
        time.sleep(2)

        # Click on save button to add records in the table
        savebuttonelement = self.driver.find_element(By.XPATH, "//body/div[3]//div[@class='ui-dialog-buttonset']/button[1]/span[@class='ui-button-text']")
        savebuttonelement.click()
	# Number of rows in table after adding a  user
        usersintable = self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")

        #
        # Verifications
        #
        # Verification 1 : Record count increased by one
        self.assertEqual(len(usersintable),numberofusers+1)

        # Verification 2 : New user data match
        rows=len(self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")) #count the number of rows 
        col=len(self.driver.find_elements(By.XPATH,"//table/thead/tr/th")) #count the number of column
        user_data_extracted = []
        for r in range(2,rows+1):
            tem_dict={}
            for c in range(2,col+1):
		#extracted user details from cell and storing them in a temprory dictionary  then making a list of dictionaries
                userdata = self.driver.find_element(By.XPATH, '//table[@id="addresses"]/tbody/tr['+str(r)+']/td['+str(c)+']').text
                keyheader = self.driver.find_element(By.XPATH,"//table/thead/tr/th["+str(c)+"]").text
                tem_dict[keyheader]=userdata
            user_data_extracted.append(tem_dict)

	# looking for the newly added user in the list of dictionry if found then testcases passes otherwise it gets fail.
        self.assertIn(user_info,user_data_extracted)



    ##############################********************(test_edit_user)**********************####################################
    def test_edit_user(self):
        #User Detail
        user_info = {' Forename':'Edituser',
            ' Surname':'Demo',
            ' Email':'elc.demo@timesys.com',
            ' Phone':'0000000000'}

	# manual wait for visibility during demo run
        time.sleep(2)

        # select a user from a list 
        selectauser = self.driver.find_element(By.XPATH, "//input[@id='jqg_addresses_1']")
        selectauser.click()

        # manual wait for visibility during demo run
        time.sleep(2)

        # select edit button to modify the data
        editbutton = self.driver.find_element(By.XPATH, "//input[@id='editButton']")
        editbutton.click()

        # manual wait for visibility during demo run
        time.sleep(2)

        # Edit user details
        forename=self.driver.find_element(By.ID, "forenameEdit")
        forename.clear()
        forename.send_keys(user_info[" Forename"])
        surname=self.driver.find_element(By.ID, "surnameEdit")
        surname.clear()
        surname.send_keys(user_info[" Surname"])
        email=self.driver.find_element(By.ID, "emailEdit")
        email.clear()
        email.send_keys(user_info[" Email"])
        phone=self.driver.find_element(By.ID, "phoneEdit")
        phone.clear()
        phone.send_keys(user_info[" Phone"])

        # manual wait for visibility during demo run
        time.sleep(2)
        saveuserbutton=self.driver.find_element(By.XPATH, "//body/div[3]//div[@class='ui-dialog-buttonset']/button[1]/span[@class='ui-button-text']")
        saveuserbutton.click()

        # Verification 1 : Edit user data match
        rows=len(self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")) #count the number of rows 
        col=len(self.driver.find_elements(By.XPATH,"//table/thead/tr/th")) #count the number of column
        user_data_extracted = []
        for r in range(2,rows+1):
            tem_dict={}
            for c in range(2,col+1):
		#extracted user details from cell and storing them in a temprory dictionary  then making a list of dictionary
                userdata = self.driver.find_element(By.XPATH, '//table[@id="addresses"]/tbody/tr['+str(r)+']/td['+str(c)+']').text
                keyheader = self.driver.find_element(By.XPATH,"//table/thead/tr/th["+str(c)+"]").text
                tem_dict[keyheader]=userdata
            user_data_extracted.append(tem_dict)
        # looking for the edited user information in the list of dictionry if found then testcases passes otherwise it gets fail.
        self.assertIn(user_info,user_data_extracted)


    ##############################********************(test_remove_user)**********************####################################
    def test_remove_user(self):
        # users detail
        user_info = {' Forename':'Aillie',
            ' Surname':'Lant',
            ' Email':'ailli.lant@harkins.net',
            ' Phone':'579 102 6482'}
        rows=len(self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")) #count the number of rows 
        col=len(self.driver.find_elements(By.XPATH,"//table/thead/tr/th")) #count the number of column

        # Select a user from the list 
        user_data_extracted = []
        for r in range(2,rows+1):
            for c in range(2,col+1):
                userdata = self.driver.find_element(By.XPATH, '//table[@id="addresses"]/tbody/tr['+str(r)+']/td['+str(c)+']').text
            for value in user_info.values():
                if value == userdata:
                    selectuser= self.driver.find_element(By.XPATH, "//input[@id='jqg_addresses_"+(str(r-1))+"']")
                    selectuser.click()
                    break

        # click on remove button 
        removebutton = self.driver.find_element(By.XPATH, "//input[@id='removeButton']")
        removebutton.click()
	# manual wait for visibility during demo run
        time.sleep(1)
        alert = Alert(self.driver)
        alert.accept()
        # manual wait for visibility during demo run
        time.sleep(2)

	#Count the number of users remaining in table
        remainingusers=len(self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr"))

        # Verification 1 : Record count decreased by one
        self.assertEqual(remainingusers,rows-1)

        # Verification 2 : New user data match

        rows=len(self.driver.find_elements(By.XPATH,"//table[@id='addresses']/tbody/tr")) #count the number of rows 
        col=len(self.driver.find_elements(By.XPATH,"//table/thead/tr/th")) #count the number of column
        user_data_extracted = []
        for r in range(2,rows+1):
            tem_dict={}
            for c in range(2,col+1):
                userdata = self.driver.find_element(By.XPATH, '//table[@id="addresses"]/tbody/tr['+str(r)+']/td['+str(c)+']').text
                keyheader = self.driver.find_element(By.XPATH,"//table/thead/tr/th["+str(c)+"]").text
                tem_dict[keyheader]=userdata
            user_data_extracted.append(tem_dict)

	# The test case gets fail when  removed user gets found in the list of the dictionary
        self.assertNotIn(user_info,user_data_extracted)

    def tearDown(self):
        self.driver.quit()
