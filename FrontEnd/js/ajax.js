'use strict';

window.onload = () => {
    if(sessionStorage["UserName"] === undefined || sessionStorage["UserName"] === "" || sessionStorage["SessionID"]=== undefined || sessionStorage["SessionID"] === "")
    {
        window.location="../LogIn.html";
    }
    else{
         var user = {
                "username": sessionStorage["UserName"],
                "sessionID": sessionStorage["SessionID"]
            }
            var request = new XMLHttpRequest();
            request.open("Post", "http://localhost:58133//api/Login/CheckSession", true);
            request.setRequestHeader("Content-Type", "application/json");
            request.onreadystatechange = () => {
                if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                    let result = JSON.parse(request.responseText)
                    if (result == null) {
                        sessionStorage["UserName"] = "";
                        sessionStorage["SessionID"] = "";
                        window.location.href = "../LogIn.html" 
                    }
                    else {
                        return;
                    }
                }
            };
            request.send(JSON.stringify(user));
    }
};