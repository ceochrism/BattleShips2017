using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using BattleShipsAPI.Controllers;
using BattleShipsAPI.Models;
using System.Net.Http;
using System.Net;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace BattleShipsAPI.Tests
{
    [TestClass]
    public class UnitTest1
    {
        

        [TestMethod]
        public async Task LoginOverHttpTest()
        {
            HttpClient client = new HttpClient();
            LoginCredentials credentials = new LoginCredentials
            {
                Username = "test",
                Password = "test"
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Login/Login", credentials);
            string response = await result.Content.ReadAsStringAsync();
            UserInfo profile = JsonConvert.DeserializeObject<UserInfo>(response);
            Assert.IsNotNull(profile.Status, "Login Succesful");
        }

        [TestMethod] 
        public async Task SignUpOverHttpTest()
        {
            HttpClient client = new HttpClient();
            SignUpCredentials credentials = new SignUpCredentials
            {
                Username = "test5",
                Password = "test",
                Email = "test@gmail.com"
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Login/SignUp", credentials);
            string response = await result.Content.ReadAsStringAsync();
            SignUpStatus profile = JsonConvert.DeserializeObject<SignUpStatus>(response);
            Assert.IsNotNull(profile.Status, "Sign Up Invalid");
        }

        [TestMethod]
        public async Task StartGameOverHttpTest()
        {
            HttpClient client = new HttpClient();
            StartGameCredentials credentials = new StartGameCredentials
            {
                Username = "test2",
                state = Guid.Parse("2A79D4EB-AE2B-4466-AEF0-DC0193E9CD5E")
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Game/Start", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string profile = JsonConvert.DeserializeObject<string>(response);
            Assert.IsNotNull(profile, "Game Creation Failed");
        }

        [TestMethod]
        public async Task GetGameIDsHttpTest()
        {
            HttpClient client = new HttpClient();
            GetGameIDs credentials = new GetGameIDs
            {
                Username = "test"
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Game/GetGameIDs", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string[] profile = JsonConvert.DeserializeObject<string[]>(response);
            Assert.IsNotNull(profile, "Game Creation Failed");
        }
    }
}
