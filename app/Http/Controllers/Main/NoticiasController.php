<?php

namespace App\Http\Controllers\Main;

use App\Models\Main\NoticiaModel;

class NoticiasController extends Controller
{

    public function __construct()
    {
        $this -> noticia_model = new NoticiaModel();
    }

    public function index() {

        $dados['noticias'] = $this -> noticia_model -> getNoticia();

        return view('main.noticias.index', $dados);

    }

    public function show($id) {

        $dados['noticia'] = $this -> noticia_model -> getNoticia($id);
        $dados['noticias'] = $this -> noticia_model -> getNoticia();

        return view('main.noticias.details', $dados);

    }

}
