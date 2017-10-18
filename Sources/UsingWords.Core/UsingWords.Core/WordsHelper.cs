using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UsingWords.Core
{
    public static class WordsHelper
    {
        public static decimal GetSimilarPercent(string word1, string word2, char emptyChar = '\0', bool ignoreCase = true, decimal defaultMinPercent = 0.1m)
        {
            string _word1 = ignoreCase ? word1.ToLower() : word1;
            string _word2 = ignoreCase ? word2.ToLower() : word2;

            string biggerWord = _word1.Length >= _word2.Length ? _word1 : _word2;
            string smallerWord = _word1.Length < _word2.Length ? _word1 : _word2;

            int biggerLength = biggerWord.Length;
            int smallerLength = smallerWord.Length;

            if (biggerLength == 0 || smallerLength == 0)
                throw new ArgumentException("One of words have zero length");

            if (biggerLength == 1 || smallerLength == 1)
                throw new ArgumentException("Words from one letter don't compare");

            if (biggerLength == 2 && smallerLength == 2)
                throw new ArgumentException("Words from two letters are compare with bigger words only");

            decimal startPercent = smallerLength / Convert.ToDecimal(biggerLength);

            if (biggerWord.Contains(smallerWord))
                return startPercent;

            if (startPercent <= defaultMinPercent)
                return startPercent;

            List<char> biggerListChars = biggerWord.ToList();
            List<char> smallerListChars = smallerWord.ToList();

            List<string> allVars = new List<string>() { smallerWord };

            //DateTime d1 = DateTime.Now;

            AddEmptyChars(allVars, biggerLength, emptyChar);

            //DateTime d2 = DateTime.Now;


            var distVars = allVars
                .Where(a => a.Length == biggerLength)
                .Distinct()
                .Select(b => new { Word = b, Percent = CompareListChars(biggerListChars, b.ToList()) });

            //foreach (var item in distVars)
            //    Console.WriteLine($"{item.Word} {item.Percent}");

            //Console.WriteLine($"Time {d2 - d1}");
            //Console.WriteLine($"Total count {allVars.Count()}");
            //Console.WriteLine($"Distinct count {distVars.Count()}");

            return distVars.Max(a => a.Percent);
        }

        public static void AddEmptyChars(List<string> words, int targetLength, char emptyChar)
        {
            List<string> variants = new List<string>();

            foreach (var item in words)
            {
                int iCount = item.Length + 1;

                if (iCount > targetLength)
                    continue;

                for (int i = 0; i < iCount; i++)
                {
                    var tmpChList = new List<char>(item);
                    tmpChList.Insert(i, emptyChar);
                    string tmpStr = string.Join("", tmpChList);
                    if (!words.Contains(tmpStr))
                        variants.Add(tmpStr);
                }

                if (iCount < targetLength)
                    AddEmptyChars(variants, targetLength, emptyChar);
            }

            words.AddRange(variants);
        }

        public static decimal CompareListChars(List<char> word1, List<char> word2)
        {
            int length = word1.Count();
            if (length == 0)
                return 0;

            decimal sum = 0;

            for (int i = 0; i < length; i++)
            {
                sum += (word1[i] == word2[i]) ? 1 : 0;
            }

            return sum / Convert.ToDecimal(length);
        } 
    }
}
