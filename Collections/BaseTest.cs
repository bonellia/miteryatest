using Miterya.ScreenTest.Builders;
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Miterya.ScreenTest.Collections
{
    public class BaseTest
    {
        public IWebDriver WebDriver { get; set; }
        public ContextBuilder contextBuilder;
        public TestUtil util;

        [OneTimeSetUp]
        public void Init()
        {
            contextBuilder = new ContextBuilder();
        }

        public string TestUrl { get; set; } = "http://localhost:33069/";

        [SetUp]
        public void SetUp()
        {
            // We don't clear all context anymore for tests' runtime efficiency.
            // Every test class now has a preparation method with OneTimeSetup annotation.
            // contextBuilder.ClearAllContext();
            _ = (AppDomain.CurrentDomain.BaseDirectory.ToString() + "Driver\\");
            WebDriver = new ChromeDriver(AppDomain.CurrentDomain.BaseDirectory.ToString() + "Driver\\");
            WebDriver.Manage().Window.Maximize();
            WebDriver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(3);
            util = new TestUtil(WebDriver);
        }

        [TearDown]
        public void TearDown()
        {
            //contextBuilder.ClearAllContext();
            WebDriver.Quit();
        }

    }
}
