<?php
include_once("../co.php");
header('Content-Type: application/json');
?>

<?php 

 
$u=array();
if(isset($_POST['v']) && $_POST['v']=="1"){


    if(isset($_POST['getDatesAppointmentsSpecDate']) && isset($_POST['dateFrom'])){
        $tg=db::stmt("SELECT `hairstyle`,`image`,`hairstyle`,`rida`,`date`,`time` FROM schedulee WHERE date = '".$_POST['dateFrom']."';");
 
        $i=0;
        while($rr=mysqli_fetch_assoc($tg)){
            $rd=DateTime::createFromFormat('Ymd', $rr['date']);
 
            $u[$i]['imageUrl']=  site::url(1)."/img/".$rr['image'].".jpg?93jv"; 
            $u[$i]['datetime']= $rd->format('Y F, l jS')." ".$rr['time'];
            $u[$i]['hairname']=$rr['hairstyle'];
            $u[$i]['orderId']=$rr['rida'];
              
            $i++; 
        }
    }
    if(isset($_POST['getDatesAppointmentsMoreThanDate']) && isset($_POST['dateTo'])){
        $tg=db::stmt("SELECT `date` FROM schedulee WHERE `date` >= '".trim($_POST['dateTo'])."' LIMIT 13;");
        $i=0;
        while($rr=mysqli_fetch_assoc($tg)){
            $rd=DateTime::createFromFormat('Ymd', $rr['date']);
            $u[$i]['year']=$rd->format('Y'); 
            $u[$i]['month']=$rd->format('m');
            $u[$i]['day']=$rd->format('j');
              
            $i++; 
        }
    }
    if(isset($_POST['getweeklyStatic']) && isset($_POST['had'])){
        $tg=db::stmt("SELECT `description` FROM `availability` WHERE `namer`='weekly' AND `id`='1';");
 
        while($rr=mysqli_fetch_assoc($tg)){
            $u=json_decode($rr['description']); 
               
        }
    }
    if(isset($_POST['updatesWeekly']) && isset($_POST['ajr'])){
        $yfs="UPDATE `availability` SET `description`='".mysqli_real_escape_string(db::conn(),$_POST['updatesWeekly'])."' WHERE `namer`='weekly';";
        $tg=db::stmt($yfs);
        //echo $yfs;
        $u=array('a'=>true);
    }
    
    if(isset($_POST['receiptIIinfo']) && isset($_POST['j'])){
        $tg=db::stmt("SELECT `price`,`time`,`hairstyle`,`email`,`phonne`,`customername`,`image`  FROM `schedulee` WHERE `rida`='".$_POST['receiptIIinfo']."' ;");
        $u=mysqli_fetch_assoc($tg);
    }
    if(isset($_POST['getOverrideDates']) && isset($_POST['va'])){
        $tg=db::stmt("SELECT `description` FROM `availability` WHERE `namer`='override';");
        $u=json_decode(mysqli_fetch_assoc($tg)['description']);
    }


//
//
    if(isset($_POST['stats']) && isset($_POST['sg']) && isset($_POST['beginingOfThisMonth']) && isset($_POST['beginingOfLastMonth'])){
        $botm=trim($_POST['beginingOfThisMonth']);$botmbs=$botm+30;
        $bolm=trim($_POST['beginingOfLastMonth']); 
        $tg=db::stmt("SELECT 
        (SELECT COUNT(*) FROM `schedulee` WHERE `date` >= '$botm' AND `date` < '$botmbs') AS beginingOfThisMonth,
        (SELECT COUNT(*) FROM schedulee WHERE `date` >= '$bolm' AND `date` < '$botm') AS lastMonth,
        (SELECT COUNT(*) FROM schedulee) AS allToDate
            FROM schedulee; ");

            //
        $tg2=db::stmt("SELECT `hairstyle`,`image`, COUNT(*) AS appearance_count FROM schedulee GROUP BY `hairstyle` ORDER BY appearance_count DESC LIMIT 5");
            // 
        while($yts=mysqli_fetch_assoc($tg2)){
            $u['popularHairstyleBooked'][]=$yts; 
        }
        while($ys=mysqli_fetch_assoc($tg)){
            $u['beginingOfThisMonth']=$ys['beginingOfThisMonth'];
            $u['lastMonth']=$ys['lastMonth'];
            $u['allToDate']=$ys['allToDate'];
        }


        
    }

    //select date time
    if(isset($_POST['select_time_forDate']) &&  $_POST['getDate4Thd'] != ""){

        $thisDAte=trim($_POST['getDate4Thd']);
        
        $thisDAte_dayInWeek = strtolower(date('l', strtotime($thisDAte))); // Output: Friday

        //get override
        //[{"date": "20240510", "time": "1530"}, {"date": "20240512", "time": "1130"}]
        $tg1=db::stmt("SELECT `description` FROM `availability` WHERE `namer` = 'override' LIMIT 1");
        $overrided_fetch_assoc=json_decode(mysqli_fetch_assoc($tg1)['description']);
        //get if person booked this date
        $tg2=db::stmt("SELECT `time` FROM `schedulee` WHERE `date` = '".$thisDAte."';");
        $Persons_AlreadyBookedFot_thisDate=array();
        while($lo=mysqli_fetch_assoc($tg2)){
                $Persons_AlreadyBookedFot_thisDate[]=$lo['time'];
        } 
        //regular schedules
        //{"sunday":"1233,3413","monday":"0830, 1230","tuesday":"0837, 1230","wednesday":"0830, 1230","thursday":"0830, 1230","friday":"0830, 1230","saturday":"0830, 1230"}
        $tg3=db::stmt("SELECT `description` FROM `availability` WHERE `namer` = 'weekly' LIMIT 1;");
        $reqgularSchedule_fetch_assoc=json_decode(strtolower(mysqli_fetch_assoc($tg3)['description']));
        



       //
       //
       //when day of week "monday" isset
       if (isset($reqgularSchedule_fetch_assoc->$thisDAte_dayInWeek)) {
            $times_to_show_from_weekly=array_map('trim',explode(",",$reqgularSchedule_fetch_assoc->$thisDAte_dayInWeek));
            //$times_to_show=$get_weekly_schedule;

            //override wekly
            foreach ($overrided_fetch_assoc as $ovrrd) {
                if ($ovrrd->date === $thisDAte) {
                    //override weekly
                    $times_to_show_from_weekly= array_map('trim',explode(",",$ovrrd->time));
                    break;
                }
            }


            //times to show from weekly
            foreach($times_to_show_from_weekly as $ki=>$times){
                if(empty($times)){
                    unset($times_to_show_from_weekly[$ki]); 
                }
                
                // if user already booked
                if(in_array($times, $Persons_AlreadyBookedFot_thisDate)){
                    //remove times from times to show
                    foreach($times_to_show_from_weekly as $k=>$a ){
                        if($a == $times){
                            unset($times_to_show_from_weekly[$k]);
                            break;
                        }
                    }
               }
            };
            
            $u=$times_to_show_from_weekly;
        }
    }
    


    //select date time
    if(isset($_POST['save_contacts_64e']) && isset($_POST['co']) && isset($_POST['ord'])){
        
        $hair=array_map('trim',explode("#",$_POST['ord']));
        $contactInfo=json_decode($_POST['co']);
        $ridaa=tools::generateRandomAlphanumeric(9); 

 
        //get hairstyle from $json
        //
        $hairFromJsonDb=array();
        foreach($haiecollection as $col=>$arr){
            foreach($arr as $i=>$p){
                if(isset($p[$hair[0]])){$hairTitle=$i;$ProductInfo=$p[$hair[0]];}
            }
        }
        $explodeInfo=explode("##",$ProductInfo);
        //
        $hairFromJsonDb_img=$hair[0];
        $hairFromJsonDb_title=$hairTitle." ".$explodeInfo[0];
        $hairFromJsonDb_price=$explodeInfo[$hair[1]];
        $hairFromJsonDb_timeRange=(explode("Time - ",$explodeInfo[1])[1]);
        //
        //
		  


        $yhd="INSERT INTO `schedulee` 
        (`rida`, `email`, `phonne`, `date`, `time`, `customername`,
         `image`, `price`, `timeRange`, `hairstyle`, `haspaid`) VALUES 
         ('$ridaa', '".$contactInfo->email."', '".$contactInfo->phone."', '".$contactInfo->date."', '".$contactInfo->time."', '".$contactInfo->fullname."',
         '$hairFromJsonDb_img', '$hairFromJsonDb_price', '$hairFromJsonDb_timeRange', '$hairFromJsonDb_title', '0');";
        //echo $yhd;
         $js = db::stmt($yhd);

        $payLink=tools::stripe_Create_Dynamic_Link_for_payments($contactInfo->email, 50.00, $ridaa);
        $u['code']=301;
        $u['link']=$payLink;

    }



    
    echo json_encode($u);
}




?>