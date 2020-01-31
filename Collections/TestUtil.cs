using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Pages;
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Interactions;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Miterya.ScreenTest.Collections
{
    public class TestUtil : BaseTest
    {
        private IWebDriver webDriver;
        public TestUtil(IWebDriver webDriver)
        {
            this.webDriver = webDriver;
        }
        
        public class MenuItem
        {
            public string parentName;
            public string menuName;
            public MenuItem(string parentName, string menuName)
            {
                this.parentName = parentName;
                this.menuName = menuName;
            }
        }

        public LoginPage JustLogin(User user)
        {
            var loginPage = new LoginPage(webDriver);
            loginPage.Login(user.UserName, user.Password);
            return loginPage;
        }

        public HomePage NavigateToPage(string menuName, string submenuName)
        {
            var testPage = new HomePage(webDriver);
            testPage.ClickMenuButtonByInnerText(menuName);
            testPage.ClickMenuButtonByInnerText(submenuName);
            return testPage;
        }

        public void LoginThenNavigateToPage(User user, string menuName, string submenuName)
        {
            JustLogin(user);
            NavigateToPage(menuName, submenuName);
        }

        public LoginPage LoginExpectingSuccess(User user)
        {
            var loginPage = new LoginPage(webDriver);
            loginPage.Login(user.UserName, user.Password);

            int loginErrorCount = loginPage.GetErrorCount();
            if (loginErrorCount > 0)
            {
                Assert.IsTrue(loginErrorCount == 0, "Loginden sonra 0 hata bekleniyordu, ancak 0 gelmedi.");
            }
            // Check URL
            Assert.AreEqual(webDriver.Url, TestUrl + "Home", "Ana sayfaya yonlenmedi");
            return loginPage;
        }
        
        public LoginPage LoginExpectingFailure(User user)
        {
            var loginPage = new LoginPage(webDriver);
            loginPage.Login(user.UserName, user.Password);

            int loginErrorCount = loginPage.GetErrorCount();
            if (loginErrorCount > 0)
            {
                Assert.IsFalse(loginErrorCount == 0, "Loginden sonra 0 hata beklenmiyordu, ancak 0 geldi");
            }
            // Check URL
            Assert.AreNotEqual(webDriver.Url, TestUrl + "Home", "Ana sayfaya yonlendi.");
            return loginPage;
        }

        public void SendEmptyMessage(User user)
        {
            // Since this action actually sends a message, currently we don't enter any data.
            JustLogin(user);
            var testPage = new HomePage(webDriver);
            testPage.ClickButtonById(webDriver, "contact.us.dropdown");
            testPage.ClickButtonById(webDriver, "send.message.button");
            string dialogTitle = webDriver.FindElement(By.Id("swal2-title")).Text;
            Assert.AreEqual("İşlem Başarısız", dialogTitle, "Mesaj gonderme islemi basarisiz olmadi.");
        }

        public void AccessProfilePage(User user)
        {
            JustLogin(user);

            var testPage = new HomePage(webDriver);
            testPage.GoToProfile();
            Assert.AreEqual(webDriver.Url, TestUrl + "UserManagement/UserAccountSettings", "Profil sayfasi acilmadi");
        }

        public void CheckVisibleMenus(User user, List<string> expectedMenus)
        {
            JustLogin(user);

            var dashboardPage = new HomePage(webDriver);
            List<string> actualMenuList = dashboardPage.GetMenuItems();

            for (int i = 0; i < expectedMenus.Count; i++)
            {
                Assert.Contains(expectedMenus[i], actualMenuList);
            }

            Assert.AreEqual(expectedMenus.Count, actualMenuList.Count, "olması gereken manü sayısından farklı sayıda menü var");
        }

        public void VisitMenus(User user, List<MenuItem> expectedMenuItems)
        {
            JustLogin(user);

            var dashboardPage = new HomePage(webDriver);
            IWebElement hosgeldinizInfo = dashboardPage.GetWebElementByInnerText("Hoşgeldiniz!");
            Assert.IsNotNull(hosgeldinizInfo, "Hosgeldiniz yazisi gelmedi");
            int count = expectedMenuItems.Count;
            for (int i = 0; i < count; i++)
            {
                MenuItem menuItem = expectedMenuItems[i];
                dashboardPage.ClickMenuButtonByInnerText(menuItem.menuName);
                if (!string.IsNullOrEmpty(menuItem.parentName))
                {
                    string breadCrumpText = webDriver.FindElement(By.Id("aktifMenu")).Text;
                    Assert.AreEqual(menuItem.menuName, breadCrumpText);
                }
            }
        }
        public void CheckPageContent(User user, string roleName)
        {
            JustLogin(user);

            var testPage = new HomePage(webDriver);
            testPage.GoToProfile();
            // Kullanici Tipi
            Assert.AreEqual(roleName, testPage.GetValueById(webDriver, "UserRoleTypeName.b"), "Rol bilgisi yanlis gorunuyor.");
            // TC No
            Assert.AreEqual(user.NationalId.ToString(), testPage.GetValueById(webDriver, "UserNationalID.b"), "TC No bilgisi yanlis gorunuyor.");
            // Organizasyon
            Assert.AreEqual(user.UserOrganizationRoles.FirstOrDefault().Organization.Name, testPage.GetValueById(webDriver, "UserOrganizationName.b"), "Kurum bilgisi yanlis gorunuyor.");
            // Dogum Tarihi
            Assert.AreEqual(user.BirthDate, Convert.ToDateTime(testPage.GetValueById(webDriver, "UserBirthDate.b")), "Dogum Tarihi bilgisi yanlis gorunuyor.");
            // Cinsiyet
            var userGender = user.Sex ? "Erkek" : "Kadin";
            Assert.AreEqual(userGender, testPage.GetValueById(webDriver, "UserGender.b"), "Cinsiyet bilgisi yanlis gorunuyor.");
            // Tel. No
            Assert.AreEqual(user.PhoneNumber, testPage.GetValueById(webDriver, "UserPhoneNumber.b"), "Tel No bilgisi yanlis gorunuyor.");
        }

        public void UpdateProfile(User user)
        {
            JustLogin(user);

            // Go to profile page with header profile button
            var testPage = new HomePage(webDriver);
            testPage.GoToProfile();

            var intendedEmail = "testi@legitdomain.co";
            var intendedTelNo = "7776655";

            // Intentionally not using helper methods from BaseTest Class for practice purposes.
            // Also some methods do not fetch proper attribute values.

            var oldEmailElement = webDriver.FindElement(By.Id("inputEmail"));
            oldEmailElement.Clear();
            oldEmailElement.SendKeys(intendedEmail);

            var oldTelNoElement = webDriver.FindElement(By.Id("inputTelephoneNumber"));
            oldTelNoElement.Clear();
            oldTelNoElement.SendKeys(intendedTelNo);

            testPage.ClickButtonById(webDriver, "submitBtn");

            // Left panel with user table contains only telephone number.
            // To check whether both values are updated or not, refreshing page and comparing.
            // Note that this method relays on page loading current values properly in forms.
            webDriver.Navigate().Refresh();

            var newEmailElement = webDriver.FindElement(By.Id("inputEmail"));
            var newTelNoElement = webDriver.FindElement(By.Id("inputTelephoneNumber"));

            // Need to fetch elements again after page is refreshed for some reason.
            var newEmail = newEmailElement.GetAttribute("value");
            var newTelNo = newTelNoElement.GetAttribute("value");

            Assert.AreEqual(intendedEmail, newEmail, "Email address has been failed to be updated.");
            Assert.AreEqual(intendedTelNo, newTelNo, "Telephone number has been failed to be updated.");
        }

        public void SolvePersonalGuidanceSurvey(string surveyName)
        {
            if (surveyName == "Davranışsal Değer Gelişim Takibi")
            {
                NavigateToPage("Değer Farkındalık Gelişim", surveyName);
            }
            else
            {
                NavigateToPage("Kişisel Gelişim", surveyName);
            }
            // Open the survey.
            var surveyButton = webDriver.FindElement(By.XPath("//i[@class ='fa fa-edit']"));
            surveyButton.Click();
            webDriver.SwitchTo().Window(webDriver.WindowHandles.Last());
            var surveyPage = new SurveyPage(webDriver);
            // Answer the questions.
            surveyPage.SolveRadioButtonTestRandom();
            var completeSurveyButton = webDriver.FindElement(By.XPath("//input[@class ='sv_complete_btn']"));
            completeSurveyButton.Click();
        }

        /*
        public string GetRoleofUser(User user)
        {
            // Start with user,
            var userID = user.Id;
            // From user's ID, fetch user's organization role ID from UserOrganizationRole table.
            var userUORID = contextBuilder.GetContext().UserOrganizationRoles.Where(uor => uor.UserId == userID).FirstOrDefault().RoleId;
            // From user's organization role ID, fetch role name (US) from Roles table.
            var roleName = contextBuilder.GetContext().Roles.Where(r => r.Id == userUORID).FirstOrDefault().RoleName_US;
            return roleName;
        }
        */

        /*
        public void SolveTemperamentTest()
        {
            NavigateToPage("Mizaç Profil Analiz", "Mizaç Testim");
            var startTestButton = WebDriver.FindElement(By.XPath("//button[@class = 'btn btn-success']"));
            startTestButton.Click();

            IReadOnlyCollection<IWebElement> thumbs;
            IWebElement bar;
            while (WebDriver.PageSource.Contains("irs-slider") || WebDriver.PageSource.Contains("confirm"))
            {
                if (WebDriver.PageSource.Contains("irs-slider"))
                {
                    thumbs = WebDriver.FindElements(By.XPath($"//*[@class = 'irs-slider single']"));
                    bar = WebDriver.FindElement(By.XPath($"//span[@class = 'irs-line']"));
                    foreach (var thumb in thumbs)
                    {
                        var offset = new Random().Next(0, bar.Size.Width);
                        Actions action = new Actions(WebDriver);
                        action.ClickAndHold(thumb);
                        action.DragAndDropToOffset(thumb, offset, 0);
                        action.Release();
                        action.Build().Perform();
                    }
                    WebDriver.FindElement(By.XPath("//button")).Click();
                }

                if (WebDriver.PageSource.Contains("confirm"))
                {
                    WebDriver.FindElement(By.ClassName("confirm")).Click();
                }
            }
        }
        */

    }
}
