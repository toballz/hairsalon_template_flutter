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
        $tg=db::stmt("SELECT `date` FROM schedulee WHERE date >= '".$_POST['dateTo']."' LIMIT 13;");
 
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
    
    if(isset($_POST['receiptIIinfo']) && isset($_POST['j'])){
        $tg=db::stmt("SELECT `price`,`time`,`hairstyle`,`email`,`phonne`,`customername`,`image`  FROM `schedulee` WHERE `rida`='".$_POST['receiptIIinfo']."' ;");
        $u=mysqli_fetch_assoc($tg);
    }
    if(isset($_POST['getOverrideDates']) && isset($_POST['va'])){
        $tg=db::stmt("SELECT `description` FROM `availability` WHERE `namer`='override';");
        $u=json_decode(mysqli_fetch_assoc($tg)['description']);
    }






    
    echo json_encode($u);
}




?>