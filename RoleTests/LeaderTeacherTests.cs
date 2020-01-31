using System;
using System.Collections.Generic;
using NUnit.Framework;
using OpenQA.Selenium;
using Miterya.ScreenTest.Pages;
using Miterya.ScreenTest.Builders;
using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Collections;
using System.Linq;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    public class LeaderTeacherTests : BaseTest
    {
        private SchoolBuilder schoolBuilder;
        User leaderTeacherUser;        

        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();        
            this.schoolBuilder = new SchoolBuilder(contextBuilder);
            this.leaderTeacherUser = schoolBuilder.leaderTeacherUser;
        }        

        [Test]
        public void LeaderTeacherLoginTest()
        {
            util.LoginExpectingSuccess(leaderTeacherUser);
        }

        [Test]
        public void LeaderTeacherProfilePageAccessTest()
        {
            util.AccessProfilePage(leaderTeacherUser);
        }

        [Test]
        public void StudentMessagePanelTest()
        {
            util.SendEmptyMessage(leaderTeacherUser);
        }

        [Test]
        public void LeaderTeacherMenuAuthorizationTest()
        {

            List<string> expectedMenuList = new List<string>
            {
                "Ana Sayfa",
                "Mizaç Profil Analiz",
                "Mizaç Testim",
                "Öğrenci Mizaç Profili Analizi",
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
                "Mizaca Özgü Anketler",
                "Anketlerim",
                "Öğrenci Danışmanlık Havuzu",
                "Öğrenci Danışmanlık Listem",
                "Veli Görüşmeleri"
            };

            util.CheckVisibleMenus(leaderTeacherUser, expectedMenuList);
        }

        [Test]
        public void LeaderTeacherVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz ","Mizaç Testim"),
                new MenuItem("Mizaç Profil Analiz ","Öğrenci Mizaç Profili Analizi"),
                new MenuItem("Mizaç Profil Analiz ","Yetişkin Mizaç Profili Analizi"),
                new MenuItem("","Kişisel Gelişim"),
                new MenuItem("Kişisel Gelişim ","Zihinsel Gelişim"),
                new MenuItem("Kişisel Gelişim ","Kişilik Gelişimi"),
                new MenuItem("Kişisel Gelişim ","Sosyal Beceri Gelişimi"),
                new MenuItem("Kişisel Gelişim ","Küresel Yaşam Becerileri"),
                new MenuItem("Kişisel Gelişim ","Evrensel Yaşam Becerileri"),
                new MenuItem("","Değer Farkındalık Gelişim"),
                new MenuItem("Değer Farkındalık Gelişim ","Davranışsal Değer Gelişim Takibi"),
                new MenuItem("","Rehberlik Danışmanlık"),
                new MenuItem("Rehberlik Danışmanlık ","Mizaca Özgü Anketler"),
                new MenuItem("Rehberlik Danışmanlık ","Anketlerim"),                
                new MenuItem("Rehberlik Danışmanlık ","Öğrenci Danışmanlık Havuzu"),
                new MenuItem("Rehberlik Danışmanlık ","Öğrenci Danışmanlık Listem"),
                new MenuItem("Rehberlik Danışmanlık ","Veli Görüşmeleri")
            };

            util.VisitMenus(leaderTeacherUser, expectedMenuItemList);
        }        

        [Test]
        public void LeaderTeacherProfilePageContentTest()
        {
            util.CheckPageContent(leaderTeacherUser, "Rehber Öğretmen");
        }

        [Test]
        public void LeaderTeacherProfileUpdateTest()
        {
            util.UpdateProfile(leaderTeacherUser);
        }
    }
}
