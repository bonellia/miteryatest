using Miterya.ScreenTest.Collections;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Miterya.ScreenTest.Pages
{
    public class SurveyPage : BasePage
    {
        public SurveyPage(IWebDriver webDriver)
        {
            this.WebDriver = webDriver;
            this.WebDriver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(3);
        }

        /// <summary>
        /// Extracts multiple choice questions within page and answers them regardless number of options.
        /// </summary>
        public void SolveRadioButtonTestRandom()
        {
            var className = "sv_q sv_qstn";
            IReadOnlyCollection<IWebElement> questions = WebDriver.FindElements(By.XPath($"//*[contains(@class, '{className}')]"));
            foreach (var question in questions)
            {
                var options = question.FindElements(By.CssSelector("input[type='radio']")).ToList();
                var c = options.Count;
                for (int i = 0; i < c; i++)
                {
                    options[new Random().Next(0, c)].Click();
                }
            }
        }
    }
}
