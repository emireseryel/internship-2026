<?php
$students = array(
    array("Ali",80,72,68,54,88),
    array("Yaren",100,54,82,76,56),
    array("Azra",62,82,77,58,65),
    array("Erdem",75,66,70,92,80),
    array("Efe",82,70,58,65,70),            //create two dimensional array
    array("Arda",64,57,80,66,72),
    array("Gözde",92,65,84,76,88),
    array("Kemal",100,85,82,70,94),
    array("Can",72,100,77,90,82),
    array("Ela",54,69,72,66,82)
);

$avg;
for($i=0;$i<10;$i++){
    $total=0;
    for($j=1;$j<6;$j++){
        $total=$total+$students[$i][$j];    //calculate avg for each student
    }
    $avg[$i][0]=$students[$i][0];
    $avg[$i][1]=$total/5;
}

for($i=0;$i<10;$i++){
    echo $avg[$i][0]."'s average = ".$avg[$i][1]."<br>";    // display students averages
}

$totalGrades=0;
for($i=0;$i<10;$i++){
    $totalGrades=$totalGrades+$avg[$i][1];      //calculate sum of each avg
}
$totalAvg=$totalGrades/10;                      //calculate total average

echo "<br>Average of all students= ". $totalAvg ."<br> <br>";   //display total average


$passed=[];
$failed=[];
$count=0;
for($i=0;$i<10;$i++){
    if($avg[$i][1]>=$totalAvg){
        array_push($passed,$avg[$i][0]);
    }else{                                      //check if the student passed 
        array_push($failed,$avg[$i][0]);
    }
}

foreach($passed as $student){
    echo $student . " PASSED. <br>";            
}                                               //display students that passed and failed
foreach($failed as $student){
    echo $student . " FAILED. <br>";
}
?>