using Miterya.Domain.DBModel;
using Miterya.ScreenTest.Builders;
using Miterya.ScreenTest.Collections;
using NUnit.Framework;
using System.Collections.Generic;
using System.Linq;
using OpenQA.Selenium;
using OpenQA.Selenium.Interactions;
using System;

namespace Miterya.ScreenTest.ModuleTests
{
    [TestFixture]
    class TemperamentProfileAnalysisModuleTests : BaseTest
    {
        // Usually it's not preferred to use services around here,
        // but some of the functionality is required. Also reusability!
        private DataBuilder dataBuilder;
        private TemperamentBuilder temperamentBuilder;
        private SchoolBuilder schoolBuilder;

        private string profileTemperamentText;
        List<long> studentNationalIds;
        List<User> students;
        IJavaScriptExecutor jsEx;

        [OneTimeSetUp]
        public void Preparation()
        {
            contextBuilder.ClearAllContext();
            schoolBuilder = new SchoolBuilder(contextBuilder);
            dataBuilder = new DataBuilder(contextBuilder);
            temperamentBuilder = new TemperamentBuilder(contextBuilder.GetContext());
        }

        public void CrossCaseProcedure()
        {
            contextBuilder.ClearTemperaments();
            contextBuilder.ResetTemperamentsOfStudents();
            WebDriver.Manage().Cookies.DeleteAllCookies();
            jsEx = (IJavaScriptExecutor)WebDriver;
        }

        /// <summary>
        /// <para>Picks student(s) to be used on test approval tests. Currently, at least two of them are needed.</para>
        /// <list type="bullet">
        ///     <item>One of them is used for teachers without approval authority, then one approver.</item>
        ///     <item>The other one is used in case two authorities can approve.</item>
        /// </list>
        /// </summary>
        public void PickStudentSample()
        {
            util.JustLogin(schoolBuilder.highSchoolTeachers[0]);
            var testPage = util.NavigateToPage("Mizaç Profil Analiz", "Öğrenci Mizaç Profili Analizi");
            // Here, we determine students that we will use on following assertions.
            studentNationalIds = testPage.GetStudentNationalIDsFromTable(WebDriver);
            students = new List<User>();
            foreach (var natID in studentNationalIds)
            {
                students.Add(schoolBuilder.highSchoolStudents.FirstOrDefault(x => x.NationalId == natID));
            }
            testPage.LogOut();
        }

        public void StudentActivityBeforeApproval(User student)
        {
            // Now is the time for logging in as one of the students and check what they can view.
            var testPage = util.JustLogin(student);
            testPage.GoToProfile();
            profileTemperamentText = WebDriver.FindElement(By.XPath("/html/body/div[1]/div[1]/section[2]/div/div[1]/div/div/p/b")).Text;
            Assert.AreEqual("Mizaç Testiniz Çözülmemiş", profileTemperamentText, "Mizacsizlik profilde bildirilmiyor.");
            // Go to "Mizac Testim" page to see if programmatically inserted test is visible to the student.
            util.NavigateToPage("Mizaç Profil Analiz", "Mizaç Testim");
            string solverNameOnPage = WebDriver.FindElement(By.XPath("//tbody/tr[2]/td[1]")).Text;
            string solverNameInDB = $"{ student.Name } { student.Surname }";
            Assert.AreEqual(solverNameInDB, solverNameOnPage, "Testi cozen dogru gosterilmiyor.");
            // Logout from student 
            testPage.LogOut();
        }

