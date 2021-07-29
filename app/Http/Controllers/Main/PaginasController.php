<?php

namespace App\Http\Controllers\Main;

use App\Models\Main\BannerModel;
use App\Models\Main\PaginaModel;
use App\Models\Main\NoticiaModel;

class PaginasController extends Controller {

	public function __construct()
	{
		$this -> banner_model  = new BannerModel();
		$this -> pagina_model  = new PaginaModel();
		$this -> news_model = new NoticiaModel();
	}

	public function index($menu = null, $page = null) {

		$dados['pagina_model'] = $this -> pagina_model;

		$dados['paginas'] = $this;
		$pagina = $this -> pagina_model -> getPagina($menu);

		if ( isset($pagina) ) {

			$dados['row'] = $pagina;

			if ( $pagina -> tipo == 'galeria' ) {
				return $this -> fotos($pagina, $page);
			}

		}

		$dados['row'] = $this -> pagina_model -> getPagina($menu, $page);
		return view('main.paginas.index', $dados);

	}

	public function fotos($page, $album = null) {

		$dados['page'] = $page;

		$dados['albuns'] = $this -> pagina_model -> getAlbuns();
		$dados['album'] = $this -> pagina_model -> getAlbuns($album);

		if ( ! is_null($album) ) {
			return view('main.galeria.fotos', $dados);
		} else{
			return view('main.galeria.index', $dados);
		}

	}

	public function getMenus($id_menu, $id_parent = 0)
	{

		$ul = '';
		$li = '';

		$menus = $this -> pagina_model -> getSubPages($id_menu, $id_parent);

		if ($menus) {

			if ($id_parent != 0) {
				$ul .= '<div class="">';
				$ul .= '<ul class="" id="menu_pag_' . $id_parent . '">';
			} else {
				$ul .= ' <ul id="">';
			}

			foreach ($menus as $m) {
				$submenu = $this -> getMenus($id_menu, $m -> id_pagina);
				$link = $m -> id_pagina == 0 ? 'javascript:void(0);' : url($m -> link . '/' . $m -> slug);
				$ul .= '<li class="">';
				$ul .= '<a href="' . $link . '" class="lk_categs"  data-target="menu_pag_' . $m -> id_pagina . '" style="display: block;">' . tradutor($m -> titulo) . '</a>';
				$ul .= $submenu;
				$ul .= '</li>';
			}

			$ul .= $li;
			$ul .= '</ul>';

			if ($id_parent != 0) {
				$ul .= '</div>';
			}

		}

		return $ul;

	}

}
