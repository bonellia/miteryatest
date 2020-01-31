using Miterya.DataAccess;
using Miterya.Domain.DBModel;
using System;
using Miterya.Service.UserOrganizationRoleServices;
using Miterya.Service.RoleServices;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.Linq;

namespace Miterya.ScreenTest.Builders
{
    class TemperamentBuilder
    {
        public Temperament temperament;
        readonly private IMiteryaDBContext dbContext;
        readonly private UserOrganizationRoleServices userOrganizationRoleServices;
        readonly private MizacTestServices mizacTestServices;
        readonly private UserBuilder userBuilder;
        private string temperamentTitle;

        public TemperamentBuilder(IMiteryaDBContext context)
        {
            this.dbContext = context;
            this.userOrganizationRoleServices = new UserOrganizationRoleServices(context);
            this.mizacTestServices = new MizacTestServices(context);
            this.userBuilder = new UserBuilder(context);
        }

        public string GetTemperamentTitle()
        {
            return temperamentTitle;
        }
        public void AddAdultTemperament(User testSubjectUser)
        {
            userBuilder.SetTemperament(dbContext, testSubjectUser.Id, new Random().Next(1, 162));
        }

        public void CreatePreSchoolTemperament(User solverUser, User testSubjectUser)
        {
            var solverUOR = userOrganizationRoleServices.GetUserOrganizationRoles(solverUser.Id);
            var testSubjectUOR = userOrganizationRoleServices.GetUserOrganizationRoles(testSubjectUser.Id);
            temperament = new Temperament()
            {
                Id = Guid.NewGuid(),
                UserOrgRole = testSubjectUOR,
                SolverUserOrgRole = solverUOR,
                MizacTestId = new Guid(),
                IsSelected = false,
                IsActive = false,
                Result = null
            };
            mizacTestServices.AddTemperament(temperament);
        }

        public void CreatePrimarySchoolTemperament(User solverUser, User testSubjectUser)
        {
            var solverUOR = userOrganizationRoleServices.GetUserOrganizationRoles(solverUser.Id);
            var testSubjectUOR = userOrganizationRoleServices.GetUserOrganizationRoles(testSubjectUser.Id);
            temperament = new Temperament()
            {
                Id = Guid.NewGuid(),
                UserOrgRole = testSubjectUOR,
                SolverUserOrgRole = solverUOR,
                MizacTestId = new Guid(),
                IsSelected = false,
                IsActive = false,
                Result = null
            };
            mizacTestServices.AddTemperament(temperament);
        }

        public void CreateSecondarySchoolTemperament(User solverUser, User testSubjectUser)
        {
            var solverUOR = userOrganizationRoleServices.GetUserOrganizationRoles(solverUser.Id);
            var testSubjectUOR = userOrganizationRoleServices.GetUserOrganizationRoles(testSubjectUser.Id);
            temperament = new Temperament()
            {
                Id = Guid.NewGuid(),
                UserOrgRole = testSubjectUOR,
                SolverUserOrgRole = solverUOR,
                MizacTestId = new Guid(),
                IsSelected = false,
                IsActive = false,
                Result = null
            };
            mizacTestServices.AddTemperament(temperament);
        }

        /// <summary>
        /// Creates a different temperamentID from mainTemperamentID.
        /// </summary>
        public int GetDifferentTemperamentID(int mainTemperamentID, int attemptNo)
        {
            // If we get unlucky, we can be stuck in the main-wing temperament alliance loop, FOREVER.
            int newTemperamentID = new Random().Next(1, 9);
            if (newTemperamentID == mainTemperamentID)
            {
                if (attemptNo <= 3)
                {
                    GetDifferentTemperamentID(mainTemperamentID, attemptNo++);
                }
                else
                {
                    // Obviously this else block would be sufficient alone.
                    // However, it's been a while since I implement a recursive functions.
                    // Also memes. Kappa
                    IEnumerable<int> temperamentNos = Enumerable.Range(1, 9);
                    temperamentNos = temperamentNos.Where(n => n != mainTemperamentID);
                    return temperamentNos.ElementAt<int>(new Random().Next(0, 7));
                }
            }
            return newTemperamentID;
        }

