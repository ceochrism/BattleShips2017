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


                if (table.Rows.Count > 0)
                {
                    string[] ids = new string[table.Rows.Count];
                    for (int i = 0; i < table.Rows.Count; i++)
                    {
                        ids[i] = table.Rows[i][0].ToString();
                    }
                    return ids;
                }
                return null;
            }
        }

        /// <summary>
        /// Places the Ships at the start of the game
        /// </summary>
        /// <param name="credentials">ship cords and user credentials</param>
        /// <returns>if succesful or not</returns>
        [HttpPost]
        [Route("PlaceShips")]
        public string PlaceShips([FromBody] PlaceShipsCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_PlaceShip", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@GameID", credentials.GameID);
                command.Parameters.AddWithValue("@StartX", credentials.X);
                command.Parameters.AddWithValue("@StartY", credentials.Y);
                command.Parameters.AddWithValue("@Orientation", credentials.Orientation);
                command.Parameters.AddWithValue("@ShipLength", credentials.ShipLength);
                command.Parameters.AddWithValue("@state", credentials.SessionID);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();

                if (int.Parse(table.Rows[0][0].ToString()) == 1)
                {
                    return "Ship Succesfully Placed";
                }
                else
                {
                    return null;
                }
            }
        }

        /// <summary>
        /// Checks Games Status
        /// </summary>
        /// <param name="credentials"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("GetGameStatus")]
        public string[] GetGameStatus([FromBody] GetGameStatusCred credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_GetGameStatus", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@GameID", credentials.GameID);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();
                DataColumnCollection columns = table.Columns;
                if (!columns.Contains("Result") && table.Rows.Count > 0)
                {
                    string[] t = new string[1] { table.Rows[0][0].ToString() };
                    return t;
                }
                else if (columns.Contains("Result"))
                {
                    string[] temp = new string[table.Rows.Count];
                    for (int i = 0; i < table.Rows.Count; i++)
                    {
                        temp[i] = table.Rows[i]["Result"].ToString() + " X: " + table.Rows[i]["LocationX"].ToString() + " Y: " + table.Rows[i]["LocationY"].ToString();
                    }
                    return temp;
                }
                else
                {
                    return null;
                }
            }
        }

        /// <summary>
        /// Fires a shot if it is there turn
        /// </summary>
        /// <param name="credentials">contains coordinates and game info</param>
        /// <returns>hit/miss and if it actually shot</returns>
        [HttpPost]
        [Route("Move")]
        public string Move([FromBody] MoveCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_Move", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@GameID", credentials.GameID);
                command.Parameters.AddWithValue("@X", credentials.X);
                command.Parameters.AddWithValue("@Y", credentials.Y);
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@state", credentials.SessionID);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();
                
                if(table.Rows[0][0].ToString() == "0" || table.Rows[0][0].ToString() == "Session Expired")
                {
                    return null;
                }
                else
                {
                    return table.Rows[0][0].ToString();
                }
            }
        }
    }
}
