@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

@section('title', tradutor($row->titulo))

@section('content')

    <div class="title_pg">{{ tradutor($row->titulo) }}</div>

    <div class="geral">

        <div class="menu_categs">

            @if ($pagina_model->getSubPages($row->id_menu)->count() > 0)

                @foreach ($pagina_model->getSubPages($row->id_menu) as $menu)

                    {? $titulo_sub = tradutor($menu -> titulo) ?? $menu -> titulo_principal ?}
                    {? $link = $menu->slug != $row->slug && count($pagina_model->getSubPages($row->id_menu)) > 0 ? url($row->link . '/' . $menu->slug) : url($row->link); ?}

                    <a href="{{ $link }}" class="lk_categs" style="display: block;">{{ $titulo_sub }}</a>

                @endforeach

            @endif

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