        public void CheckWhetherUserCanApproveOrNot(User approver, User student, bool hasAuthority)
        {
            // Login with the given user which maybe a class teacher, leader teacher or manager.
            util.JustLogin(approver);
            var testPage = util.NavigateToPage("Mizaç Profil Analiz", "Öğrenci Mizaç Profili Analizi");
            // Make sure to filter correct student.
            testPage.SendKeysToElementById("nameTxt", student.NationalId.ToString());
            testPage.ClickButtonByClassName("btn btn-info btn-flat");
            // Need an explicit wait here, otherwise we may click on wrong student.
            System.Threading.Thread.Sleep(2000);
            // Go to approval page.
            testPage.ClickButtonByXPath("//*[@id=\"userGrid\"]/tbody/tr[1]/td[5]/a/i");
            WebDriver.SwitchTo().Window(WebDriver.WindowHandles.Last());
            // Before attempting to approve, lets check if the button has an onclick even attached to it or not.
            jsEx = (IJavaScriptExecutor)WebDriver;
            bool onClickEventOfApproveButton = (bool)jsEx.ExecuteScript("return (document.getElementsByClassName('btn btn-warning pull-right')[0].onclick == null)");
            if (hasAuthority)
            {
                Assert.IsFalse(onClickEventOfApproveButton);
                // Proceed to approve.
                testPage.ClickButtonByXPath("/html/body/div/div[1]/section[2]/div[1]/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td[5]/input");
                testPage.ClickButtonByClassName("btn btn-warning pull-right");
                // A dialog is expected to open with proper message.
                string dialogMessage = WebDriver.FindElement(By.XPath("//*[@id=\"swal2-content\"]/h4")).Text;
                Assert.AreEqual(dialogMessage, "Seçilen mizaç tipi onaylandı!", "Onaylanma diyalogu dogru mesaji gostermiyor.");
                // Close the dialog then proceed to check whether student can see his temperament updated on his/her profile page or not.
                testPage.ClickButtonByClassName("swal2-confirm swal2-styled");
            }
            else
            {
                Assert.IsTrue(onClickEventOfApproveButton);
                _ = WebDriver.FindElement(By.XPath($"//*[contains(@class, 'btn btn-warning pull-right disabled')]"));
                // Since the code is not testable, currently performing assertion by running js.
                onClickEventOfApproveButton = (bool)jsEx.ExecuteScript("return (document.getElementsByClassName('btn btn-warning pull-right disabled')[0].onclick == null)");
                Assert.IsTrue(onClickEventOfApproveButton, "Manager may be able to approve tests.");
            }            
        }

        public void StudentActivityAfterApproval(User student)
        {
            var testPage = util.JustLogin(student);
            testPage.GoToProfile();
            profileTemperamentText = WebDriver.FindElement(By.XPath("/html/body/div[1]/div[1]/section[2]/div/div[1]/div/div/p/b")).Text;
            Assert.AreNotEqual("Mizaç Testiniz Çözülmemiş", profileTemperamentText, "Mizacsizlik durumu var.");
            // This will give us the temperamentTitle for the latest unapproved test.
            var temperamentTitle = temperamentBuilder.GetTemperamentTitle();
            Assert.AreEqual(temperamentTitle, profileTemperamentText, "Dogru mizac adi goruntulenemiyor.");
            testPage.LogOut();
        }
        
