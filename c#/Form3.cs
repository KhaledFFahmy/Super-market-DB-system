using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Market
{
    public partial class Form3 : Form
    {

        SqlConnection connection;

        public Form3()
        {
            InitializeComponent();
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(@"Data Source=DESKTOP-5JC2MA4;Initial Catalog=market_DB; User ID=DESKTOP-5JC2MA4/USER;Integrated Security=SSPI;Persist Security Info=False;");
        }

        private void button8_Click(object sender, EventArgs e)
        {
            String sql = "UPDATE CUSTOMER SET SSN = '" + textBox22.Text + "' , FNAME = '" + textBox5.Text + "' , LNAME = '" + textBox6.Text + "' , Phone = '" + textBox7.Text + "' , HOUSE_NUM = '" + textBox8.Text + "' , ADDRESS = '" + textBox9.Text + "' , USERNAME = '" + textBox1.Text + "' , PASSWORD = '" + textBox2.Text + "' WHERE SSN = '" + textBox22.Text + "'";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.UpdateCommand = command;
            adapter.UpdateCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The User has been updated!");
            Form1 main = new Form1();
            main.Show();
            this.Hide();
        }
    }
}
