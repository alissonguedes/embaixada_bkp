@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

@section('title', tradutor($row->titulo))

@section('content')

    <div class="title_pg">{{ tradutor($row->titulo) }}</div>

    <div class="geral">

        <div class="menu_categs">

            {{-- <ul class="menu">
                <li>
                    <a href="#">Home</a>
                </li>
                <li>
                    <a href="#">
                        Sobre
                        <i class="material-icons">arrow_right</i>
                    </a>
                    <ul class="sub-menu clearfix">
                        <li>
                            <a href="#">
                                O que fazemos
                            </a>
                            <ul class="sub-menu clearfix">
                                <li>
                                    <a href="#">Web Design</a>
                                </li>
                                <li>
                                    <a href="#">SEO</a>
                                </li>
                                <li>
                                    <a href="#">Design</a>
                                </li>
                                <li>
                                    <a href="#">Desenvolivmento</a>
                                    <ul class="sub-menu clearfix">
                                        <li>
                                            <a href="#">Aplicativos</a>
                                            <ul class="sub-menu clearfix">
                                                <li>
                                                    <a href="#">Android</a>
                                                </li>
                                                <li>
                                                    <a href="#">IOs</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#">Sistemas para Internet 1</a>
                                        </li>
                                        <li>
                                            <a href="#">Sistemas para Internet 2</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">Contato</a>
                </li>
            </ul> --}}

            @php echo $paginas -> getMenus($row->id_menu) @endphp

        </div>

        <style>
            .clearfix {
                clear: both;
            }

            .geral {
                overflow: unset;
            }

            .menu_categs {
                overflow: unset;
                margin-top: 0;
                padding-top: 50px;
            }

            .menu_categs ul {
                width: 200px;
                overflow: unset;
            }

            .menu_categs ul li {
                position: relative;
                margin-bottom: 2px;
            }

            .menu_categs ul li a {
                padding: 10px;
                display: block;
                background: #454545;
                transition: all 200ms ease-in-out;
            }

            .menu_categs ul a:hover {
                background: #656565
            }

            .menu_categs ul li:hover>a {
                background: #545454;
                padding-left: 15px;
            }

            .menu_categs ul li a i {
                position: absolute;
                right: 10px;
                padding: 0;
                top: 0;
                bottom: 0;
                line-height: 2.5;
                font-size: 15px;
            }

            .menu_categs ul li ul {
                position: absolute;
                top: 0;
                left: calc(100% - 0px);
                display: none;
            }

            .menu_categs ul li:hover>ul {
                display: block;
            }

            /* .menu_categs {
                                                                overflow: hidden;
                                                                height: auto;
                                                            }

                                                            .menu {
                                                                height: auto;
                                                                width: 300px;
                                                            }

                                                            ul.menu li {
                                                                position: relative;
                                                            }

                                                            ul.menu li a {
                                                                color: #000;
                                                            }

                                                            .menu,
                                                            .sub-menu {
                                                                margin: 0;
                                                                padding: 0;
                                                            }

                                                            .sub-menu {
                                                                background: #454545;
                                                                display: none;
                                                                position: absolute;
                                                                left: 199px;
                                                                top: 0;
                                                            }

                                                            .menu li>.sub-menu {
                                                                position: relative;
                                                            }

                                                            .sub-menu li a:after {
                                                                content: '+';
                                                                float: right;
                                                                width: 30px;
                                                                height: 30px;
                                                                background: blue;
                                                            }

                                                            .clearfix:after {
                                                                content: '.';
                                                                display: block;
                                                                clear: both;
                                                                height: 0;
                                                                line-height: 0;
                                                                font-size: 0;
                                                                visibility: hidden;
                                                            }

                                                            .menu a {
                                                                display: block;
                                                                padding: 10px;
                                                                color: #fff;
                                                            }

                                                            .menu li:hover>a {
                                                                background: blue;
                                                            }

                                                            .menu li:hover>ul.sub-menu {
                                                                display: block;
                                                            }

                                                            .menu li:hover ul:hover {
                                                                display: block;
                                                            }
                                                */

        </style>


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
