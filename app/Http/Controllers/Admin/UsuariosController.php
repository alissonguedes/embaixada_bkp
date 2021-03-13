<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

use \App\Models\Admin\UsuarioModel;

class UsuariosController extends Controller
{

	public function __construct() {

		$this -> usuario_model = new UsuarioModel();

	}

	public function index(Request $request) {

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		return view('admin.usuarios.index');

	}

}
