using BattleShipsAPI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;
using System.Web.Http.Cors;

namespace BattleShipsAPI.Controllers
{
    /// <summary>
    /// User-related functions
    /// </summary>
    [RoutePrefix("api/Login")]
    [EnableCors("*", "*", "*")]
    public class LoginController : ApiController
    {
        //encryption magic that i don't understand but it works.
        private string sha256(string password)
        {
            SHA256Managed crypt = new SHA256Managed();
            string hash = String.Empty;
            byte[] crypto = crypt.ComputeHash(Encoding.ASCII.GetBytes(password), 0, Encoding.ASCII.GetByteCount(password));
            crypto.ToList().ForEach(b => hash += b.ToString("x2"));
            return hash;
        }

        private static string connString = System.Configuration.ConfigurationManager.ConnectionStrings["gmrskybase"].ConnectionString;

        /// <summary>
        /// Registers a new user
        /// </summary>
        /// <param name="credentials">The user's username and password</param>
        /// <returns>if success</returns>

        [HttpPost]
        [Route("SignUp")]
        public SignUpStatus SignUp([FromBody] SignUpCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_SignUp", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@Password", sha256(credentials.Password));
                command.Parameters.AddWithValue("@Email", credentials.Email);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();

                if (int.Parse(table.Rows[0][0].ToString()) == 1)
                {
                    return new SignUpStatus("Account succesfully created");
                }

                return new SignUpStatus(null);
            }
        }

        /// <summary>
        /// Logins in a user
        /// </summary>
        /// <param name="credentials">Username and Password</param>
        /// <returns>if succesful</returns>
        [HttpPost]
        [Route("Login")]
        public UserInfo Login([FromBody] LoginCredentials credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_Login", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@Password", sha256(credentials.Password));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();

                if (table.Rows.Count>0)
                {
                    return new UserInfo(credentials.Username, Guid.Parse(table.Rows[0][1].ToString()));
                }
                else
                {
                    return new UserInfo(credentials.Username, null);
                }

            }
        }

        [HttpPost]
        [Route("CheckSession")]
        public string CheckSession([FromBody] CheckSessionCred credentials)
        {
            using (SqlConnection conn = new SqlConnection(connString))

            using (SqlCommand command = new SqlCommand("usp_CheckSession", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", credentials.Username);
                command.Parameters.AddWithValue("@status", credentials.SessionID);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();

                conn.Open();

                adapter.Fill(table);

                conn.Close();

                if (table.Rows.Count > 0)
                {
                    return "Correct";
                }
                else
                {
                    return null;
                }

            }
        }
    }
}
