<?php

namespace App\Http\Controllers\Main;

use App\Models\Main\BannerModel;
use App\Models\Main\PaginaModel;
use App\Models\Main\NoticiaModel;

class PaginasController extends Controller
{

    public function __construct()
    {
        $this -> banner_model  = new BannerModel();
        $this -> pagina_model  = new PaginaModel();
        $this -> news_model = new NoticiaModel();
    }

    public function index($menu = null, $page = null) {

		$dados['pagina_model'] = $this -> pagina_model;
        $dados['row'] = $this -> pagina_model -> getPagina($menu, $page);

        return view('main.paginas.index', $dados);

    }

    public function fotos($album = null) {

		$dados['pagina_model'] = $this -> pagina_model;
        $dados['albuns'] = $this -> pagina_model -> getAlbuns();
        $dados['album'] = $this -> pagina_model -> getAlbuns($album);

        if ( ! is_null($album) ) {
            return view('main.galeria.fotos', $dados);
        } else{
            return view('main.galeria.index', $dados);
        }


    }

}
