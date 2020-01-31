using NUnit.Framework;
using OpenQA.Selenium;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Miterya.ScreenTest.Collections
{
    public class BasePage
    {
        public IWebDriver WebDriver { get; set; }

        public string TestUrl { get; set; } = "http://localhost:33069/";


        // Setting Value By Id -- Ilgili Id Tagine Sahip Input Degeri Atama
        public void SetValueById(string elementId, string value)
        {
            var element = WebDriver.FindElement(By.Id(elementId));
            element.SendKeys(value);
        }

        // Getting Value By Id -- Ilgili Id Tagine Sahip Elementin Text Bilgisini Cekme
        public string GetValueById(string elementId)
        {
            return WebDriver.FindElement(By.Id(elementId)).Text;
        }

        // Clicking Button By Id -- Ilgili Id Tagine Sahip Butona Basma
        public void ClickButtonById(IWebDriver webDriver, string elementId)
        {
            webDriver.FindElement(By.Id(elementId)).Click();
        }

        // Clicking Button By ClassName -- Ilgili ClassName Tagine Sahip Butona Basma
        // This method has been changed to use By.Xpath's class picker instead,
        // because By.ClassName doesn't allow whitespaces inside class name.
        public void ClickButtonByClassName(string className)
        {
            WebDriver.FindElement(By.XPath($"//*[contains(@class, '{className}')]")).Click();
        }

        public ReadOnlyCollection<IWebElement> getListOfWebElementByClassName(string name)
        {
            return WebDriver.FindElements(By.Id("ErrorMessage.Text"));
        }

        public ReadOnlyCollection<IWebElement> getListOfWebElementByTagAndParentClassName(string parentClassName, string tagName)
        {
            return WebDriver.FindElements(By.CssSelector("." + parentClassName + " " + tagName));
        }

        public string GetInnerText(IWebElement webElement)
        {
            return webElement.GetAttribute("innerText");
        }

        public IWebElement GetElementByTagAndInnerText(string tag, string innerText)
        {
            return WebDriver.FindElement(By.XPath("//"+tag + "[contains(text(),'"+innerText+"')]"));
        }

        public IWebElement GetElementByTagChildTagAndInnerText(string ancestorTag, string childTag, string innerText)
        {
            return WebDriver.FindElement(By.XPath("//"+childTag+"[contains(text(),'" + innerText + "')]//ancestor::"+ancestorTag));
        }

        public void ClickButtonByXPath(string xpath)
        {
            WebDriver.FindElement(By.XPath(xpath)).Click();
        }

        public void Login(string name, string password)
        {
            this.SetValueById("UserName.Input.Text", name);
            this.SetValueById("Password.Input.Password", password);
            this.ClickButtonById(WebDriver, "Login.Button.Submit");
        }

        public void LogOut()
        {
            this.ClickButtonById(WebDriver, "Profile.Button.DropDown");
            this.ClickButtonById(WebDriver, "Cikis.Button");
        }

        //Getting Value By Id -- Ilgili Id Tagine Sahip Elementin Text Bilgisini Cekme
        public string GetValueById(IWebDriver webDriver, string elementId)
        {
            return webDriver.FindElement(By.Id(elementId)).Text;
        }

        //Clicking Button By ClassName -- Ilgili ClassName Tagine Sahip Butona Basma
        public void ClickButtonByClassName(IWebDriver webDriver, string className)
        {

            Assert.IsTrue(webDriver.FindElement(By.ClassName(className)).Displayed,
                                                    className + " butonu gorunmuyor");
            webDriver.FindElement(By.ClassName(className)).Click();
        }

        public void GoToProfile()
        {
            this.ClickButtonById(WebDriver, "Profile.Button.DropDown");
            this.ClickButtonById(WebDriver, "ProfilBilgilerim.Button");
        }

        public List<long> GetStudentNationalIDsFromTable(IWebDriver webDriver)
        {
            // Need the table to be filtered load first, so a sleep is necessary here.
            System.Threading.Thread.Sleep(2000);
            ReadOnlyCollection<IWebElement> tableRows = webDriver.FindElements(By.XPath("//tbody/tr/td[3]"));
            List<long> studentNationalIds = new List<long>();
            foreach (var element in tableRows)
            {
                studentNationalIds.Add(long.Parse(element.Text));
            }
            return studentNationalIds;
        }

        public void ClickMenuButtonByInnerText(string menuInnerText)
        {
            System.Threading.Thread.Sleep(666);
            GetElementByTagChildTagAndInnerText("a", "span", menuInnerText).Click();
        }
    }
}
