using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Miterya.DataAccess;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;
using Miterya.Service.PropertyServices;
using Miterya.Service.RoleServices;
using Miterya.Service.UserServices;
using Miterya.Service.OrganizationServices;

namespace Miterya.ScreenTest.Builders
{
    public class UserBuilder
    {
        private User user;
        private IMiteryaDBContext _context;
        private readonly IPropertyServices _userProperties;
        private readonly IOrganizationServices _organizationServices;
        readonly List<string> dummyFemaleNames = new List<string>
        {
            "Fatma", "Ayse", "Emine", "Hatice", "Zeynep", "Elif", "Meryem", "Serife", "Zehra", "Sultan", "Hanife", "Merve",
            "Havva", "Zeliha", "Esra", "Fadime", "Ozlem", "Hacer", "Melek", "Yasemin", "Rabia", "Hulya", "Cemile", "Sevim", "Gulsum",
            "Leyla", "Dilek", "Busra", "Aysel", "Songul", "Kubra", "Halime", "Esma", "Aynur", "Hayriye", "Kadriye", "Tugba", "Sevgi",
            "Rukiye", "Hava", "Sibel", "Derya", "Filiz", "Asiye", "Keziban", "Ebru", "Aysegul", "Dondu", "Selma", "Ayten"
        };
        readonly List<string> dummyMaleNames = new List<string>
        {
            "Mehmet", "Mustafa", "Ahmet", "Ali", "Huseyin", "Hasan", "Ibrahim", "Ismail", "Osman", "Yusuf", "Murat", "Omer",
            "Ramazan", "Halil", "Suleyman", "Abdullah", "Mahmut", "Recep", "Salih", "Fatih", "Kadir", "Emre", "Mehmet Ali", "Hakan",
            "Adem", "Kemal", "Yasar", "Bekir", "Musa", "Metin", "Bayram", "Serkan", "Orhan", "Burak", "Furkan", "Gokhan",
            "Yasin", "Ugur", "Yakup", "Muhammet", "Muhammed", "Sukru", "Cemal", "Enes", "Yunus", "Arif", "Onur", "Yilmaz", "Saban", "Halil Ibrahim"
        };
        readonly List<string> dummySurnames = new List<string>
        {
            "Yilmaz", "Kaya", "Demir", "Celik", "Sahin", "Yildiz", "Yildirim", "Ozturk", "Aydin", "Ozdemir", "Arslan",
            "Dogan", "Kilic", "Aslan", "Cetin", "Kara", "Koc", "Kurt", "Ozkan", "Simsek", "Polat", "Ozcan", "Korkmaz",
            "Cakir", "Erdogan", "Yavuz", "Can", "Acar", "Sen", "Aktas", "Guler", "Yalcin", "Gunes", "Bozkurt", "Bulut",
            "Keskin", "Unal", "Turan", "Gul", "Ozer", "Isik", "Kaplan", "Avci", "Sari", "Tekin", "Tas", "Kose", "Yuksel", "Ates", "Aksoy"
        };

        public UserBuilder(long nationalId, string userName, string password, string name, string surname, string email,
                                /*int positionId,*/ string phoneNumber, Boolean sex, UserStateEnum state)
        {
            this.user = new User
            {
                NationalId = nationalId,
                UserName = userName,
                Password = password,
                Name = name,
                Surname = surname,
                Email = email,
                PositionID = 0,
                PhoneNumber = phoneNumber,
                State = state,
                Sex = sex,
                BirthDate = DateTime.Today,ShowTemperament = true
            };
        }

        public UserBuilder(IMiteryaDBContext context)
        {
            this._context = context;
            _organizationServices = new OrganizationServices(_context);
            _userProperties = new PropertyServices(context);
        }

        
        public UserBuilder(long nationalId, string userName)
        {
            this.user = new User
            {
                NationalId = nationalId,
                UserName = userName,
                Password = "biriki34",
                Sex = new Random().Next() > (int.MaxValue / 2),
                BirthDate = DateTime.Today,
                Surname = dummySurnames[new Random().Next(0, 49)],
                Email = "tester@testdomain.com",
                PositionID = 0,
                PhoneNumber = "+903122211212",
                ShowTemperament = true
            };
            // Benim gibi cocugun cinsiyeti belli olmadan isim vermeye calismayin, patliyor. :D
            this.user.Name = this.user.Sex ? dummyMaleNames[new Random().Next(0, 49)] : dummyFemaleNames[new Random().Next(0, 49)];
        }

        public User GetUser()
        {
            return this.user;
        }

        public void SetRoleToUser(IMiteryaDBContext _context, RoleEnum role, Term term, Organization organization, User user)
        {
            this._context = _context;

            UserOrganizationRole tempRole = this._context.UserOrganizationRoles.Where(i => i.UserId == this.user.Id && i.IsActive == true).FirstOrDefault();
            if (tempRole != null)
            {
                tempRole.IsActive = false;
                tempRole.DateModified = DateTime.Now;

                this._context.Entry(this.user).State = EntityState.Modified;
            }

            UserOrganizationRole newRole = new UserOrganizationRole
            {
                Id = Guid.NewGuid(),
                IsActive = true,
                DateCreated = DateTime.Now,
                DateModified = DateTime.Now,
                UserCreated = user.Id,
                IsDeleted = false,
                UserId = user.Id,
                OrganizationId = organization.Id,
                RoleId = this._context.Roles.AsNoTracking().FirstOrDefault(a => a.Code == (int)role).Id, //GetRuleId(role);
                TermId = term.Id,
                UserDashboardModule = null,
                AccessClassroomIds = null,
                CanLogin = false
            };
            if (organization.OrganTypeId == Guid.Parse("E0A53BFC-7837-4B05-A351-FCAE56A371D7") || organization.OrganTypeId == Guid.Parse("A1E78419-9EA6-4B61-B4E6-C7F2C6BE68EF"))
                newRole.AccessClassroomIds = organization.Id.ToString();

            this._context.UserOrganizationRoles.Add(newRole);
            this._context.SaveChanges();

            
        }

