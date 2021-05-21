<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/assets/product/media/images/20191007/22/337969/56988875/11/11_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/assets/product/media/images/20191007/22/337969/56988875/2/2_org.jpg",
            'title' => "Samsung Galaxy M30s (Çift SIM) Karbon Siyahı",
            'price' => 3.299,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty12/product/media/images/20200914/18/10641289/86454582/3/3_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty12/product/media/images/20200914/18/10641289/86454582/3/3_org.jpg",
            'title' => "Samsung Galaxy M51 128 GB (Samsung Türkiye Garantili)",
            'price' => 3.679,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty10/product/media/images/20200818/16/8287076/81852299/2/2_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty10/product/media/images/20200818/16/8287076/81852299/3/3_org.jpg",
            'title' => "Samsung Galaxy S21 Plus 5G",
            'price' => 11.740,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty97/product/media/images/20210404/01/e6bb4bec/36095446/3/3_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty98/product/media/images/20210404/01/095c7060/36095446/1/1_org.jpg",
            'title' => "Samsung Galaxy Note10+ Star Wars Special Edition",
            'price' => 12.869,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty38/product/media/images/20201222/17/40861773/113184509/1/1_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty37/product/media/images/20201222/17/40861783/113184509/1/1_org.jpg",
            'title' => "Apple iPhone 12 Pro (512 GB)",
            'price' => 16.749,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty9/product/media/images/20200821/16/8554684/57616589/1/1_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty10/product/media/images/20200821/16/8554684/57616589/2/2_org.jpg",
            'title' => "Apple iPhone 11 Pro Max (512 GB)",
            'price' => 17.745,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty24/product/media/images/20201114/10/25968524/105701511/2/2_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty23/product/media/images/20201114/10/25968524/105701511/4/4_org.jpg",
            'title' => "Monster Semruk S7 V7.1.1 Notebook",
            'price' => 28.699,
        ]);
        DB::table('products')->insert([
            'image' => "https://cdn.dsmcdn.com/ty94/product/media/images/20210405/20/b7d8a95f/63244132/2/2_org.jpg",
            'image1' => "https://cdn.dsmcdn.com/ty96/product/media/images/20210405/20/4f812e55/63244132/4/4_org.jpg",
            'title' => "MSI Prestige 15 A10SC-251TR Notebook",
            'price' => 22.722,
        ]);
    }
}
