function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

var queryString;
var currentStatus;

window.onload = () => {
    var youT = 0;
    for (var r = 0; r < 9; r++) {
        document.getElementById("YourTable").innerHTML += '<tr id="YourRow' + r + '" style="border-color:black;border-width:3px;border-style:solid;">'
        for (var c = 0; c < 9; c++) {
            youT++;
            var temp = "YourRow" + r;
            document.getElementById(temp).innerHTML += '<td id="Your' + youT + '" style="border-color:black;border-width:3px;border-style:solid; width:30px; height:35px;" onClick="YourTableClick(' + (c + 1) + ',' + (r + 1) + ')">   </td>'
        }
        document.getElementById("YourTable").innerHTML += "</tr>"
    }
    var theirT = 0;
    for (var r = 0; r < 9; r++) {
        document.getElementById("TheirTable").innerHTML += '<tr id="TheirRow' + r + '" style="border-color:black;border-width:3px;border-style:solid;">'
        for (var c = 0; c < 9; c++) {
            theirT++;
            var temp = "TheirRow" + r;
            document.getElementById(temp).innerHTML += '<td id="Their' + youT + '" style="border-color:black;border-width:3px;border-style:solid; width:30px; height:35px;" onClick="TheirTableClick(' + (c + 1) + ',' + (r + 1) + ')">   </td>'
        }
        document.getElementById("TheirTable").innerHTML += "</tr>"
    }
    queryString = getParameterByName('GameID');

    if (sessionStorage["UserName"] === undefined || sessionStorage["UserName"] === "" || sessionStorage["SessionID"] === undefined || sessionStorage["SessionID"] === "") {
        window.location = "Login.html";
    }
    else {
        var user = {
            "GameID": queryString
        }
        var request = new XMLHttpRequest();
        request.open("Post", "http://localhost:58133//api/Game/GetGameStatus", true);
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

                    if (i > 1) {
                        for (var i = 0; i < result.length; i++) {

                        }
                    }
                    else {
                        document.getElementById('statusP').innerText = 'Game Status: ' + result[0];
                        currentStatus = result[0]
                    }
                }
            }
        };
        request.send(JSON.stringify(user));

         var user2 = {
            "GameID": queryString,
            "username": sessionStorage["UserName"]
        }
        var request2 = new XMLHttpRequest();
        request2.open("Post", "http://localhost:58133//api/Game/getShips", true);
        request2.setRequestHeader("Content-Type", "application/json");
        request2.onreadystatechange = () => {
            if (request2.readyState == 4 && request2.status >= 200 && request2.status < 300) {
                let result2 = JSON.parse(request2.responseText)
                if (result2 == null) {
                }
                else {
                    for(var temps = 0; temps < result2.length; temps++)
                    {
                        document.getElementById("Your"+result2[temps]).style.backgroundColor = "Green";
                    }
                }
            }
        };
        request2.send(JSON.stringify(user2));
    }
};

function LogOut() {
    sessionStorage["UserName"] = "";
    sessionStorage["SessionID"] = "";
    window.location = "../LogIn.html";
}
var selectedX = 0;
var oreintation = 0;
var shipLength = 0;
var selectedY = 0;


function YourTableClick(X, Y) {
    if (currentStatus == "Game is still in ship select phase... Please Wait...") {
        if (selectedX != 0) {
            document.getElementById("Your" + ((selectedY - 1) * 9 + (selectedX))).style.backgroundColor = "white";
        }
        document.getElementById("Your" + ((Y - 1) * 9 + (X))).style.backgroundColor = "blue";
        selectedX = X;
        selectedY = Y;
    }
    var user2 = {
            "GameID": queryString,
            "username": sessionStorage["UserName"]
        }
        var request2 = new XMLHttpRequest();
        request2.open("Post", "http://localhost:58133//api/Game/getShips", true);
        request2.setRequestHeader("Content-Type", "application/json");
        request2.onreadystatechange = () => {
            if (request2.readyState == 4 && request2.status >= 200 && request2.status < 300) {
                let result2 = JSON.parse(request2.responseText)
                if (result2 == null) {
                }
                else {
                    for(var temps = 0; temps < result2.length; temps++)
                    {
                        document.getElementById("Your"+result2[temps]).style.backgroundColor = "Green";
                    }
                }
            }
        };
        request2.send(JSON.stringify(user2));
}

function TheirTableClick(X, Y) {

}

function PlaceShip() {
    if (orientation != 0 && selectedX != 0 && shipLength != 0 && selectedY != 0) {
        var user = {
            "GameID": queryString,
            "username": sessionStorage["UserName"],
            "x": selectedX,
            "y": selectedY,
            "Orientation": orientation,
            "shipLength": shipLength,
            "sessionID": sessionStorage["SessionID"]
        }
        var request = new XMLHttpRequest();
        request.open("Post", "http://localhost:58133//api/Game/PlaceShips", true);
        request.setRequestHeader("Content-Type", "application/json");
        request.onreadystatechange = () => {
            if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                let result = JSON.parse(request.responseText)
                if (result == null) {
                    document.getElementById("result").style.color = "red";
                    document.getElementById("result").innerText = "Placing Ship Has Failed";
                }
                else {

                    document.getElementById("result").style.color = "green";
                    document.getElementById("result").innerText = "Placing Ship Has Succeeded";
                }
            }
        };
        request.send(JSON.stringify(user));
        var user2 = {
            "GameID": queryString,
            "username": sessionStorage["UserName"]
        }
        var request2 = new XMLHttpRequest();
        request2.open("Post", "http://localhost:58133//api/Game/getShips", true);
        request2.setRequestHeader("Content-Type", "application/json");
        request2.onreadystatechange = () => {
            if (request2.readyState == 4 && request2.status >= 200 && request2.status < 300) {
                let result2 = JSON.parse(request2.responseText)
                if (result2 == null) {
                }
                else {
                    for(var temps = 0; temps < result2.length; temps++)
                    {
                        document.getElementById("Your"+result2[temps]).style.backgroundColor = "Green";
                    }
                }
            }
        };
        request2.send(JSON.stringify(user2));
    }
    
}

function PickOrientation(T) {
    orientation = T;
}

function PickShipLength(T) {
    shipLength = T;
}