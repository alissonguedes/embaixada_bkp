<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\IdiomaModel;

class IdiomasController extends Controller
{
	public function __construct()
	{
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

		if (Session::get('userdata')['id_grupo'] > 1) {
			exit(view('pages.error.not_found'));
		}

		if ($request->ajax()) {
			$dados['paginate'] = $this->idioma_model->getIdioma();
			return view('admin.idiomas.list', $dados);
		}

		return view('admin.idiomas.index');
	}

	public function show_form(Request $request, $id = null)
	{
		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		if (Session::get('userdata')['id_grupo'] > 1) {
			return view('pages.error.not_found');
		}

		$dados = [];

		if (!is_null($id)) {
			$dados['row'] = $this->idioma_model->getIdioma($id)->first();
		}

		return view('admin.idiomas.form', $dados);
	}

	public function insert(Request $request)
	{

		if ( ! Session::has('userdata')) {
			if ( $request -> ajax() )
				return abort(403);
			else
				return redirect() -> route('admin.auth.login');
		}

		if (Session::get('userdata')['id_grupo'] > 1) {
			return view('pages.error.not_found');
		}

		$request->validate([
			'label' => ['required', 'unique:tb_sys_idioma,descricao', 'max:100'],
			'sigla' => ['required', 'unique:tb_sys_idioma,sigla', 'max:6'],
		]);

		$url = url('admin/idiomas');
		$type = 'back';

		if ($this->idioma_model->create($request)) {
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

		if (Session::get('userdata')['id_grupo'] > 1) {
			return view('pages.error.not_found');
		}

		$request->validate([
			'label' => ['required', Rule::unique('tb_sys_idioma', 'descricao')->ignore($_POST['id'], 'id'), 'max:100'],
			'sigla' => ['required', Rule::unique('tb_sys_idioma', 'sigla')->ignore($_POST['id'], 'id'), 'max:6'],
		]);

		$url = url('admin/idiomas');
		$type = 'back';

		if ($this->idioma_model->edit($request)) {
			$status = 'success';
			$message = 'Idioma atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o idioma. Por favor, tente novamente.';
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

		if (Session::get('userdata')['id_grupo'] > 1) {
			return view('pages.error.not_found');
		}

		$url = url('admin/idiomas');
		$type = null;

		if ($this->idioma_model->edit($request, $field)) {
			$status = 'success';
			$message = 'Idioma atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o idioma. Por favor, tente novamente.';
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

		if (Session::get('userdata')['id_grupo'] > 1) {
			return view('pages.error.not_found');
		}

		$url = url('admin/idiomas');
		$type = 'back';

		if ($this->idioma_model->remove($request)) {
			$status = 'success';
			$message = 'Idioma removido com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível remover o idioma. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}
}

