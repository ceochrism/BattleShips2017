using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class SignUpStatus
    {
        [JsonProperty("status")]
        public string Status { get; }

        public SignUpStatus(string status)
        {
            Status = status;
        }

    }
}