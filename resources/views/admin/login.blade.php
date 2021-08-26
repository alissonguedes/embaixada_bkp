@extends('admin.layouts.app')

@section('container')

    <div id="login-page" class="row">

        <div class="tacticweb col m8 l8 xl9 hide-on-small-only">
            <p class="logo">
                <img src="{{ asset('assets/tacticweb/img/logotw.png') }}" class="img_cem">
            </p>
            <h5 class="title-1">Área</h5>
            <h2 class="title-2">ADMINISTRATIVA</h2>
        </div>

        <div class="login-form padding-3 col s12 m5 l4 xl3">

            <div id="logo-cliente">
                <img src="{{ asset(get_config('site_logo')) }}" alt="asdf">
            </div>

            <div id="boas-vindas" class="vertical-align no-padding">
                <button type="button" id="btn-back" class="btn btn-small btn-floating transparent left z-depth-0">
                    <i class="material-icons grey-text text-darken-4">keyboard_arrow_left</i>
                </button>
                <h5 class="animated lightSpeedInLeft faster delay-15">
                    Bem-vindo!
                </h5>
            </div>

            <form novalidate id="frm-login" class="" action="{{ route('admin.auth.login') }}" method="post"
                enctype="multipart/form-data" autocomplete="off">

                <div class="form">

                    <div id="input-login" class="slow">
                        <div class="input-field">
                            <input type="email" name="login" id="login" autofocus="autofocus">
                            <label for="login">
                                Usuário
                            </label>
                        </div>
                        {{-- <button type="button" id="relembrar_login" name="relembrar_login"
                            class="btn btn-flat pl-0 pr-0 transparent left">
                            Esqueci meu login
                        </button> --}}
                    </div>

                    <div id="input-pass" class="slow">
                        <div class="input-field">
                            <input type="password" name="senha" id="senha" disabled="disabled" autofocus="autofocus"
                                minlength="5">
                            <label for="pass">
                                Senha
                            </label>
                        </div>
                        {{-- <button type="button" id="relembrar_senha" name="relembrar_senha"
                            class="btn btn-flat pl-0 pr-0 transparent right">
                            Recuperar senha
                        </button> --}}
                    </div>

                </div>

                <button type="submit" id="entrar" name="entrar"
                    class="btn btn-small waves-effect waves-light right mb-2 next">
                    Próximo
                    <i class="material-icons margin-left">input</i>
                </button>

                <input type="hidden" name="acao" value="login">
                <input type="hidden" name="url" id="url" value="">
                <input type="hidden" name="_method" value="post">

                @csrf

            </form>

            <br>

            <p class="aviso">
                Caso tenha esquecido seus dados de acesso, favor entrar em contato com o desenvolvedor.<br><br> TacticWeb /
                Luiz Felipe:<br> fone: <strong>(83)98833-6804</strong><br> e-mail: <strong>tacticwebcg@gmail.com</strong>
            </p>

        </div>
    </div>

@endsection
