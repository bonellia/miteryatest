using Miterya.DataAccess;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using System;
using System.Collections.Generic;
using System.Text;

namespace Miterya.ScreenTest.Builders
{

    public class DataBuilder
    {
        public User user;
        public Term term;
        public Organization organization;
        public ContextBuilder contextBuilder;
        public UserBuilder userBuilder;
        public TermBuilder termBuilder;
        public OrganizationBuilder organizationBuilder;
        public int nationalIdCounter;
        //public List<Organization> organizations;
        public List<User> users;
        int idCounter;
        int nationalIDCounter;

        public DataBuilder(ContextBuilder contextBuilder)
        {
            this.contextBuilder = contextBuilder;
            //organizations = new List<Organization>();
            users = new List<User>();
        }

        public string GenerateUserID()
        {
            string userID;
            /*
            During the tests, we need to generate user credentials where user id needs to be unique.
            When user count of the test is few (say 10), the random number generation works fine.
            However, when user count exceeds a certain threshold, collisions occur.
            We also don't want to use Guid because we want to use more "typable" usernames.
            */
            if (idCounter < 10)
            {
                userID = "000" + idCounter.ToString();
            }
            else if (idCounter < 100)
            {
                userID = "00" + idCounter.ToString();
            }
            else if (idCounter < 1000)
            {
                userID = "0" + idCounter.ToString();
            }
            else
            {
                userID = idCounter.ToString();
            }
            idCounter++;
            return userID;
        }

        public int GenerateNationalID()
        {
            nationalIDCounter++;
            return nationalIDCounter;
        }

        public DataBuilder CreateDummyUserWithRole(RoleEnum roleEnum)
        {
            this.userBuilder = new UserBuilder(1111111, "dummyUser", "123456", "dummyUser", "dummySirName", "dummyUser@mizmer.com.tr", "123456", true,UserStateEnum.Active);
            this.user = userBuilder.Build(contextBuilder.GetContext());

            this.termBuilder = new TermBuilder("testTerm", "testTerm", DateTime.Now.Year, 1);
            this.term = termBuilder.Build(contextBuilder.GetContext());

            this.organizationBuilder = new OrganizationBuilder("testOrganization", 0, Miterya.Domain.Common.Enums.StudentTypeEnum.ElementarySchool, 12);
            organizationBuilder.SetType(OrganTypeEnum.Organization);
            this.organization = organizationBuilder.Build(contextBuilder.GetContext());

            userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, term, organization);
            return this;
        }

        public DataBuilder CreateDummyUser()
        {
            this.userBuilder = new UserBuilder(1111111, "dummyUser", "123456", "dummyUser", "dummySirName", "dummyUser@mizmer.com.tr", "123456", true,UserStateEnum.Active);
            this.user = userBuilder.Build(contextBuilder.GetContext());
            this.users.Add(this.user);

            this.termBuilder = new TermBuilder("testTerm", "testTerm", DateTime.Now.Year, 1);
            this.term = termBuilder.Build(contextBuilder.GetContext());
            return this;
        }

        public DataBuilder CreateDummyTerm()
        {
            this.termBuilder = new TermBuilder("testTerm", "testTerm", DateTime.Now.Year, 1);
            this.term = termBuilder.Build(contextBuilder.GetContext());
            return this;
        }

        public DataBuilder CreateDummyUserWithRoleToOrganization(RoleEnum roleEnum)
        {
            this.userBuilder = new UserBuilder
                (
                    10000000000 + GenerateNationalID(), // National Id
                    (roleEnum.ToString() + GenerateUserID()).Trim(), // Username
                    "123456",  //pass
                    "dummyUser", //name
                    "dummySirName", //surname
                    "dummyUser@dummymail.com.tr", //email
                    "123456", //phone
                    true, //sex
                    UserStateEnum.Active
                );

            this.user = userBuilder.Build(contextBuilder.GetContext());
            this.users.Add(this.user);

            userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, term, organization);

