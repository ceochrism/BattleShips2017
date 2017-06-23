using BattleShipsAPI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BattleShipsAPI.Controllers
{
    [RoutePrefix("api/Login")]
    public class LoginController : ApiController
    {
        private static string connString = System.Configuration.ConfigurationManager.ConnectionStrings["gmrskybase"].ConnectionString;

        [HttpPost]
        [Route("SignUp")]
        public string SignUp([FromBody] SignUpCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_SignUp", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@Password", credentials.Password);
                command.Parameters.AddWithValue("@Email", credentials.Email);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();
                
                if(int.Parse(table.Rows[0][0].ToString()) == 1)
                {
                    return "Account succesfully created";
                }

                return "Account creation failed";
            }
        }
    }
}
