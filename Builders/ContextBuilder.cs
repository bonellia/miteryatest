using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Miterya.DataAccess;
using Miterya.Domain.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace Miterya.ScreenTest.Builders
{
    public class ContextBuilder
    {
        private IMiteryaDBContext _context;

        public ContextBuilder()
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile(Directory.GetCurrentDirectory().
                                            Substring(0, Directory.GetCurrentDirectory().
                                            LastIndexOf("\\bin")) + " \\appsettings.json")
                .Build();

            var builder = new DbContextOptionsBuilder<MiteryaDBContext>();            
            builder.UseSqlServer(configuration.GetConnectionString("MiteryaDBContext"));

            this._context = new MiteryaDBContext(builder.Options);
        }

        public IMiteryaDBContext GetContext()
        {
            return this._context;
        }

        public void ClearAllContext()
        {
            // Order of these are important.
            this._context.SchoolSettings.RemoveRange(this._context.SchoolSettings.ToList());
            this._context.Temperaments.RemoveRange(this._context.Temperaments.ToList());
            this._context.UserOrganizationRoles.RemoveRange(this._context.UserOrganizationRoles.ToList());
            this._context.UserProperties.RemoveRange(this._context.UserProperties.ToList());
            this._context.Parents.RemoveRange(this._context.Parents.ToList());
            this._context.Users.RemoveRange(this._context.Users.ToList());
            this._context.Terms.RemoveRange(this._context.Terms.ToList());
            this._context.RelOrganizationMenuActions.RemoveRange(this._context.RelOrganizationMenuActions.ToList());
            this._context.HrPositions.RemoveRange(this._context.HrPositions.ToList());
            this._context.HrDepartments.RemoveRange(this._context.HrDepartments.ToList());
            this._context.Organizations.RemoveRange(this._context.Organizations.ToList());
            this._context.TempClassrooms.RemoveRange(this._context.TempClassrooms.ToList());
            this._context.StudentDistributions.RemoveRange(this._context.StudentDistributions.ToList());
            this._context.TemperamentConfirmationLogs.RemoveRange(this._context.TemperamentConfirmationLogs.ToList());
            this._context.SurveyResults.RemoveRange(this._context.SurveyResults.ToList());
            this._context.SurveyQuestionAnswers.RemoveRange(this._context.SurveyQuestionAnswers.ToList());
            this._context.ClassroomSittingPlanTemplates.RemoveRange(this._context.ClassroomSittingPlanTemplates.ToList());
            this._context.SittingPlanClassroomDesks.RemoveRange(this._context.SittingPlanClassroomDesks.ToList());
            this._context.SurveyCriteriaScores.RemoveRange(this._context.SurveyCriteriaScores.ToList());
            this._context.SurveyCriteriaGroupScores.RemoveRange(this._context.SurveyCriteriaGroupScores.ToList());
            this._context.UserProperties.RemoveRange(this._context.UserProperties.ToList());
            this._context.SchoolTemperamentConfirmationSettings.RemoveRange(this._context.SchoolTemperamentConfirmationSettings.ToList());
            
            this._context.SaveChanges();
        }
        //TODO
        //public void ClearSpesificTable()
        //{
            
        //    _context.nameof("Users")
        //}
        public void ClearTemperaments()
        {
            this._context.TemperamentConfirmationLogs.RemoveRange(this._context.TemperamentConfirmationLogs.ToList());
            this._context.Temperaments.RemoveRange(this._context.Temperaments.ToList());
            this._context.SaveChanges();
        }
        public void ResetTemperamentsOfStudents()
        {
            List<User> studentsToReset = this._context.Users.Where(u => u.TemperamentTypeId != null && u.UserName.Contains("Student")).ToList();
            if (studentsToReset.Count != 0)
            {
                foreach (var student in studentsToReset)
                {
                    student.TemperamentTypeId = null;
                    this._context.Users.Update(student);
                }
            }
            this._context.SaveChanges();
        }
        public void ResetTemperamentOfUser(User user)
        {
            user.TemperamentTypeId = null;
            this._context.Users.Update(user);
            this._context.SaveChanges();
        }
    }
}
