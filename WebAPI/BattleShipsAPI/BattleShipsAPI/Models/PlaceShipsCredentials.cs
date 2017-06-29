using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class PlaceShipsCredentials
    {
        [JsonProperty("username")]
        public string Username { get; set; }
        [JsonProperty("gameID")]
        public int GameID { get; set; }
        [JsonProperty("x")]
        public int X { get; set; }
        [JsonProperty("y")]
        public int Y { get; set; }
        [JsonProperty("orientation")]
        public int Orientation { get; set; }//1=right 2=left  3 = up    4=down
        [JsonProperty("shipLength")]
        public int ShipLength { get; set; }
        [JsonProperty("sessionID")]
        public Guid SessionID { get; set; }
    }
}