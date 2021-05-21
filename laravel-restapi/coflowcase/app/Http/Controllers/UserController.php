<?php

namespace App\Http\Controllers;

use App\Models\BasketItems;
use App\Models\OrderItems;
use App\Models\Orders;
use App\Models\Products;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function getMyBasket($id){

        try {
            $baskets = BasketItems::where('user_id',$id)->get();
            $basketList=array();
            foreach ($baskets as $index => $item) {
                $products = Products::where('id',$item->product_id)->get();
                foreach ($products as $index1 => $item1) {
                    array_push($basketList,[
                        "id"=> $item1->id,
                        "images"=> [ $item1->image,$item1->image1,],
                        "title"=> $item1->title,
                        "price"=> $item->quantity,
                        "count"=>$item->quantity/$item1->price
                    ]);
                }

            }

            return response()->json(['result_code'=> "1","baskets"=>$basketList], 200);
        } catch (\Exception $e) {

            return $e->getMessage();
        }

    }
    public function addBasket(Request $request){
        $basket = BasketItems::where('user_id',$request->user_id)->where('product_id',$request->product_id)->first();
        if($basket){
            $basket->quantity= $basket->quantity+$request->quantity;
            $basket->save();
            return response()->json(['result_code'=> "1", 'basket_id'=> $basket->id,"result_desc"=> "Sepetteki ürün güncellendi"],201, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'],
                JSON_UNESCAPED_UNICODE);
        }else{
            $basket1=new BasketItems();
            $basket1->product_id=$request->product_id;
            $basket1->user_id=$request->user_id;
            $basket1->quantity=$request->quantity;
            $basket1->save();
            return response()->json(['result_code'=> "1", 'basket_id'=> $basket1->id,"result_desc"=> "Ürün sepete başarılı şekilde eklendi"],201, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'],
                JSON_UNESCAPED_UNICODE);
        }


    }
    public function addOrder(Request $request){
        date_default_timezone_set("Europe/Istanbul");
        $order=new Orders();
        $order->user_id=$request->user_id;
        $order->order_quantity=$request->order_quantity;
        $order->order_date=date("d.m.Y H:i:s");
        $order->save();
        if($order){
            for($i=0;$i<count($request->oderItems);$i++){
                $orderItems=new OrderItems();
                $orderItems->order_id=$order->id;
                $orderItems->product_id=$request->oderItems[$i]['product_id'];
                $orderItems->quantity=$request->oderItems[$i]['quantity'];
                $orderItems->save();
            }
            BasketItems::where('user_id',$request->user_id)->delete();
            return response()->json(['result_code'=> "1", 'order_id'=> $order->id,"result_desc"=> "Ürün şipariş işlemi başarılı"],201, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'],
                JSON_UNESCAPED_UNICODE);
        }
    }
    public function getUserInfo($id){
        $user = User::where('id',$id)->first();
        return response()->json($user,201, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'],
            JSON_UNESCAPED_UNICODE);
    }
    public function getMyOrders($id){
        $orderList=array();


        $orders = Orders::where('user_id',$id)->get();
        foreach ($orders as $index => $item) {
            $orderItems=OrderItems::where('order_id',$item->id)->get();
            $orderimge=array();
            $orderDetailList=array();
            foreach ($orderItems as $index1 => $item1) {
                $products = Products::where('id',$item1->product_id)->first();
                array_push($orderimge, $products->image);
                array_push($orderDetailList,[
                    "id"=> $products->id,
                    "image"=> $products->image,
                    "title"=> $products->title,
                    "price"=> $products->price,
                ]);
            }
            array_push($orderList,[
                "id"=> $item->id,
                "product_images"=> $orderimge,
                "order_date"=> $item->order_date,
                "order_quantity"=> $item->order_quantity,
                "order_count"=>count($orderDetailList),
                "order_products"=>$orderDetailList
            ]);
        }
        return response()->json(['result_code'=>'1','orders'=>$orderList],200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'],
            JSON_UNESCAPED_UNICODE);
    }
}
