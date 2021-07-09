<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Storage;

class LinkRapidoModel extends Authenticatable
{

    use HasFactory, Notifiable;

	protected $table = 'tb_link';

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

	public function getLink($find = null) {

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

		$traducao	= [];
		$data = [
			'titulo' => $request -> titulo,
			'slug' => limpa_string($request -> titulo),
			'descricao' => $request -> descricao,
			'link' => $request -> link,
			'status' => isset($request -> status) ? $request -> status : '0'
		];

		// Gravar o ícone do link
		$path = 'assets/embaixada/links/';
		$origName = null;
		$fileName = null;
		$imagem = null;

		if ( $request -> file('imagem') ){

			$file = $request -> file('imagem');

			$fileName = sha1($file -> getClientOriginalName());
			$fileExt  = $file -> getClientOriginalExtension();

			$imgName  = explode('.', ($file -> getClientOriginalName()));

			$origName = limpa_string($imgName[count($imgName) - 2], '_') . '.' . $fileExt;
			$imagem = limpa_string($fileName) . '.' . $fileExt;

			$file -> storeAs($path, $imagem);

		}

		foreach($_POST as $ind => $val) {

			$lang = explode(':', $ind);
			if ( count($lang) == 2) {
				$traducao[$lang[1]][$lang[0]]  = $val;
			} else {
				$traducao[$ind] = $val;
			}

		}

		if ( !is_null($imagem) )
			$data['imagem'] = $path . $imagem;

		$data['titulo'] = $traducao['titulo'];
		$data['descricao'] = !empty($traducao['descricao']) ? json_encode($traducao['descricao']) : null;

        if ( $id = $this -> insertGetId($data)) {

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

	public function edit($request, $field = null) {

		$files = [];
		$path = 'assets/embaixada/links/';
		$origName = null;
		$fileName = null;
		$imagem = null;

		if ( is_null($field) ) {

			$traducao	= [];
			$data = [
				'titulo' => $request -> titulo,
				'slug' => limpa_string($request -> titulo),
				'descricao' => $request -> descricao,
				'link' => $request -> link,
				'status' => isset($request -> status) ? $request -> status : '0'
			];

			// Gravar o ícone do link
			$path = 'assets/embaixada/links/';
			$origName = null;
			$fileName = null;
			$imagem = null;

			if ( $request -> file('imagem') ){

				$file = $request -> file('imagem');

				$fileName = sha1($file -> getClientOriginalName());
				$fileExt  = $file -> getClientOriginalExtension();

				$imgName  = explode('.', ($file -> getClientOriginalName()));

				$origName = limpa_string($imgName[count($imgName) - 2], '_') . '.' . $fileExt;
				$imagem = limpa_string($fileName) . '.' . $fileExt;

				$file -> storeAs($path, $imagem);

			}

			if ( !is_null($imagem) )
				$data['imagem'] = $path . $imagem;

			foreach($_POST as $ind => $val) {
				$lang = explode(':', $ind);
				if ( count($lang) == 2) {
					$traducao[$lang[1]][$lang[0]]  = $val;
				} else {
					$traducao[$ind] = $val;
				}
			}

			$data['titulo'] = $traducao['titulo'];
			$data['descricao'] = !empty($traducao['descricao']) ? json_encode($traducao['descricao']) : null;

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
