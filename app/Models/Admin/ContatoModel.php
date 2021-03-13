<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class ContatoModel extends Authenticatable
{

    use HasFactory, Notifiable;

	protected $table = 'tb_sys_config';

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

	public function getContato($find = null) {

		$get = $this -> select('*');

		if ( !is_null($find) ) {
			$get -> where('id', $find);
			return $get ;
		}

		if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
            $get->where(function ($get) {
                $search = $_GET['search']['value'];
                $get->orWhere('id', 'like', $search . '%')
                    ->orWhere('descricao', 'like', $search . '%')
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

		$path = 'assets/embaixada/img/paginas/';
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

		$traducao	= [];

		foreach($_POST as $ind => $val) {

			$data = ['config' => $ind, 'value' => $val];

			$issetConfig = $this -> select('config', 'value') -> where('config', $ind) -> first();

			if( isset($issetConfig) ) {

				if ( $val !== $issetConfig -> value)
					$this -> where('config', $ind) -> update($data);

			} else {

				$this -> insert($data);

			}

		}

		return true;

	}

}
