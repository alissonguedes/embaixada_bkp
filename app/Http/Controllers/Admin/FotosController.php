<?php

namespace App\Http\Controllers\Admin;

use App\Models\Admin\FotoModel;
use App\Models\Admin\IdiomaModel;
use App\Models\Admin\MenuModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

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

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

        }

        if ($request->ajax()) {
			return response($this -> foto_model->getLastAlbum(), 200);
        }

        $dados['paginate'] = $this->foto_model->getAlbum();

        return view('admin.fotos.index', $dados);

    }

    public function show_form(Request $request, $id = null)
    {

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }
        }

        $dados = [];

        if (!is_null($id)) {
            $dados['row'] = $this->foto_model->getAlbum($id)->first();
        }

        $dados['idiomas'] = $this->idioma_model->getIdioma();
        $dados['menus'] = $this->menu_model->getMenu();

        if ($request->action == 'rename') {

            return response($dados['row'], 200);

        } else {
            return view('admin.fotos.form', $dados);
        }

    }

    public function insert(Request $request)
    {

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

        }

        $request->validate([
            'nome' => ['required', 'unique:tb_album,nome', 'max:255'],
        ]);

        $url = url('admin/fotos ');
        $type = 'back';

        if ($this->foto_model->create($request)) {
            $status = 'success';
            $message = 'Álbum cadastrado com sucesso!';
        } else {
            $status = 'error';
            $message = 'Não foi possível cadastrar o álbum. Por favor, tente novamente.';
        }

        return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
    }

    public function update(Request $request)
    {

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

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

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

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

    public function delete(Request $request, $id)
    {

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403, 'Acesso não autorizado');
            } else {
                return redirect()->route('admin.auth.login');
            }

        }

        $url = url('admin/fotos');
        $type = 'back';

        if ($this->foto_model->remove([$id])) {
            $status = 'success';
            $message = 'Foto removido com sucesso!';
        } else {
            $type = null;
            $status = 'error';
            $message = 'Não foi possível remover o foto. Por favor, tente novamente.';
        }

        return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
    }

    public function delete_file(Request $request, $id, $file)
    {

        if (!Session::has('userdata')) {
            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

        }

        $url = url('admin/fotos');
        $type = 'back';

        if ($this->foto_model->remove_file($file)) {
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
