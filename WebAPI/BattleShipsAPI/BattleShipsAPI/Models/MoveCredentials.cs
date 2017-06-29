using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class MoveCredentials
    {
        [JsonProperty("username")]
        public string Username { get; set; }
        [JsonProperty("x")]
        public int X { get; set; }
        [JsonProperty("y")]
        public int Y { get; set; }
        [JsonProperty("gameID")]
        public int GameID { get; set; }
        [JsonProperty("sessionID")]
        public Guid SessionID { get; set; }
    }
}