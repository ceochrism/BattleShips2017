using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BattleShipsAPI.Models
{
    public class UserInfo
    {
        [JsonProperty("username")]
        public string Username { get; }

        [JsonProperty("status")]
        public Guid? Status { get; }

        public UserInfo(string username, Guid? status)
        {
            Username = username;
            Status = status;
        }
    }
}