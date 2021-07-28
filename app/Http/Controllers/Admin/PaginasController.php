<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\PaginaModel;
use App\Models\Admin\MenuModel;
use App\Models\Admin\IdiomaModel;

class PaginasController extends Controller
{
	public function __construct()
	{
		$this->pagina_model = new PaginaModel();
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
			$dados['paginate'] = $this->pagina_model->getPagina();

			return view('admin.paginas.list', $dados);
		}

		return view('admin.paginas.index');
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
			$dados['row'] = $this->pagina_model->getPagina($id)->first();
		}

		$dados['paginas'] = $this -> pagina_model -> getGrupo($id);
		$dados['idiomas'] = $this->idioma_model->getIdioma();
		$dados['menus'] = $this->menu_model->getMenu();

		return view('admin.paginas.form', $dados);
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
			'descricao' => ['required', 'unique:tb_pagina,descricao', 'max:255'],
			'menu' => ['required'],
			'idioma' => ['required'],
		]);

		$url = url('admin/paginas ');
		$type = 'back';

		if ($this->pagina_model->create($request)) {
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
			'descricao' => ['required', Rule::unique('tb_pagina', 'descricao')->ignore($_POST['id'], 'id'), 'max:255'],
			'menu' => ['required'],
			'idioma' => ['required'],
		]);

		$request -> validate([
			'arquivo' => 'required|max:8192'
		]);

		$url = url('admin/paginas ');
		$type = 'back';

		if ($this->pagina_model->edit($request)) {
			$status = 'success';
			$message = 'Pagina atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o pagina. Por favor, tente novamente.';
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

		$url = url('admin/paginas');
		$type = null;

		if ($this->pagina_model->edit($request, $field)) {
			$status = 'success';
			$message = 'Pagina atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o pagina. Por favor, tente novamente.';
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

		$url = url('admin/paginas');
		$type = 'back';

		if ($this->pagina_model->remove($request)) {
			$status = 'success';
			$message = 'Pagina removido com sucesso!';
		} else {
			$type = null;
			$status = 'error';
			$message = 'Não foi possível remover o pagina. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}

	public function delete_file(Request $request, $id, $file)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		$url = url('admin/paginas');
		$type = 'back';

		if ($this->pagina_model->remove_file($file)) {
			$status = 'success';
			$message = 'Arquivo removido com sucesso!';
		} else {
			$type = null;
			$status = 'error';
			$message = 'Não foi possível remover o arquivo. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);

	}


}
