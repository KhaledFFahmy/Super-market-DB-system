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
    public partial class Form1 : Form
    {

        SqlConnection connection;

        public Form1()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(@"Data Source=DESKTOP-5JC2MA4;Initial Catalog=market_DB; User ID=DESKTOP-5JC2MA4/USER;Integrated Security=SSPI;Persist Security Info=False;");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            String sql = "INSERT INTO PRODUCT (PID, CART_ID, NAME, PRICE, QUANTITY) VALUES('" + textBox4.Text + "' , '" + textBox3.Text + "' , '" + textBox10.Text + "' , '" + textBox12.Text + "' , '" + textBox11.Text + "')";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.InsertCommand = command;
            adapter.InsertCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The Product has been added!");
        }

        private void button6_Click(object sender, EventArgs e)
        {
            String sql = "SELECT * FROM PRODUCT WHERE QUANTITY != 0";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            command.ExecuteNonQuery();
            this.pRODUCTTableAdapter.Fill(this.market_DBDataSet.PRODUCT);
            connection.Close();
        }

        private void button6_Click_1(object sender, EventArgs e)
        {
            String sql = "SELECT * FROM PRODUCT WHERE QUANTITY = 0";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            command.ExecuteNonQuery();
            this.pRODUCTTableAdapter.Fill(this.market_DBDataSet.PRODUCT);
            connection.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            String sql = "INSERT INTO CUSTOMER (SSN, FNAME, LNAME, PHONE, HOUSE_NUM, ADDRESS, USERNAME, PASSWORD) VALUES('" + textBox22.Text + "' , '" + textBox5.Text + "' , '" + textBox6.Text + "' , '" + textBox7.Text + "' , '" + textBox8.Text + "' , '" + textBox9.Text + "' , '" + textBox1.Text + "' , '" + textBox2.Text + "')";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.InsertCommand = command;
            adapter.InsertCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The User has been added!");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form2 Search = new Form2();
            Search.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            String sql = "UPDATE PRODUCT SET CART_ID = '" + textBox16.Text + "' , NAME = '" + textBox15.Text + "' , PRICE = '" + textBox13.Text + "' , QUANTITY = '" + textBox14.Text + "' WHERE PID = '" + textBox20.Text + "'";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.UpdateCommand = command;
            adapter.UpdateCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The Product has been updated!");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            String sql = "DELETE FROM PRODUCT WHERE CART_ID = " + textBox17.Text + " AND PID = " + textBox21.Text;
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.DeleteCommand = command;
            adapter.DeleteCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The Product has been deleted!");
        }

        private void button7_Click(object sender, EventArgs e)
        {
            String sql = "DELETE USERNAME, FROM CUSTOMER WHERE USERNAME = '" + textBox18.Text + "' AND PASSWORD = '" + textBox19.Text + "'";
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.DeleteCommand = command;
            adapter.DeleteCommand.ExecuteNonQuery();
            command.Dispose();
            connection.Close();
            MessageBox.Show("The User has been deleted!");
        }
        private void button8_Click(object sender, EventArgs e)
        {
            Form3 Edit = new Form3();
            Edit.Show();
            this.Hide();
        }
    }

}
