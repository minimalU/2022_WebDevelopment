//FILE          : Listener.cs
//PROJECT       : PROG2001-A06MyOwnWebServer
//PROGRAMMER    : Yujung Park
//FIRST VERSION : 2022.11.24
//DESCRIPTION   : This file has Logger class of my own web server
//                Reference: https://learn.microsoft.com/en-us/dotnet/standard/io/how-to-open-and-append-to-a-log-file

using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace myOwnWebServer
{
    // NAME     :   Logger
    // PURPOSE  :   This Logger class is created to log the message from Server Listener.
    public class Logger
    {
        public string log;
        string logPath = ConfigurationManager.AppSettings["logPath"];


        public void FileWrite(string str)
        {
            log = str;
            using (StreamWriter w = File.AppendText(logPath))
            {
                w.WriteLine(log + '\n');
                w.AutoFlush = true;
                w.Close();
            }
        }

    }
}
