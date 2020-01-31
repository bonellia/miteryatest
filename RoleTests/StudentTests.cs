using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Builders;
using Miterya.ScreenTest.Collections;
using NUnit.Framework;
using System.Collections.Generic;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    public class StudentTest : BaseTest
    {
        private SchoolBuilder schoolBuilder;

        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            this.schoolBuilder = new SchoolBuilder(contextBuilder);
            this.schoolBuilder.AddRandomTemperamentsToAllStudents();
        }
        
        [Test]
        public void StudentLoginTest()
        {
            util.LoginExpectingFailure(schoolBuilder.preSchoolStudents[0]);
            util.LoginExpectingFailure(schoolBuilder.primarySchoolStudents[0]);
            util.LoginExpectingSuccess(schoolBuilder.secondarySchoolStudents[0]).LogOut();
            util.LoginExpectingSuccess(schoolBuilder.highSchoolStudents[0]);
        }

        [Test]
        public void StudentProfilePageAccessTest()
        {
            util.AccessProfilePage(schoolBuilder.secondarySchoolStudents[0]);
        }

        [Test]
        public void StudentMessagePanelTest()
        {
            util.SendEmptyMessage(schoolBuilder.secondarySchoolStudents[0]);
        }

        [Test]
        public void StudentCanSeeLimitedMenuTest()
        {
            List<string> expectedMenuList = new List<string>
            {
                "Ana Sayfa",
                "Mizaç Profil Analiz",
                "Mizaç Testim",
                "Kişisel Gelişim",
                "Kişilik Gelişimi",
                "Sosyal Beceri Gelişimi",
                "Küresel Yaşam Becerileri",
                "Evrensel Yaşam Becerileri",
                "Değer Farkındalık Gelişim",
                "Davranışsal Değer Gelişim Takibi"
            };
            util.CheckVisibleMenus(schoolBuilder.secondarySchoolStudents[0], expectedMenuList);
        }

        [Test]
        public void StudentVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
               // new MenuItem("","Anketlerim"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz","Mizaç Testim"),
                new MenuItem("","Kişisel Gelişim"),
                new MenuItem("Kişisel Gelişim","Kişilik Gelişimi"),
                new MenuItem("Kişisel Gelişim","Sosyal Beceri Gelişimi"),
                new MenuItem("Kişisel Gelişim","Küresel Yaşam Becerileri"),
                new MenuItem("Kişisel Gelişim","Evrensel Yaşam Becerileri"),
                new MenuItem("","Değer Farkındalık Gelişim"),
                new MenuItem("Değer Farkındalık Gelişim","Davranışsal Değer Gelişim Takibi"),

            };
            util.VisitMenus(schoolBuilder.secondarySchoolStudents[0], expectedMenuItemList);
        }

        [Test]
        public void SecondarySchoolStudentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.secondarySchoolStudents[0]);
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Evrensel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");
        }

        [Test]
        public void HighSchoolStudentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.highSchoolStudents[0]);
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Evrensel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");
        }
    }
}