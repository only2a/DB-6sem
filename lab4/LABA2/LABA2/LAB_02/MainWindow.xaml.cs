using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Collections.ObjectModel;
using System.Data.Entity.Migrations;
using System.Data.Entity.Spatial;
using System.Data.Entity;
using System.Runtime.Remoting.Contexts;

namespace LAB_02
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            



        }



		//private void addAuthor_Click(object sender, RoutedEventArgs e)
		//{
		//    var author = new Author(
		//        )
		//    {

		//        Name = textBoxIdName.Text,
		//        Date_of_birth = (DateTime)DateOfBirthId.SelectedDate,
		//        Bio = textBoxBIOID.Text,
		//        Nationality = textBoxNationality.Text

		//    };

		//    using (var context = new PublishingHouseEntities())
		//    {

		//        context.Authors.Add(author);
		//        context.SaveChanges();

		//    }


		//}

		//private void allAuthors_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        AuthorsGrid.ItemsSource = context.Authors.ToList();

		//    }
		//}

		//private void dropAuthor_Click(object sender, RoutedEventArgs e)
		//{
		//    var author = new Author(
		//       )
		//    {
		//        Author_ID= Int32.Parse(textBoxID.Text),


		//    };

		//    using (var context = new PublishingHouseEntities())
		//    {
		//        context.Authors.Remove(context.Authors.Where(p => (p.Author_ID == author.Author_ID)).Single());
		//        context.SaveChanges();

		//    }

		//}

		//private void changeAuthor_Click(object sender, RoutedEventArgs e)
		//{
		//    var author = new Author(
		//       )
		//    {
		//        Author_ID = Int32.Parse(textBoxID.Text),
		//        Name = textBoxIdName.Text,
		//        Date_of_birth = (DateTime)DateOfBirthId.SelectedDate,
		//        Bio = textBoxBIOID.Text,
		//        Nationality = textBoxNationality.Text

		//    };

		//    using (var context = new PublishingHouseEntities())
		//    {
		//        context.Authors.AddOrUpdate(author);
		//        context.SaveChanges();

		//    }
		//}

		//private void addSale_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        if (DateOfSaleId.SelectedDate != null)
		//        {
		//            var sale = new Sale
		//            {
		//                ISBN = textBoxSaleISBN.Text,
		//                Sales_date = (DateTime)DateOfSaleId.SelectedDate,
		//                Copies_sold = Int32.Parse(textBoxSalesCopiesSold.Text),
		//                Revenue = Int32.Parse(textBoxRevenue.Text)
		//            };
		//            context.Sales.Add(sale);
		//        }

		//        context.SaveChanges();

		//    }
		//}

		//private void dropSale_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        if (DateOfSaleId.SelectedDate != null)
		//        {
		//            var sale = new Sale
		//            {
		//                Sales_ID = Int32.Parse(textBoxSaleID.Text),

		//            };
		//            context.Sales.Remove(context.Sales.Where(p => (p.ISBN == sale.ISBN) && (p.Sales_date == sale.Sales_date)).Single());
		//        }

		//        context.SaveChanges();

		//    }
		//}

		//private void changeSale_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        if (DateOfSaleId.SelectedDate != null)
		//        {
		//            var sale = new Sale
		//            {
		//                Sales_ID = Int32.Parse(textBoxSaleID.Text),
		//                ISBN = textBoxSaleISBN.Text,
		//                Sales_date = (DateTime)DateOfSaleId.SelectedDate,
		//                Copies_sold = Int32.Parse(textBoxSalesCopiesSold.Text),
		//                Revenue = Int32.Parse(textBoxRevenue.Text)
		//            };
		//            context.Sales.AddOrUpdate(sale);
		//        }

		//        context.SaveChanges();

		//    }
		//}

		//private void allSales_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        SalesGrid.ItemsSource = context.Sales.ToList();

		//    }

		//}


		//private void addInventory_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {

		//        {
		//            var inventory = new Inventory()
		//            {
		//                ISBN = textBoxISBN.Text,
		//                Copies_in_stock = Int32.Parse(textBoxCopiesInStock.Text),
		//                Location = textBoxLocation.Text
		//            };
		//            context.Inventories.Add(inventory);
		//            context.SaveChanges();
		//        }
		//    }
		//}

		//private void dropInventory_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {

		//        {
		//            var inventory = new Inventory()
		//            {
		//                Inventory_ID = Int32.Parse(inventoryId.Text),


		//            };
		//            context.Inventories.Remove(context.Inventories.Where(p => (p.Inventory_ID == inventory.Inventory_ID)).Single());
		//            context.SaveChanges();
		//        }
		//    }
		//}

		//private void changeInventory_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {

		//        {
		//            var inventory = new Inventory()
		//            {
		//                Inventory_ID = Int32.Parse(inventoryId.Text),
		//                ISBN = textBoxISBN.Text,
		//                Copies_in_stock = Int32.Parse(textBoxCopiesInStock.Text),
		//                Location = textBoxLocation.Text
		//            };
		//            context.Inventories.AddOrUpdate(inventory);
		//            context.SaveChanges();
		//        }
		//    }
		//}

		//private void allInventory_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        InventoryGrid.ItemsSource = context.Inventories.ToList();

		//    }
		//}

		//private void Button_Click(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {

		//        var firstDate = (DateTime)FirstDate.SelectedDate;
		//        var secondDate = (DateTime)SecondDate.SelectedDate;

		//        SalesGrid.ItemsSource = context.Sales.Where(x=>x.Sales_date > firstDate && x.Sales_date < secondDate).ToList();

		//    }
		//}

		//private void Button_Click_1(object sender, RoutedEventArgs e)
		//{

		//    using (var context = new PublishingHouseEntities())
		//    {
		//        // Load the SQL Server spatial native assemblies
		//        SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

		//        // Parse the IDs of the two publishers you want to compare
		//        var publisherId1 = int.Parse(X.Text);
		//        var publisherId2 = int.Parse(Y.Text);

		//        // Retrieve the spatial coordinates of the two publishers
		//        var publisher1 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId1)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        var publisher2 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId2)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        // Find the intersection point of the two publishers
		//        var intersection = publisher1.Intersection(publisher2);

		//        // Set the result text to the intersection point, or "No intersection" if there is none
		//        RESULT.Text = intersection != null ? intersection.ToString() : "No intersection";
		//    }

		//}

		//private void Button_Click_2(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        // Load the SQL Server spatial native assemblies
		//        SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

		//        // Parse the IDs of the two publishers you want to compare
		//        var publisherId1 = int.Parse(X.Text);
		//        var publisherId2 = int.Parse(Y.Text);

		//        // Retrieve the spatial coordinates of the two publishers
		//        var publisher1 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId1)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        var publisher2 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId2)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        // Find the intersection point of the two publishers
		//        var intersection = publisher1.Union(publisher2);

		//        // Set the result text to the intersection point, or "No intersection" if there is none
		//        RESULT.Text = intersection != null ? intersection.ToString() : "No intersection";
		//    }

		//}

		//private void Button_Click_3(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        // Load the SQL Server spatial native assemblies
		//        SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

		//        // Parse the IDs of the two publishers you want to compare
		//        var publisherId1 = int.Parse(X.Text);
		//        var publisherId2 = int.Parse(Y.Text);

		//        // Retrieve the spatial coordinates of the two publishers
		//        var publisher1 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId1)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        var publisher2 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId2)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        // Find the intersection point of the two publishers
		//        var intersection = publisher1.Difference(publisher2);

		//        // Set the result text to the intersection point, or "No intersection" if there is none
		//        RESULT.Text = intersection != null ? intersection.ToString() : "No intersection";
		//    }

		//}

		//private void Button_Click_4(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        // Load the SQL Server spatial native assemblies
		//        SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

		//        // Parse the IDs of the two publishers you want to compare
		//        var publisherId1 = int.Parse(X.Text);
		//        var publisherId2 = int.Parse(Y.Text);

		//        // Retrieve the spatial coordinates of the two publishers
		//        var publisher1 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId1)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        var publisher2 = context.Publishers
		//            .Where(p => p.Publisher_ID == publisherId2)
		//            .Select(p => p.Address)
		//            .FirstOrDefault();

		//        // Find the intersection point of the two publishers
		//        var intersection = publisher1.Distance(publisher2);

		//        // Set the result text to the intersection point, or "No intersection" if there is none
		//        RESULT.Text = intersection != null ? intersection.ToString() : "No intersection";
		//    }

		//}

		//private void Button_Click_5(object sender, RoutedEventArgs e)
		//{
		//    using (var context = new PublishingHouseEntities())
		//    {
		//        // Load the SQL Server spatial native assemblies
		//        SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

		//       SampleGrid.ItemsSource = context.Publishers.ToList();


		//    }
		//}

		
		private void addClient_Click (object sender, RoutedEventArgs e)
		{
			//string fName = textBoxFirstName.Text;
			//string lName = textBoxLastName.Text;
			//string email = textBoxEmail.Text;

			//string result = DataWorker.addUser(fName, lName, email);
			//if (result == "Сделано!")
			//{
			//	textBoxFirstName.Text = "";
			//	textBoxLastName.Text = "";
			//	textBoxEmail.Text = "";

			//}
		}



		private void changeClient_Click (object sender, RoutedEventArgs e)
		{
			//string result = "";
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	//check user is exist
			//	string fName = textBoxFirstName.Text;
			//	string lName = textBoxLastName.Text;
			//	string email = textBoxEmail.Text;

			//	User2 user = db.Users.FirstOrDefault(p => p.email == email);
			//	if (user != null)
			//	{
			//		user.first_name = fName;
			//		user.last_name = lName;
			//		db.SaveChanges();
			//		result = "Сделано!";
			//	}
			//}
			//if (result == "Сделано!")
			//{
			//	textBoxFirstName.Text = "";
			//	textBoxLastName.Text = "";
			//	textBoxEmail.Text = "";

			//}

		}

		private void allClients_Click (object sender, RoutedEventArgs e)
		{
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	var result = db.Users.ToList();
			//	myGrid.ItemsSource = null;
			//	myGrid.Items.Clear();
			//	myGrid.ItemsSource = result;
			//	myGrid.Items.Refresh();
			//}
		}
		private void delClients_Click (object sender, RoutedEventArgs e)
		{
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	string email = textBoxEmail.Text;
			//	User2 user = db.Users.FirstOrDefault(p => p.email == email);
			//	db.Users.Remove(user);
			//	db.SaveChanges();
			//}
		}
	

		
		private void postsByUser_Click (object sender, RoutedEventArgs e)
		{
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	string email = textBoxEmail.Text;
			//	User2 user = db.Users.FirstOrDefault(p => p.email == email);
			//	List<Post> res = db.Post.Where(x => x.userid == user.id).ToList();
			//	myGrid.ItemsSource = null;
			//	myGrid.Items.Clear();
			//	myGrid.ItemsSource = res;
			//	myGrid.Items.Refresh();
			//}
		}
		private void friends_CLick (object sender, RoutedEventArgs e)
		{
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	string email = textBoxEmail.Text;
			//	User2 user = db.Users.FirstOrDefault(p => p.email == email);
			//	List<Friendship> res = db.Friendships.Where(x => x.UserId1 == user.id || x.UserId2 == user.id).ToList();
			//	List<User2> result = new List<User2>();
			//	foreach (var el in res)
			//	{
			//		foreach (var elem in db.Users.ToList())
			//		{
			//			if (el.UserId1 != user.id)
			//			{
			//				User2 friend = db.Users.FirstOrDefault(p => p.id == el.UserId1);
			//				result.Add(friend);
			//			}
			//			if (el.UserId2 != user.id)
			//			{
			//				User2 friend = db.Users.FirstOrDefault(p => p.id == el.UserId2);
			//				result.Add(friend);
			//			}
			//		}
			//	}
			//	myGrid.ItemsSource = null;
			//	myGrid.Items.Clear();
			//	myGrid.ItemsSource = result.Distinct();
			//	myGrid.Items.Refresh();
			//}
		}
		private void commentsByUser_Click (object sender, RoutedEventArgs e)
		{
			//using (SocialNetworkEntities db = new SocialNetworkEntities())
			//{
			//	List<Comment> res = new List<Comment>();
			//	string email = textBoxEmail.Text;
			//	string postId = postIdTb.Text;
			//	if (email != "")
			//	{
			//		User2 user = db.Users.FirstOrDefault(p => p.email == email);
			//		res = db.Comment.Where(x => x.UserId == user.id).ToList();
			//	}
			//	else if (postId != "")
			//	{
			//		Post post = db.Post.FirstOrDefault(p => p.id == Convert.ToInt32(postId));
			//		res = db.Comment.Where(x => x.PostId == post.id).ToList();
			//	}

			//	myGrid.ItemsSource = null;
			//	myGrid.Items.Clear();
			//	myGrid.ItemsSource = res;
			//	myGrid.Items.Refresh();
			//}
		}
		private void messagesByUser_Click (object sender, RoutedEventArgs e)
		{
			using (SocialNetworkEntities db = new SocialNetworkEntities())
			{
				string userId1 = userId1Tb.Text;
				string userId2 = userId2Tb.Text;
		                         //		//var res = db.Messages
		                         //		//    .Include(m => ((User2)m.User1))
		                         //		//    .Include(m => ((User2)m.User2))
		                         //		//        .Where(m => (m.SenderId == Convert.ToInt32(userId1) && m.ReceiverId == Convert.ToInt32(userId2)) ||
		                         //		//                    (m.SenderId == Convert.ToInt32(userId2) && m.ReceiverId == Convert.ToInt32(userId1)))
		                         //		//        .OrderBy(m => m.message_date).ToList();
		                         
		                         //		var res = db.Messages
		                         //.Join(db.Users,
		                         //	m => m.SenderId,
		                         //	s => s.id,
		                         //	(m, s) => new { Message = m, Sender = s })
		                         //.Join(db.Users,
		                         //	ms => ms.Message.ReceiverId,
		                         //	r => r.id,
		                         //	(ms, r) => new { ms.Message, ms.Sender, Receiver = r })
		                         //.Where(m => ( m.Message.SenderId == Convert.ToInt32(userId1) && m.Message.ReceiverId == Convert.ToInt32(userId2) ) ||
		                         //	( m.Message.SenderId == Convert.ToInt32(userId2) && m.Message.ReceiverId == Convert.ToInt32(userId1) ))
		                         //.OrderBy(m => m.Message.message_date)
		                         //.Select(m => new Message
		                         //{
		                         //	Id = m.Message.Id,
		                         //	SenderId = m.Message.SenderId,
		                         //	ReceiverId = m.Message.ReceiverId,
		                         //	message_text = m.Message.message_text,
		                         //	message_date = m.Message.message_date,
		                         //	User1 = new User2 { email = m.Sender.email },
		                         //	User2 = new User2 { email = m.Receiver.email }
		                         //})
		                         //.ToList();
		                         
		                         
		                         //		myGrid.ItemsSource = null;
		                         //		myGrid.Items.Clear();
		                         //		myGrid.ItemsSource = res;
		                         //		myGrid.Items.Refresh();
		                         	}
		}
		private void posts_Click (object sender, RoutedEventArgs e)
		{
			using (SocialNetworkEntities db = new SocialNetworkEntities())
			{
				List<Post> res = db.Post.ToList();
				myGrid.ItemsSource = null;
				myGrid.Items.Clear();
				myGrid.ItemsSource = res;
				myGrid.Items.Refresh();
			}
		}

		public void distance_Click (object sender, RoutedEventArgs e)
		{
			using (var db = new SocialNetworkEntities())
			{

				SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

				int userId1 = Int32.Parse(user1.Text);
				int userId2 = Int32.Parse(user2.Text);

			   var user1Location = db.UserLocation
				   .Where(l => l.user_id == userId1)
				   .Select(l => l.location)
				   .FirstOrDefault();

				var user2Location = db.UserLocation
					.Where(l => l.user_id == userId2)
					.Select(l => l.location)
					.FirstOrDefault();

				//// Calculate the distance between the two locations in kilometers
				spatialTextBox.Text = (user1Location.Distance(user2Location) / 1000.0).ToString();
			}


		}

		public void intersaction_Click (object sender, RoutedEventArgs e)
		{
			using (var db = new SocialNetworkEntities())
			{

				SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

				int userId1 = Int32.Parse(user1.Text);
				int userId2 = Int32.Parse(user2.Text);

				var user1Location = db.UserLocation
					.Where(l => l.user_id == userId1)
					.Select(l => l.location)
					.FirstOrDefault();

				var user2Location = db.UserLocation
					.Where(l => l.user_id == userId2)
					.Select(l => l.location)
					.FirstOrDefault();

				//// Calculate the distance between the two locations in kilometers
				spatialTextBox.Text = ( user1Location.Intersection(user2Location) ).ToString();
			}
		}

		public void difference_Click (object sender, RoutedEventArgs e)
		{
			using (var db = new SocialNetworkEntities())
			{

				SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

				int userId1 = Int32.Parse(user1.Text);
				int userId2 = Int32.Parse(user2.Text);

				var user1Location = db.UserLocation
					.Where(l => l.user_id == userId1)
					.Select(l => l.location)
					.FirstOrDefault();

				var user2Location = db.UserLocation
					.Where(l => l.user_id == userId2)
					.Select(l => l.location)
					.FirstOrDefault();

				//// Calculate the distance between the two locations in kilometers
				spatialTextBox.Text = ( user1Location.Union(user2Location) ).ToString();
			}
		}
		
		public void ul_Click (object sender, RoutedEventArgs e)
		{
			using (var db = new SocialNetworkEntities())
			{

				List<UserLocation> res = db.UserLocation.ToList();
				spatialGrid.ItemsSource = null;
				spatialGrid.Items.Clear();
				spatialGrid.ItemsSource = res;
				spatialGrid.Items.Refresh();
			}
		}
	}
}