        /// <summary>
        /// Creates a wingTemperamentID from mainTemperamentID.
        /// </summary>
        public int GetAWingTemperamentID(int mainTemperamentID)
        {
            List<int> candidates = new List<int>();
            switch (mainTemperamentID)
            {
                case 1:
                    candidates.AddRange(new List<int> { 9, 2 });
                    break;
                case 2:
                    candidates.AddRange(new List<int> { 1, 3 });
                    break;
                case 3:
                    candidates.AddRange(new List<int> { 2, 4 });
                    break;
                case 4:
                    candidates.AddRange(new List<int> { 3, 5 });
                    break;
                case 5:
                    candidates.AddRange(new List<int> { 4, 6 });
                    break;
                case 6:
                    candidates.AddRange(new List<int> { 5, 7 });
                    break;
                case 7:
                    candidates.AddRange(new List<int> { 6, 9 });
                    break;
                case 8:
                    candidates.AddRange(new List<int> { 7, 9 });
                    break;
                case 9:
                    candidates.AddRange(new List<int> { 8, 1 });
                    break;
                default:
                    break;
            }
            return candidates[new Random().Next(0, 1)];
        }
        /// <summary>
        /// <para>Calculates coefficient of wingTemperament used in temperamentID calculation.</para>
        /// <para>Extracted from CalculateTemperamentID method for readability purposes.</para>
        /// </summary>
        /// <param name="mainTemperamentNo"></param>
        /// <param name="wingTemperamentNo"></param>
        /// <returns>Returns 0 or 1 depending on positioning of main-wing temperaments.</returns>
        public int GetWingTemperamentCoefficient(int mainTemperamentNo, int wingTemperamentNo)
        {
            int wtCo = 0;
            // wtCo is 0 if wingTemperament is on the "left" of mainTemperamentNo, 1 otherwise.
            // For boundaries (1 and 9), positioning is determined as follows:
            // In a circular placement like ..9,1,2,3,4,5,6,7,8,9,1..
            // Left: Counter-clockwise direction neighbor.
            // Right: Clockwise direction neighbor.
            if (mainTemperamentNo == 1 || mainTemperamentNo == 9)
            {
                if (mainTemperamentNo == 1)
                {
                    // (mt,wt) = (1,2)
                    if (wingTemperamentNo == 2)
                    {
                        wtCo++;
                    }
                    // (mt,wt) = (1,9) case left only => wtCo stays zero.
                    // No need else block.
                }
                // (mt,wt) = (1,2)
                if (wingTemperamentNo == 2)
                {
                    // Note that (mt,wt) cannot be (2,3) anyways due to out-most if check.
                    wtCo++;
                }
                // (mt,wt) = (9,1) case left only => wtCo stays zero.
                // No need else block.
            }
            return wtCo;
        }


        /// <summary>
        ///     <para> Calculates temperamentID(1..162) with the following formula: </para>
        ///     <para> ID = mtCo * 18 + wtCo * 9 + moCo * 3 + woCo </para>
        ///     <para> Each input parameter is mapped into a proper coefficient.</para>
        ///     <list type="bullet">
        ///     <item> mainTemperamentNo(1..9) -> mtCo(0..8)</item>
        ///     <item> wingTemperamentNo(1..9) -> mtCo(0,1)</item>
        ///     <item> mainOrientation(1,2,3) -> mtCo(0,1,2)</item>
        ///     <item> wingOrientation(1,2,3) -> mtCo(1,2,3)</item>
        ///     </list>
        /// </summary>
        /// <param name="mainTemperamentNo">Main temperament number should be a number in the range [1,9] </param>
        /// <param name="wingTemperamentNo">Wing temperament number must be a number adjacent to mainTemperamentNo.
        ///     <para>Sample valid (m,w) pairs: (1,3),(1,9),(4,3),(2,3)...</para>
        ///     <para>Sample invalid (m,w) pairs: (1,7),(2,4),(9,3),(1,8)...</para>
        /// </param>
        /// <param name="mainOrientation">Main Social Orientation. (1,2,3) for (Self,Relationships,Society) respectively.</param>
        /// <param name="wingOrientation">Wing Social Orientation. (1,2,3) for (Self,Relationships,Society) respectively.</param>
        /// <returns> A unique temperament ID number from 1 to 162. </returns>
        public int CalculateTemperamentID(int mainTemperamentNo, int wingTemperamentNo, int mainOrientation, int wingOrientation)
        {
            // mainTemperamentCoefficient
            int mtCo = mainTemperamentNo-1;
            // wingTemperamentCoefficient
            int wtCo = GetWingTemperamentCoefficient(mainTemperamentNo, wingTemperamentNo);
            // mainOrientationCoefficient
            int moCo = mainOrientation-1;
            // wingOrientationCoefficient
            int woCo = wingOrientation;
            return mtCo * 18 + wtCo * 9 + moCo * 3 + woCo;
        }

        public string GenerateTemperamentCode(int mainTemperamentNo, int wingTemperamentNo, int mainOrientation, int wingOrientation)
        {
            // Inconsistent whitespaces following commas...
            string code = $"T{mainTemperamentNo}, K{wingTemperamentNo}, E {mainOrientation},KE {wingOrientation}";
            return code;
        }

        public string GenerateTemperamentTitle(int mainTemperamentNo, int wingTemperamentNo, int mainOrientationNo, int wingOrientationNo)
        {
            string mainOrientation = "";
            string wingOrientation = "";
            switch (mainOrientationNo)
            {
                case 1:
                    mainOrientation += "Kendine Dönük";
                    break;
                case 2:
                    mainOrientation += "Iliskilere Dönük";
                    break;
                case 3:
                    mainOrientation += "Topluma Dönük";
                    break;
                default:
                    break;
            }
            switch (wingOrientationNo)
            {
                case 1:
                    wingOrientation += "Kendine Dönük";
                    break;
                case 2:
                    wingOrientation += "Iliskilere Dönük";
                    break;
                case 3:
                    wingOrientation += "Topluma Dönük";
                    break;
                default:
                    break;
            }
            // Inconsistent whitespaces following commas...
            string title = $"{mainOrientation} DTM{mainTemperamentNo} {wingOrientation} DTM{wingTemperamentNo}";
            return title;
        }

