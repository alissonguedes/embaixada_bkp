<?php

namespace App\Http\Controllers\Admin {

    use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Auth;
    use Illuminate\Support\Facades\Route;
    use Illuminate\Support\Facades\Session;
    use \App\Models\Admin\UsuarioModel;

    class AuthController extends Controller
    {

        public function __construct()
        {

            $this->usuario_model = new UsuarioModel();

        }

        public function index(Request $request)
        {

            if (!Session::has('userdata')) {

                return view('admin.login');

            } else {

                return redirect()->route('admin.dashboard');

            }

        }

        public function login(Request $request)
        {

            if (isset($_POST['login'])) {

                $request->validate([
                    'login' => 'required',
                ]);

                if ($this->validate_login($request->login)) {
                    $data['user'] = Session::get('userlogin')['nome'];
                    return json_encode(['status' => 200, 'data' => $data, 'message' => 'Usuário logado com sucesso']);
                } else {
                    $errors = ['login' => 'Usuário inexistente ou inativo no sistema.'];
                    return json_encode(['status' => 'error', 'message' => 'Usuário inválido', 'errors' => $errors]);
                }

            }

            if (isset($_POST['senha'])) {

                $request->validate([
                    'senha' => 'required',
                ]);

                if ($this->validate_senha($request->senha)) {

                    $data['user'] = Session::get('userdata');
                    $data['token'] = Session::get('app_session');
                    $url = isset($_POST['url']) && !empty($_POST['url']) ? $_POST['url'] : url('admin/dashboard');

                    return json_encode(['status' => 'success', 'data' => $data, 'message' => 'Usuário logado com sucesso', 'url' => $url]);

                } else {

                    $errors = ['senha' => 'Senha incorreta.'];
                    return json_encode(['status' => 'error', 'message' => 'Usuário inválido', 'errors' => $errors]);

                }

            }

        }

        private function validate_login($login)
        {

            if ($this->usuario_model->auth($login)) {
                return true;
            }

            return false;

        }

        private function validate_senha($senha)
        {

            if ($this->usuario_model->auth(null, $senha)) {
                return true;
            }

            return false;

        }

        public function logout(Request $request)
        {

            Session::forget(['userdata', 'senha', 'id', 'id_grupo', 'permissao', 'app_session']);

            // if ( $request -> ajax() )
            return abort(403);
            // return response('Not Authorized', 403);
            // else
            //     return redirect()->route('admin.auth.index');

        }

    }

}