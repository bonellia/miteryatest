using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Builders;
using Miterya.ScreenTest.Collections;
using NUnit.Framework;
using System.Collections.Generic;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    public class ParentTests : BaseTest
    {
        
        private SchoolBuilder schoolBuilder;
        User parentUser;
        
        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            this.schoolBuilder = new SchoolBuilder(contextBuilder);
            // Users with parent role requires predefined temperaments for testing.
            this.schoolBuilder.AddRandomTemperamentsToAllStudents();
            this.parentUser = schoolBuilder.allParents[0];
        }
        
        [Test]
        public void ParentLoginTest()
        {
            util.LoginExpectingSuccess(parentUser);
        }

        [Test]
        public void ParentProfilePageAccessTest()
        {
            util.AccessProfilePage(parentUser);
        }

        [Test]
        public void ParentMessagePanelTest()
        {
            util.SendEmptyMessage(parentUser);
        }

        [Test]
        public void ParentMenuAuthorizationTest()
        {
            List<string> expectedMenuList = new List<string>
            {
                "Ana Sayfa",
                "Mizaç Profil Analiz",
                "Mizaç Testim",
                "Çocuğumun Mizaç Testi",
                "Yetişkin Mizaç Profili Analizi",
                "Kişisel Gelişim",
                "Zihinsel Gelişim",
                "Kişilik Gelişimi",
                "Sosyal Beceri Gelişimi",
                "Küresel Yaşam Becerileri",
                "Evrensel Yaşam Becerileri",
                "Değer Farkındalık Gelişim",
                "Davranışsal Değer Gelişim Takibi",
                "Rehberlik Danışmanlık",
                "Anketlerim"
            };

            util.CheckVisibleMenus(parentUser, expectedMenuList);
        }

        [Test]
        public void ParentVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz","Mizaç Testim"),
                new MenuItem("Mizaç Profil Analiz","Çocuğumun Mizaç Testi"),
                new MenuItem("Mizaç Profil Analiz","Yetişkin Mizaç Profili Analizi"),
                new MenuItem("","Kişisel Gelişim"),
                new MenuItem("Kişisel Gelişim","Zihinsel Gelişim"),
                new MenuItem("Kişisel Gelişim","Kişilik Gelişimi"),
                new MenuItem("Kişisel Gelişim","Sosyal Beceri Gelişimi"),
                new MenuItem("Kişisel Gelişim","Küresel Yaşam Becerileri"),
                new MenuItem("Kişisel Gelişim","Evrensel Yaşam Becerileri"),
                new MenuItem("","Değer Farkındalık Gelişim"),
                new MenuItem("Değer Farkındalık Gelişim","Davranışsal Değer Gelişim Takibi"),
                new MenuItem("","Rehberlik Danışmanlık"),
                new MenuItem("Rehberlik Danışmanlık","Anketlerim")
            };

            util.VisitMenus(parentUser, expectedMenuItemList);
        }        

        [Test]
        public void ParentProfilePageContentTest()
        {
            util.CheckPageContent(parentUser, "Veli");
        }

        [Test]
        public void ParentProfileUpdateTest()
        {
            util.UpdateProfile(parentUser);
        }

        [Test]
        public void PreSchoolParentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.preSchoolParents[0]);
            util.SolvePersonalGuidanceSurvey("Zihinsel Gelişim");
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");
        }
        
        [Test]
        public void PrimarySchoolParentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.primarySchoolParents[0]);
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");            
        }

        
        [Test]
        public void SecondarySchoolParentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.secondarySchoolParents[0]);
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");            
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Evrensel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");
        }

        
        [Test]
        public void HighSchoolParentPersonalGuidanceTest()
        {
            util.JustLogin(schoolBuilder.highSchoolParents[0]);
            util.SolvePersonalGuidanceSurvey("Kişilik Gelişimi");
            util.SolvePersonalGuidanceSurvey("Sosyal Beceri Gelişimi");
            util.SolvePersonalGuidanceSurvey("Küresel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Evrensel Yaşam Becerileri");
            util.SolvePersonalGuidanceSurvey("Davranışsal Değer Gelişim Takibi");
        }
    }
}