        /// <summary>
        /// Temperament approval procedure for case one where only class teachers can approve tests.
        /// </summary>
        public void TAPCaseOneProcedureTest()
        {
            // Need to clear previous approval related settings from DB.
            CrossCaseProcedure();
            schoolBuilder.ResetApprovalAuthority(true, false);
            // Pick a class, then collect nationalIDs to use later on.
            PickStudentSample();
            // Firstly, lets confirm that manager and leader teacher cannot approve temperament tests.
            temperamentBuilder.CreateHighSchoolTemperament(students[0], students[0]);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.managerUser, students[0], false);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.leaderTeacherUser, students[0], false);
            // Now is the time for logging in as one of the students and check what they can view.
            StudentActivityBeforeApproval(students[0]);
            // See if class teacher can also approve this student's temperament or not:
            CheckWhetherUserCanApproveOrNot(schoolBuilder.highSchoolTeachers[0], students[0], true);
            StudentActivityAfterApproval(students[0]);
        }

        /// <summary>
        /// Temperament approval procedure for case two where only leader teacher can approve tests.
        /// </summary>
        public void TAPCaseTwoProcedureTest()
        {
            // Need to clear previous approval related settings from DB.
            CrossCaseProcedure();
            schoolBuilder.ResetApprovalAuthority(false, true);
            // Pick a class, then collect nationalIDs to use later on.
            PickStudentSample();
            // Firstly, lets confirm that manager and leader teacher cannot approve temperament tests.
            temperamentBuilder.CreateHighSchoolTemperament(students[0], students[0]);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.managerUser, students[0], false);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.highSchoolTeachers[0], students[0], false);
            // Now is the time for logging in as one of the students and check what they can view.
            StudentActivityBeforeApproval(students[0]);
            // See if leader teacher can approve this student's temperament or not:
            CheckWhetherUserCanApproveOrNot(schoolBuilder.leaderTeacherUser, students[0], true);
            StudentActivityAfterApproval(students[0]);
        }

        /// <summary>
        /// Temperament approval procedure for case three where both leader and class teachers can approve tests.
        /// </summary>
        public void TAPCaseThreeProcedureTest()
        {
            // Need to clear previous approval related settings from DB.
            CrossCaseProcedure();
            schoolBuilder.ResetApprovalAuthority(true, true);
            // Pick a class, then collect nationalIDs to use later on.
            PickStudentSample();
            // Firstly, lets confirm that manager cannot approve temperament tests.
            temperamentBuilder.CreateHighSchoolTemperament(students[0], students[0]);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.managerUser, students[0], false);
            StudentActivityBeforeApproval(students[0]);
            // See if high school teacher can approve the same student's temperament or not:
            CheckWhetherUserCanApproveOrNot(schoolBuilder.highSchoolTeachers[0], students[0], true);
            // Can student[0] see the updated temperament title on his/her profile?
            StudentActivityAfterApproval(students[0]);
            // Since student[0]'s temperament is already approved, using student[1] from now on.
            temperamentBuilder.CreateHighSchoolTemperament(students[1], students[1]);
            StudentActivityBeforeApproval(students[1]);
            // See if class teacher can also approve this other student's temperament or not:
            CheckWhetherUserCanApproveOrNot(schoolBuilder.leaderTeacherUser, students[1], true);
            // Can student[1] see the updated temperament title on his/her profile as well?
            StudentActivityAfterApproval(students[1]);
        }

        /// <summary>
        /// Temperament approval procedure for case four where neither leader nor class teachers can approve tests.
        /// </summary>
        public void TAPCaseFourProcedureTest()
        {
            // Need to clear previous approval related settings from DB.
            CrossCaseProcedure();
            schoolBuilder.ResetApprovalAuthority(false, false);
            // Pick a class, then collect nationalIDs to use later on.
            PickStudentSample();
            // Lets confirm that nobody can approve any of the temperament tests.
            temperamentBuilder.CreateHighSchoolTemperament(students[0], students[0]);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.managerUser, students[0], false);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.highSchoolTeachers[0], students[0], false);
            CheckWhetherUserCanApproveOrNot(schoolBuilder.leaderTeacherUser, students[0], false);
        }
        /// <summary>
        ///     <para> Inserts <i>solved</i> tests to DB which are awaiting approval. </para>
        ///     <para> Switches sessions between relevant users to check whether temperament updates or not. </para>
        ///     <para> Between those changes, it also asserts that only authorized users can approve these tests. </para>
        ///     <list type="bullet">
        ///     <item> Case 1: Only class teachers can approve tests. </item>
        ///     <item> Case 2: Only leader teacher can approve tests. </item>
        ///     <item> Case 3: Both class teachers and leader teacher can approve tests. </item>
        ///     <item> Case 4: Either one of them can approve tests. </item>
        ///     </list>
        /// </summary>
        [Test]
        public void TemperamentApprovalProcedureTest()
        {
            TAPCaseOneProcedureTest();
            TAPCaseTwoProcedureTest();
            TAPCaseThreeProcedureTest();
            TAPCaseFourProcedureTest();
        }

        // TODO (Taha) Review this, see if it is possible to sinegin kanadindan yag cikarmak.
        [Test]
        public void TemperamentTestLimitTest()
        {
            util.JustLogin(schoolBuilder.managerUser);
            var userID = contextBuilder.GetContext().UserOrganizationRoles.Where(i => i.UserId == schoolBuilder.managerUser.Id).Select(i => i.Id).FirstOrDefault();
            var testPage = util.NavigateToPage("Mizaç Profil Analiz", "Mizaç Testim");

            #region Test Initial State
            var startTestButton = WebDriver.FindElement(By.XPath("//button[@class ='btn btn-success']"));
            startTestButton.Click();
            // If test loads, go back.
            WebDriver.Navigate().Back();
            #endregion

            #region Test 3/5 Results State
            // Get rid of previous data before creating new ones.
            // TODO (Taha): Optimization. (Pair with Mertcan)
            contextBuilder.GetContext().Temperaments.RemoveRange(contextBuilder.GetContext().Temperaments.ToList());
            contextBuilder.GetContext().SaveChanges();
            // Add three survey results. (3/5)
            dataBuilder.AddDummyMizacTestToUser(userID, userID);
            dataBuilder.AddDummyMizacTestToUser(userID, userID);
            dataBuilder.AddDummyMizacTestToUser(userID, userID);
            WebDriver.Navigate().Refresh();
            // Get the button again after dummy results are added.
            startTestButton = WebDriver.FindElement(By.XPath("//button[@class ='btn btn-success']"));
            startTestButton.Click();
            // Check hidden test count.
            var solvedTestCount = WebDriver.FindElement(By.Id("totalCountSolvedTest")).GetAttribute("value");
            Assert.AreEqual("3", solvedTestCount, "Hidden solved test count is not 3.");
            // Check result count on the table.
            int solvedTestCountOnTable = WebDriver.FindElements(By.XPath("//table/tbody/tr")).Count;
            Assert.AreEqual(3, solvedTestCountOnTable - 1, "Solved test count on the table is not 3.");
            // Check whether the warning before test is correct or not.
            Assert.AreEqual("Kalan mizaç testi çözme hakkınız: 2", testPage.GetValueById("swal2-content"), "Kalan hak yanlis gorunuyor.");
            var continueButton = WebDriver.FindElement(By.XPath("//button[@class ='swal2-confirm swal2-styled']"));
            continueButton.Click();
            // If test loads, go back.
            WebDriver.Navigate().Back();
            #endregion

            #region Test 4/5 Results State
            // Add one more dummy result. (4/5)
            dataBuilder.AddDummyMizacTestToUser(userID, userID);
            WebDriver.Navigate().Refresh();
            // Check remaining test count again.
            startTestButton = WebDriver.FindElement(By.XPath("//button[@class ='btn btn-success']"));
            startTestButton.Click();
            // Check hidden test count.
            solvedTestCount = WebDriver.FindElement(By.Id("totalCountSolvedTest")).GetAttribute("value");
            Assert.AreEqual("4", solvedTestCount, "Hidden solved test count is not 4.");
            // Check result count on the table.
            solvedTestCountOnTable = WebDriver.FindElements(By.XPath("//table/tbody/tr")).Count;
            Assert.AreEqual(4, solvedTestCountOnTable - 1, "Solved test count on the table is not 4.");
            // Check whether the warning before test is correct or not.
            Assert.AreEqual("Kalan mizaç testi çözme hakkınız: 1", testPage.GetValueById("swal2-content"), "Kalan hak yanlis gorunuyor.");
            continueButton = WebDriver.FindElement(By.XPath("//button[@class = 'swal2-confirm swal2-styled']"));
            continueButton.Click();
            // If test loads, go back.
            WebDriver.Navigate().Back();
            #endregion

            #region Test 5/5 Results State
            // Add one last dummy result. (5/5)
            dataBuilder.AddDummyMizacTestToUser(userID, userID);
            WebDriver.Navigate().Refresh();
            // Check hidden test count.
            solvedTestCount = WebDriver.FindElement(By.Id("totalCountSolvedTest")).GetAttribute("value");
            Assert.AreEqual("5", solvedTestCount, "Hidden solved test count is not 5.");
            // Check result count on the table.
            solvedTestCountOnTable = WebDriver.FindElements(By.XPath("//table/tbody/tr")).Count;
            Assert.AreEqual(5, solvedTestCountOnTable - 1, "Solved test count on the table is not 5.");
            // TODO (Taha): Hakki dolunca buton kayboluyor mu?
            // Check whether startTestButton disappeared or not.
            Assert.IsFalse(WebDriver.FindElements(By.XPath("//button[@class ='btn btn-success']")).Count != 0, "Start test button has not disappeared.");
            #endregion
        }
        
        [Test]
        public void AdultTemperamentProfileAnalysisProcedureTest()
        {
            var leaderTeacher = schoolBuilder.leaderTeacherUser;
            var manager = schoolBuilder.managerUser;
            List<string> adultsLeaderTeacherCanView = new List<string>() { "Veli" };
            List<string> adultsManagerCanView = new List<string>() { "Öğretmen", "Veli", "Rehber Öğretmen", "Müdür", "Müdür Yardımcısı", "Personel" };

            util.JustLogin(leaderTeacher);

            var testPage = util.NavigateToPage("Mizaç Profil Analiz", "Yetişkin Mizaç Profili Analizi");
            
            IReadOnlyCollection<IWebElement> adultsInFilter = WebDriver.FindElements(By.XPath("//*[@id='searchForm']/div/div/div/label"));
            List<string> adultsInPage = new List<string>();
            foreach (var adult in adultsInFilter)
            {
                adultsInPage.Add(adult.Text);
            }
            foreach (var item in adultsInPage)
            {
                Assert.Contains(item, adultsLeaderTeacherCanView, "Role filter options are wrong.");
            }
            foreach (var element in adultsInFilter)
            {
                element.Click();
                testPage.ClickButtonByClassName("btn btn-info btn-flat");
                var roleInTable = WebDriver.FindElement(By.XPath("//*/tbody/tr[1]/td[4]")).Text;
                Assert.AreEqual(element.Text, roleInTable, "Filter doesn't function properly.");
                var fullNameInTable = WebDriver.FindElement(By.XPath("//*/tbody/tr[1]/td[2]")).Text;
                var temperamentOfTopUser = WebDriver.FindElement(By.XPath("//*/tbody/tr[1]/td[3]")).Text;
                testPage.ClickButtonByClassName("fa fa-user");
                WebDriver.SwitchTo().Window(WebDriver.WindowHandles.Last());
                var fullNameOnCard = WebDriver.FindElement(By.XPath("//*[@class = 'widget-user-username']")).Text;
                var temperamentOnCard = WebDriver.FindElement(By.XPath("//*[@class = 'widget-user-desc']")).Text;
                // Checking whether name and temperaments are valid or not.
                Assert.AreEqual(temperamentOnCard, temperamentOfTopUser, "Temperament of the user is different on table and report page.");
                Assert.AreEqual(fullNameOnCard, fullNameInTable, "Full name of the user is different on table and report page.");

                IReadOnlyCollection<IWebElement> reportContainers = WebDriver.FindElements(By.XPath($"//*[@id = 'temperamentReportDiv']/*[@class = 'box box-primary']"));
                foreach (var section in reportContainers)
                {
                    var reportTitle = section.FindElement(By.XPath($"//*[@class = 'box-title']")).Text;
                    var reportText = section.FindElement(By.XPath($"//*[@class = 'box-body text-justify']")).Text;
                    Assert.AreNotEqual(reportText, "", $"{ reportTitle } section may not have necessary information.");
                }
                // TODO (Taha) Move these into TestUtil or another relevant file.
                // Parameters to pass: User, maybe user's role as well if it is not desired to query DB for it.
            }

            testPage.LogOut();

            util.JustLogin(manager);
            util.NavigateToPage("Mizaç Profil Analiz", "Yetişkin Mizaç Profili Analizi");
            adultsInFilter = WebDriver.FindElements(By.XPath("//*[@id='searchForm']/div/div/div/label"));
            adultsInPage.Clear();
            foreach (var adult in adultsInFilter)
            {
                adultsInPage.Add(adult.Text);
            }
            foreach (var item in adultsInPage)
            {
                Assert.Contains(item, adultsManagerCanView, "Role filter options are wrong.");
            }
        }
        
    }
}
