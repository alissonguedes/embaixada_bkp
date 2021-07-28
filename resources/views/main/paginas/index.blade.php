@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

@section('title', tradutor($row->titulo))

@section('content')

    <div class="title_pg">{{ tradutor($row->titulo) }}</div>

    <div class="geral">

        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">one</a></li>
            <li><a href="#!">two</a></li>
            <li class="divider"></li>
            <li><a href="#!">three</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper">
                <a href="#!" class="brand-logo">Logo</a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="sass.html">Sass</a></li>
                    <li><a href="badges.html">Components</a></li>
                    <!-- Dropdown Trigger -->
                    <li>
						<a class="dropdown-trigger" href="#!" data-target="dropdown1">Dropdown<i
                                class="material-icons right">arrow_drop_down</i>
							</a>
							</li>
                </ul>
            </div>
        </nav>


        <div class="menu_categs">

            @php echo $paginas -> getMenus($row->id_menu) @endphp

        </div>

        <div class="container2">

            {? $data_add = $row -> created_at; ?}
            {? $data_upd = $row -> updated_at; ?}

            <div class="datapost">{{ tradutor($data_upd) }}</div>

            <div class="subtitlepage">{{ tradutor($row->subtitulo) }}</div>

            {? $imagem = !empty($noticia -> imagem) && file_exists(public_path($row->imagem)) ? asset($noticia -> imagem) : null; ?}

            @if (!is_null($imagem))
                <div class="img_news">
                    <img src="{{ $imagem }}" class="img_cem">
                </div>
            @endif

            <div class="texto_pagina">
                @php
                    echo tradutor($row->texto);
                @endphp
            </div>

        </div>

    </div>

@endsection
