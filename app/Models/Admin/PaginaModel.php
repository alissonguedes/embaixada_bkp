<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Storage;

class PaginaModel extends Authenticatable
{

    use HasFactory, Notifiable;

	protected $table = 'tb_pagina';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

	private $order = [
		null,
		'descricao',
		'status',
	];

	public function getPagina($find = null) {

		$get = $this -> select('*');

		if ( !is_null($find) ) {
			$get -> where('id', $find);
			return $get ;
		}

		if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
            $get->where(function ($get) {
                $search = $_GET['search']['value'];
                $get->orWhere('id', 'like', $search . '%')
                    ->orWhere('label', 'like', $search . '%')
                    ->orWhere('status', 'like', $search . '%');
            });
        }

		// Order By
		if (isset($_GET['order']) && $_GET['order'][0]['column'] != 0 ) {
			$orderBy[$this -> order[$_GET['order'][0]['column']]] = $_GET['order'][0]['dir'];
		} else {
			$orderBy[$this -> order[1]] = 'desc';
		}

		foreach($orderBy as $key => $val) {
			$get -> orderBy($key, $val);
		}

		return $get -> paginate($_GET['length'] ?? null);

	}

	public function create($request) {

		$path = 'assets/embaixada/documentos/';
		$origName = null;
		$fileName = null;
		$arquivo = null;

		$traducao	= [];
		$data = [
			'id_pagina' => isset($request -> grupo) ? $request -> grupo : 0,
			'id_menu' => $request -> menu,
			'descricao' => $request -> descricao,
			'slug' => limpa_string($request -> descricao),
			'titulo' => null,
			'subtitulo' => null,
			'texto'		=> null,
			'idioma'	=> $request -> idioma,
			'status' => isset($request -> status) ? $request -> status : '0'
		];

		foreach($_POST as $ind => $val) {

			$lang = explode(':', $ind);
			if ( count($lang) == 2) {
				$traducao[$lang[1]][$lang[0]]  = $val;
			}

		}

		if ( !is_null($arquivo) )
			$data['arquivo'] = $path . $arquivo;

		$data['titulo'] = json_encode($traducao['titulo']);
		$data['subtitulo'] = json_encode($traducao['subtitulo']);
		$data['texto'] = json_encode($traducao['texto']);

        if ( $id = $this -> insertGetId($data)) {

			if ( $request -> file('arquivo') ) {

				$file = $request -> file('arquivo');

				foreach ( $file as $f ) {

					$fileName = $f -> getClientOriginalName();
					$fileExt  = $f -> getClientOriginalExtension();
					$fileExt  = $fileExt != '' ? '.' . $fileExt : '.txt';

					$imgName  = explode('.', ($f -> getClientOriginalName()));

					$origName = limpa_string($imgName[count($imgName) - 2 > 0 ? count($imgName) - 2 : 0], '_') . $fileExt;
					$arquivo = uniqid(sha1(limpa_string($fileName))) . $fileExt;

					$f -> storeAs($path, $arquivo);

					$files[] = [
						'id_modulo' => $id,
						'modulo' => 'page',
						'path' => $path . $arquivo,
						'realname' => $origName,
						'author' => Session::get('userdata')['nome'],
						'titulo' => null,
						'descricao' => null,
						'clicks' => 0,
						'url' => null,
						'size' => $f -> getSize()
					];

				}

				$this -> from('tb_attachment') -> insert($files);

			}

			return true;

        }

		return false;

	}

	public function getAttach($id) {

		return $this -> select('*')
			-> from('tb_attachment')
			-> where('id_modulo', $id)
			-> where('modulo', 'page')
			-> orderBy('realname')
			-> get();

	}

	public function getGrupo($id = null) {
		$pag = $this -> select('id', 'id_pagina', 'descricao')
			-> from('tb_pagina');

		if ( ! is_null($id) ) $pag -> where('id', '<>', $id);

		return $pag -> get();
	}

	public function edit($request, $field = null) {

		$files = [];
		$path = 'assets/embaixada/documentos/';
		$origName = null;
		$fileName = null;
		$arquivo = null;

		if ( is_null($field) ) {

			if ( $request -> file('arquivo') ) {

				$file = $request -> file('arquivo');

				foreach ( $file as $f ) {

					$fileName = $f -> getClientOriginalName();
					$fileExt  = $f -> getClientOriginalExtension();
					$fileExt  = $fileExt != '' ? '.' . $fileExt : '.txt';

					$imgName  = explode('.', ($f -> getClientOriginalName()));

					$origName = limpa_string($imgName[count($imgName) - 2 > 0 ? count($imgName) - 2 : 0], '_') . $fileExt;
					$arquivo = uniqid(sha1(limpa_string($fileName))) . $fileExt;

					$f -> storeAs($path, $arquivo);

					$files[] = [
						'id_modulo' => $request -> id,
						'modulo' => 'page',
						'path' => $path . $arquivo,
						'realname' => $origName,
						'author' => Session::get('userdata')['nome'],
						'titulo' => null,
						'descricao' => null,
						'clicks' => 0,
						'url' => null,
						'size' => $f -> getSize()
					];

				}

				$this -> from('tb_attachment') -> insert($files);

			}

			if ( isset($request -> album)){

				foreach($request -> album as $album) {

					$issetAlbum = $this -> from('tb_pagina_album') -> select('id') -> where('id_album', $album) -> where('id_pagina', $request -> id) -> get() -> first();

					if ( ! isset($issetAlbum) ) {
						$this -> from('tb_pagina_album') -> insert(['id_pagina' => $request -> id, 'id_album' => $album]);
					}

				}

				$this -> from('tb_pagina_album') -> whereNotIn('id_album', $request -> album) -> where('id_pagina', $request -> id) -> delete();

			}

			$traducao	= [];
			$data = [
				'id_pagina' => isset($request -> grupo) ? $request -> grupo : 0,
				'id_menu' => $request -> menu,
				'tipo' => $request -> tipo_pagina ?? 'post',
				'descricao' => $request -> descricao,
				'slug' => limpa_string($request -> descricao),
				'titulo' => null,
				'subtitulo' => null,
				'texto'		=> null,
				'idioma'	=> $request -> idioma,
				'status' => isset($request -> status) ? $request -> status : '0'
			];

			foreach($_POST as $ind => $val) {
				$lang = explode(':', $ind);
				if ( count($lang) == 2) {
					$traducao[$lang[1]][$lang[0]] = $val;
				}
			}

			$data['titulo'] = json_encode($traducao['titulo']);
			$data['subtitulo'] = json_encode($traducao['subtitulo']);
			$data['texto'] = json_encode($traducao['texto']);

			return $this -> where('id', $request -> id) -> update($data);

		} else {

			$data = [ $field =>  $request -> value ];

			return $this -> whereIn('id', $request -> id) -> update($data);

		}

	}

	public function remove($request) {

		$this -> remove_file($request -> id);
		return $this -> whereIn('id', $request -> id) -> delete();

	}

	public function remove_file($id) {

		if ( is_array($id) ) {
			$column = 'id_modulo';
		} else {
			$column = 'id';
		}

		$files = $this -> from('tb_attachment')
			-> select('path')
			-> where($column, $id)
			-> get();

		if ( isset($files) )
		{

			foreach ( $files as $file ) {

				$file = public_path($file -> path);

			}

			$un = file_exists($file) ? unlink($file) : true;

			if ( $un )
				return $this -> from('tb_attachment') -> where($column, $id) -> delete();

			return true;

		}

		return false;

	}

}
