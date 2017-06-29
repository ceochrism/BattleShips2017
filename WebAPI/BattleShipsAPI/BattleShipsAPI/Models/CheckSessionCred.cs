using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class CheckSessionCred
    {
        [JsonProperty("username")]
        public string Username { get; set; }
        [JsonProperty("sessionID")]
        public Guid SessionID { get; set; }
    }
}