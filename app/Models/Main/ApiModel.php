<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiModel extends Model
{

    protected $table = '';
    use HasFactory;

    public function getBanners() {
       return $this -> all(); 
    }

    public function getTranslate($lang) {

        return $this -> from('tb_sys_linguagem_traducao') -> where('lang_abr', $lang) -> get();

    }

}
