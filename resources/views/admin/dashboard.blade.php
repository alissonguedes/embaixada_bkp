@extends('admin.layouts.app')

@section('search', '')
@section('title', 'Dashboard')

@section('content')

<div class="dashboard content">

    <div class="row">

        <div class="col s12 mb-2">
            <div class="boas_vindas">
                <span class="mb-1" style="display: block;font-size: 38px;">
                    Bem vindo, {{ session()->get('userdata')['nome'] }}.
                </span>
                <br>
                Esta é a área administrativa do seu site.
                <br>
                Aqui você irá administrar os produtos e as intenções de compras dos seus clientes.
                <br>
                Fique a vontade.
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.banners') }}" class="waves-effect waves-light">
                        <span class="card-title">Banners Cadastrados</span>
                        <p>{{ $total_banners }}</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.produtos') }}" class="waves-effect waves-light">
                        <span class="card-title">Serviços Cadastrados</span>
                        <p>{{ $total_produtos }}</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.intencoes') }}" class="waves-effect waves-light">
                        <span class="card-title">Interessados</span>
                        <p>{{ $total_intencoes }}</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.emails') }}" class="waves-effect waves-light">
                        <span class="card-title">Contatos</span>
                        <p>{{ $total_emails }}</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.categorias') }}" class="waves-effect waves-light">
                        <span class="card-title">Categorias Cadastradas</span>
                        <p>{{ $total_categorias }}</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="col xl4 l4 m6 s6">
            <div class="card bordered">
                <div class="card-content no-padding">
                    <a href="{{ route('admin.distribuidores') }}" class="waves-effect waves-light">
                        <span class="card-title">Distribuidores</span>
                        <p>{{ $total_distribuidores }}</p>
                    </a>
                </div>
            </div>
        </div>

    </div>

</div>


@endsection
