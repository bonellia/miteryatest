using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Builders;
using Miterya.ScreenTest.Collections;
using Miterya.ScreenTest.Pages;
using Miterya.Service.OrganizationServices;
using NUnit.Framework;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Linq;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    class PersonnelTests: BaseTest
    {
        User personnelUser;
        DataBuilder data;
        OrganizationServices organizationServices;

        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            organizationServices = new OrganizationServices(contextBuilder.GetContext());
            //Create Data
            data = new DataBuilder(contextBuilder)
                .CreateDummyUser()
                .CreateOrganizationByType(OrganTypeEnum.Classroom)
                .SetRol(RoleEnum.Personnel);

            this.personnelUser = data.user;
            data.userBuilder.SetTemperament(contextBuilder.GetContext(), personnelUser.Id, 330);
        }

        [Test]
        public void PersonnelLoginTest()
        {
            util.LoginExpectingSuccess(personnelUser);
        }

        [Test]
        public void PersonnelProfilePageAccessTest()
        {
            util.AccessProfilePage(personnelUser);
        }

        [Test]
        public void PersonnelMessagePanelTest()
        {
            util.SendEmptyMessage(personnelUser);
        }

        [Test]
        public void PersonnelMenuAuthorizationTest()
        {
            List<String> expectedMenuList = new List<string>
            {
                "Ana Sayfa",
                "Anketlerim",
                "Mizaç Profil Analiz",
                "Mizaç Testim",
                "Yetişkin Mizaç Profili Analizi"
            };

            util.CheckVisibleMenus(personnelUser, expectedMenuList);
        }

        [Test]
        public void PersonnelVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
                new MenuItem("","Anketlerim"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz","Mizaç Testim"),
                new MenuItem("Mizaç Profil Analiz","Yetişkin Mizaç Profili Analizi"),

            };

            util.VisitMenus(personnelUser, expectedMenuItemList);
        }

        [Test]
        public void PersonnelSurveyTest()
        {
            // TODO (Taha) Move this to TestUtil, then add similar tests with appropriate surveys to other roles.
            util.JustLogin(personnelUser);
            data.AddDummySurveyTestToUser(personnelUser.Id, personnelUser.Id, 60268);
            data.AddDummySurveyTestToUser(personnelUser.Id, personnelUser.Id, 60285);
            util.NavigateToPage("", "Anketlerim");

            // Open the survey.
            var surveyButton = WebDriver.FindElement(By.XPath("//a[@class ='btn btn-sm btn-info']"));
            surveyButton.Click();
            WebDriver.SwitchTo().Window(WebDriver.WindowHandles.Last());

            var surveyPage = new SurveyPage(WebDriver);
            surveyPage.SolveRadioButtonTestRandom();
            var completeSurveyButton = WebDriver.FindElement(By.XPath("//input[@class ='sv_complete_btn']"));
            completeSurveyButton.Click();
        }                    
    }
}
