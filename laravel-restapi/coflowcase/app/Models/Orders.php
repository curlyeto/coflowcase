<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orders extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'id',
        'user_id',
        'order_quantity',
        'order_date'
    ];
}
