using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class getShipsCred
    {
        [JsonProperty("username")]
        public string UserName { get; set; }
        [JsonProperty("gameID")]
        public int GameID { get; set; }
    }
}