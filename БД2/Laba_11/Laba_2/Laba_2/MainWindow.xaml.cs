using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Migrations;
using System.Data.SqlClient;
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
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Windows.Controls.Primitives;

namespace Laba_2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        public MainWindow()
        {
            InitializeComponent();
            Students.ItemsSource = UniversityEntities.GetContext().STUDENT.ToList();
            Faculties.ItemsSource = UniversityEntities.GetContext().FACULTY.ToList();
            Pulpits.ItemsSource = UniversityEntities.GetContext().PULPIT.ToList();
            allAuditoriumSelect();
            allAuditoriumTypesSelect();
        }

        private void CreateStudent_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (STUDENT.Text == string.Empty ||
                    STUDENT_NAME.Text == string.Empty ||
                    FACULTY.Text == string.Empty ||
                    PHONE_NUMBER.Text == string.Empty ||
                    STUDENT.Text == null ||
                    STUDENT_NAME.Text == null ||
                    FACULTY.Text == null ||
                    PHONE_NUMBER.Text == null)
                {
                    throw new Exception("пустые значения");
                }

                STUDENT newStudent = new STUDENT();
                newStudent.STUDENT1 = STUDENT.Text;
                newStudent.STUDENT_NAME = STUDENT_NAME.Text;
                newStudent.FACULTY = FACULTY.Text;
                newStudent.PHONE_NUMBER = PHONE_NUMBER.Text;
                UniversityEntities.GetContext().STUDENT.Add(newStudent);
                UniversityEntities.GetContext().SaveChanges();
                Students.ItemsSource = UniversityEntities.GetContext().STUDENT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void UpdateStudent_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().STUDENT.AddOrUpdate((STUDENT)Students.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Students.ItemsSource = UniversityEntities.GetContext().STUDENT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void DeleteStudent_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().STUDENT.Remove((STUDENT)Students.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Students.ItemsSource = UniversityEntities.GetContext().STUDENT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void CreateFaculty_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (FACULTY1.Text == string.Empty ||
                    FACULTY_NAME.Text == string.Empty ||
                    FACULTY1.Text == null ||
                    FACULTY_NAME.Text == null)
                {
                    throw new Exception("пустые значения");
                }

                FACULTY newFaculty = new FACULTY();
                newFaculty.FACULTY1 = FACULTY1.Text;
                newFaculty.FACULTY_NAME = FACULTY_NAME.Text;
                UniversityEntities.GetContext().FACULTY.Add(newFaculty);
                UniversityEntities.GetContext().SaveChanges();
                Faculties.ItemsSource = UniversityEntities.GetContext().FACULTY.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void UpdateFaculty_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().FACULTY.AddOrUpdate((FACULTY)Faculties.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Faculties.ItemsSource = UniversityEntities.GetContext().FACULTY.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void DeleteFaculty_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().FACULTY.Remove((FACULTY)Faculties.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Faculties.ItemsSource = UniversityEntities.GetContext().FACULTY.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void CreatePulpit_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (PULPIT.Text == string.Empty ||
                    PULPIT_NAME.Text == string.Empty ||
                    FACULTY2.Text == string.Empty ||
                    PULPIT.Text == null ||
                    PULPIT_NAME.Text == null ||
                    FACULTY2.Text == null)
                {
                    throw new Exception("пустые значения");
                }

                PULPIT newPulpit = new PULPIT();
                newPulpit.PULPIT1 = PULPIT.Text;
                newPulpit.PULPIT_NAME = PULPIT_NAME.Text;
                newPulpit.FACULTY = FACULTY2.Text;
                UniversityEntities.GetContext().PULPIT.Add(newPulpit);
                UniversityEntities.GetContext().SaveChanges();
                Pulpits.ItemsSource = UniversityEntities.GetContext().PULPIT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void UpdatePulpit_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().PULPIT.AddOrUpdate((PULPIT)Pulpits.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Pulpits.ItemsSource = UniversityEntities.GetContext().PULPIT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void DeletePulpit_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                UniversityEntities.GetContext().PULPIT.Remove((PULPIT)Pulpits.SelectedItem);
                UniversityEntities.GetContext().SaveChanges();
                Pulpits.ItemsSource = UniversityEntities.GetContext().PULPIT.ToList();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void Select_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (
                    FACULTY3.Text == string.Empty ||
                    FACULTY3.Text == null)
                {
                    throw new Exception("пустые значения");
                }

                SqlConnection connection = new SqlConnection("data source=DESKTOP-8T2LUTM;Initial Catalog=University;Integrated Security=true;");
                connection.Open();
                SqlCommand command = new SqlCommand("avgMarkFacultyStudents", connection);
                command.Parameters.Add(new SqlParameter("@faculty", FACULTY3.Text));
                command.CommandType = System.Data.CommandType.StoredProcedure;
                StudentsMarks.ItemsSource = command.ExecuteReader();
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        private void Inter_Click(object sender, RoutedEventArgs e)
        {

            try
            {
                using (var context = new UniversityEntities())
                {
                    // Load the SQL Server spatial native assemblies
                    SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

                    // Retrieve the spatial coordinates of the two publishers
                    var publisher1 = context.STUDENT
                        .Where(p => p.STUDENT1 == CoordX.Text)
                        .Select(p => p.HOME_ADDRESS)
                        .FirstOrDefault();

                    var publisher2 = context.STUDENT
                        .Where(p => p.STUDENT1 == CoordY.Text)
                        .Select(p => p.HOME_ADDRESS)
                        .FirstOrDefault();

                    // Find the intersection point of the two publishers
                    var intersection = publisher1.Union(publisher2);

                    // Set the result text to the intersection point, or "No intersection" if there is none
                    CoordXText.Text = intersection != null ? intersection.ToString() : "No intersection";
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }

        }

        private void Distance_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (var context = new UniversityEntities())
                {
                    // Load the SQL Server spatial native assemblies
                    SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);

                    // Retrieve the spatial coordinates of the two publishers
                    var publisher1 = context.STUDENT
                        .Where(p => p.STUDENT1 == CoordX.Text)
                        .Select(p => p.HOME_ADDRESS)
                        .FirstOrDefault();

                    var publisher2 = context.STUDENT
                        .Where(p => p.STUDENT1 == CoordY.Text)
                        .Select(p => p.HOME_ADDRESS)
                        .FirstOrDefault();

                    // Find the intersection point of the two publishers
                    var intersection = publisher1.Distance(publisher2);

                    // Set the result text to the intersection point, or "No intersection" if there is none
                    CoordXText.Text = intersection != null ? intersection.ToString() : "No intersection";
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Проверьте данные");
            }
        }

        static string connStr = @"Data Source=F:\__3 курс 1 сем\БД2\Laba_11\University.db;foreign keys=true;";

        private void allAuditoriumSelect()
        {
            string sql = $"SELECT * FROM AUDITORIUM";
            SQLiteDataAdapter ad;
            DataTable dt = new DataTable();
            SQLiteConnection connection = null;

            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;  //set the passed query
                ad = new SQLiteDataAdapter(cmd);
                ad.Fill(dt); //fill the datasource

                Auditoriums.ItemsSource = dt.DefaultView;
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }
        }

        private void addAuditorium_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"insert into AUDITORIUM (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)" +
                $" values ('{AUDITORIUM.Text}', '{AUDITORIUM_NAME.Text}', " +
                $"'{AUDITORIUM_TYPE.Text}', {AUDITORIUM_CAPACITY.Text});";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumSelect();
            }
        }

        private void updateAuditorium_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"UPDATE AUDITORIUM SET AUDITORIUM_NAME = {AUDITORIUM_NAME.Text}, " +
                $"AUDITORIUM_TYPE = '{AUDITORIUM_TYPE.Text}', " +
                $"AUDITORIUM_CAPACITY = {AUDITORIUM_CAPACITY.Text} " +
                $"WHERE AUDITORIUM.AUDITORIUM = '{AUDITORIUM.Text}';";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumSelect();
            }
        }

        private void deleteAuditorium_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"DELETE FROM AUDITORIUM " +
                $"WHERE AUDITORIUM.AUDITORIUM = '{AUDITORIUM.Text}';";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumSelect();
            }
        }

        private void allAuditoriumTypesSelect()
        {
            string sql = $"SELECT * FROM AUDITORIUM_TYPE";
            SQLiteDataAdapter ad;
            DataTable dt = new DataTable();
            SQLiteConnection connection = null;

            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;  //set the passed query
                ad = new SQLiteDataAdapter(cmd);
                ad.Fill(dt); //fill the datasource

                AuditoriumTypes.ItemsSource = dt.DefaultView;
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }
        }

        private void addAuditoriumType_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values" +
                        $" ('{AUDITORIUM_TYPE_.Text}', '{AUDITORIUM_TYPENAME.Text}');";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;  
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumTypesSelect();
            }
        }

        private void updateAuditoriumType_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"UPDATE AUDITORIUM_TYPE SET AUDITORIUM_TYPENAME = '{AUDITORIUM_TYPENAME.Text}' " +
                $"WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE = '{AUDITORIUM_TYPE_.Text}';";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumTypesSelect();
            }
        }

        private void deleteAuditoriumType_Click(object sender, RoutedEventArgs e)
        {
            string sql = $"DELETE FROM AUDITORIUM_TYPE " +
                $"WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPE = '{AUDITORIUM_TYPE_.Text}';";
            SQLiteConnection connection = null;
            try
            {
                connection = new SQLiteConnection(connStr);
                SQLiteCommand cmd;
                connection.Open();  //Initiate connection to the db
                cmd = connection.CreateCommand();
                cmd.CommandText = sql;
                cmd.ExecuteScalar();
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }

                allAuditoriumTypesSelect();
            }
        }

    }
}
