@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

<?php $title = tradutor($row -> titulo); ?>

@section('title', $title)

@section('content')

    <div class="title_pg">{{ $title }}</div>

    <div class="geral">

        @if (isset($row))

            <div class="subtitlepage">{{ tradutor($row->subtitulo) }}</div>
            <div class="datapost">{{ tradutor($row->created_at) }}</div>

            <br>

        @endif

        <div class="texto_pagina">
            @php
                echo tradutor($row->texto);
            @endphp
        </div>

    </div>

@endsection
