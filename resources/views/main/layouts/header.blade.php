<header>
    <!--img_bandeira_angola-->
    <div class="simbolo_angola">
        <img src="{{ asset('assets/embaixada/img/simbolo_angola.png') }}" class="img_cem">
    </div>

    <!--barra de pesquisa-->
    <div class="head_1">
        <form method="post" action="">
            <input type="text" name="busca" class="barrabusca" placeholder="{{ tradutor([
				'en' => 'Search the site',
				'hr' => 'Keressen az oldalon',
				'pt-br' => 'Pesquisar no site'
			]) }}">
            <!--fixo-->
            <div class="bt_busca">
                <img src="{{ asset('assets/embaixada/img/lupa.png') }}" class="img_cem">
            </div>
        </form>
    </div>

    <!--barra um-->
    <div class="head_2">

        <!--logo-->
        <div class="insignia">
            <img src="{{ asset(get_config('site_logo')) }}" class="img_cem">
        </div>
        <div class="nome_site">
            <div class="nome1">{{ tradutor([
				'en' => 'EMBASSY OF THE REPUBLIC',
				'hr' => 'A KÖZTÁRSASÁG NAGYKÖVETSÉGE',
				'pt-br' =>'EMBAIXADA DA REPÚBLICA'
			]) }}</div>
            <!--fixo-->
            <div class="nome2">{{ tradutor([
				'en' => 'OF ANGOLA IN HUNGARY',
				'hr' => 'ANGOLA MAGYARORSZÁGON',
				'pt-br' => 'DE ANGOLA NA HUNGRIA'
			]) }}</div>
            <!--fixo-->
        </div>

        <!--idioma-->
        <div class="idioma"
            data-url-lang="{{ url('api/translate/' . ($_COOKIE['idioma'] ?? get_config('language'))) }}">

            {? $idiomas = new App\Models\Main\IdiomaModel(); ?}

            @foreach ($idiomas->getIdioma() as $lang)
                <div class="icon_idioma">
                    <a href="{{ url('api/translate/' . $lang->sigla) }}" class="languages" id="pt-br"
                        data-tooltip="{{ $lang->descricao }}" data-position="bottom">
                        <img src="{{ asset($lang->bandeira) }}" class="img_cem">
                    </a>
                </div>
            @endforeach

        </div>

    </div>

    <!--barra dois-->
    <nav class="menu">
        {{-- <a href="{{ route('home') }}">
			<div class="lk" data-element=".menu" id="bt_menu">{{ tradutor('home_page') }}</div>
		</a> --}}

        @php $menus = new \App\Models\Main\PaginaModel(); @endphp

        @foreach ($menus->getMenus() as $menu)
            {? $traducao = json_decode($menu -> traducao, true); ?}
            <a href="{{ url('' . $menu->link) }}">
                <div class="lk" data-element=".menu" id="bt_menu">{{ tradutor($traducao) ?? $menu->label }}</div>
            </a>
        @endforeach

        {{-- <a href="{{ route('news') }}">
			<div class="lk" data-element=".menu" id="bt_menu">{{ tradutor('novidades') }}</div>
		</a>
		<a href="{{ url('fotos') }}">
			<div class="lk" data-element=".menu" id="bt_menu">{{ tradutor('fotos') }}</div>
		</a> --}}
    </nav>

    <!--botão mobile-->
    <div class="bt_menu_mob" data-element=".menu" id="bt_menu">
        <img src="{{ asset('assets/embaixada/img/bt_mob.png') }}" class="img_cem">
    </div>

    <!--design_header-->
    <div class="design_header">
        <img src="{{ asset('assets/embaixada/img/top_black.png') }}" class="img_cem">
    </div>

</header>
