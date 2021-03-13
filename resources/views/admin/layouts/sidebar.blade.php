@if (session()->has('userdata'))
    <div class="menu_left sidebar">
        <div class="logo_tw_topo">
            <img src="{{ asset('assets/tacticweb/img/ltw.png') }}"
                class="img_cem">
        </div>

        <div class="menu_dashboard">

            <a href="{{ route('admin.dashboard') }}">
                <div class="lk_menu">Dashboard</div>
            </a>

            {{-- <a href="{{ route('admin.banners') }}">
                <div class="lk_menu">Banners</div>
            </a> --}}

            <a href="{{ route('admin.menus') }}">
                <div class="lk_menu">Menus do site</div>
            </a>

            <a href="{{ route('admin.paginas') }}">
                <div class="lk_menu">Páginas</div>
            </a>

            <a href="{{ route('admin.noticias') }}">
                <div class="lk_menu">Notícias</div>
            </a>

            <a href="{{ route('admin.fotos') }}">
                <div class="lk_menu">Fotos</div>
            </a>

            <a href="{{ route('admin.contato') }}">
                <div class="lk_menu">Contato</div>
            </a>

            {{-- <a href="{{ route('admin.intencoes') }}">
				<div class="lk_menu">Intenções de Compra</div>
			</a>

			<a href="{{ route('admin.distribuidores') }}">
				<div class="lk_menu">Distribuidores</div>
			</a>

			<a href="{{ route('admin.emails') }}">
				<div class="lk_menu">E-mail</div>
			</a>

			<a href="{{ route('admin.emails.template') }}">
				<div class="lk_menu">Editar Template de e-mail</div>
			</a>

            <a href="{{ route('admin.localidades') }}">
				<div class="lk_menu">Localidades</div>
			</a>

            <a href="{{ route('admin.dicionario') }}">
				<div class="lk_menu">Dicionário</div>
			</a> --}}

            <a href="{{ route('admin.usuarios') }}">
                <div class="lk_menu">Gerenciar Usuários</div>
            </a>

            @if (session()->get('userdata')['id_grupo'] === 1)
                <a href="{{ route('admin.idiomas') }}">
                    <div class="lk_menu">Gerenciar Idiomas</div>
                </a>
            @endif

            <a href="{{ asset('/') }}"
                target="_blank">
                <div class="lk_menu">Acessar o site</div>
            </a>

            <a href="{{ route('admin.auth.logout') }}">
                <div class="lk_menu">Sair</div>
            </a>

        </div>
    </div>

    <div class="bt_mob"
        id="menu_mob"
        data-element=".menu_dashboard">
        <img src="img/bt_mob.png"
            class="img_cem">
    </div>

@endif
