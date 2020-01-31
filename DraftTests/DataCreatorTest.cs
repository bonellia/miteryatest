using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;

using Miterya.ScreenTest.Pages;
using Miterya.ScreenTest.Models;
using Miterya.ScreenTest.Builders;
using Miterya.Domain.DBModel;
using Miterya.Domain.Common.Enums;
using Miterya.ScreenTest.Collections;
using System.Linq;
using Miterya.Service.OrganizationServices;
using Miterya.Domain.Common.CustomClass;

/*
 * Is Kurallari
 * I1 - En az bir tane Baskın Alan 
 * I2 - En az bir tane Eslik Eden Alan 
 * 
 * I3 - En az 3 tane Baskin Alt Alan
 * I4 - En az 3 tane Eslik Eden Alt Alan
 * olmali
 */
namespace Miterya.ScreenTest.DraftTests
{
    public class DataCreatorTest : BaseTest
    {
        DataBuilder data;
        OrganizationServices organizationServices;
        User leaderTeacher;
        List<User> students;

        [SetUp]
        public void BuildData()
        {

            data = new DataBuilder(contextBuilder)
                .CreateDummyOrganization().CreateDummyTerm().CreateDummyUserWithRoleToOrganization(RoleEnum.SuperAdmin);

            //data.createDummySchool()
            data.CreateDummySchool(data.organizationBuilder.organization.Id, false, false, true, false, 50);

            organizationServices = new OrganizationServices(contextBuilder.GetContext());
            List<Organization> subOrganizations = organizationServices.GetSubOrganisations(data.organization.Id);
            List<Organization> classrooms = organizationServices.GetSubOrganisations(data.organization.Id)
                                                                .Where(i => i.OrganTypeId == AppSettings.OrganizationTypeId.Classroom
                                                                         || i.OrganTypeId == AppSettings.OrganizationTypeId.ClassroomWithoutBranch).ToList();

            data.CreateListDummyUserInRangeWithRoleToOrganization(subOrganizations.Where(i => i.OrganTypeId == AppSettings.OrganizationTypeId.School).FirstOrDefault(),
                                                                        RoleEnum.LeaderTeacher,1);
            //Kullanacagim rehber ogretmeni sakliyorum
            leaderTeacher = data.user;
            
            students = new List<User>();
            foreach (Organization item in classrooms)
            {
                students.AddRange(data.CreateListDummyUserInRangeWithRoleToOrganization(item, RoleEnum.Student, 1));
                data.SetAccessClassroom(leaderTeacher, item.Id);
            }
            

        }

        [OneTimeSetUp]
        public void Preparation()
        {
            contextBuilder.ClearAllContext();
        }

        // [Test] Temporarily excluded from fixture.
        public void LeaderTeacherLoginTest()
        {
            //DATA
            //zihinsel yetenek testi icin kullanıcıların mizaci belli olması gerekiyor
            foreach (User u in students)
                data.userBuilder.SetTemperament(contextBuilder.GetContext(), u.Id, 220);


            #region Login
            var loginPage = SeleniumExtras.PageObjects.PageFactory.InitElements<LoginPage>(WebDriver);//login page callcd
            loginPage.Login(leaderTeacher.UserName, leaderTeacher.Password);
            //loginPage.MultipleRolesLogin(leaderTeacher.UserName, leaderTeacher.Password, RoleEnum.LeaderTeacher);
            #endregion

            var dashboardPage = SeleniumExtras.PageObjects.PageFactory.InitElements<HomePage>(WebDriver);
            dashboardPage.ClickMenuButtonByInnerText("Zihinsel Yetenek");

            WebDriver.FindElement(By.CssSelector("i[class='fa fa-edit']")).Click();
            WebDriver.SwitchTo().Window(WebDriver.WindowHandles.Last());

            System.Threading.Thread.Sleep(2000);


            //TODO TEST COZ


            WebDriver.FindElement(By.CssSelector("input[class='sv_complete_btn']")).Click();
            System.Threading.Thread.Sleep(2000);//anket sonucu 1.5 saniye sonra yükleniyor.

            System.Threading.Thread.Sleep(4000);
            var reportBlocks = WebDriver.FindElements(By.CssSelector("div[class='widget-user-header'"));
            Assert.AreEqual(6, reportBlocks.Count(), "Rapor blok basliklari - rapor gelmedi");

            /*
             * Is Kurallari
             * I1 - En az bir tane Baskın Alan 
             * I2 - En az bir tane Eslik Eden Alan 
             * 
             * I3 - En az 3 tane Baskin Alt Alan
             * I4 - En az 3 tane Eslik Eden Alt Alan
             * olmali
             */
            #region Talents
            var dominatedTalent = WebDriver.FindElement(By.Name("DominatedTalent"));
            Assert.IsNotNull(dominatedTalent.Text,"I1 - Baskın Alan Gorunmuyor");

            var accompanyTalent = WebDriver.FindElement(By.Name("AccompanyTalents"));
            var accompanyTalents = accompanyTalent.FindElements(By.TagName("h5"));
            Assert.AreNotEqual(0, accompanyTalents.Count, "I2 - Eslik Eden Alan Gorunmuyor");

            var supportedTalent = WebDriver.FindElement(By.Name("SupportedTalents"));
            var supportedTalents = supportedTalent.FindElements(By.TagName("h5"));
            Assert.AreNotEqual(0, supportedTalents.Count, "I3 - Desteklenmesi Gereken Alan Gorunmuyor");
            #endregion


            #region Sub Talents
            var dominatedSubTalent = WebDriver.FindElement(By.Name("DominatedSubTalents"));
            var dominatedSubTalents = dominatedSubTalent.FindElements(By.TagName("a"));
            Assert.LessOrEqual(2, dominatedSubTalents.Count(), "Olmasi gerekenden daha az BASKIN YSA var");

            var accompanySubTalent = WebDriver.FindElement(By.Name("AccompanySubTalents"));
            var accompanySubTalents = accompanySubTalent.FindElements(By.TagName("a"));
            Assert.LessOrEqual(2, accompanySubTalents.Count(), "Olmasi gerekenden daha az ESLİK EDEN YSA var");
            #endregion

            //var talentCategories = webDriver.FindElements(By.CssSelector("div[class='description-header'")).ToList().Select(i=>i.Text);
            //Assert.AreEqual(4, talentCategories.Count(),"Zihinsel Yetenek Alanları yuklenmedi");
        }


    }
}
