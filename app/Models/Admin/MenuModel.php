<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class MenuModel extends Authenticatable
{

    use HasFactory, Notifiable;

	protected $table = 'tb_acl_menu';

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
		'label',
		'status',
	];

	public function getMenu($find = null) {

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

	public function getTitulo($link) {

		$get = $this -> select('*');

		$get -> where('link', $link);
		return $get -> get() -> first();

	}

	public function create($request) {

		$label		= $request -> label;
		$link		= limpa_string($request -> label);
		$status		= isset($request -> status) ? $request -> status : '0';
		$editavel	= isset($request -> editavel) ? $request -> editavel : ( Session::get('userdata')['id_grupo'] === '1' ? '0' : '1' );

		$traducao	= [];

		foreach($_POST as $ind => $val) {
			$lang = explode(':', $ind);
			if ( count($lang) == 2) {
				$traducao[$lang[1]] = $val;
			}
		}

		$data = [
			'label' => $label,
			'traducao' => json_encode($traducao),
			'id_palavra' => 0,
			'id_secao' => 2,
			'link' => $link,
			'status' => $status,
			'editavel' => $editavel
		];

		return $this -> insert($data);

	}

	public function edit($request, $field = null) {

		if ( is_null($field) ) {

			$get = $this -> select('editavel') -> where('id', $request -> id) -> first();

			$id			= $request -> id;
			$label		= Session::get('userdata')['id_grupo'] === 1 || ( Session::get('userdata')['id_grupo'] > 1 && $get -> editavel === '1' ) ? $request -> label : null;
			$link		= limpa_string($request -> label);
			$status		= isset($request -> status) ? $request -> status : '0';
			$editavel	= isset($request -> editavel) ? $request -> editavel : '0';

			$traducao	= [];

			foreach($_POST as $ind => $val) {
				$lang = explode(':', $ind);
				if ( count($lang) == 2) {
					$traducao[$lang[1]] = $val;
				}
			}

			if ( !is_null($label))
				$data['label'] = $label;
			$data['traducao'] 	= json_encode($traducao);
			$data['id_palavra'] = 0;
			$data['id_secao'] 	= 2;
			$data['link'] 		= $link;
			$data['status'] 	= $status;
			$data['editavel'] 	= $editavel;

			return $this -> where('id', $id) -> update($data);

		} else {

			$data = [ $field =>  $request -> value ];

			return $this -> whereIn('id', $request -> id) -> update($data);

		}

	}

	private $error;

	public function setError($error) {

		switch($error) {

			case 'user_not_allowed' :
				$this -> error = 'Você não possui permissão para remover alguns itens.';
				break;

			default :
				$this -> error = 'Não foi possível remover o menu. Por favor, tente novamente.';
				break;
		}

	}

	public function getMessage() {
		return $this -> error;
	}

	public function remove($request) {

		$editavel = $this -> select('editavel') -> whereIn('id', $request -> id) -> get();

		$i = 0;
		foreach($editavel as $e ){
			if ( $e -> editavel === '1' ){
				$this -> whereIn('id', $request -> id) -> delete();
				$i ++;
			} else {
				$this -> setError('user_not_allowed');
			}
		}

		if ($i > 0 ) return true;

		return false;

	}

}
