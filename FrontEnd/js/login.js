'use strict';

window.onload = () => {
    if(sessionStorage["UserName"] != undefined && sessionStorage["UserName"] != "")
    {
        window.location="Home.html";
    }
};

        var lists = document.getElementsByClassName("validate");

        function validateTextBox()
        {
            var successful = true;
            for(let i = 0; i < lists.length; i++)
            {
                //console.log(lists[i].value);
                if(lists[i].value === "")
                {
                    successful = false;
                    lists[i].classList.add("error");
                    document.getElementById(lists[i].dataset.label).classList.add("error");
                }
            }
            return successful;
        }
        function typing()
        {
            for(let i = 0; i < lists.length; i++)
            {
                if(lists[i].value !== "")
                {
                    lists[i].classList.remove("error");
                    document.getElementById(lists[i].dataset.label).classList.remove("error");
                }
            }
        }

        function logIn() {

        if (validateTextBox()) {
            var user = {
                "username": usernameTextBox.value,
                "password": passwordTextBox.value
            }
            var request = new XMLHttpRequest();
            request.open("Post", "http://localhost:58133//api/Login/Login", true);
            request.setRequestHeader("Content-Type", "application/json");
            request.onreadystatechange = () => {
                if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                    let result = JSON.parse(request.responseText)
                    if (result.status == null) {
                        alert("Incorrect credentials have been entered.")
                    }
                    else {
                        sessionStorage["UserName"] = result.username;
                        sessionStorage["SessionID"] = result.status;
                        window.location = "Home.html"
                    }
                }
            };
            request.send(JSON.stringify(user));
        }
    }