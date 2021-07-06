@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

{? $titulo_pag = tradutor(json_decode($row->titulo, true)) ?? $row -> titulo_principal; ?}
{? $subtitulo_pag = tradutor(json_decode($row -> subtitulo, true)) ?? $row -> subtitulo; ?}
{? $texto_pag = tradutor(json_decode($row -> texto, true)) ?? $row -> texto_pag; ?}
{? $imagem = !empty($noticia -> imagem) && file_exists(public_path($row->imagem)) ? asset($noticia -> imagem) : null; ?}
{? $data_add = $row -> created_at; ?}
{? $data_upd = $row -> updated_at; ?}

@section('title', $titulo_pag)

@section('content')

    <div class="title_pg">{{ $titulo_pag }}</div>

    <div class="geral">

        <div class="menu_categs">

            @if ($pagina_model->getSubPages($row->id_menu)->count() > 0)

                @foreach ($pagina_model->getSubPages($row->id_menu) as $menu)

                    {? $titulo_sub = tradutor(json_decode($menu -> titulo, true)) ?? $menu -> titulo_principal ?}
                    {? $link = $menu->slug != $row->slug && count($pagina_model->getSubPages($row->id_menu)) > 0 ? url($row->link . '/' . $menu->slug) : url($row->link); ?}

                    <a href="{{ $link }}"
                       class="lk_categs"
                       style="display: block;">{{ $titulo_sub }}</a>

                @endforeach

            @endif

        </div>

        <div class="container2">

            <div class="datapost">{{ tradutor($data_upd) }}</div>

            <div class="subtitlepage">{{ $subtitulo_pag }}</div>

            @if (!is_null($imagem))
                <div class="img_news">
                    <img src="{{ $imagem }}"
                         class="img_cem">
                </div>
            @endif

            <div class="texto_pagina">
                @php
                    echo $texto_pag;
                @endphp
            </div>

        </div>

    </div>

@endsection
