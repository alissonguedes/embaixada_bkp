@extends('main.layouts.app')

<?php $titulo = 'Página não encontrada'; ?>
@section('title', $titulo)

@section('content')

    <div class="title_pg">404 - Página Não encontrada</div>

    <div class="geral">

        <div class="container2">

            <h3>Desculpe!</h3>

            <p>
                A página que você procura não foi encontrada ou não está disponível no momento.
                <br>
                Por favor, tente novamente mais tarde.
            </p>

        </div>

    </div>

@endsection
