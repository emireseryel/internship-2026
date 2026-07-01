<?php
$numbers=[];
for($i=0;$i<10;$i++){
    array_push($numbers,rand(0,30));        //create an array with 10 random numbers from 0 to 30
}

echo "Unsorted array : ";
foreach($numbers as $number){               //display original array
    echo $number.", ";
}

$sorted=$numbers;                           //copy original array to sorted array
for($i=0;$i<10;$i++){
    for($j=$i+1;$j<10;$j++){
        if($sorted[$i]<$sorted[$j]){
            $temp=$sorted[$i];              //sort the elements in array by bubblesort
            $sorted[$i]=$sorted[$j];
            $sorted[$j]=$temp;
        }
    }
}
echo "<br> Sorted array : ";
foreach($sorted as $number){                //display sorted array
    echo $number.", ";
}

rsort($numbers);                            //usage of rsort
echo "<br> Sorted array via rsort : ";  
foreach($numbers as $number){               //display sorted array
    echo $number.", ";
}

?>