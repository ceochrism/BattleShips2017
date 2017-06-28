using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class StartGameCredentials
    {
        [JsonProperty("username")]
        public string Username { get; set; }

        [JsonProperty("state")]
        public Guid state { get; set; }
        
    }
}