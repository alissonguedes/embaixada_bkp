<?php

namespace App\Http\Controllers\Main;

use Illuminate\Http\Request;
use App\Models\Admin\MenuModel;
use App\Models\Main\NoticiaModel;

class NoticiasController extends Controller
{

    public function __construct()
    {
		$this -> menu_model = new MenuModel();
        $this -> noticia_model = new NoticiaModel();
    }

    public function index(Request $request) {

		$dados['title']   = $this -> menu_model -> getTitulo(basename($request -> url('/')));
        $dados['row'] = $this -> noticia_model -> getNoticia();

        return view('main.noticias.index', $dados);

    }

    public function show(Request $request, $id) {

		$url = $request -> url();
		$title = explode('/', $url);
		$title = $title[count($title) - 2];

		$dados['title']   = $this -> menu_model -> getTitulo($title);
        $dados['row'] = $this -> noticia_model -> getNoticia($id);
        $dados['noticias'] = $this -> noticia_model -> getNoticia();

        return view('main.noticias.details', $dados);

    }

}
