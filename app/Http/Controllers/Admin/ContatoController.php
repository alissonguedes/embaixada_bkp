<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\ConfigModel;
use App\Models\Admin\MenuModel;
use App\Models\Admin\IdiomaModel;

class ContatoController extends Controller
{
	public function __construct()
	{
		$this->config_model = new ConfigModel();
		$this->menu_model = new MenuModel();
		$this->idioma_model = new IdiomaModel();
	}

	public function index(Request $request)
	{
		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		if ($request->ajax()) {
			$dados['paginate'] = $this->config_model->getContato();

			return view('admin.contato.list', $dados);
		}

		return view('admin.contato.index');
	}

	public function show_form(Request $request, $id = null)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$dados = [];

		if (!is_null($id)) {
			$dados['row'] = $this->config_model->getContato($id)->first();
		}

		$dados['idiomas'] = $this->idioma_model->getIdioma();
		$dados['menus'] = $this->menu_model->getMenu();

		return view('admin.contato.form', $dados);
	}

	public function insert(Request $request)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$request->validate([
			'language' => ['required'],
		]);

		$url = url('admin/contato ');
		$type = '';

		if ($this->config_model->create($request)) {
			$status = 'success';
			$message = 'As configurações foram salvas com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível cadastrar o idioma. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}

}
