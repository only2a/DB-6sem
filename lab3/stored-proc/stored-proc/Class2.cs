using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using System.Runtime.InteropServices;
using System.IO;
using System.Net;

namespace stored_proc
{
    [Serializable]
    [StructLayout(LayoutKind.Sequential)]
    [SqlUserDefinedType(Format.UserDefined, IsByteOrdered = true, MaxByteSize = 8000)]
    public class UserCredentials : INullable, IBinarySerialize
    {
        private string _username;
        private string _password;
        private bool _isNull;

        public static UserCredentials Parse(SqlString s)
        {
            if (s.IsNull)
            {
                return Null;
            }

            // Split the input string into its components
            string[] components = s.Value.Split(',');

            UserCredentials userCredentials = new UserCredentials();

            userCredentials.Username = components.Length > 0 ? components[0].Trim() : "";
            userCredentials.Password = components.Length > 0 ? components[1].Trim() : "";

            return userCredentials;
        }

        public UserCredentials(string username, string password)
        {
            _username = username;
            _password = password;
            _isNull = false;
        }

        public UserCredentials()
        {
        }

        public bool IsNull => _isNull;

        public static UserCredentials Null
        {
            get
            {
                UserCredentials u = new UserCredentials();
                u._isNull = true;
                return u;
            }
        }

        

        public string Username
        {
            get => _username;
            set => _username = value;
        }

        public string Password
        {
            get => _password;
            set => _password = value;
        }

        public override string ToString()
        {
            if (IsNull)
                return "NULL";

            return string.Format("Username: {0}, Password: {1}", _username, _password);
        }

        public void Read(BinaryReader reader)
        {
            if (reader == null)
            {
                throw new ArgumentNullException(nameof(reader));
            }

            _username = reader.ReadString();
            _password = reader.ReadString();
            _isNull = false;
        }

        public void Write(BinaryWriter writer)
        {
            if (writer == null)
            {
                throw new ArgumentNullException(nameof(writer));
            }

            writer.Write(_username ?? string.Empty);
            writer.Write(_password ?? string.Empty);
        }
    }
}

