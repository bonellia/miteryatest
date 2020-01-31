using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Miterya.DataAccess;
using Miterya.Domain.Common.Enums;
using Miterya.Domain.DBModel;

namespace Miterya.ScreenTest.Builders
{
    public class TermBuilder
    {
        private Term term;

        private IMiteryaDBContext _context;

        public TermBuilder(string name, string nameUs, int year, byte termIndex)
        {
            this.term = new Term();
            this.term.Id = Guid.NewGuid();
            this.term.Name = name;
            this.term.Name_US = nameUs; //db'de hepsi null
            this.term.Year = year;
            this.term.TermIndex = termIndex;

        }


        public Term Build(IMiteryaDBContext _context)
        {
            this._context = _context;
            Term tempTerm = _context.Terms.Where(i => i.IsActive == true).FirstOrDefault();
            if (tempTerm != null)
            {
                tempTerm.IsActive = false;
                this._context.Entry(tempTerm);
            }

            #region basemodel operations
            this.term.DateCreated = DateTime.Now;
            this.term.DateModified = DateTime.Now;
            this.term.IsActive = true;
            this.term.IsDeleted = false;
            #endregion

            #region db actions
            this._context.Terms.Add(this.term);
            this._context.SaveChanges();
            #endregion

            return this.term;
        }


    }
}
