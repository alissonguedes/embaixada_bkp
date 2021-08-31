<?php

namespace App\Http\Controllers\Admin {

    use App\Models\Admin\IdiomaModel;
    use App\Models\Admin\LinkRapidoModel;
    use App\Models\Admin\MenuModel;
    use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Session;
    use Illuminate\Validation\Rule;

    class LinksRapidosController extends Controller
    {

        public function __construct()
        {
            $this->link_model = new LinkRapidoModel();
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
                $dados['paginate'] = $this->link_model->getLink();

                return view('admin.links.list', $dados);
            }

            return view('admin.links.index');
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
                $dados['row'] = $this->link_model->getLink($id)->first();
            }

            $dados['idiomas'] = $this->idioma_model->getIdioma();
            $dados['menus'] = $this->menu_model->getMenu();

            return view('admin.links.form', $dados);
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
                'titulo' => ['required', 'unique:tb_link,titulo', 'max:255'],
            ]);

            $url = url('admin/links ');
            $type = 'back';

            if ($this->link_model->create($request)) {
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

            if (!Session::has('userdata')) {
                if ($request->ajax()) {
                    return abort(403);
                } else {
                    return redirect()->route('admin.auth.login');
                }

            }

            $request->validate([
                'titulo' => ['required', Rule::unique('tb_link', 'titulo')->ignore($_POST['id'], 'id'), 'max:255'],
            ]);

            $url = url('admin/links ');
            $type = 'back';

            if ($this->link_model->edit($request)) {
                $status = 'success';
                $message = 'Link atualizado com sucesso!';
            } else {
                $status = 'error';
                $message = 'Não foi possível atualizar o link. Por favor, tente novamente.';
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

            $url = url('admin/links');
            $type = null;

            if ($this->link_model->edit($request, $field)) {
                $status = 'success';
                $message = 'Link atualizado com sucesso!';
            } else {
                $status = 'error';
                $message = 'Não foi possível atualizar o link. Por favor, tente novamente.';
            }

            return json_encode(['status' => $status, 'message' => $message, 'type' => $type, 'url' => $url]);
        }

        public function delete(Request $request)
        {

            if (!Session::has('userdata')) {
                if ($request->ajax()) {
                    return abort(403);
                } else {
                    return redirect()->route('admin.auth.login');
                }

            }

            $url = url('admin/links');
            $type = 'back';

            if ($this->link_model->remove($request)) {
                $status = 'success';
                $message = 'Link removido com sucesso!';
            } else {
                $type = null;
                $status = 'error';
                $message = 'Não foi possível remover o link. Por favor, tente novamente.';
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

            $url = url('admin/links');
            $type = 'back';

            if ($this->link_model->remove_file($file)) {
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

}
