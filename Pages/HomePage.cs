using Miterya.ScreenTest.Collections;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace Miterya.ScreenTest.Pages
{
    public class HomePage : BasePage
    {
        public HomePage(IWebDriver webDriver)
        {
            this.WebDriver = webDriver;
            this.WebDriver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(3);
            this.WebDriver.Navigate().GoToUrl(TestUrl + "/Home");
        }

        public List<string> GetMenuItems()
        {
            ReadOnlyCollection<IWebElement> spanList = getListOfWebElementByTagAndParentClassName("sidebar-menu", "span");
            List<string> menuList = new List<string>();
            for (int i = 0; i < spanList.Count; i++)
            {
                string spanText = GetInnerText(spanList[i]);
                if (spanText != string.Empty)
                {
                    menuList.Add(spanText);
                }
            }

            return menuList;
        }

        public void GoToLogin()
        {
            this.WebDriver.Navigate().GoToUrl(TestUrl + "Account/Login");
        }

        public List<IWebElement> GetMenuButtons()
        {
            ReadOnlyCollection<IWebElement> menuButtons = getListOfWebElementByTagAndParentClassName("sidebar-menu", "span");
            List<IWebElement> menuButtonList = new List<IWebElement>();
            for (int i = 0; i < menuButtons.Count; i++)
            {
                string spanText = GetInnerText(menuButtons[i]);
                if (spanText != string.Empty)
                {
                    menuButtonList.Add(menuButtons[i]);
                }
            }
            return menuButtonList;
        }


        public IWebElement GetMenuButtonByInnerText(string menuInnerText)
        {
            return GetElementByTagChildTagAndInnerText("a","span", menuInnerText);
        }                

        public IWebElement GetWebElementByInnerText(string menuInnerText)
        {
            return GetElementByTagChildTagAndInnerText("td", "div", menuInnerText);
        }

        public void SendKeysToElementById(string elementID, string inputText)
        {
            WebDriver.FindElement(By.Id(elementID)).SendKeys(inputText);
        }
    }
}
