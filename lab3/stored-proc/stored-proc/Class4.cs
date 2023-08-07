using Microsoft.SqlServer.Server;
using System;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Net;
using System.Net.Mail;

public partial class StoreProcedure
{
	[Microsoft.SqlServer.Server.SqlProcedure]
	public static void SendEmailOnUpdate (SqlString objectName)
	{
		System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

		using (SqlConnection connection = new SqlConnection("context connection=true"))
		{
				var smtpClient = new SmtpClient("smtp.yandex.com")
				{
					Port = 587,
					Credentials = new NetworkCredential("alrikmo@yandex.by", "ABCDEFG123t"),
					EnableSsl = true,
				};

				smtpClient.Send("alrikmo@yandex.by", "alrikmo@yandex.by", (string)objectName, "Db object changed");

			
			}
		}


}
