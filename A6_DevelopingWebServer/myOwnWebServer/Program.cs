using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace myOwnWebServer
{
    internal class Program
    {
        // command line arguments: -webRoot, -webIP, -webPort
        // ex. myOwnWebServer –webRoot=C:\localWebSite –webIP=192.168.100.23 –webPort=5300
        static void Main(string[] args)
        {
            if (args.Length == 3)
            {
                //!!!!! Required: input validation for ip, root, port
                string[] serverRoot = args[0].Split('=');
                string[] serverIp = args[1].Split('=');
                string[] serverPort = args[2].Split('=');
                string rt = serverRoot[1].ToString();
                string ip = serverIp[1].ToString();
                Int32 port = Int32.Parse(serverPort[1]);

                Listener mowsListener = new Listener(rt, ip, port);
                mowsListener.RunListener();
            }
            else
            {
                Console.WriteLine("Syntex error: myOwnWebServer <-webRoot=> <-webIP=> <-webPort=>");
            }

        }
    }
}
