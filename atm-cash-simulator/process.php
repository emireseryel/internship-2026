<?php
if ($_SERVER["REQUEST_METHOD"] == "POST"){
    $amount = $_POST['withdraw-amount'];
    if(empty($amount)||($amount%5!=0)){
        echo "Lütfen geçerli bir değer girin.";
        exit;   
    }else{
        $banknotes = [200,100,50,20,10,5];
        $counts = [];
        for($i=0;$i<6;$i++){
            $count = (int) ($amount/$banknotes[$i]);
            $counts[$i]=$count;                         
            if($count>0){
                    echo $count." Tane ".$banknotes[$i]." TL <br>";   
            }
            $amount = $amount-($count*$banknotes[$i]);
        }
    }
}

?>