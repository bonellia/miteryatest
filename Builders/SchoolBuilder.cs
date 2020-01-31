using Miterya.Domain.Common.CustomClass;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using Miterya.Service.OrganizationServices;
using Miterya.Service.SettingsServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Miterya.ScreenTest.Builders
{
    class SchoolBuilder
    {
        private readonly ContextBuilder contextBuilder;
        private DataBuilder dataBuilder;
        private readonly UserBuilder userBuilder;
        private readonly OrganizationServices organizationServices;
        private readonly SettingsServices settingsServices;

        // Keeping all these in lists in order to not query DB too often.
        public List<Organization> allOrganizations = new List<Organization>();
        public List<Organization> allClassrooms = new List<Organization>();
        public List<Organization> preSchoolClassrooms = new List<Organization>();
        public List<Organization> primarySchoolClassrooms = new List<Organization>();
        public List<Organization> secondarySchoolClassrooms = new List<Organization>();
        public List<Organization> highSchoolClassrooms = new List<Organization>();
        public Organization school;

        public List<User> allClassTeachers = new List<User>();
        public List<User> preSchoolTeachers = new List<User>();
        public List<User> primarySchoolTeachers = new List<User>();
        public List<User> secondarySchoolTeachers = new List<User>();
        public List<User> highSchoolTeachers = new List<User>();
        public User managerUser;
        public User leaderTeacherUser;

        public List<User> allStudents = new List<User>();
        public List<User> preSchoolStudents = new List<User>();
        public List<User> primarySchoolStudents = new List<User>();
        public List<User> secondarySchoolStudents = new List<User>();
        public List<User> highSchoolStudents = new List<User>();

        public List<User> allParents = new List<User>();
        public List<User> preSchoolParents = new List<User>();
        public List<User> primarySchoolParents = new List<User>();
        public List<User> secondarySchoolParents = new List<User>();
        public List<User> highSchoolParents = new List<User>();

        public SchoolBuilder(ContextBuilder contextBuilder)
        {
            this.contextBuilder = contextBuilder;
            this.userBuilder = new UserBuilder(contextBuilder.GetContext());
            this.organizationServices = new OrganizationServices(contextBuilder.GetContext());
            this.settingsServices = new SettingsServices(contextBuilder.GetContext());
            CreateAlternativeSchool();
        }

        public void ClearLists()
        {
            allStudents.Clear();
            preSchoolStudents.Clear();
            primarySchoolStudents.Clear();
            secondarySchoolStudents.Clear();
            highSchoolStudents.Clear();

            allParents.Clear();
            preSchoolParents.Clear();
            primarySchoolParents.Clear();
            secondarySchoolParents.Clear();
            highSchoolParents.Clear();

            allClassTeachers.Clear();
            preSchoolTeachers.Clear();
            primarySchoolTeachers.Clear();
            secondarySchoolTeachers.Clear();
            highSchoolTeachers.Clear();

            allOrganizations.Clear();
            allClassrooms.Clear();
            preSchoolClassrooms.Clear();
            primarySchoolClassrooms.Clear();
            secondarySchoolClassrooms.Clear();
            highSchoolClassrooms.Clear();
        }

        public void ResetApprovalAuthority(bool classTeacherAuthorized, bool leaderTeacherAuthorized)
        {
            // Need to clear previous approval related settings from DB.
            dataBuilder.contextBuilder.GetContext().SchoolTemperamentConfirmationSettings.RemoveRange(dataBuilder.contextBuilder.GetContext().SchoolTemperamentConfirmationSettings.ToList());
            dataBuilder.contextBuilder.GetContext().SaveChanges();

            if (classTeacherAuthorized || leaderTeacherAuthorized)
            {
                string confirmingRoleID = "";
                if (leaderTeacherAuthorized)
                {
                    // Only leader teacher can approve.
                    confirmingRoleID += "4";
                    if (classTeacherAuthorized)
                    {
                        // Both leader and class teachers can approve.
                        confirmingRoleID += ",2";
                    }
                }
                else
                {
                    if (classTeacherAuthorized)
                    {
                        // Only class teacher can approve.
                        confirmingRoleID += "2";
                    }
                }
                foreach (Organization classroom in allClassrooms)
                {
                    SchoolTemperamentConfirmationSetting newTemperamentAuthority;
                    Organization parentDepartment = organizationServices.GetParentOrganization(classroom.Id);
                    Organization parentSchool = organizationServices.GetParentOrganization(parentDepartment.Id);
                    newTemperamentAuthority = new SchoolTemperamentConfirmationSetting()
                    {
                        Id = Guid.NewGuid(),
                        SchoolId = parentSchool.Id,
                        ClassroomId = classroom.Id,
                        ConfirmingRoleIds = confirmingRoleID
                    };
                    settingsServices.AddNewTemperamentAuthority(newTemperamentAuthority);
                }
            }
            // Not inserting anything to SchoolTemperamentConfirmationSetting table in DB.
        }

        public void AddRandomTemperamentsToAllStudents()
        {
            foreach (User student in allStudents)
            {
                var studentNo = new Random().Next(1000, 9999) + "";
                userBuilder.AddPropertyToUser("schoolNo", studentNo, student);
            }
            foreach (User student in preSchoolStudents)
            {
                dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), student.Id, new Random().Next(501, 509));
                for (int i = 1; i <= 17; i += 4)
                {
                    dataBuilder.AssignGuidanceSurveyToUser(leaderTeacherUser, managerUser, student, i);
                }
            }
            foreach (User student in primarySchoolStudents)
            {
                userBuilder.SetTemperament(contextBuilder.GetContext(), student.Id, new Random().Next(401, 418));
                for (int i = 2; i <= 18; i += 4)
                {
                    dataBuilder.AssignGuidanceSurveyToUser(leaderTeacherUser, managerUser, student, i);
                }
            }
            foreach (User student in secondarySchoolStudents)
            {
                userBuilder.SetTemperament(contextBuilder.GetContext(), student.Id, new Random().Next(201, 362));
                for (int i = 3; i <= 19; i += 4)
                {
                    dataBuilder.AssignGuidanceSurveyToUser(leaderTeacherUser, managerUser, student, i);
                }
            }
            foreach (User student in highSchoolStudents)
            {
                userBuilder.SetTemperament(contextBuilder.GetContext(), student.Id, new Random().Next(201, 362));
                for (int i = 4; i <= 20; i += 4)
                {
                    dataBuilder.AssignGuidanceSurveyToUser(leaderTeacherUser, managerUser, student, i);
                }
            }
        }

        public void CreateAlternativeSchool()
        {
            ClearLists();
            dataBuilder = new DataBuilder(contextBuilder).CreateDummyOrganization().CreateDummyTerm();
            dataBuilder.CreateDummySchool(dataBuilder.organizationBuilder.organization.Id, true, true, true, true, 3);
            allOrganizations = organizationServices.GetSubOrganisations(dataBuilder.organization.Id);
            school = allOrganizations.Where(j => j.OrganTypeId == AppSettings.OrganizationTypeId.School).ToList()[0];

            User newManager = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(school, RoleEnum.Manager, 1)[0];
            dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newManager.Id, new Random().Next(1, 162));
            managerUser = newManager;
            User newLeaderTeacher = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(school, RoleEnum.LeaderTeacher, 1)[0];
            dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newLeaderTeacher.Id, new Random().Next(1, 162));
            leaderTeacherUser = newLeaderTeacher;

            foreach (Organization classroom in allOrganizations)
            {
                // Organizations we are iterating needs to be either a classroom or classroom without branch which are all types but preschool.
                // Preschool has branches (Either age based distribution or animal names etc.)
                if (classroom.OrganTypeId == AppSettings.OrganizationTypeId.Classroom || classroom.OrganTypeId == AppSettings.OrganizationTypeId.ClassroomWithoutBranch)
                {
                    dataBuilder.SetAccessClassroom(leaderTeacherUser, classroom.Id);
                    if (-5 <= classroom.Level && classroom.Level <= -3)
                    {
                        preSchoolClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        allClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        User newParent = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Parent, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newParent.Id, new Random().Next(1, 162));
                        User classTeacher = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Teacher, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), classTeacher.Id, new Random().Next(1, 162));
                        allClassTeachers.Add(classTeacher);
                        preSchoolTeachers.Add(classTeacher);
                        allParents.Add(newParent);
                        preSchoolParents.Add(newParent);
                        preSchoolStudents.AddRange(dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Student, 4));

                    }
                    else if (1 <= classroom.Level && classroom.Level <= 4)
                    {
                        primarySchoolClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        allClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        User newParent = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Parent, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newParent.Id, new Random().Next(1, 162));
                        User classTeacher = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Teacher, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), classTeacher.Id, new Random().Next(1, 162));
                        allClassTeachers.Add(classTeacher);
                        primarySchoolTeachers.Add(classTeacher);
                        allParents.Add(newParent);
                        primarySchoolParents.Add(newParent);
                        primarySchoolStudents.AddRange(dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Student, 4));

                    }
                    else if (5 <= classroom.Level && classroom.Level <= 8)
                    {
                        secondarySchoolClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        allClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        User newParent = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Parent, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newParent.Id, new Random().Next(1, 162));
                        User classTeacher = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Teacher, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), classTeacher.Id, new Random().Next(1, 162));
                        allClassTeachers.Add(classTeacher);
                        secondarySchoolTeachers.Add(classTeacher);
                        allParents.Add(newParent);
                        secondarySchoolParents.Add(newParent);
                        secondarySchoolStudents.AddRange(dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Student, 4));

                    }
                    else if (9 <= classroom.Level && classroom.Level <= 12)
                    {
                        highSchoolClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        allClassrooms.Add(allOrganizations.Where(i => i.Level == classroom.Level).FirstOrDefault());
                        User newParent = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Parent, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), newParent.Id, new Random().Next(1, 162));
                        User classTeacher = dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Teacher, 1)[0];
                        dataBuilder.userBuilder.SetTemperament(contextBuilder.GetContext(), classTeacher.Id, new Random().Next(1, 162));
                        allClassTeachers.Add(classTeacher);
                        highSchoolTeachers.Add(classTeacher);
                        allParents.Add(newParent);
                        highSchoolParents.Add(newParent);
                        highSchoolStudents.AddRange(dataBuilder.CreateListDummyUserInRangeWithRoleToOrganization(classroom, RoleEnum.Student, 4));

                    }
                    else // s: -2, -1, 0
                    {
                        // Console.WriteLine("This shouldn't happen.");
                    }
                }
            }
            allStudents.AddRange(preSchoolStudents);
            allStudents.AddRange(primarySchoolStudents);
            allStudents.AddRange(secondarySchoolStudents);
            allStudents.AddRange(highSchoolStudents);
            foreach (User student in allStudents)
            {
                var studentNo = new Random().Next(1000, 9999) + "";
                userBuilder.AddPropertyToUser("schoolNo", studentNo, student);

                // For every student we created (wow!), assign them a parent from their classroom.
                var studentOrganisationID = contextBuilder.GetContext().UserOrganizationRoles.Where(uor => student.Id == uor.UserId).FirstOrDefault().OrganizationId;
                var parentRoleID = "13676A48-FC7A-4694-82B2-CF0EE8F06313";
                var parentID = contextBuilder.GetContext().UserOrganizationRoles.Where(uor => uor.OrganizationId == studentOrganisationID && uor.RoleId == new Guid(parentRoleID)).FirstOrDefault().UserId;
                dataBuilder.AssignParentToStudent(parentID, student.Id);
            }
        }
    }
}
