using Miterya.ScreenTest.Collections;
using Miterya.ScreenTest.Pages;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Text;

namespace Miterya.ScreenTest.OtherTests
{
    [TestFixture]
    class Miscellaneous : BaseTest
    {
        [Test]
        public void LoginTestWithWrongCredentials()
        {
            var loginPage = SeleniumExtras.PageObjects.PageFactory.InitElements<LoginPage>(WebDriver);
            loginPage.Login("notcorrect", "totallywrong");
         
            var errorElement = loginPage.GetValueById(WebDriver, "ErrorMessage.Text");
            Assert.AreEqual(errorElement, "Kullanıcı adı veya şifre hatalı", "Login failure isn't being reported.");            
        }

        [Test]
        public void LoginTestWithEmptyCredentials()
        {
            var loginPage = SeleniumExtras.PageObjects.PageFactory.InitElements<LoginPage>(WebDriver);
            loginPage.Login("", "");

            var errorElement = loginPage.GetValueById(WebDriver, "ErrorMessage.Text");
            Assert.AreEqual(errorElement, "Kullanıcı adı ve şifre alanları zorunlu alanlardır.", "Login failure isn't being reported.");
        }
    }
}
