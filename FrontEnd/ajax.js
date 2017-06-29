'use strict';

window.onload = () => {
    if(localStorage.UserName === undefined || localStorage.UserName === "")
    {
        window.location="Login.html";
    }
    else{
         var user = {
                "username": localStorage.UserName,
                "sessionID": localStorage.SessionID
            }
            var request = new XMLHttpRequest();
            request.open("Post", "http://localhost:58133//api/Login/CheckSession", true);
            request.setRequestHeader("Content-Type", "application/json");
            request.onreadystatechange = () => {
                if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                    let result = JSON.parse(request.responseText)
                    if (result == null) {
                        localStorage.UserName = "";
                        window.location = "logIn.html" 
                    }
                    else {
                        return;
                    }
                }
            };
            request.send(JSON.stringify(user));
    }
};