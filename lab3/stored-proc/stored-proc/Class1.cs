//using System;
//using System.Data.SqlClient;
//using System.Data.SqlTypes;
//using Microsoft.SqlServer.Server;
//using System.IO;

//public partial class StoredProcedures
//{
//    [SqlProcedure]
//    public static void CopyFile(SqlString sourcePath, SqlString destPath)
//    {
//        try
//        {
//            // Ensure source file exists
//            if (!File.Exists(sourcePath.Value))
//            {
//                throw new FileNotFoundException("Source file not found.", sourcePath.Value);
//            }

//            // Create directory if it doesn't exist
//            string destDir = Path.GetDirectoryName(destPath.Value);
//            if (!Directory.Exists(destDir))
//            {
//                Directory.CreateDirectory(destDir);
//            }

//            // Copy file to destination path
//            File.Copy(sourcePath.Value, destPath.Value, true);
//        }
//        catch (Exception ex)
//        {
//            throw new Exception("Error copying file: " + ex.Message);
//        }
//    }
//}

using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [SqlProcedure]
    public static void CopyFileProc(SqlString sourcePath, SqlString destinationPath)
    {
        try
        {
            File.Copy(sourcePath.Value, destinationPath.Value);
            SqlContext.Pipe.Send("File copied successfully.");
        }
        catch (IOException ex)
        {
            SqlContext.Pipe.Send("Error copying file: " + ex.Message);
        }
    }
}


