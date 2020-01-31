using System.Collections.Generic;
using NUnit.Framework;
using Miterya.ScreenTest.Builders;
using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Collections;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    public class ManagerTests : BaseTest
    {
        private SchoolBuilder schoolBuilder;
        User managerUser;
        
        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            this.schoolBuilder = new SchoolBuilder(contextBuilder);
            this.schoolBuilder.AddRandomTemperamentsToAllStudents();
            this.managerUser = schoolBuilder.managerUser;
        }

        [Test]
        public void ManagerLoginTest()
        {
            util.LoginExpectingSuccess(managerUser);
        }

        [Test]
        public void ManagerProfilePageAccessTest()
        {
            util.AccessProfilePage(managerUser);
        }

        [Test]
        public void StudentMessagePanelTest()
        {
            util.SendEmptyMessage(managerUser);
        }

        [Test]
        public void ManagerMenuAuthorizationTest()
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
                "Rehberlik Danışmanlık",
                "Anketlerim",
                "Öğrenci Danışmanlık Havuzu",
                "Öğrenci Danışmanlık Listem",
                "Davranışsal Değer Gelişim Takibi",
                "Sınıf Yönetimi",
                "Sınıf Mevcudu Belirleme"
            };

            util.CheckVisibleMenus(managerUser, expectedMenuList);
        }

        [Test]
        public void ManagerVisitAuthorizedPagesTest()
        {
            List<MenuItem> expectedMenuItemList = new List<MenuItem>
            {
                new MenuItem("","Ana Sayfa"),
                new MenuItem("","Mizaç Profil Analiz"),
                new MenuItem("Mizaç Profil Analiz","Mizaç Testim"),
                new MenuItem("Mizaç Profil Analiz","Öğrenci Mizaç Profili Analizi"),
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
                new MenuItem("Rehberlik Danışmanlık ","Anketlerim"),
                new MenuItem("Rehberlik Danışmanlık ","Öğrenci Danışmanlık Havuzu"),
                new MenuItem("Rehberlik Danışmanlık ","Öğrenci Danışmanlık Listem"),
                new MenuItem("","Sınıf Yönetimi"),
                new MenuItem("Sınıf Yönetimi", "Sınıf Mevcudu Belirleme")
            };

            util.VisitMenus(managerUser, expectedMenuItemList);
        }        

        [Test]
        public void ManagerProfilePageContentTest()
        {
            util.CheckPageContent(managerUser, "Müdür");
        }

        [Test]
        public void ManagerProfileUpdateTest()
        {
            util.UpdateProfile(managerUser);
        }        
    }
}
