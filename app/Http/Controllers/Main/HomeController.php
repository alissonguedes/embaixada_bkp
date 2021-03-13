<?php

namespace App\Http\Controllers\Main;

use App\Models\Main\BannerModel;
use App\Models\Main\PaginaModel;
use App\Models\Main\NoticiaModel;

class HomeController extends Controller
{

    public function __construct()
    {
        $this -> banner_model  = new BannerModel();
        $this -> page_model  = new PaginaModel();
        $this -> noticia_model = new NoticiaModel();
    }

    public function index() {

        $dados['banners'] = $this -> banner_model -> getBanners();
        $dados['destaques'] = $this -> noticia_model -> getDestaques();
        return view('main.home.index', $dados);

    }

}
