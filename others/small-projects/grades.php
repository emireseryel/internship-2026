<?php
$students = [
    "Ali"=>[80,72,68,54,88],
    "Yaren"=>[100,54,82,76,56],
    "Azra"=>[62,82,77,58,65],
    "Erdem"=>[75,66,70,92,80],
    "Efe"=>[82,70,58,65,70],            //create two dimensional array
    "Arda"=>[64,57,80,66,72],
    "Gözde"=>[92,65,84,76,88],
    "Kemal"=>[100,85,82,70,94],
    "Can"=>[72,100,77,90,82],
    "Ela"=>[54,69,72,66,82]
];

$student_avg=[];
$total_avg_grades=0;
foreach($students as $name=>$grades){   
    $avg=array_sum($grades)/count($grades);                 //calculate avg for each student
    $total_avg_grades+=$avg;                                //calculate sum of each avg
    $student_avg+=["$name"=>($avg)];                        //add key-value to array
    
    echo $name."'s average = ".$student_avg[$name]."<br>";          //display students and averages
}

$total_avg=$total_avg_grades/count($student_avg);
echo "<br>Average of all students= ". $total_avg ."<br> <br>";      //calculate sum of each avg

$passed=[];
$failed=[];

foreach($student_avg as $name=>$avg){
    if($avg>=$total_avg){
        array_push($passed,$name);
    }else{                                      //check if the student passed 
        array_push($failed,$name);
    }
}

foreach($passed as $student){
    echo $student . " PASSED. <br>";            
}                                               //display students that passed and failed
foreach($failed as $student){
    echo $student . " FAILED. <br>";
}
?>