'use strict';

function LogOut() {
    sessionStorage["UserName"] = "";
    sessionStorage["SessionID"] = "";
    window.location = "LogIn.html";
}

function myGames() {
    window.location = "MyGames.html"
}

function startGame() {
    var user = {
        "username": sessionStorage["UserName"],
        "state":    sessionStorage["SessionID"]
    }
    var request = new XMLHttpRequest();
    request.open("Post", "http://localhost:58133//api/Game/Start", true);
    request.setRequestHeader("Content-Type", "application/json");
    request.onreadystatechange = () => {
        if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
            let result = JSON.parse(request.responseText)
            if (result == null) {
                document.getElementById("startingStatus").innerText = "StartingGame Failed";
            }
            else {
                window.location = "GameStarted.html";
            }
        }
    };
    request.send(JSON.stringify(user));
}