        public void SetRole(IMiteryaDBContext _context, RoleEnum role, Term term, Organization organization)
        {
            this._context = _context;

            UserOrganizationRole tempRole = this._context.UserOrganizationRoles.Where(i => i.UserId == this.user.Id && i.IsActive == true).FirstOrDefault();
            if (tempRole != null)
            {
                tempRole.IsActive = false;
                tempRole.DateModified = DateTime.Now;

                this._context.Entry(this.user).State = EntityState.Modified;
            }

            UserOrganizationRole newRole = new UserOrganizationRole
            {
                Id = Guid.NewGuid(),
                IsActive = true,
                DateCreated = DateTime.Now,
                DateModified = DateTime.Now,
                UserCreated = this.user.Id,
                IsDeleted = false,
                UserId = this.user.Id,
                OrganizationId = organization.Id,
                RoleId = this._context.Roles.AsNoTracking().FirstOrDefault(a => a.Code == (int)role).Id,
                TermId = term.Id,
                UserDashboardModule = null,
                AccessClassroomIds = null,
                CanLogin = false
            };
            if (organization.OrganTypeId == Guid.Parse("E0A53BFC-7837-4B05-A351-FCAE56A371D7") || organization.OrganTypeId == Guid.Parse("A1E78419-9EA6-4B61-B4E6-C7F2C6BE68EF"))
                newRole.AccessClassroomIds = organization.Id.ToString();

            this._context.UserOrganizationRoles.Add(newRole);
            this._context.SaveChanges();

        }

        public void SetAccessClassrooms(IMiteryaDBContext _context, User user, List<Guid> classes)
        {
            this._context = _context;

            UserOrganizationRole uor = this._context.UserOrganizationRoles.Find(user);

            foreach (var item in classes)
                uor.AccessClassroomIds = string.Join(",", item);

            this._context.Entry(uor);
            this._context.SaveChanges();

        }

        public void SetAccessClassroom(IMiteryaDBContext _context, Guid userId, Guid clss)
        {
            this._context = _context;

            UserOrganizationRole uor = this._context.UserOrganizationRoles.Where(i => i.UserId == userId && i.IsActive == true).FirstOrDefault();
            if (String.IsNullOrEmpty(uor.AccessClassroomIds))
                uor.AccessClassroomIds = clss.ToString();
            else
                uor.AccessClassroomIds += "," + clss.ToString();// (",", clss); bu parantezli yapiyi yazinca (,, GUID) seklinde kayit atiyor mantigi incele

            this._context.Entry(uor);
            this._context.SaveChanges();

        }

        public void AddRole(IMiteryaDBContext _context, RoleEnum role, Term term, Organization organization)
        {
            this._context = _context;

            UserOrganizationRole newRole = new UserOrganizationRole
            {
                Id = Guid.NewGuid(),
                IsActive = true,
                DateCreated = DateTime.Now,
                DateModified = DateTime.Now,
                UserCreated = this.user.Id,
                IsDeleted = false,
                UserId = this.user.Id,
                OrganizationId = organization.Id,
                RoleId = this._context.Roles.AsNoTracking().FirstOrDefault(a => a.Code == (int)role).Id,
                TermId = term.Id,
                AccessClassroomIds = null,
                UserDashboardModule = null
            };

            this._context.UserOrganizationRoles.Add(newRole);
            this._context.SaveChanges();

        }

        public void SetTemperament(IMiteryaDBContext _context,Guid userId, int tempId)
        {
            var user = _context.Users.Find(userId);
            user.TemperamentTypeId = tempId;
            _context.Entry(user);
            _context.SaveChanges();
        }
        public StudentTypeEnum GetStudentRankByStudentOrganizationId(Guid StudentOrganizationId)
        {
            StudentTypeEnum studentEnum = _organizationServices.GetStudentTypeByStudentOrganizationId(StudentOrganizationId);
            return studentEnum;
        }
        
        public Guid GetRoleId(RoleEnum role)
        {
            return this._context.Roles.AsNoTracking().FirstOrDefault(a => a.Code == (int)role).Id;
        }

        public User Build(IMiteryaDBContext _context)
        {
            this.user.Id = Guid.NewGuid();
            this.user.UserCreated = this.user.Id;
            this.user.UserModified = this.user.Id;

            this._context = _context;


            this._context.Users.Add(this.user);
            this._context.SaveChanges();

            return this.user;
        }

        public void AddPropertyToUser(string propertyName, string propertyValue, User user)
        {
            var propertyID = _context.Properties.Where(i => i.PropertyName == propertyName).Select(i => i.Id).FirstOrDefault();
            var hasGivenProperty = _context.UserProperties.Where(i => i.UserId == user.Id && i.PropertyId == propertyID).FirstOrDefault();
            if (hasGivenProperty == null)
            {
                UserProperty userProperty = new UserProperty
                {
                    // Depending on user role, add different properties.
                    Id = Guid.NewGuid(),
                    IsActive = true,
                    IsDeleted = false,
                    DateCreated = DateTime.Now,
                    DateModified = DateTime.Now,
                    UserId = user.Id,
                    // Following property ID is expected to be for School No.
                    PropertyId = propertyID,
                    Value = propertyValue
                };
                _userProperties.AddUserProperties(userProperty);
            }
            else
            {
                Console.WriteLine("User already has the given property.");
            }
        }

    }
}
