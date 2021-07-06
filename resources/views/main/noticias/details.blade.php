@extends('main.layouts.app')

<?php $titulo_pag = tradutor('novidades'); ?>

@section('title', $titulo_pag)

@section('content')

    <div class="title_pg">{{ $titulo_pag }}</div>

    @php
    $titulo = null;
    $subtitulo = null;
    $texto = 'Nenhuma notícia ainda publicada';
    $imagem = null;
    $date = null;
    @endphp

    <div class="geral">

        @if (isset($noticia))

            {? $titulo = json_decode($noticia->titulo, true) ?}
            {? $subtitulo = json_decode($noticia->subtitulo, true) ?}
            {? $data_add = $noticia->created_at ?}
            {? $texto = tradutor(json_decode($noticia->texto, true)) ?}
            {? $imagem = !empty($noticia -> imagem) ? asset($noticia -> imagem) : null; ?}

            <div class="subtitlepage">{{ tradutor($subtitulo) }}</div>
            <div class="datapost">{{ tradutor($data_add) }}</div>

            <br>

            @if (!is_null($imagem))
                {{-- <div class="img_news">
                    <img src="{{ $imagem }}"
                         class="img_cem">
                </div> --}}
            @endif

        @endif

        <div class="texto_pagina">
            @php
                echo $texto;
            @endphp
        </div>

    </div>

@endsection
