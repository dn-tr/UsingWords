using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuickStartApp
{
    public partial class MainForm : Form
    {
        string fileName;

        public MainForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = "Text files (*.txt)|*.txt";

            if (dialog.ShowDialog() == DialogResult.OK)
            {
                textBox1.Text = dialog.FileName;
                fileName = dialog.FileName;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            richTextBox1.Clear();

            StreamReader file = new StreamReader(fileName,Encoding.ASCII);
            string line;
            while ((line = file.ReadLine()) != null)
            {
                ////
                //var s = line.Split(' ');

                //foreach (var item in s)
                //{
                //    richTextBox1.AppendText(item);
                //    richTextBox1.AppendText("\n");
                //}

                ////
                richTextBox1.AppendText(line);
                richTextBox1.AppendText("******");

            }

            file.Close();
        }
    }
}
