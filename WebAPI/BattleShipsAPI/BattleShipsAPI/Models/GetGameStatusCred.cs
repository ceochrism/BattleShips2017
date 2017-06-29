using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class GetGameStatusCred
    {
        [JsonProperty("gameID")]
        public int GameID { get; set; }
    }
}