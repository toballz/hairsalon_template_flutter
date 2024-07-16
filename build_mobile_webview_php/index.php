<?php
if(isset($_SESSION['logkin']) && $_SESSION['logkin'] == "ok" ){

}else{
    include("./login.php");
    exit();
}
$rS="0x11qq";

?><!DOCTYPE html>
<html lang="en">

<head>
    <!--
        title
        base
        favicon
        theme-color
    -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <!-- e -->
    <title> </title>
    <base href="./"/>
    <link rel="shortcut icon" href="./favicon.ico?<?php echo $rS;?>"/>
    <link rel="icon" type="image/x-icon" href="/favicon.ico?<?php echo $rS;?>"/>
    <!-- 1 -->
    <!--
    <meta content="dark" name="color-scheme">
    <meta http-equiv="refresh" content="660">
    -->
    <meta name="theme-color" content="#151d3d"/>
    <!-- a -->
    <script type="text/javascript" src="./jq.js?<?php echo $rS;?>"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css?<?php echo $rS;?>">
    <link rel="stylesheet" href="./bootstrap_5.3.3.min.css?<?php echo $rS;?>">
    <link rel="stylesheet" href="./datepicker4/css/pignose.calendar.min.css?<?php echo $rS;?>">
    <link rel="stylesheet" href="./css.css?<?php echo $rS;?>">
    <script src="./sharparp.js?<?php echo $rS;?>"></script>
    <!-- t -->
    <style type="text/css">
        input{padding-top:12px!important;padding-bottom:12px!important}.bottom-navbar{position:fixed;bottom:0;width:100%;z-index:6;justify-content:space-around}footer{margin-top:7rem}.top-navbar{position:relative}[data-pageswitchref]{display:none}.nav-item{flex:1;text-align:center}.nav-link{text-align:center;font-weight:600;flex:1}.bi{font-size:19px;padding-right:5px;padding-left:5px}.list-group.settingsj>a{padding:15px}.settingsj-sunmoon{display:flex;justify-content:space-between}.schld-days-ofweek{display:flex;align-items:center;margin-bottom:12px}.schld-days-ofweek>label{flex:0 0 100px;margin-bottom:0}.schld-days-ofweek>input{flex:1;color:#00f!important}.pignose-calendar{width:100%!important;max-width:100%}.navb-fs{font-size:12px!important}.listeceiptul{padding-left:20px;padding-right:20px}.listeceiptul>li{display:flex;margin-top:12px}.listeceiptul>li>span:first-child{flex:1;font-weight:700}.listeceiptul>li>span:nth-child(2){flex:2}
    </style>
    <script>;</script> 

</head>



<body>

    <header></header>



    <main data-pageviewer="main">

        <!-- home / view appointments   -->
        <section data-pageswitchref="viewappointment">
            <div class="container mt-5">
                <h2 style="text-align:center;">Upcoming Appointments</h2>
                <div class="mt-4" id="viewappointmentpage"></div>
                <div class="viewappointmentlist mt-5"> </div>
            </div>
        </section>



        <!-- schedules -->
        <section data-pageswitchref="schedules">
            <div class="container mt-5">
                <div class="container mt-5">

                    <!-- schedules -->
                    <!-- weekly schedules -->
                    <h2>Weekly schedules</h2>
                    <p>Leave empty for unavailability (24hrs clock)</p>

                    <div class="form-group schld-days-ofweek">
                        <label for="sunday">Sunday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="sunday" name="sunday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="monday">Monday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="monday" name="monday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="tuesday">Tuesday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="tuesday" name="monday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="wednesday">Wednesday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="wednesday" name="monday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="thursday">Thursday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="thursday" name="monday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="friday">Friday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class=" form-control" id="friday" name="monday">
                    </div>
                    <div class="form-group schld-days-ofweek">
                        <label for="saturday">Saturday:</label>
                        <input placeholder="0845, 1230, 1540, 2000, 0000" type="text" class="form-control" id="saturday" name="monday">
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mt-3 p-3 saveweeklyschedules" >Update Weekly</button>

                    <!-- schedules -->
                    <!-- override schedules -->
                    <h2 class="mt-5">Override Schedules</h2>
                    <div class="mt-4" id="overridecalendar"></div>
                    <p class="mt-4">Click a date and enter only the time(s) you will be available for that date.<br /><br />Leave empty for unavailability (24hrs clock)</p> 

                    <input type="text" placeholder="0920, 1230, 1400,1845" class="text-success form-control mb-2" id="updateoverride" name="updateoverride" />

                    <ul class="list-group overrideitemslist"> </ul>

                    <button type="submit" class="btn btn-primary w-100 mt-3 p-3 addoverridebtnclick">Add Override</button>


                </div>
            </div>
        </section>


        <!-- settings   -->
        <section data-pageswitchref="settings">
            <div class="container mt-5">
                <div class="list-group settingsj">
                    <a href="javascript:void(0);" class="list-group-item list-group-item-action settingsj-sunmoon" ">
                        <span><i class="bi bi-bell"></i> Notifications </span> <i class="bi bi-toggle-on"></i>
                    </a>

                    <br />
                    <a href="jk://159742f243a05f0733d5d6497fd3f947/eyJ0aXRsZSI6ImhyZWYiLCJ2YWx1ZSI6Imh0dHBzOi8vc3RyaXBlLmNvbS8/ZnJvbT1hcHAifQ==" class="list-group-item list-group-item-action">
                        <i class="bi bi-globe"></i> View payments - stripe.com
                    </a>
                    <a href="jk://159742f243a05f0733d5d6497fd3f947/eyJ0aXRsZSI6ImhyZWYiLCJ2YWx1ZSI6Imh0dHBzOi8vY29jb2hhaXJzaWduYXR1cmUuY29tLz9mcm9tPWFwcCJ9" class="list-group-item list-group-item-action"><i class="bi bi-globe"></i> cocohairsignature.com</a>
                    <br />

                    <div href="javascript:void(0);" class="list-group-item list-group-item-action">
                        <i class="bi bi-person"></i> <span>Change Email</span>
                        <input type="email" class="form-control mt-3" id="email" value="john@example.com" />
                        <button type="button" class="btn btn-primary mt-2">Save Email</button>
                    </div>

                    <a href="javascript:void(0);" class="list-group-item list-group-item-action">
                        <i class="bi bi-box-arrow-right"></i> Sign Out
                    </a>
                </div>
            </div>
        </section>
    </main>

  


    <footer></footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js?<?php echo $rS;?>"></script>
    <script src="./datepicker4/js/pignose.calendar.full.min.js?<?php echo $rS;?>"></script>

    <script src="./js.js?<?php echo $rS;?>"></script>
 </body>
</html>
