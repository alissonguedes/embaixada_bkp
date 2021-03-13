<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class UsuarioModel extends Authenticatable
{
    use HasFactory, Notifiable;

	protected $table = 'tb_acl_usuario';

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

	public function getUser($find = null) {

		if ( !is_null($find) ) {

			foreach ($find as $ind => $val) {
				$this -> where($ind, $val);
			}

		}

		return $this -> select('*') -> first();
	}

	public function auth($login = null, $senha = null) {

		if ( ! is_null($login) ) {

			$user = $this -> select('id', 'id_grupo', 'senha', 'permissao', 'nome', 'login', 'email', 'senha')
						   -> where('login', $login)
						   -> orWhere('email', $login)
						   -> first();

			if ( isset($user) ) {

				Session::put('id', $user -> id);
				Session::put('id_grupo', $user -> id_grupo);
				Session::put('senha', $user -> senha);
				Session::put('permissao', $user -> permissao);

				Session::put('userlogin', ['nome' => $user -> nome, 'login' => $user -> login, 'email' => $user -> email]);

				return true;

			}

		}

		if ( ! is_null($senha) ) {

			if ( Session::has('senha') && hashCode($senha) === Session::get('senha') ) {

				$session = Session::get('userlogin');
				$session['id'] = Session::get('id');
				$session['id_grupo'] = Session::get('id_grupo');
				$session['permissao'] = Session::get('permissao');

				$token = hashCode(dirname($_SERVER['REQUEST_URI']) . time());

				Session::put('userdata', $session);
				Session::put('app_session', $token);

				Session::forget(['userlogin', 'id', 'id_grupo', 'senha', 'permissao', 'login', 'email']);

				return true;

			}

		}

		return false;

	}

}
