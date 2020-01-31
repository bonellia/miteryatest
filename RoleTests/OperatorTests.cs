using Miterya.Domain.Common.CustomClass;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Builders;
using Miterya.ScreenTest.Collections;
using Miterya.Service.OrganizationServices;
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using System.Collections.Generic;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    class OperatorTests: BaseTest
    {
        DataBuilder dataBuilder;
        OrganizationServices organizationServices;
        User operatorUser;

        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            organizationServices = new OrganizationServices(contextBuilder.GetContext());
            //Create Data
            dataBuilder = new DataBuilder(contextBuilder)
                .CreateDummyOrganization()
                .CreateDummyTerm()
                .CreateDummyUserWithRoleToOrganization(RoleEnum.Operator);
            dataBuilder.CreateDummySchool(dataBuilder.organizationBuilder.organization.Id, true, true, true, true, 3);
            organizationServices = new OrganizationServices(contextBuilder.GetContext());
            List<Organization> subOrganizations = organizationServices.GetSubOrganisations(dataBuilder.organization.Id);
            List<User> operatorUsers = new List<User>();
            foreach (Organization item in subOrganizations)
            {
                if(item.OrganTypeId == AppSettings.OrganizationTypeId.School)
                {
                    dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(item, RoleEnum.LeaderTeacher,1);
                }
                
                else if (item.OrganTypeId == AppSettings.OrganizationTypeId.Classroom || item.OrganTypeId == AppSettings.OrganizationTypeId.ClassroomWithoutBranch)
                {
                    dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(item, RoleEnum.Student, 20);
                    dataBuilder.SetRoleToOrganization(dataBuilder.user, item, RoleEnum.LeaderTeacher);
                    //data.createListDummyUserWithRoleToOrganization(item, RoleEnum.LeaderTeacher);
                }
            }
            
            foreach (Organization item in subOrganizations)
            {
                operatorUsers = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(item, RoleEnum.Operator, 1);
                
            }
            operatorUser = operatorUsers[0];
            dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), operatorUser.Id, 160);

        }
        [Test]
        public void OperatorLogInTest()
        {
            util.LoginExpectingSuccess( dataBuilder.user);
        }

        [Test]
        public void OperatorProfilePageAccessTest()
        {
            util.AccessProfilePage(operatorUser);
        }
        [Test]
        public void OperatorMessagePanelTest()
        {
            util.SendEmptyMessage(operatorUser);
        }

        [Test]
        public void OperatorMenuAuthorizationTest()
        {
            List<string> expectedMenuList = new List<string> 
            { 
                "Ana Sayfa",
                "Anketlerim",
                "Mizaç Testim",
                "Sistem Yönetimi",
                "Organizasyon Yönetimi",
                "Kullanıcı Yönetimi",
                "Mizaç Profil Analiz",
                "Mizaç Testim"
            };
            util.CheckVisibleMenus(operatorUser, expectedMenuList);
        }

        [Test]
        public void OperatorVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
                new MenuItem("","Sistem Yönetimi "),
                new MenuItem("Sistem Yönetimi ","Organizasyon Yönetimi"),
                new MenuItem("Sistem Yönetimi ","Kullanıcı Yönetimi"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz","Mizaç Testim"),

            };
            util.VisitMenus(operatorUser, expectedMenuItemList);
        }

        [Test]
        public void AddNewUser()
        {
            util.JustLogin(operatorUser);
            util.NavigateToPage("Sistem Yönetimi", "Kullanıcı Yönetimi");

            var NewUserAddButton = WebDriver.FindElement(By.XPath("//i[@class ='fa fa-user-plus']"));
            NewUserAddButton.Click();

            WebDriver.FindElement(By.Id("user_Name")).SendKeys("operator");
            WebDriver.FindElement(By.Id("user_SurName")).SendKeys("deneme");
            WebDriver.FindElement(By.Id("user_NationalId")).SendKeys("12543620879");
            WebDriver.FindElement(By.Id("user_SurName")).SendKeys("deneme");
            WebDriver.FindElement(By.Id("user_UserName")).SendKeys("deneme.operator");
            WebDriver.FindElement(By.Id("user_Email")).SendKeys("user@gmail.com");
            WebDriver.FindElement(By.Id("user_Password")).SendKeys("123456");
            WebDriver.FindElement(By.Id("user_ConfirmPassword")).SendKeys("123456");
            WebDriver.FindElement(By.Id("user_BirthDate")).SendKeys("01.01.1990");

            //Choose Role
            var userRole = WebDriver.FindElement(By.Name("RoleId"));// select the drop down list
            var selectRoleElement = new SelectElement(userRole);//create select element object 
            selectRoleElement.SelectByText("Rehber Öğretmen");// select by text

            //Choose Organization
            var userOrganization = WebDriver.FindElement(By.Name("OrganizationId"));// select the drop down list
            var selectOrganizationElement = new SelectElement(userOrganization);//create select element object
            selectOrganizationElement.SelectByText("Dummy Organization");// select by text

            //Choose School
            var userSchool = WebDriver.FindElement(By.Name("SchoolId"));// select the drop down list
            var selectSchoolElement = new SelectElement(userSchool);//create select element object 
            selectSchoolElement.SelectByText("dummy School");// select by text

            ////Choose Department-----> If Leader teacher can see all students, then department is not chosen for her/him.
            //var userDepartment = webDriver.FindElement(By.Name("DepartmentId"));// select the drop down list
            //var selectDepartmentElement = new SelectElement(userDepartment);//create select element object 
            //selectDepartmentElement.SelectByText("ilkokul");// select by text

            ////Choose Class for adding student
            //var userClass = webDriver.FindElement(By.Name("ClassId"));// select the drop down list
            //var selectClassElement = new SelectElement(userClass);//create select element object 
            //selectClassElement.SelectByText("1-A");// select by text

            //choose class for teacher
            var SaveUserButton = WebDriver.FindElement(By.XPath("//button[@class = 'btn btn-block btn-success']"));
            SaveUserButton.Click();
        }

        [Test]
        public void UpdateUserInformation()
        {
            util.JustLogin(operatorUser);
            util.NavigateToPage("Sistem Yönetimi", "Kullanıcı Yönetimi");

            var UpdateUserButton = WebDriver.FindElement(By.XPath("//i[@class ='fa fa-edit']"));
            UpdateUserButton.Click();

            var UpdateEmail = "destek@mizmer.com.tr";
            var BirtDate = "01.01.2017";

            var oldEmailElement = WebDriver.FindElement(By.Id("user_Email"));
            oldEmailElement.Clear();
            oldEmailElement.SendKeys(UpdateEmail);
            var OldBirthDate = WebDriver.FindElement(By.Id("user_BirthDate"));
            OldBirthDate.Clear();
            OldBirthDate.SendKeys(BirtDate);

            //Choose Role
            var updateRole = WebDriver.FindElement(By.Name("RoleId"));// select the drop down list
            var selectRoleElement = new SelectElement(updateRole);//create select element object 
            selectRoleElement.SelectByText("Öğrenci");// select by text

            //Choose Department
            var updateDepartment = WebDriver.FindElement(By.Name("DepartmentId"));// select the drop down list
            var selectDepartmentElement = new SelectElement(updateDepartment);//create select element object 
            selectDepartmentElement.SelectByText("Okul Öncesi");// select by text

            //Choose Class
            var updateClass = WebDriver.FindElement(By.Name("ClassId"));// select the drop down list
            var selectClassElement = new SelectElement(updateClass);//create select element object 
            selectClassElement.SelectByText("3 Yaş");// select by text
            
            var UpdateButton = WebDriver.FindElement(By.XPath("//button[@class ='btn btn-block btn-warning']"));
            UpdateButton.Click();

            WebDriver.Navigate().Refresh();
        }

        [Test]
        public void ChooseRoleAndSearch()
        {
            util.JustLogin(operatorUser);
            util.NavigateToPage("Sistem Yönetimi", "Kullanıcı Yönetimi");

            //choose role to search
            var ChooseStudentRoleButton = WebDriver.FindElement(By.XPath("//input[@id ='role_1']"));
            ChooseStudentRoleButton.Click();
            var SearchForStudentButton = WebDriver.FindElement(By.XPath("//i[@class ='fa fa-list-alt']"));
            SearchForStudentButton.Click();
            var ReloadButton = WebDriver.FindElement(By.XPath("//i[@class ='fa fa-refresh']"));
            ReloadButton.Click();

            var ChooseLeaderRoleButton = WebDriver.FindElement(By.XPath("//input[@id ='role_4']"));
            ChooseLeaderRoleButton.Click();

            //click search button
            var SearchButton = WebDriver.FindElement(By.XPath("//i[@class ='fa fa-list-alt']"));
            SearchButton.Click();
        }
        /*
        [Test]
        public void SearchForClass()
        {
            #region Login
            var loginPage = SeleniumExtras.PageObjects.PageFactory.InitElements<LoginPage>(webDriver);
            loginPage.Login(Operator.UserName, Operator.Password);
            var userID = contextBuilder.GetContext().UserOrganizationRoles.Where(i => i.UserId == Operator.Id).Select(i => i.Id).FirstOrDefault();
            #endregion
            List<MenuItem> UserItemList = new List<MenuItem>
            {
                new MenuItem("","Sistem Yönetimi"),
                new MenuItem("Sistem Yönetimi","Kullanıcı Yönetimi")
            };
            var testPage = SeleniumExtras.PageObjects.PageFactory.InitElements<DashboardPage>(webDriver);


            int countItem = UserItemList.Count;
            for (int i = 0; i < countItem; i++)
            {
                MenuItem menuItem = UserItemList[i];
                testPage.clickMenuButtonByInnerText(menuItem.menuName);

                if (!String.IsNullOrEmpty(menuItem.parentName))
                {
                    string breadCrumpText = webDriver.FindElement(By.Id("aktifMenu")).Text;
                    Assert.AreEqual(menuItem.menuName, breadCrumpText);
                }
            }

            var Classes = webDriver.FindElement(By.XPath("//[@class ='filter-option pull-left']"));// select the drop down list
            var selectClassElement = new SelectElement(Classes);//create select element object 
            selectClassElement.SelectByText("1-A");// select by text
        }
        */
    }
}
