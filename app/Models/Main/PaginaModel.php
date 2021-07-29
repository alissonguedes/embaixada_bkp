<?php

namespace App\Models\Main;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class PaginaModel extends Model
{

	protected $table = 'tb_pagina';
	use HasFactory;

	public function getPagina($menu = null, $subpage = null, $idioma = null) {

		$get = $this -> select(
			'P.id',
			'P.id_menu',
			'P.tipo',
			'P.descricao AS titulo_principal',
			'P.slug',
			'P.titulo',
			'P.subtitulo',
			'P.texto',
			'P.arquivo',
			'P.created_at',
			'P.updated_at',
			'P.idioma',
			'M.link',
			'M.label'
		);

		$get -> from('tb_pagina AS P')
			 -> join('tb_acl_menu AS M', 'M.id', '=', 'P.id_menu')
			 -> where('P.status', '1');


		if ( ! is_null($subpage) ) {
				$get -> where('M.link', $menu);
				$get -> where('P.slug', $subpage);
		} else {
			$get -> where('M.link', $menu);
		}

		if ( ! is_null($this -> limit) ) $get -> limit($this -> limit);

		$this -> orderBy('date_time', 'desc');

		if ( ! is_null($menu) ) {

			if( is_numeric($menu) ){
				$get -> where('P.id', $menu);
			}

			return $get -> first();

		}

		return $get -> get();

	}

	public function getSubPages($id_menu, $page = null, $idioma = null) {

		$get = $this -> select('P.id AS id_pagina', 'P.id_menu', 'M.link', 'P.id_pagina AS id_parent', 'P.titulo', 'P.descricao AS titulo_principal', 'P.slug')
						-> from('tb_pagina AS P')
						-> join('tb_acl_menu AS M', 'M.id', '=', 'P.id_menu')
						-> where('P.status', '1');

		$get -> where('P.id_menu', $id_menu);

		$page = ! is_null($page) ? $page : 0;
		$get -> where('P.id_pagina', $page);

		if ( !is_null($this -> limit) ) $get -> limit($this -> limit);

		$this -> orderBy('date_time', 'desc');

		return $get -> get();

	}

	public function getPost($post, $id) {

		return $this -> where('lang', $_COOKIE['idioma'] ?? get_config('language'))
					-> where('titulo_slug', $post)
					-> where('id', $id) -> first();

	}

	public function getAlbuns($album = null) {

		$get = $this-> select('id', 'nome', 'slug', 'titulo', 'descricao', 'imagem', 'created_at', 'updated_at')
					-> from ('tb_album AS A')
					-> where('status', '1');

		if ( !is_null($album) )
			return $get -> where('slug', $album)
						-> first();

		$get -> orderBy('created_at', 'desc');

		return $get -> get();

	}

	public function getUltimosAlbuns($limit = 3) {

		return $this -> select('id', 'nome', 'slug', 'titulo', 'descricao', 'imagem', 'created_at', 'updated_at')
					 -> from ('tb_album AS A')
					 -> where('status', '1')
					 -> limit($limit)
					 -> orderBy('created_at', 'desc')
					 -> get();

	}

	public function getFotos($id_album) {

		return $this
					-> select('F.id', 'F.titulo', 'F.descricao', 'F.path', 'F.author')
					-> from ('tb_attachment AS F')
					-> join('tb_album AS A', 'A.id', '=', 'F.id_modulo')
					-> where('A.status', '1')
					-> where('A.slug', $id_album)
					-> where('F.modulo', 'album')
					-> orderBy('F.created_at', 'desc')
					-> get();

	}

	public function getMenus() {

		return $this -> select('label', 'traducao', 'link') -> from('tb_acl_menu') -> where('id_secao', '2') -> where('status', '1') -> get();

	}

}
