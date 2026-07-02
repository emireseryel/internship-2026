<?php
interface PaymentMethodInterface{               //interface that used by payment methods
    public function pay(float $amount):bool;
}

class Product {                                 //class that contains product info
    private string $name;
    private float $price;

    public function getPrice(){
        return $this->price;
    }

    public function __construct(string $name,float $price){     
        $this->isValidPrice($price);
        $this->name=$name;
        $this->price=$price;
    }

    private function isValidPrice($price):void{                 //check if price is 0 or negative
        if($price<=0){
            throw new \Exception('Price is not vaild.');
        }
    }
}

class CreditCardPayment implements PaymentMethodInterface{      
    public function pay(float $amount):bool{
        echo "The payment was {$amount} via Credit Card.<br>";      
        return true;
    }
}

class CryptoPayment implements PaymentMethodInterface{
    public function pay(float $amount):bool{
        echo "The payment was {$amount} via Crypto.<br>";
        return true;
    }
}

class ShoppingCart{                                             
    private array $products;

    public function __construct()                   //inital constructure
    {
        $this->products=[];
    }

    public function addProduct(Product $product):void{      //add item to basket
        array_push($this->products,$product);
    }

    public function calculateTotal():float{                 //calc total prices
        $total=0;
        foreach($this->products as $product){
            $total+=$product->getPrice();
        }
        return $total;
    }

    public function checkout(PaymentMethodInterface $paymentMethod):void{   
        $total = $this->calculateTotal();
        if(empty($this->products) || $total<=0){                       
            return;
        }
        $paymentMethod->pay($total);                        //payment wrt which method used.
    }
}


$p1 = new Product("Klavye", 1500);
$p2 = new Product("Mouse", 800);


$cart = new ShoppingCart();
$cart->addProduct($p1);
$cart->addProduct($p2);


$creditCard = new CreditCardPayment();
$cart->checkout($creditCard); 



$crypto = new CryptoPayment();
$cart->checkout($crypto);

?>

