<?php

namespace App\Http\Controllers;

use App\Models\BasketItems;
use App\Models\Products;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function getProducts(){
        $products=Products::all();
        $productList=array();
        foreach ($products as $index => $item) {
            array_push($productList,[
                "id"=> $item->id,
                "images"=> [ $item->image,$item->image1,],
                "title"=> $item->title,
                "price"=> $item->price,
            ]);
        }

        return response()->json(['result_code'=> "1","products"=>$productList], 200);
    }

}
