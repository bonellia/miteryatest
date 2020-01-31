using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Miterya.DataAccess;
using Miterya.Domain.Common.CustomClass;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using Miterya.Service.OrganizationServices;

namespace Miterya.ScreenTest.Builders
{
    public class OrganizationBuilder
    {
        public Organization organization;

        private IMiteryaDBContext _context;

        IOrganizationServices organizationServices;

        //TODO make generic with only Random Imt
        public OrganizationBuilder(string name, int capacity, StudentTypeEnum rank, int level)
        {
            this.organization = new Organization();
            this.organization.Id = Guid.NewGuid();
            this.organization.Capacity = capacity;
            this.organization.Rank = rank;
            this.organization.Level = level;
            this.organization.Name = name;
            this.organization.ParentId = this.organization.Id;
        }

        public OrganizationBuilder(string name, int capacity)
        {
            this.organization = new Organization();
            this.organization.Id = Guid.NewGuid();
            this.organization.Name = name;
            this.organization.Capacity = capacity;
        }

        public OrganizationBuilder CreateOrganization(IMiteryaDBContext _context)
        {
            this._context = _context;
            this.organization.OrganTypeId = AppSettings.OrganizationTypeId.Organization;
            this.organization.ParentId = this.organization.Id;
            _context.Organizations.Add(this.organization);
            _context.SaveChanges();
            return this;
        }

        public List<Organization> CreateSchool(IMiteryaDBContext _context, Guid parentId, bool PreSchool, bool ElementerySchool, bool SecondarySchool, bool HighSchool, int? UserLimit)
        {
            List<Organization> organizations = new List<Organization>();
            this._context = _context;
            this.organization.OrganTypeId = AppSettings.OrganizationTypeId.School;
            this.organization.ParentId = parentId;

            #region db actions
            this._context.Organizations.Add(this.organization);
            this._context.SaveChanges();
            #endregion

            organizations.Add(this.organization);
            organizations.AddRange(AddSchoolWidthDefaultDepartments(this.organization, PreSchool, ElementerySchool, SecondarySchool, HighSchool, UserLimit));
            
            return organizations;
        }

        public List<Organization> AddSchoolWidthDefaultDepartments(Organization School, bool PreSchool, bool ElementerySchool, bool SecondarySchool, bool HighSchool, int? UserLimit)
        {
            List<Organization> organizations = new List<Organization>();
            var Classroom = _context.OrganTypes.Where(x => x.Id == AppSettings.OrganizationTypeId.Classroom).FirstOrDefault();
            var SchoolTypeId = AppSettings.OrganizationTypeId.School;
            var DepartmentTypeId = AppSettings.OrganizationTypeId.Department;

            var currentDepartmentsOfSchool = _context.Organizations.Include(x => x.Organizations1)
                                                     .Where(x => x.ParentId == School.Id && x.IsActive && !x.IsDeleted).ToList();

            if (PreSchool)
                organizations.AddRange(CreatePreSchoolWithDefault(School, Classroom, DepartmentTypeId));

            if (ElementerySchool)
                organizations.AddRange(CreateElementerySchoolWithDefault(School, Classroom, DepartmentTypeId));

            if (SecondarySchool)
                organizations.AddRange(CreateSecondarySchoolWithDefault(School, Classroom, DepartmentTypeId));

            if (HighSchool)
                organizations.AddRange(CreateHighSchoolWithDefault(School, Classroom, DepartmentTypeId));

            SchoolSetting schoolSetting = _context.SchoolSettings.Where(a => a.SchoolId == School.Id).FirstOrDefault();
            _context.SchoolSettings.Add(new SchoolSetting { SchoolId = School.Id, SchoolUserLimit = UserLimit });
            _context.SaveChanges();
            return organizations;
        }

