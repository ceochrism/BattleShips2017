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

        [TestMethod]
        public async Task PlaceShipOverHttp()
        {
            HttpClient client = new HttpClient();
            PlaceShipsCredentials credentials = new PlaceShipsCredentials
            {
                Username = "test",
                GameID = 19,
                X = 5,
                Y = 3,
                ShipLength = 3,
                Orientation = 1,
                SessionID = Guid.Parse("67A3B179-D4AB-4E34-A63F-D37101C4B324")
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Game/PlaceShips", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string profile = JsonConvert.DeserializeObject<string>(response);
            Assert.IsNotNull(profile, "Placing Ship Failed");
        }

        [TestMethod]
        public async Task GetGameStatusOverHttp()
        {
            HttpClient client = new HttpClient();
            GetGameStatusCred credentials = new GetGameStatusCred
            {
                
                GameID = 19
            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Game/GetGameStatus", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string[] profile = JsonConvert.DeserializeObject<string[]>(response);
            Assert.IsNotNull(profile, "Getting Game Status Failed");
        }

        [TestMethod]
        public async Task MoveOverHttp()
        {
            HttpClient client = new HttpClient();
            MoveCredentials credentials = new MoveCredentials
            {
                GameID = 19,
                X = 5,
                Y = 3,
                Username = "test2",
                SessionID = Guid.Parse("2A79D4EB-AE2B-4466-AEF0-DC0193E9CD5E")

            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Game/Move", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string profile = JsonConvert.DeserializeObject<string>(response);
            Assert.IsNotNull(profile, "Getting Game Status Failed");
        }

        [TestMethod]
        public async Task CheckSessionOverHttp()
        {
            HttpClient client = new HttpClient();
            CheckSessionCred credentials = new CheckSessionCred
            {
                Username = "test2",
                SessionID = Guid.Parse("2A79D4EB-AE2B-4466-AEF0-DC0193E9CD5E")

            };
            var result = await client.PostAsJsonAsync($"http://localhost:58133/api/Login/CheckSession", credentials);
            string response = await result.Content.ReadAsStringAsync();
            string profile = JsonConvert.DeserializeObject<string>(response);
            Assert.IsNotNull(profile, "Session Expired");
        }
    }
}
