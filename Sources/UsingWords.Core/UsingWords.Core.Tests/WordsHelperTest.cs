using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UsingWords.Core.Tests
{
    [TestClass]
    public class WordsHelperTest
    {
        #region GetSimilarPercent

        [TestMethod]
        public void GetSimilarPercent_HelloWorld_and_HeloWorld_0_9()
        {
            var res = WordsHelper.GetSimilarPercent("HelloWorld", "HeloWorld");
            Assert.AreEqual(0.9m, res);
        }

        [TestMethod]
        public void GetSimilarPercent_HelloWorld_and_HeloWord_0_8()
        {
            var res = WordsHelper.GetSimilarPercent("HelloWorld", "HeloWord");
            Assert.AreEqual(0.8m, res);
        }

        [TestMethod]
        public void GetSimilarPercent_Word_and_Wrd_0_75()
        {
            var res = WordsHelper.GetSimilarPercent("Word", "Wrd");
            Assert.AreEqual(0.75m, res);
        }

        #endregion

        #region AddEmptyChars

        [TestMethod]
        public void AddEmptyChars_Wrd_4targetLength()
        {
            List<string> resList = new List<string>() { "Wrd" };

            WordsHelper.AddEmptyChars(resList, 4, '_');

            Assert.AreEqual(resList.Count, 5);
            Assert.IsTrue(resList.Contains("_Wrd"));
            Assert.IsTrue(resList.Contains("W_rd"));
            Assert.IsTrue(resList.Contains("Wr_d"));
            Assert.IsTrue(resList.Contains("Wrd_"));
        }

        #endregion

        #region CompareListChars

        [TestMethod]
        public void CompareListChars_HelloWorld_and_HeloWorld_0_9()
        {
            var res = WordsHelper.CompareListChars("HelloWorld".ToList(), "Hel_oWorld".ToList());
            Assert.AreEqual(0.9m, res);
        }

        [TestMethod]
        public void CompareListChars_HelloWorld_and_HeloWord_0_8()
        {
            var res = WordsHelper.CompareListChars("HelloWorld".ToList(), "Hel_oWor_d".ToList());
            Assert.AreEqual(0.8m, res);
        }

        [TestMethod]
        public void CompareListChars_Word_and_Wrd_0_75()
        {
            var res = WordsHelper.CompareListChars("Word".ToList(), "W_rd".ToList());
            Assert.AreEqual(0.75m, res);
        }

        #endregion
    }
}
