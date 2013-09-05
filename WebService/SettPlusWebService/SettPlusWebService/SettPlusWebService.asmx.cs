using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SettsPlusDAL;
namespace SettPlusWebService
{
    /// <summary>
    /// Сводное описание для Service1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку.
    // [System.Web.Script.Services.ScriptService]
    public class Service1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string CheckBlacklist(string CompanyCode,  string message, DateTime LUCheckDate, DateTime
        TerminateDate, DateTime ExpireDate, int BuildVersion)
        {
            DAL layer = new DAL();
            layer.CheckBlacklist(
                CompanyCode, 
                ref message, 
                ref LUCheckDate, 
                ref TerminateDate,
                ref ExpireDate,
                ref BuildVersion
                );
            //message = "Ololo";
            return message;
        }

        [WebMethod]
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
            DAL layer = new DAL();

            layer.AddCompanyStats(
                CompanyCode, 
                OpenedThisYear,
                SettledThisYear,
                CurrentVersion,
                userlist, 
                ipaddresses,
                userLastLoggedOn
            );
        }
    }
}