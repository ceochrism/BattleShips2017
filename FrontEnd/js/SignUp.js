'use strict';

window.onload = () => {
    if(localStorage.UserName != undefined && localStorage.UserName != "")
    {
        window.location="Home.html";
    }
};

var lists = document.getElementsByClassName("validate");

function validateTextBox() {
    var successful = true;
    for (let i = 0; i < lists.length; i++) {
        //console.log(lists[i].value);
        if (lists[i].value === "") {
            successful = false;
            lists[i].classList.add("error");
            document.getElementById(lists[i].dataset.label).classList.add("error");
        }
    }
    return successful;
}
function typing() {
    for (let i = 0; i < lists.length; i++) {
        if (lists[i].value !== "") {
            lists[i].classList.remove("error");
            document.getElementById(lists[i].dataset.label).classList.remove("error");
        }
    }
}

function signUp() {

    if (validateTextBox()) {
        var user = {
            "username": usernameTextBox.value,
            "password": passwordTextBox.value,
            "email": emailTextBox.value
        }
        var request = new XMLHttpRequest();
        request.open("Post", "http://localhost:58133//api/Login/SignUp", true);
        request.setRequestHeader("Content-Type", "application/json");
        request.onreadystatechange = () => {
            if (request.readyState == 4 && request.status >= 200 && request.status < 300) {
                let result = JSON.parse(request.responseText)
                if (result.status == null) {
                    resultBox.value="Sign Up has failed";
                    resultBox.classList.add("error");
                }
                else {
                    resultBox.value="You have successfully Signed Up";
                    resultBox.classList.add("succesful");
                    resultBox.classList.remove("error");
                    signUpButton.style.visibility = 'hidden';
                }
            }
        };
        request.send(JSON.stringify(user));
    }
}