//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LAB_02
{
    using System;
    using System.Collections.Generic;
    
    public partial class Friendships
    {
        public int id { get; set; }
        public Nullable<int> UserId1 { get; set; }
        public Nullable<int> UserId2 { get; set; }
        public Nullable<System.DateTime> frendship_date { get; set; }
    
        public virtual Users Users { get; set; }
        public virtual Users Users1 { get; set; }
    }
}
