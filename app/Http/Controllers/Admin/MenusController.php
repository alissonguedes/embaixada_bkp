<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\MenuModel;
use App\Models\Admin\IdiomaModel;

class MenusController extends Controller
{
	public function __construct()
	{
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
			$dados['menus'] = $this->menu_model->getMenu();
			$dados['paginate'] = $this->menu_model->getMenu();
			return view('admin.menus.list', $dados);
		}

		return view('admin.menus.index');
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
			$dados['row'] = $this->menu_model->getMenu($id)->first();
		}

		$dados['idiomas'] = $this->idioma_model->getIdioma();

		return view('admin.menus.form', $dados);
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
			'label' => ['required', 'unique:tb_acl_menu,label', 'max:100'],
		]);

		$url = url('admin/menus ');
		$type = 'back';

		if ($this->menu_model->create($request)) {
			$status = 'success';
			$message = 'Idioma cadastrado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível cadastrar o idioma. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}

	public function update(Request $request)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$request->validate([
			'label' => ['required', Rule::unique('tb_acl_menu', 'label')->ignore($_POST['id'], 'id'), 'max:100'],
		]);

		$url = url('admin/menus ');
		$type = 'back';

		if ($this->menu_model->edit($request)) {
			$status = 'success';
			$message = 'Menu atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o menu. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}

	public function replace(Request $request, $field)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$url = url('admin/menus');
		$type = null;

		if ($this->menu_model->edit($request, $field)) {
			$status = 'success';
			$message = 'Menu atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o menu. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}

	public function delete(Request $request)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$url = url('admin/menus');
		$type = 'back';

		if ($this->menu_model->remove($request)) {
			$status = 'success';
			$message = 'Menu removido com sucesso!';
		} else {
			$type = null;
			$status = 'error';
			$message = $this->menu_model->getMessage();
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}
}
