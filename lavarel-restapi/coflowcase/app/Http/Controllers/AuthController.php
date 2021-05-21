<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function signIn(Request $request){
        $user = User::where('username', $request->username)->where('password',$request->password)->first();
        if($user){
            return response()->json(['result_code'=> "1", 'user_id'=> $user->id,"result_desc"=> "Giriş yapma işlemi başarılı"], 200);
        }else{
            return response()->json(['result_code'=> "0", "result_desc"=> "Kullanıcı adi veya şifre yanlış"], 404);
        }
    }
}
