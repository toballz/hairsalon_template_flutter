<?php //include_once("./conf.php"); 
      /*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
      */                 
//echo(mail("toballz@yahoo.com","dhgfjhgkjhfd dasfd","ytrgthyjkujhdsfdg"));
 
 //     $_SESSION[session::userArrayNameKey]['id']=5462;
//<pre><?php print_r($_SESSION); </pre>
?>
<?php
session_start();
header('Content-Type: application/json');
class db{
    const servername = "localhost"; 
    const username = "root";
    const password = "";
    const dbname = "cocohairsignature";
    // Create a connection
    static function conn(){
        $rr= new mysqli(self::servername, self::username, self::password, self::dbname);
        if($rr->connect_error){
            die("Connection err: ");
        }else{return $rr;}
    }
    static function stmt($stm){
        return mysqli_query(self::conn(), $stm);
    }
} 
?>

<?php 

 
$u=array();
if(isset($_POST['v']) && $_POST['v']=="1"){


    if(isset($_POST['getDatesAppointmentsSpecDate']) && isset($_POST['dateFrom'])){
        $tg=db::stmt("SELECT `hairstyle`,`image`,`hairstyle`,`rida`,`date`,`time` FROM schedulee WHERE date = '".$_POST['dateFrom']."';");
 
        $i=0;
        while($rr=mysqli_fetch_assoc($tg)){
            $rd=DateTime::createFromFormat('Ymd', $rr['date']);
 
            $u[$i]['imageUrl']=  "https://cocohairsignature.com/img/".$rr['image'].".jpg?93jv"; 
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


    
    echo json_encode($u);
}




?>