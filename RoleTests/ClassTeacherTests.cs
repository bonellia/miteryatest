using System.Collections.Generic;
using NUnit.Framework;
using Miterya.ScreenTest.Builders;
using Miterya.Domain.DBModel;
using Miterya.Domain.Common.Enums;
using Miterya.ScreenTest.Collections;
using static Miterya.ScreenTest.Collections.TestUtil;

namespace Miterya.ScreenTest.RoleTests
{
    [TestFixture]
    public class ClassTeacherTests : BaseTest
    {
        DataBuilder data;
        User classTeacherUser;

        [OneTimeSetUp]
        public void BuildData()
        {
            contextBuilder.ClearAllContext();
            // This builder is sufficient for now. No need to use schoolBuilder atm.
            data = new DataBuilder(contextBuilder)
                .CreateDummyUser()
                .CreateOrganizationByType(OrganTypeEnum.Classroom)
                .SetRol(RoleEnum.Teacher);
            this.classTeacherUser = data.user;
        }

        [Test]
        public void ClassTeacherLoginTest()
        {
            util.LoginExpectingSuccess(classTeacherUser);
        }

        [Test]
        public void ClassTeacherProfilePageAccessTest()
        {
            util.AccessProfilePage(classTeacherUser);
        }

        [Test]
        public void StudentMessagePanelTest()
        {
            util.SendEmptyMessage(classTeacherUser);
        }

        [Test]
        public void ClassTeacherMenuAuthorizationTest()
        {
            List<string> expectedMenuList = new List<string> 
            { 
                "Ana Sayfa",
                "Mizaç Profil Analiz",
                "Mizaç Testim",
                "Öğrenci Mizaç Profili Analizi",
                "Yetişkin Mizaç Profili Analizi",
                "Kişilik Gelişimi",
                "Kişisel Gelişim",
                "Zihinsel Gelişim",
                "Sosyal Beceri Gelişimi",
                "Küresel Yaşam Becerileri",
                "Evrensel Yaşam Becerileri",
                "Değer Farkındalık Gelişim",
                "Davranışsal Değer Gelişim Takibi",
                "Sınıf Yönetimi",
                "Oturma Düzeni Belirleme"
            };

            util.CheckVisibleMenus(classTeacherUser, expectedMenuList);
        }

        [Test]
        public void ClassTeacherVisitAuthorizedPagesTest()
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
                new MenuItem("","Sınıf Yönetimi"),
                new MenuItem("Sınıf Yönetimi","Oturma Düzeni Belirleme")
            };

            util.VisitMenus(classTeacherUser, expectedMenuItemList);
        }
    }
}