            return this;
        }

        //TODO yarim gonderilen usera ilgili role atanacak
        public DataBuilder SetRoleToOrganization(User user, Organization organization, RoleEnum roleEnum)
        {
            userBuilder.SetRoleToUser(contextBuilder.GetContext(), roleEnum, term, organization, user);
            return this;
        }

        public List<User> CreateListDummyUserWithRoleToOrganization(Organization organizations, RoleEnum roleEnum)
        {
            List<User> users = new List<User>();
            int userRandId = new Random().Next(10000, 99999);
            this.userBuilder = new UserBuilder
                (
                    10000000000 + GenerateNationalID(), // National Id
                    (roleEnum.ToString() + GenerateUserID()).Trim(), // Username
                    "123456",  //pass
                    "testerName" + userRandId.ToString(), //name
                    "testerSurname", //surname
                    "tester@testdomain.com", //email
                    "+905001234567", // phone number
                    true, // gender
                    UserStateEnum.Active
                );
            this.user = userBuilder.Build(contextBuilder.GetContext());
            this.users.Add(this.user);

            userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, term, organizations);

            return users;
        }

        public List<User> CreateListDummyUserWithRoleToRangeOrganization(List<Organization> organizations, RoleEnum roleEnum)
        {
            List<User> users = new List<User>();
            foreach(var item in organizations)
            {
                this.userBuilder = new UserBuilder
                    (
                        10000000000 + GenerateNationalID(), // National Id, //national Id
                        (/*organization.Level.ToString() + */roleEnum.ToString() + GenerateUserID()).Trim() // Username
                    );
                this.user = userBuilder.Build(contextBuilder.GetContext());
                this.users.Add(this.user);

                userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, term, item);
            }

            return users;
        }

        public List<User> CreateListDummyUserInRangeWithRoleToOrganization(Organization organization, RoleEnum roleEnum, int count)
        {
            List<User> users = new List<User>();
            for (int i = 0; i < count; i++)
            {
                this.userBuilder = new UserBuilder
                    (
                        10000000000 + GenerateNationalID(), // National Id
                        (/*organization.Level.ToString() +*/ roleEnum.ToString() + GenerateUserID()).Trim() // Username
                    );
                this.user = userBuilder.Build(contextBuilder.GetContext());
                users.Add(this.user);

                userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, term, organization);
            }
            return users;
        }

        public DataBuilder CreateOrganizationByType(OrganTypeEnum organType)
        {
            this.organizationBuilder = new OrganizationBuilder("testOrganization", 0, Miterya.Domain.Common.Enums.StudentTypeEnum.ElementarySchool, 12);
            organizationBuilder.SetType(organType);
            this.organization = organizationBuilder.Build(contextBuilder.GetContext());

            //this.organizations.Add(this.organization);

            organizationBuilder.AddAllModuleToOrganization();//setting all modules as a purchased
            return this;
        }

        public DataBuilder SetRol(RoleEnum roleEnum)
        {
            userBuilder.SetRole(contextBuilder.GetContext(), roleEnum, this.term, this.organization);
            return this;
        }

        public DataBuilder AddRole(RoleEnum roleEnum)
        {
            userBuilder.AddRole(contextBuilder.GetContext(), roleEnum, this.term, this.organization);
            return this;
        }

        public DataBuilder SetAccessClassrooms(User user, List<Guid> classes)
        {
            foreach(var item in classes)
            userBuilder.SetAccessClassrooms(contextBuilder.GetContext(), user, classes);
            return this;
        }

        public DataBuilder SetAccessClassroom(User user, Guid clss)
        {
            userBuilder.SetAccessClassroom(contextBuilder.GetContext(), user.Id, clss);
            return this;
        }

        public DataBuilder CreateDummyOrganization()
        {
            //this.organizationBuilder = new OrganizationBuilder("testOrganization", 0, Miterya.Domain.Common.Enums.StudentTypeEnum.ElementarySchool, 12);
            this.organizationBuilder = new OrganizationBuilder("Dummy Organization", 20).CreateOrganization(contextBuilder.GetContext());
            this.organization = this.organizationBuilder.organization;
            //this.organizations.Add(this.organization);
            organizationBuilder.AddAllModuleToOrganization();//setting all modules as a purchased
            return this;
        }

        public DataBuilder CreateDummySchool(Guid parentId, bool PreSchool, bool ElementerySchool, bool SecondarySchool, bool HighSchool, int? UserLimit)
        {
            this.organizationBuilder = new OrganizationBuilder("dummy School", 20);
            organizationBuilder.CreateSchool(contextBuilder.GetContext(), parentId, PreSchool, ElementerySchool, SecondarySchool, HighSchool, UserLimit);// this.organizations.AddRange(organizationBuilder.CreateSchool(contextBuilder.GetContext(), parentId, true, false, false, false, 100));

            return this;
        }

        public User AssignParentToStudent(Guid parentGuid, Guid studentGuid)
        {

            contextBuilder.GetContext().Parents.Add
                (
                    new Parent
                    {
                        Id = new Guid(),
                        UserParentId = parentGuid,
                        UserStudentId = studentGuid
                    }
                );
            contextBuilder.GetContext().SaveChanges();
            return this.user;
        }

        // Created to use on Mizac Testi functionality test.
        public void AddDummyMizacTestToUser(Guid solver, Guid solved)
        {
            IMiteryaDBContext _context = contextBuilder.GetContext();

            // Note: Student still needs approval.
            _context.Temperaments.Add(
                new Temperament
                {
                    DateCreated = DateTime.Today,
                    UserCreated = solver,
                    DateModified = DateTime.Today,
                    UserModified = solver,
                    Id = new Guid(),
                    UserOrgRoleId = solved,
                    SolverUserOrgRoleId = solver,
                    MizacTestId = new Guid(),
                    Result = "{ \"result\": true,\"data\": {\"id\": 113,\"testTypeId\": 3,\"mainTemperamentId\": 7, "
                            + " \"wingMainTemperamentId\": 6, \"mainTemperamentTendencyId\": 2, "
                            + " \"wingMainTemperamentTendencyId\": 2, \"code\": \"T7, K6, E 2,KE 2\", "
                            + " \"title\": \"İliskilere Dönük DTM7 İliskilere Dönük DTM6\", "
                            + " \"summary\": \"<p>dummy summary </p>\", \"description\": \"Description of T7, K6, E 2,KE 2\", "
                            + " \"openTrendId\": 2, \"hiddenTrendId\": 2, \"basicMotivation\": \"Keşfetmenin Hazzını Arayış\"}, "
                            + " \"message\": \"Success\" }",
                    IsSelected = true
                }
                );
            _context.SaveChanges();
        }

        public void AddDummySurveyTestToUser(Guid solver, Guid solved, int anketId)
        {
            IMiteryaDBContext _context = contextBuilder.GetContext();

            _context.HrUserSurveys.Add(
                new HrUserSurvey
                {
                    DateCreated = DateTime.Today,
                    UserCreated = solver,
                    DateModified = DateTime.Today,
                    UserModified = solver,
                    IsActive = true,
                    IsDeleted = false,
                    Id = new int(),
                    RatedUserId = solved,
                    EvaluatedUserId = solver,
                    SurveyId = anketId,
                    SurveyState  = 1,
                    AnswerId = 0,
                    SurveyManipulationValue = 0
                }
                );
            _context.SaveChanges();
        }

        public void AssignGuidanceSurveyToUser(User assigner, User evaluator, User evaluatee, int surveyID)
        {
            IMiteryaDBContext _context = contextBuilder.GetContext();

            _context.GuidanceUserSurveys.Add(
                new GuidanceUserSurvey
                {
                    DateCreated = DateTime.Today,
                    UserCreated = evaluator.Id,
                    DateModified = DateTime.Today,
                    UserModified = evaluator.Id,
                    IsActive = true,
                    IsDeleted = false,
                    Id = new int(),
                    AssignmentUserId = assigner.Id,
                    EvaluatedUserId = evaluator.Id,
                    StudentUserId = evaluatee.Id,
                    DfnGuidanceSurveyId = surveyID,
                    StudentTemperamentId = evaluatee.TemperamentTypeId != null ? (int) evaluatee.TemperamentTypeId : 0,
                    SurveyState = 1,
                    AnswerId = 0
                }
                );
            _context.SaveChanges();
            
    }
    }
}
