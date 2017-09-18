using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UsingWords.Core.Tests
{
    [TestClass]
    public class WordsHelperTest
    {
        [TestMethod]
        public void GetSimilarPercent_HelloWord_compare_HeloWord_0_9()
        {
            var res = WordsHelper.GetSimilarPercent("HelloWord", "HeloWord");
            Assert.AreEqual(0.9m, res);
        }
    }
}
