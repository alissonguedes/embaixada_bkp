<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\FotoModel;
use App\Models\Admin\MenuModel;
use App\Models\Admin\IdiomaModel;

class FotosController extends Controller
{
	public function __construct()
	{
		$this->foto_model = new FotoModel();
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
			$dados['paginate'] = $this->foto_model->getFoto();

			return view('admin.fotos.list', $dados);
		}

		return view('admin.fotos.index');
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
			$dados['row'] = $this->foto_model->getFoto($id)->first();
		}

		$dados['idiomas'] = $this->idioma_model->getIdioma();
		$dados['menus'] = $this->menu_model->getMenu();

		return view('admin.fotos.form', $dados);
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
			'nome' => ['required', 'unique:tb_album,nome', 'max:255'],
		]);

		$url = url('admin/fotos ');
		$type = 'back';

		if ($this->foto_model->create($request)) {
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
			'nome' => ['required', Rule::unique('tb_album', 'nome')->ignore($_POST['id'], 'id'), 'max:255'],
		]);

		$url = url('admin/fotos ');
		$type = 'back';

		if ($this->foto_model->edit($request)) {
			$status = 'success';
			$message = 'Foto atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o foto. Por favor, tente novamente.';
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

		$url = url('admin/fotos');
		$type = null;

		if ($this->foto_model->edit($request, $field)) {
			$status = 'success';
			$message = 'Foto atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o foto. Por favor, tente novamente.';
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

		$url = url('admin/fotos');
		$type = 'back';

		if ($this->foto_model->remove($request)) {
			$status = 'success';
			$message = 'Foto removido com sucesso!';
		} else {
			$type = null;
			$status = 'error';
			$message = 'Não foi possível remover o foto. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}
}
