//FILE          : starPage.aspx.cs
//PROJECT       : PROG2001 - A07TextEditor
//PROGRAMMER    : Yujung Park
//FIRST VERSION : 2022.12.08
//DESCRIPTION   : This code behind program provides Page_load and other WebMethod to perform 
//                functionalities of web text editor such as load, save an exist file and save as a new file.



using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using System.Web.Caching;
using System.Web.Script.Serialization;

namespace A07TextEditor
{
    public partial class startPage : System.Web.UI.Page
    {
        static string crrntdirectory = Directory.GetCurrentDirectory().ToString();
        static public string dirPath = crrntdirectory + @"\MyFiles";
        static Dictionary<string, string> fnames = new Dictionary<string, string>();

        public string[] myFiles;
        static public string[] files;
        public string fileName;
        string selectedFile;
        static string saveFileName;
        static string thepath;
        static string newFile;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                myFiles = Directory.GetFiles(dirPath);
                files = myFiles;
                for (int i = 0; i < myFiles.Length; i++)
                {
                    fileName = Path.GetFileName(myFiles[i]);
                    files[i] = fileName;
                }

            }
            selectedFile = selectfile.Value;

        }


        // METHOD            :   GetFiles()
        // DESCRIPTION       :   Get file names of server folder and send the data back as a key pair containing the status and the
        //                       data itself.
        // PARAMETERS        :   none
        // RETURNS           :   string fNameJason
        [WebMethod]
        public static string GetFiles()
        {
            string fNameJson = (new JavaScriptSerializer()).Serialize(files);
            return fNameJson;
        }


        // METHOD            :   GetData()
        // DESCRIPTION       :   Open selected file and read the file contents and then sends the data back as a key pair containing the status and the data itself.
        // PARAMETERS        :   string fileToLoad
        // RETURNS           :   string myJsonString
        [WebMethod]
        public static string GetData(string fileToLoad)
        {
            string filepath;
            fileToLoad = fileToLoad.TrimStart(' ');
            fileToLoad = fileToLoad.TrimEnd(' ');
            saveFileName = fileToLoad;
            
            string myJsonString;
            
            Dictionary<string, string> data;

            filepath = HttpContext.Current.Server.MapPath("MyFiles");
            filepath = filepath + @"\" + fileToLoad;
            thepath = filepath;

            if (File.Exists(filepath))
            {
                data = new Dictionary<string, string>();
                data.Add("Success", File.ReadAllText(filepath));
            }
            else
            {
                data = new Dictionary<string, string>();
                data.Add("Failure", "File does not exist");
            }

            myJsonString = (new JavaScriptSerializer()).Serialize(data);
            return myJsonString;
        }


        // METHOD            :   saveFile()
        // DESCRIPTION       :   Along with the request from client side, save the file with updated contents.
        // PARAMETERS        :   string newText
        // RETURNS           :   string jsonString
        [WebMethod]
        public static string saveFile(string newText)
        {
            string jsonString;

            Dictionary<string, string> dt;

            try
            {
                if (File.Exists(thepath))
                {
                    dt = new Dictionary<string, string>();
                    dt.Add("Success", "File is saved");
                    // if exist, it is overwritten
                    File.WriteAllText(thepath, newText);

                }
                else
                {
                    dt = new Dictionary<string, string>();
                    dt.Add("Failure", "File does not exist");
                }
            }
            catch (Exception e)
            {
                dt = new Dictionary<string, string>();
                dt.Add("Exception", "Something bad happened : " + e.ToString());
            }

            jsonString = (new JavaScriptSerializer()).Serialize(dt);
            return jsonString;
        }


        // METHOD            :   NewFile()
        // DESCRIPTION       :   Update NewFile name variable for Save As function.
        // PARAMETERS        :   string fileToLoad
        // RETURNS           :   string myJsonString
        [WebMethod]
        public static string NewFile(string fileNew)
        {
            string filepath;
            fileNew = fileNew.TrimStart(' ');
            fileNew = fileNew.TrimEnd(' ');
            newFile = fileNew;

            string myJsonString;

            Dictionary<string, string> data;

            filepath = HttpContext.Current.Server.MapPath("MyFiles");
            filepath = filepath + @"\" + fileNew;
            thepath = filepath;

            if (File.Exists(filepath))
            {
                data = new Dictionary<string, string>();
                data.Add("Failure", "File exists");
            }
            else
            {
                data = new Dictionary<string, string>();
                data.Add("Failure", "File does not exist");
            }

            myJsonString = (new JavaScriptSerializer()).Serialize(data);
            return myJsonString;
        }


        // METHOD            :   SaveAs()
        // DESCRIPTION       :   Create file and save with the file name specified by user.
        // PARAMETERS        :   string saveAs
        // RETURNS           :   string jsonStr
        [WebMethod]
        public static string SaveAs(string saveAs)
        {
            string jsonStr;

            Dictionary<string, string> dt;

            try
            {
                if (File.Exists(thepath))
                {
                    dt = new Dictionary<string, string>();
                    dt.Add("Success", "File is saved");
                    // if exist, it is overwritten
                    File.WriteAllText(thepath, saveAs);

                }
                else
                {
                    dt = new Dictionary<string, string>();
                    dt.Add("Failure", "File does not exist");
                }
            }
            catch (Exception e)
            {
                dt = new Dictionary<string, string>();
                dt.Add("Exception", "Something bad happened : " + e.ToString());
            }

            jsonStr = (new JavaScriptSerializer()).Serialize(dt);
            return jsonStr;
        }

    }
}