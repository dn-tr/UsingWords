using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UsingWords.Core.Tests
{
    [TestClass]
    public class WordsHelperTest
    {
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
    }
}
