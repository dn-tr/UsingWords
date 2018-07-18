using System;
using UsingWords.Core;

namespace UsingWords.TestApp
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
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);
            }
            Console.ReadKey();

        }
    }
}
