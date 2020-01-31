using OpenQA.Selenium;
using NUnit.Framework;
using Miterya.ScreenTest.Collections;
using Miterya.Domain.Common.Enums;
using System;

namespace Miterya.ScreenTest.Pages
{
    [TestFixture]
    [Parallelizable]
    public class LoginPage : BasePage
    {
        public LoginPage(IWebDriver webDriver)
        {
            this.WebDriver = webDriver;
            this.WebDriver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(3);
            this.WebDriver.Navigate().GoToUrl(TestUrl + "Account/Login");
        }

        public void TypeUserName(string name)
        {
            this.SetValueById("UserName.Input.Text", name);
        }

        public void TypePassword(string password)
        {
            this.SetValueById("Password.Input.Password", password);
        }

        public void ClickLogin()
        {
            this.ClickButtonById(WebDriver, "Login.Button.Submit");
        }

        public void SelectRole(RoleEnum roleEnum)
        {
            //webDriver.FindElement(By.Id(roleEnum.ToString())).Click();
            ClickButtonById(WebDriver, ((int)roleEnum).ToString());
            ClickLogin();

        }

        public void MultipleRolesLogin(string name, string password, RoleEnum roleEnum)
        {
            TypeUserName(name);
            TypePassword(password);
            ClickLogin();
            SelectRole(roleEnum);
        }

        public int GetErrorCount()
        {
            return getListOfWebElementByClassName("ErrorMessage.Text").Count;
        }

        public void ChooseRole()
        {

        }
    }
}
