<?php
if(isset($_SESSION['logkin']) && $_SESSION['logkin'] == "ok" ){header("Location: ./index.php");exit();}
?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body { font-family: Arial,sans-serif;background: linear-gradient(120deg,#3498db,#8e44ad);display: flex;justify-content: center;align-items: center;height: 100vh;margin: 0}

        .login-container {background: #fff;padding: 30px;border-radius: 10px;box-shadow: 0 4px 8px rgba(0,0,0,.1);max-width: 400px;width: 100%;text-align: center}

            .login-container h2 {margin-bottom: 20px;color: #333}

            .login-container input {width: calc(100% - 20px);padding: 16px;margin: 10px 0;border: 1px solid #ccc;border-radius: 5px}

            .login-container button {padding: 14px 20px;width: 100%;margin-top: 20px;background: #3498db;color: #fff;border: none;border-radius: 5px;cursor: pointer;font-size: 16px}

                .login-container button:hover {background: #2980b9}

            .login-container p {font-size: 12px;text-align: left;margin-bottom: 1px}
    </style>
    <script src="./sharparp.js?gfs"></script>
</head>
<body>
    <div class="login-container"><h2>Login</h2><p>Email: mail@example.com</p><input type="email" id="hhemail" placeholder="Email: mail@example.com" /><br><p>Password: *****</p><input type="password" id="hhpassword" placeholder="Password"><br><button type="button" onclick="loginPagge();">Login</button></div>


    <script>var hdomain = document.getElementById('hhdomain');
        var hemail = document.getElementById('hhemail');
        var hpassword = document.getElementById('hhpassword'); 
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        async function loginPagge() {

            var err = false; 

            if (!emailPattern.test(hemail.value)) {
                hemail.style.border = '2px solid red'; err = true; 
            } else {
                hemail.style.border = '2px solid #7cff7c';
            }

            if (hpassword.value.length <= 5) {
                hpassword.style.border = '2px solid red'; err = true; 
            } else {
                hpassword.style.border = '2px solid #7cff7c';
            }
            sharparp.push({
                title: "trylogin",
                value: "/portfolio.oo.folder/.null/index.php"
            }); 




            return;
            if (err != true) {
   
            }
        }</script>

</body>
</html>