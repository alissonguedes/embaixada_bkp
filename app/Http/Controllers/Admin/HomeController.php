<?php

namespace App\Http\Controllers\Admin {

	use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Session;

	use \App\Models\Admin\UsuarioModel;

	class HomeController extends Controller {

		public function index(Request $request) {

			if ( ! Session::has('userdata')) {
				if ( $request -> ajax() )
					return abort(403);
				else
					return redirect() -> route('admin.auth.login');
			}

			$dados['total_banners'] = 0;
			$dados['total_categorias'] = 0;
			$dados['total_produtos'] = 0;
			$dados['total_intencoes'] = 0;
			$dados['total_distribuidores'] = 0;
			$dados['total_emails'] = 0;

			return response(view('admin.dashboard', $dados), 200);

		}

	}

}