        public string GetMotivationFromTemperament(int mainTemperamentNo)
        {
            string motivation = "";
            switch (mainTemperamentNo)
            {
                case 1:
                    motivation += "Kusursuzluk Arayışı";
                    break;
                case 2:
                    motivation += "Duyguları Hissetme Arayışı";
                    break;
                case 3:
                    motivation += "Hayran Olunacak Kendilik İmajı Arayışı";
                    break;
                case 4:
                    motivation += "Bilginin Anlamını Arayış";
                    break;
                case 5:
                    motivation += "Iliskilere Dönük";
                    break;
                case 6:
                    motivation += "Entellektüel Dinginlik Arayışı";
                    break;
                case 7:
                    motivation += "Keşfetmenin Hazzını Arayış";
                    break;
                case 8:
                    motivation += "Mutlak Güç Arayışı";
                    break;
                case 9:
                    motivation += "Fiziksel (Duyumsal-Bedensel) Konfor Arayışı";
                    break;
                default:
                    break;
            }
            return motivation;
        }

        public void CreateHighSchoolTemperament(User solverUser, User testSubjectUser)
        {
            var solverUORID = dbContext.UserOrganizationRoles.FirstOrDefault(u => u.UserId == solverUser.Id).Id;
            var solverUOR = userOrganizationRoleServices.GetUserOrganizationRoles(solverUORID);
            var testSubjectUORID = dbContext.UserOrganizationRoles.FirstOrDefault(u => u.UserId == testSubjectUser.Id).Id;
            var testSubjectUOR = userOrganizationRoleServices.GetUserOrganizationRoles(solverUORID);
            int mainTemperamentId = new Random().Next(1, 9);
            int wingTemperamentId = GetAWingTemperamentID(mainTemperamentId);
            int mainOrientation = new Random().Next(1, 3);
            int wingOrientation = new Random().Next(1, 3);
            int temperamentID = CalculateTemperamentID(mainTemperamentId, wingTemperamentId, mainOrientation, wingOrientation);
            string code = GenerateTemperamentCode(mainTemperamentId, wingTemperamentId, mainOrientation, wingOrientation);
            temperamentTitle = GenerateTemperamentTitle(mainTemperamentId, wingTemperamentId, mainOrientation, wingOrientation);
            string result = $"{{" +
                            $"	\"result\": true," +
                            $"	\"data\": {{" +
                            $"		\"id\": { temperamentID }," +
                            $"		\"testTypeId\": 2," +
                            $"		\"mainTemperamentId\": { mainTemperamentId }," +
                            $"		\"wingMainTemperamentId\": { wingTemperamentId }," +
                            $"		\"mainTemperamentTendencyId\": {new Random().Next(1, 3)}," +
                            $"		\"wingMainTemperamentTendencyId\": {new Random().Next(1, 3)}," +
                            $"		\"code\": \"{ code }\","+
                            $"		\"title\": \"{ temperamentTitle }\","+
                            $"		\"summary\": \"<h2>Tanimlayan Anahtar Kelimeler:</h2>\\n <p>Iyi, Kotu, Cirkin</p>\\n <h3>Mizac Potansiyelinde Yer Alan Guclu Yonler</h3>\\n <ul>\\n <li>Gezmek</li>\\n <li>Gormek</li>\\n <li>Yazmak</li>\\n </ul>\\n <h3>Risk Olusturabilecek/Dengelenmesi Gereken Yonler</h3>\\n <ul>\\n <li>Cok gezmek</li>\\n <li>Cok gormek</li>\\n <li>Cok yazmak</li>\\n </ul>\\n <h3>Motivasyon Kaynaklari</h3>\\n <ul>\\n <li>Daha cok gezmek</li>\\n <li>Daha cok gormek</li>\\n <li>Daha cok yazmak</li>\\n </ul>\"," +
                            $"		\"description\": \"Currently there is no description.\"," +
                            $"		\"openTrendId\": { new Random().Next(1, 3) }," + // TODO (Taha) Ask what these are.
                            $"		\"hiddenTrendId\": { new Random().Next(1, 3) }," +
                            $"		\"basicMotivation\": \"{ GetMotivationFromTemperament(mainTemperamentId) }\"" +
                            $"	}}," +
                            $"	\"message\": \"Success\"" +
                            $"}}";

            temperament = new Temperament()
            {
                Id = Guid.NewGuid(),
                UserOrgRole = testSubjectUOR,
                SolverUserOrgRole = solverUOR,
                MizacTestId = new Guid(),
                IsSelected = false,
                IsActive = false,
                Result = result
            };
            mizacTestServices.AddTemperament(temperament);
        }
    }
}
