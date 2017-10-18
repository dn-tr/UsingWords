using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UsingWords.Core;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine(WordsHelper.GetSimilarPercent("HelloWorld", "HeloWorl", '_'));
                //Console.WriteLine(WordsHelper.GetSimilarPercent("Managementas", "mn", '_'));
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);
            }
            Console.ReadKey();
        }
    }
}

