using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace Market
{
    public partial class Form2 : Form
    {
        SqlConnection connection;
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(@"Data Source=DESKTOP-5JC2MA4;Initial Catalog=market_DB; User ID=DESKTOP-5JC2MA4/USER;Integrated Security=SSPI;Persist Security Info=False;");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String sql = "SELECT * FROM PRODUCT WHERE CART_ID = " + textBox4.Text;
            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            command.ExecuteNonQuery();
            this.pRODUCTTableAdapter.Fill(this.market_DBDataSet.PRODUCT);
            connection.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form1 main = new Form1();
            main.Show();
            this.Hide();
        }
    }
}
