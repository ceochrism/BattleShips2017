using BattleShipsAPI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace BattleShipsAPI.Controllers
{
    /// <summary>
    /// Game Related Calls
    /// </summary>
    [RoutePrefix("api/Game")]
    [EnableCors("*", "*", "*")]
    public class GameController : ApiController
    {
        private static string connString = System.Configuration.ConfigurationManager.ConnectionStrings["gmrskybase"].ConnectionString;

        /// <summary>
        /// Starts a game for a user
        /// </summary>
        /// <param name="credentials">Takes in username and session ID</param>
        /// <returns>If game started</returns>
        [HttpPost]
        [Route("Start")]
        public string StartGame([FromBody] StartGameCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_StartGame", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@UserName", credentials.Username);
                command.Parameters.AddWithValue("@state", credentials.state);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();

                if (int.Parse(table.Rows[0][0].ToString()) == 1)
                {
                    return "Game succesfully started";
                }
                return null;
            }
        } 

        /// <summary>
        /// Gets game ids for that user
        /// </summary>
        /// <param name="cred">takes in username</param>
        /// <returns>game ids</returns>
        [HttpPost]
        [Route("GetGameIDs")]
        public string[] GetGameIDs([FromBody] GetGameIDs cred)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_GetGameIDs", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@UserName", cred.Username);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();
                

                if(table.Rows.Count>0)
                {
                    string[] ids = new string[table.Rows.Count];
                    for(int i = 0; i<table.Rows.Count; i++)
                    {
                        ids[i] = table.Rows[i][0].ToString();
                    }
                    return ids;
                }
                return null;
            }
        }
    }
}
