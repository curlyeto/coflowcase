<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/



Route::post('user/login',[AuthController::class,'signIn']);
Route::get('user/getmybasket/{id}',[UserController::class,'getMyBasket']);
Route::get('user/info/{id}',[UserController::class,'getUserInfo']);
Route::post('user/addbasket',[UserController::class,'addBasket']);
Route::post('user/addorder',[UserController::class,'addOrder']);
Route::get('user/myorders/{id}',[UserController::class,'getMyOrders']);
Route::get('product/products',[ProductController::class,'getProducts']);

