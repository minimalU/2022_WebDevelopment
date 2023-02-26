//FILE          : Listener.cs
//PROJECT       : PROG2001-A06MyOwnWebServer
//PROGRAMMER    : Yujung Park
//FIRST VERSION : 2022.11.24
//DESCRIPTION   : This file has Listener class of my own web server
//                Reference: https://learn.microsoft.com/en-us/dotnet/api/system.net.sockets.socket.receive?view=net-6.0#system-net-sockets-socket-receive(system-byte()-system-int32-system-net-sockets-socketflags)
//                https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses
//                https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API/Writing_WebSocket_server

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;
using System.Data;
using System.Runtime.InteropServices.ComTypes;
using System.ComponentModel.Design.Serialization;
using System.Runtime.InteropServices;

namespace myOwnWebServer
{
    // NAME     :   Listener
    // PURPOSE  :   This Listener class is created to listens web browser requests and 
    //              receive the request to the server and process the requests and send the response
    public class Listener
    {
        string webRoot; 
        string webIP;
        int webPort;

        string contentFileName;
        string contentFilePath;
        string[] httpRequest;

        string version = "HTTP/1.1";
        string status;
        string[] content_type = { "text", "html", "jpg", "jpeg", "gif" };
        string outgoing_mime;
        string server_name = "A06MyOwnWebServer";
        string date = DateTime.Now.ToString();

        string responseHeader;
        string response;


        Logger logger = new Logger();


        // CONSTRUCTOR
        // DESCRIPTION : constructor of the class Listner and initialize the values
        // PARAMETERS  : root   string      root of web server
        //               ip     string      ip address of web server
        //               port   int         port of web server
        // RETURNS     : none
        public Listener(string root, string ip, int port)
        {
            webRoot = root;
            webIP = ip;
            webPort = port;
        }

        // FUNCTION    : RunListener
        // DESCRIPTION : This function listens client web request and if the client is connected, 
        //               this function starts thread to start web service
        // PARAMETERS  : none
        // RETURNS     : none
        public void RunListener()
        {
            TcpListener server = null;
            IPAddress IP = IPAddress.Parse(webIP);
            server = new TcpListener(IP, webPort);
 
            try
            {
                server.Start();
                logger.FileWrite(date + ": Request : Server started");

                while (true)
                {
                    TcpClient client = server.AcceptTcpClient();
                    logger.FileWrite(date + ": connected");
                    ParameterizedThreadStart ts = new ParameterizedThreadStart(ServerWorker);
                    Thread clientThread = new Thread(ts);
                    clientThread.Start(client);
                }
            }
            catch (Exception e)
            {
                logger.FileWrite(e.ToString());
                return;
            }
            finally
            {
                server.Stop();
            }
        }


        // FUNCTION    : ServerWorker
        // DESCRIPTION : This function handles the request from web client and 
        //               send the appropreate server side responses to the client' web
        // PARAMETERS  : o  Object
        // RETURNS     : none
        public void ServerWorker(Object o)
        {
            TcpClient client = (TcpClient)o;

            Byte[] bytes = new Byte[8192];
            String data = null;

            NetworkStream stream = client.GetStream();
            StreamReader sr = new StreamReader(stream);
            StreamWriter sw = new StreamWriter(stream);
            
            
            int i;
            while ((i = stream.Read(bytes, 0, bytes.Length)) != 0)
            {
                data = System.Text.Encoding.ASCII.GetString(bytes, 0, i);
                logger.FileWrite(date + ": Request :" + data);

                // parse http request ex. [0] = GET [1] = /index.html or / for local [2] = HTTP/1.1
                httpRequest = data.Split(' ', '\r', '\n');

                // only support GET method
                if (httpRequest[0].ToString() != "GET")
                {
                    status = "501 Not Implemented";
                    outgoing_mime = "text/html";
                    response = "<html><body><h1>501 Not Implemented</h1></body></html>";
                 
                    logger.FileWrite(date + ": Response: 501 Not Implemented");
                }


                // get requested contents file name to only support text, HTML, JPG, GIF
                contentFileName = httpRequest[1];
                int index = httpRequest[1].IndexOf('/');
                contentFilePath = httpRequest[1].Insert(index, webRoot);
                contentFilePath = contentFilePath.Replace("/", "\\");
                // if there is no '.', no file - 
                string[] fileExtension = httpRequest[1].Split('.');

                // index out of range exception
                if (fileExtension.Length != 2)
                {
                    // client did enter no file name
                    status = "400 Bad Reuqest";
                    outgoing_mime = "text/html";
                    response = "<html><body><h1>400 Bad Reuqest :/</h1></body></html>";
                    logger.FileWrite(date + ": Response: 400 Bad Reuqest");
                }
                else if (fileExtension[1] == "txt" || fileExtension[1] == "html" || fileExtension[1] == "htm" 
                    || fileExtension[1] == "jpg" || fileExtension[1] == "jpeg" || fileExtension[1] == "gif")
                {
                    // if file exist, open file, read file, send the content
                    // HTTP Status code for exception or error condition
                    if (File.Exists(contentFilePath))
                    {
                        if (fileExtension[1] == "txt" || fileExtension[1] == "html" || fileExtension[1] == "htm")
                        {
                            FileStream fileStream = File.OpenRead(contentFilePath);
                            response = File.ReadAllText(contentFilePath);

                            status = "200 OK";
                            outgoing_mime = "text/html";
                        }
                        // jpg, jpeg, gif
                        if (fileExtension[1] == "jpg" || fileExtension[1] == "jpeg" || fileExtension[1] == "gif")
                        {
                            FileStream imgStream = new FileStream(contentFilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                            BinaryReader br = new BinaryReader(imgStream);
                            int binaryData;
                            while ((binaryData = br.Read(bytes, 0, bytes.Length)) != 0)
                            {
                                response = Encoding.ASCII.GetString(bytes, 0, binaryData);
                            }

                            status = "200 OK";
                            outgoing_mime = "image/jpeg";
                        }                        
                    }
                    else
                    {
                        status = "404 Not Found";
                        outgoing_mime = "text/html";
                        response = "<html><body><h1>404 Not Found :(</h1></body></html>";
                        logger.FileWrite(date + ": Response: 404 Not Found");
                    }
                }
                else
                {
                    status = "415 Unsupported Media Type";
                    outgoing_mime = "text/html";
                    response = "<html><body><h1>415 Unsupported Media Type/</h1></body></html>";
                    logger.FileWrite(date + ": 415 Unsupported Media Type");
                }

                // response header
                responseHeader = version + " " + status + "\r\n" +
                    "Content-Type: " + outgoing_mime + "\r\n" +
                    "Date: " + date + "\r\n" +
                    "Content-length: " + response.Length + "\r\n" +
                    "Server: " + server_name + "\r\n";

                // content = responseHeader + response;
                sw.WriteLine(responseHeader);
                sw.Write(response);

                logger.FileWrite(date + ": Response :" + responseHeader);

                byte[] headerBuffer = System.Text.Encoding.ASCII.GetBytes(responseHeader);
                byte[] responseBuffer = System.Text.Encoding.ASCII.GetBytes(response);
                stream.Write(headerBuffer, 0, headerBuffer.Length);
                stream.Write(responseBuffer, 0, responseBuffer.Length);
                sw.Flush();
            }
        }
    }
}
