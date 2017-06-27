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
    [RoutePrefix("api/Login")]
    [EnableCors("*","*","*")]
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

        [HttpPost]
        [Route("SignUp")]
        public string SignUp([FromBody] SignUpCredentials credentials)
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
                
                if(int.Parse(table.Rows[0][0].ToString()) == 1)
                {
                    return "Account succesfully created";
                }

                return "Account creation failed";
            }
        }

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

                if (int.Parse(table.Rows[0][0].ToString()) == 0)
                {
                    return null;
                }

                return new UserInfo(credentials.Username,Guid.Parse(table.Rows[0][0].ToString()));
            }
        }
    }
}
