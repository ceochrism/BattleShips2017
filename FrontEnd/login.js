'use strict';

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