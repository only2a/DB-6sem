using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.IO;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]


public struct SqlUserDefinedType1 : INullable, IBinarySerialize
{
	String name;
	String description;
	DateTime deadline;
	//DateTime dead;
	String Overdue;
	String executor;




	public override string ToString ()
	{
		return $"Task: {name}";

	}

	public bool IsNull
	{
		get
		{
			return _null;
		}
	}

	public static SqlUserDefinedType1 Null
	{
		get
		{
			SqlUserDefinedType1 h = new SqlUserDefinedType1();
			h._null = true;
			return h;
		}
	}

	public static SqlUserDefinedType1 Parse (SqlString s)
	{
		string[] b = s.Value.Split(' ');
		if (s.IsNull)
			return Null;

		if (Convert.ToDateTime(b[2]) > DateTime.Today)
		{
			SqlUserDefinedType1 u = new SqlUserDefinedType1
			{

				name = b[0],
				description = b[1],
				deadline = Convert.ToDateTime(b[2]),
				executor = b[3],
				Overdue = "NOT EXPIRED"
			};
			return u;
		}
		else
		{
			SqlUserDefinedType1 u = new SqlUserDefinedType1
			{

				name = b[0],
				description = b[1],
				deadline = Convert.ToDateTime(b[2]),
				executor = b[3],
				Overdue = "OVERDUE"
			};
			return u;
		}

	}

	public string Method1 ()
	{
		return string.Empty;
	}

	public static SqlString Method2 ()
	{
		return new SqlString("");
	}

	public void Read (BinaryReader r)
	{
		name = r.ReadString();
	}

	public void Write (BinaryWriter w)
	{
		w.Write($"Task: {name}, description: {description}, deadline: {deadline},executor: {executor}, overdue: {Overdue}");
	}

	public int _var1;

	private bool _null;
}