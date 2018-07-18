using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace UsingWords.Core.Tests
{
    public class WordsHelperTest
    {
        #region GetSimilarPercent

        [Fact]
        public void GetSimilarPercent_HelloWorld_and_HeloWorld_0_9()
        {
            var res = WordsHelper.GetSimilarPercent("HelloWorld", "HeloWorld");
            Assert.Equal(0.9m, res);
        }

        [Fact]
        public void GetSimilarPercent_HelloWorld_and_HeloWord_0_8()
        {
            var res = WordsHelper.GetSimilarPercent("HelloWorld", "HeloWord");
            Assert.Equal(0.8m, res);
        }

        [Fact]
        public void GetSimilarPercent_Word_and_Wrd_0_75()
        {
            var res = WordsHelper.GetSimilarPercent("Word", "Wrd");
            Assert.Equal(0.75m, res);
        }

        #endregion

        #region AddEmptyChars

        [Fact]
        public void AddEmptyChars_Wrd_4targetLength()
        {
            List<string> resList = new List<string>() { "Wrd" };

            WordsHelper.AddEmptyChars(resList, 4, '_');

            Assert.Equal(5, resList.Count);
            Assert.Contains("_Wrd", resList);
            Assert.Contains("W_rd", resList);
            Assert.Contains("Wr_d", resList);
            Assert.Contains("Wrd_", resList);
        }

        #endregion

        #region CompareListChars

        [Fact]
        public void CompareListChars_HelloWorld_and_HeloWorld_0_9()
        {
            var res = WordsHelper.CompareListChars("HelloWorld".ToList(), "Hel_oWorld".ToList());
            Assert.Equal(0.9m, res);
        }

        [Fact]
        public void CompareListChars_HelloWorld_and_HeloWord_0_8()
        {
            var res = WordsHelper.CompareListChars("HelloWorld".ToList(), "Hel_oWor_d".ToList());
            Assert.Equal(0.8m, res);
        }

        [Fact]
        public void CompareListChars_Word_and_Wrd_0_75()
        {
            var res = WordsHelper.CompareListChars("Word".ToList(), "W_rd".ToList());
            Assert.Equal(0.75m, res);
        }

        #endregion

    }
}
