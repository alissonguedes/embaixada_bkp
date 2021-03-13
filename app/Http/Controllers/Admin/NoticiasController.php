<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

use App\Models\Admin\NoticiaModel;
use App\Models\Admin\MenuModel;
use App\Models\Admin\IdiomaModel;

class NoticiasController extends Controller
{
	public function __construct()
	{
		$this->noticia_model = new NoticiaModel();
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
			$dados['paginate'] = $this->noticia_model->getNoticia();

			return view('admin.noticias.list', $dados);
		}

		return view('admin.noticias.index');
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
			$dados['row'] = $this->noticia_model->getNoticia($id)->first();
		}

		$dados['idiomas'] = $this->idioma_model->getIdioma();
		$dados['menus'] = $this->menu_model->getMenu();

		return view('admin.noticias.form', $dados);
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
			'descricao' => ['required', 'unique:tb_noticia,descricao', 'max:255'],
			// 'menu'   => ['required'],
			'idioma' => ['required'],
		]);

		$url = url('admin/noticias ');
		$type = 'back';

		if ($this->noticia_model->create($request)) {
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
			'descricao' => ['required', Rule::unique('tb_noticia', 'descricao')->ignore($_POST['id'], 'id'), 'max:255'],
			'idioma' => ['required'],
		]);

		$url = url('admin/noticias ');
		$type = 'back';

		if ($this->noticia_model->edit($request)) {
			$status = 'success';
			$message = 'Noticia atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o noticia. Por favor, tente novamente.';
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

		$url = url('admin/noticias');
		$type = null;

		if ($this->noticia_model->edit($request, $field)) {
			$status = 'success';
			$message = 'Noticia atualizado com sucesso!';
		} else {
			$status = 'error';
			$message = 'Não foi possível atualizar o noticia. Por favor, tente novamente.';
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

		$url = url('admin/noticias');
		$type = 'back';

		if ($this->noticia_model->remove($request)) {
			$status = 'success';
			$message = 'Noticia removido com sucesso!';
		} else {
			$type = null;
			$status = 'error';
			$message = 'Não foi possível remover o noticia. Por favor, tente novamente.';
		}

		return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
	}
}
