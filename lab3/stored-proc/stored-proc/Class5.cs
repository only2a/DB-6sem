using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace stored_proc
{
	using System.Data.SqlTypes;
	using System.IO;
	using Microsoft.SqlServer.Server;

	[Serializable]
	[SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
	public class Structure : INullable, IBinarySerialize
	{
		private bool _isNull;

		private int _size;
		private string _location;

		public static Structure Parse (SqlString s)
		{
			if (s.IsNull)
			{
				return Null;
			}

			// Split the input string into its components
			string[] components = s.Value.Split(',');

			// Create a new Address object
			Structure structure = new Structure();

			// Set the properties of the Address object
			structure.Size = Convert.ToInt32(components.Length > 0 ? components[0].Trim() : "");
			structure.Location = components.Length > 1 ? components[1].Trim() : "";


			return structure;
		}

		public override string ToString ()
		{
			if (this._isNull)
			{
				return "NULL";
			}

			// Create a string representation of the Address object
			StringBuilder sb = new StringBuilder();
			sb.Append(this.Size);
			sb.Append(", ");
			sb.Append(this.Location);
			sb.Append(", ");

			return sb.ToString();
		}


		public bool IsNull
		{
			get { return _isNull; }
		}

		public static Structure Null
		{
			get
			{
				Structure structure = new Structure();
				structure._isNull = true;
				return structure;
			}
		}

		public int Size
		{
			get => _size;
			set => _size = value;
		}

		public string Location
		{
			get => _location;
			set => _location = value;
		}

		public void Read (BinaryReader r)
		{
			Size = r.ReadInt32();
			Location = r.ReadString();
		}

		public void Write (BinaryWriter w)
		{
			w.Write(Size);
			w.Write(Location);
		}
	}

}
