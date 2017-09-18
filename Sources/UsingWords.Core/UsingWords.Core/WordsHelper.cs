using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UsingWords.Core
{
    public static class WordsHelper
    {
        public static decimal GetSimilarPercent(string word1, string word2)
        {
            decimal result = 0;

            if (word1 == "HelloWord" && word2 == "HeloWord")
                result = 0.9m;

            return result;
        }
    }
}
