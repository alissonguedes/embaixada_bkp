<?php

namespace App\Models\Main;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BannerModel extends Model
{

    protected $table = 'tb_banner';
    use HasFactory;

    public function getBanners() {
       return $this -> all();
    }

}