        public OrganizationBuilder SetType(OrganTypeEnum organTypeEnum)
        {
            switch (organTypeEnum)
            {
                //TODO organizasyon olmayan hepsine organizasyon ekle
                case (OrganTypeEnum.Organization):
                    this.organization.OrganTypeId = new Guid("32222218-716A-47B0-BDDF-6D9AE4837C2E");
                    this.organization.Rank = 0;
                    break;
                case (OrganTypeEnum.School):
                    this.organization.OrganTypeId = new Guid("242821D5-58AB-47C9-991E-1E96A6FC3074");
                    //Organization organization = GetParentOrganizationOrCreateForTest(this.organization);
                    break;
                case (OrganTypeEnum.Classroom):
                    this.organization.OrganTypeId = new Guid("E0A53BFC-7837-4B05-A351-FCAE56A371D7");
                    break;
                case (OrganTypeEnum.ClassroomWithoutBranch):
                    this.organization.OrganTypeId = new Guid("A1E78419-9EA6-4B61-B4E6-C7F2C6BE68EF");
                    break;
                case (OrganTypeEnum.Department): // PreSchool, Elementary, Secondary, High School
                    this.organization.OrganTypeId = new Guid("FAFE25E5-2E61-4502-B076-F04217ACB18B");
                    break;
            }

            return this;
        }

        public Organization Build(IMiteryaDBContext _context)
        {
            this._context = _context;

            #region basemodel operations
            this.organization.DateCreated = DateTime.Now;
            this.organization.DateModified = DateTime.Now;
            this.organization.IsActive = true;
            this.organization.IsDeleted = false;
            #endregion

            #region db actions
            //organizationServices.AddNewOrganization(this.organization);
            this._context.Organizations.Add(this.organization);
            this._context.SaveChanges();
            #endregion
            //AddAllModuleToOrganization();
            return this.organization;
        }

        public Organization GetParentOrganizationOrCreateForTest(Organization organization)
        {
            if (organization.ParentId == null)
            { return null; }
            //TODO Create Organization

            int count = 0;

            while (count < 5)
            {
                if (organization.OrganType.Id == AppSettings.OrganizationTypeId.Organization)
                    break;
                else
                    organization = _context.Organizations.Include(a => a.OrganType).Where(a => a.Id == organization.ParentId).FirstOrDefault();

                count++;
            }
            return organization;
        }


        //Modul satin alinma islemleri
        public void AddAllModuleToOrganization()
        {
            List<Guid> menuActions = this._context.MenuActions.Select(i => i.Id).ToList();
            foreach (var item in menuActions)
            {
                RelOrganizationMenuAction relOrganizationMenuAction = new RelOrganizationMenuAction();
                relOrganizationMenuAction.MenuActionId = item;
                relOrganizationMenuAction.OrganizationId = this.organization.Id;
                relOrganizationMenuAction.IsPassive = null;
                this._context.RelOrganizationMenuActions.Add(relOrganizationMenuAction);
            }
            this._context.SaveChanges();
        }

        public void AddModuleToOrganization(string menuName)
        {
            Guid menuGuid = this._context.MenuActions.Where(i => i.Name_TR == menuName).Select(i => i.Id).FirstOrDefault();

            RelOrganizationMenuAction isAlreadyExist = this._context.RelOrganizationMenuActions
                                                .Where(i => i.MenuActionId == menuGuid & i.OrganizationId == this.organization.Id)
                                                .FirstOrDefault();
                                                
            if(isAlreadyExist == null)
            {
                RelOrganizationMenuAction relOrganizationMenuAction = new RelOrganizationMenuAction();
                relOrganizationMenuAction.MenuActionId = menuGuid;
                relOrganizationMenuAction.OrganizationId = this.organization.Id;
                relOrganizationMenuAction.IsPassive = null;
                this._context.RelOrganizationMenuActions.Add(relOrganizationMenuAction);
                this._context.SaveChanges();
            }

        }

        public void RemoveModuleToOrganization(string menuName)
        {
            Guid menuGuid = this._context.MenuActions.Where(i => i.Name_TR == menuName).Select(i => i.Id).FirstOrDefault();

            RelOrganizationMenuAction isAlreadyExist = this._context.RelOrganizationMenuActions
                                                .Where(i => i.MenuActionId == menuGuid & i.OrganizationId == this.organization.Id)
                                                .FirstOrDefault();

            if (isAlreadyExist != null)
            {
                this._context.RelOrganizationMenuActions.Remove(isAlreadyExist);
                this._context.SaveChanges();
            }

        }

