'use strict';

window.onload = () => {
    if(sessionStorage["UserName"] === undefined || sessionStorage["UserName"] === "" || sessionStorage["SessionID"]=== undefined || sessionStorage["SessionID"] === "")
    {
        window.location="Login.html";
    }
    else{
         var user = {
                "username": sessionStorage["UserName"],
            }
            var request = new XMLHttpRequest();
            request.open("Post", "http://localhost:58133//api/Game/GetGameIDs", true);
            request.setRequestHeader("Content-Type", "application/json");
            request.onreadystatechange = () => {
                if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                    let result = JSON.parse(request.responseText)
                    if (result == null) {
                        //sessionStorage["UserName"] = "";
                        //sessionStorage["SessionID"] = "";
                        //window.location = "logIn.html" 
                    }
                    else {
                        for(var i = 0; i < result.length; i++)
                        {
                            document.getElementById('games').innerHTML += '<a href="Games/?GameID='+result[i] +'"><ol style="list-style-type:none"><li> Game ' + (i+1) +'</li></ol></a>';
                        }
                    }
                }
            };
            request.send(JSON.stringify(user));
    }
};

function LogOut()
{
    sessionStorage["UserName"] = "";
    sessionStorage["SessionID"] = "";
    window.location = "LogIn.html";
}