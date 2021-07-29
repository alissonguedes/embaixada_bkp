@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

@section('title', tradutor($row->titulo))

@section('content')

    <div class="title_pg">{{ tradutor($row->titulo) }}</div>

    <div class="geral">

        <div class="menu_categs">


            <nav>
                <a href="javascript:void(0);" class="mobile-menu-trigger">Open mobile menu</a>
                <ul class="menu menu-bar">
                    <li>
                        <a href="javascript:void(0);" class="menu-link menu-bar-link" aria-haspopup="true">1. Multilevel
                            mega menu</a>
                        <ul class="mega-menu mega-menu--multiLevel">
                            <li>
                                <a href="javascript:void(0);" class="menu-link mega-menu-link" aria-haspopup="true">1.1
                                    Flyout link</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.1.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" class="menu-link menu-list-link"
                                            aria-haspopup="true">1.1.2 Flyout link</a>
                                        <ul class="menu menu-list">
                                            <li>
                                                <a href="/page" class="menu-link menu-list-link">1.1.2.1 Page link</a>
                                            </li>
                                            <li>
                                                <a href="/page" class="menu-link menu-list-link">1.1.2.2 Page link</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.1.3 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0);" class="menu-link mega-menu-link" aria-haspopup="true">1.2
                                    Flyout link</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.2.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.2.2 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="javascript:void(0);" class="menu-link mega-menu-link" aria-haspopup="true">1.3
                                    Flyout link</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.3.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">1.3.2 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="/page" class="menu-link mega-menu-link">1.4 Page link</a>
                            </li>
                            <li class="mobile-menu-back-item">
                                <a href="javascript:void(0);" class="menu-link mobile-menu-back-link">Back</a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript:void(0);" class="menu-link menu-bar-link" aria-haspopup="true">2. Flat mega menu
                            (3 cols)</a>
                        <ul class="mega-menu mega-menu--flat">
                            <li>
                                <a href="/page" class="menu-link mega-menu-link mega-menu-header">2.1 Page link header</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.1.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.1.2 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.1.3 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="/page" class="menu-link mega-menu-link mega-menu-header">2.2 Page link header</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.2.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.2.2 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.2.3 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="/page" class="menu-link mega-menu-link mega-menu-header">2.3 Page link header</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.2.1 Page link</a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">2.2.2 Page link</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="mobile-menu-back-item">
                                <a href="javascript:void(0);" class="menu-link mobile-menu-back-link">Back</a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript:void(0);" class="menu-link menu-bar-link" aria-haspopup="true">3. Flat mega menu
                            (2 cols)</a>
                        <ul class="mega-menu mega-menu--flat">
                            <li>
                                <a href="#" class="menu-link mega-menu-link mega-menu-header">3.1 Page link header</a>
                                <ul class="menu menu-list">
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">
                                            3.1.1 Page link<br />
                                            <small>Short decription of link</small>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">
                                            3.1.2 Page link<br />
                                            <small>Short decription of link</small>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="/page" class="menu-link menu-list-link">
                                            3.1.2 Page link<br />
                                            <small>Short decription of link</small>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="mega-menu-content">
                                <p class="mega-menu-header">3.2 Page link header</p>
                                <p>This is just static content. You can add anything here. Images, text, buttons, your
                                    grandma's secrect recipe.</p>
                            </li>
                            <li class="mobile-menu-back-item">
                                <a href="javascript:void(0);" class="menu-link mobile-menu-back-link">Back</a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="/page" class="menu-link menu-bar-link">Static link</a>
                    </li>

                    <li class="mobile-menu-header">
                        <a href="/home" class="">
                            <span>Home</span>
                        </a>
                    </li>
                </ul>
            </nav>
            {{-- @php echo $paginas -> getMenus($row->id_menu) @endphp --}}

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
