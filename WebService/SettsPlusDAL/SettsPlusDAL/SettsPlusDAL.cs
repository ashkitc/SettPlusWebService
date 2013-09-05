using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
namespace SettsPlusDAL
{
    public class  DAL
    {
        public void CheckBlacklist(
            string CompanyCode,
            ref string message,
            ref DateTime LUCheckDate,
            ref DateTime TerminateDate,
            ref DateTime ExpireDate,
            ref int BuildVersion
        )
        {
            using (DataBaseContext context = new DataBaseContext())
            {
                var appExpire = (from obj in context.AppExpiries
                                 where obj.CompanyCode == CompanyCode
                                 select obj).First();

                LUCheckDate = (DateTime)appExpire.LUCheckDate;
                TerminateDate = (DateTime)appExpire.TerminateDate;
                ExpireDate = (DateTime)appExpire.ExpiryDate;
                BuildVersion = (int)appExpire.BuildVersion;
               
                    bool companyFound = false;
                    foreach (BlackList blackList in context.BlackLists)
                    {
                        if (blackList.CompanyCode == CompanyCode)
                        {
                            companyFound = true;
                            message = blackList.ExpireMessage;
                        }
                    }
                 
               
               if (!companyFound)
               {
                        var company = (from obj in context.Companies
                                       where obj.CompanyCode == CompanyCode
                                       select obj).First();
                        message = appExpire.Message;
               }
                   
                
            }
        }

       public void AddCompanyStats(
                string CompanyCode,
                int OpenedThisYear,
                int SettledThisYear,
                int CurrentVersion,
                string[] userlist,
                string[] ipaddresses,
                DateTime[] userLastLoggedOn
            )
        {
            using (DataBaseContext context = new DataBaseContext())
            {

                int currentIndex = 0;
                var company = (from obj in context.Companies
                               where obj.CompanyCode == CompanyCode
                               select obj).First();

                if (company.CompanyDetail != null)
                {
                    company.CompanyDetail.OpenedThisYear = OpenedThisYear;
                    company.CompanyDetail.SettledThisYear = SettledThisYear;
                    company.CompanyDetail.CurrentVersion = CurrentVersion;
                }
                else
                {

                    CompanyDetail newDetail = new CompanyDetail();
                    newDetail.OpenedThisYear = OpenedThisYear;
                    newDetail.SettledThisYear = SettledThisYear;
                    newDetail.CurrentVersion = CurrentVersion;
                    newDetail.Company = company;
                    context.AddToCompanyDetails(newDetail);

                }
                bool canInsertUser = (company.SettUsers.Count() == userlist.Count()
                                        && company.SettUsers.Count() == ipaddresses.Count()
                                        && company.SettUsers.Count() == userLastLoggedOn.Count()
                                      );
                if (canInsertUser)
                {
                    foreach (var current in company.SettUsers)
                    {
                        SettUser newUser = new SettUser();
                        newUser.UserName = userlist[currentIndex];
                        newUser.IPAddress = ipaddresses[currentIndex]; //??? needs change type of field ipaddress
                        newUser.LastLogonDate = userLastLoggedOn[currentIndex];
                        newUser.Company = company;
                        context.AddToSettUsers(newUser);
                        ++currentIndex;
                    }
                }
                else
                {

                    //Handle error here
                }
            }

        }
    }
}
