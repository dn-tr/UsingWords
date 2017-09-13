using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
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
        const string _connectionString = @"Server=localhost\SQLEXPRESS;Database=for-any-tests;Trusted_Connection=True;";

        string fileName;

        public MainForm()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Get symmbols (punctuation marks)
        /// </summary>
        /// <returns>Symbols list</returns>
        private List<string> GetSymbols()
        {
            List<string> symbols = new List<string>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                string cmdText = @"
                        SELECT	i.Item
                        FROM	dbo.TextItems		i
                        JOIN	dbo.TextItemKinds	k
	                        ON	k.Id	= i.Kind
                        WHERE	k.Name	= 'symbol'    
                    ";
                SqlCommand command = new SqlCommand(cmdText, connection);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        symbols.Add(reader.GetString(0));
                    }
                }
            }

            return symbols;
        }

        /// <summary>
        /// EXEC dbo.pAddTextData
        /// </summary>
        /// <param name="word">Adding word</param>
        /// <param name="prewId">Id of previous word</param>
        /// <param name="sourceId">Id of source (books, articles, etc.)</param>
        /// <param name="debugMode">0 - EXEC dbo.pAddTextData; 1 - print to richTextBox1</param>
        /// <returns>Id of added word</returns>
        private long AddTextData(SqlConnection connection, string word, long prewId, int sourceId, int debugMode = 0)
        {
            long id = 0;

            if (debugMode == 0)
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();

                SqlCommand command = new SqlCommand("dbo.pAddTextData", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@Word", word));
                command.Parameters.Add(new SqlParameter("@PrevId", prewId));
                command.Parameters.Add(new SqlParameter("@SourceId", sourceId));
                command.Parameters.Add(new SqlParameter("@Id", SqlDbType.BigInt)).Direction = ParameterDirection.Output;

                command.ExecuteNonQuery();

                id = Convert.ToInt64(command.Parameters["@Id"].Value);
            }
            else if (debugMode == 1)
            {
                WriteLine(word);
            }

            return id;
        }

        private void WriteLine(string line)
        {
            if (!string.IsNullOrWhiteSpace(line))
                richTextBox1.AppendText(line);
            richTextBox1.AppendText("\n");
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
            //using (SqlConnection connection = new SqlConnection(_connectionString))
            //{
            //    long id = AddTextData(connection, $"test{DateTime.Now.Ticks}", 0, 0, 0);
            //    richTextBox1.AppendText(id.ToString());
            //    richTextBox1.AppendText("\n");
            //}

            richTextBox1.Clear();

            try
            {
                List<string> symbols = GetSymbols();

                using (StreamReader file = new StreamReader(fileName, Encoding.ASCII))
                {
                    string fileLine;
                    Dictionary<int, string> endSymbols = new Dictionary<int, string>();
                    int key = 0;
                    long wordsCount = 0;
                    long wordsAndSymbolsCount = 0;
                    long prevId = 0;
                    int sourceId = 0;
                    int debugMode = 0;

                    using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        WriteLine($"[{DateTime.Now.ToString()}] Start write words to DB... File size: {new FileInfo(fileName).Length} byte");

                        while ((fileLine = file.ReadLine()) != null)
                        {
                            var lineWords = fileLine.Split(' ');

                            //TODO: to think about spaces
                            //TODO: do something with numbers
                            //TODO: to think about words with punctuation marks in middle

                            foreach (var word in lineWords)
                            {
                                if (!string.IsNullOrWhiteSpace(word))
                                {
                                    endSymbols.Clear();
                                    key = 0;
                                    string tmpWord = word;

                                    if (word.Length > 1)
                                    {
                                        // finding and removing punctuation marks on begin and end words
                                        for (int i = 0; i < symbols.Count; i++)
                                        {
                                            bool repeat = false;

                                            while (tmpWord.StartsWith(symbols[i]))
                                            {
                                                // write start symbols to DB in order
                                                prevId = AddTextData(connection, symbols[i], prevId, sourceId, debugMode);
                                                wordsAndSymbolsCount++;

                                                tmpWord = tmpWord.Remove(0, 1);
                                                repeat = true;
                                            }

                                            if (tmpWord.Length > 1)
                                            {
                                                while (tmpWord.EndsWith(symbols[i]))
                                                {
                                                    endSymbols.Add(key, symbols[i]);
                                                    key++;
                                                    tmpWord = tmpWord.Remove(tmpWord.Length - 1, 1);
                                                    repeat = true;
                                                }
                                            }

                                            if (repeat)
                                                i = -1;
                                        }
                                    }

                                    // write word to DB
                                    prevId = AddTextData(connection, tmpWord, prevId, sourceId, debugMode);
                                    wordsCount++;
                                    wordsAndSymbolsCount++;

                                    if (endSymbols.Count != 0)
                                    {
                                        foreach (var endS in endSymbols.OrderByDescending(a => a.Key))
                                        {
                                            // write end symbols to DB "in reverse order"
                                            prevId = AddTextData(connection, endS.Value, prevId, sourceId, debugMode);
                                            wordsAndSymbolsCount++;
                                        }
                                    }
                                }
                            }
                        }

                        WriteLine($"[{DateTime.Now.ToString()}] End write words to DB. Words count: {wordsCount}; with symbols: {wordsAndSymbolsCount};");
                    }
                }
            }
            catch (Exception ex)
            {
                WriteLine("");
                WriteLine(ex.Message);
                WriteLine(ex.StackTrace);
            }
        }
    }
}