        public void RemoveAllModuleFromOrganization()
        {
            List<RelOrganizationMenuAction> relOrganizationMenuActions = this._context.RelOrganizationMenuActions
                                                                                    .Where(i => i.OrganizationId == this.organization.Id)
                                                                                    .ToList();

            if (relOrganizationMenuActions.Count != 0)
            {
                this._context.RelOrganizationMenuActions.RemoveRange(relOrganizationMenuActions);
                this._context.SaveChanges();
            }
        }

        //TODO optimize edilecek
        private List<Organization> CreateHighSchoolWithDefault(Organization School, OrganType Classroom, Guid DepartmentTypeId)
        {
            Organization newDepartment = new Organization
            {
                Id = Guid.NewGuid(),
                ParentId = School.Id,
                OrganTypeId = DepartmentTypeId,
                Name = StudentTypeEnum.HighSchool.ToString(),
                Rank = StudentTypeEnum.HighSchool,
            };

            List<Organization> organizations = new List<Organization>() { newDepartment };

            organizations.AddRange(ClassroomWithoutBranchList(newDepartment.Id, Classroom, 1000, 4, 9, 12));
            _context.Organizations.AddRange(organizations);

            return organizations;
        }

        private List<Organization> CreateSecondarySchoolWithDefault(Organization School, OrganType Classroom, Guid DepartmentTypeId)
        {
            Organization newDepartment = new Organization
            {
                Id = Guid.NewGuid(),
                ParentId = School.Id,
                OrganTypeId = DepartmentTypeId,
                Name = StudentTypeEnum.SecondarySchool.ToString(),
                Rank = StudentTypeEnum.SecondarySchool,
            };

            List<Organization> organizations = new List<Organization>() { newDepartment };

            organizations.AddRange(ClassroomWithoutBranchList(newDepartment.Id, Classroom, 1000, 3, 5, 8));
            _context.Organizations.AddRange(organizations);

            return organizations;
        }

        private List<Organization> CreateElementerySchoolWithDefault(Organization School, OrganType Classroom, Guid DepartmentTypeId)
        {
            Organization newDepartment = new Organization
            {
                Id = Guid.NewGuid(),
                ParentId = School.Id,
                OrganTypeId = DepartmentTypeId,
                Name = StudentTypeEnum.ElementarySchool.ToString(),
                Rank = StudentTypeEnum.ElementarySchool,
            };

            List<Organization> organizations = new List<Organization>() { newDepartment };

            organizations.AddRange(ClassroomWithoutBranchList(newDepartment.Id, Classroom, 1000, 2, 1, 4));
            _context.Organizations.AddRange(organizations);

            return organizations;
        }

        private List<Organization> CreatePreSchoolWithDefault(Organization School, OrganType Classroom, Guid DepartmentTypeId)
        {
            Organization newDepartment = new Organization()
            {
                Id = Guid.NewGuid(),
                ParentId = School.Id,
                Name = StudentTypeEnum.PreSchool.ToString(),
                OrganTypeId = DepartmentTypeId,
                Rank = StudentTypeEnum.PreSchool
            };

            List<Organization> DefaultClassrooms = new List<Organization>() { newDepartment };

            for (int i = 3; i < 6; i++)
                DefaultClassrooms.Add(new Organization() { Id = Guid.NewGuid(), ParentId = newDepartment.Id, Name = i + " Yaş", OrganType = Classroom, Capacity = 1000, Level = -1 * i, Rank = StudentTypeEnum.PreSchool });

            _context.Organizations.AddRange(DefaultClassrooms);
            return DefaultClassrooms;
        }

        private List<Organization> ClassroomWithoutBranchList(Guid ParentId, OrganType organType, int Capacity, int Rank, int LevelStart, int LevelEnd)
        {
            List<Organization> list = new List<Organization>();
            for (int i = LevelStart; i <= LevelEnd; i++)
            {
                list.Add(new Organization()
                {
                    Id = Guid.NewGuid(),
                    ParentId = ParentId,
                    Name = i.ToString() + "-" + Convert.ToChar(i % 4 + 65),
                    OrganType = organType,
                    Capacity = Capacity,
                    Level = i,
                    Rank = (StudentTypeEnum)Rank
                });
            }
            return list;
        }


    }
}
