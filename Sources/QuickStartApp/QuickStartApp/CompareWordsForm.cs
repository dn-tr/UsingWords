using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using UsingWords.Core;

namespace QuickStartApp
{
    public partial class CompareWordsForm : Form
    {
        public CompareWordsForm()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            CompareWords();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            CompareWords();
        }

        private void CompareWords()
        {
            object res = null;

            try
            {
                if (!(string.IsNullOrEmpty(textBox1.Text) || string.IsNullOrEmpty(textBox2.Text)))
                    res = WordsHelper.GetSimilarPercent(textBox1.Text.Trim(), textBox2.Text.Trim());
            }
            catch(Exception ex)
            {
                res = ex.Message;
            }

            label3.Text = $"Result : {res}";
        }
    }
}
