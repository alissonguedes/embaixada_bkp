@extends('admin.layouts.app')

@section('content')

    <div class="container_right">

        <!-- Header search bar starts -->
        <div class="title_pg f_avante">
            <div class="mr-2">Dashboard</div>
        </div>

        <!-- BEGIN panel-body -->
        <div class="area_dashboard panel-body pt-10">

            <div class="boas_vindas">
                <span style="font-size: 38px;">Bem vindo, {{ session()->get('userdata')['nome'] }}.</span>
                <br>
                Esta é a área administrativa do seu site.
                <br>
                Aqui você irá administrar os produtos e as intenções de compras dos seus clientes.
                <br>
                Fique a vontade.
            </div>

            <a href="{{ route('admin.banners') }}">
                <div class="conj_dash">
                    <div class="item_dash">Banners Cadastrados</div>
                    <div class="valor_dash f_bebas">{{ $total_banners }}</div>
                </div>
            </a>

            <!-- <a href="{{ route('admin.categorias') }}">
               <div class="conj_dash">
                <div class="item_dash">Categorias Cadastradas</div>
                <div class="valor_dash f_bebas">{{ $total_categorias }}</div>
               </div>
              </a> -->

            <a href="{{ route('admin.produtos') }}">
                <div class="conj_dash">
                    <div class="item_dash">Serviços Cadastrados</div>
                    <div class="valor_dash f_bebas">{{ $total_produtos }}</div>
                </div>
            </a>

            <a href="{{ route('admin.intencoes') }}">
                <div class="conj_dash">
                    <div class="item_dash">Interessados</div>
                    <div class="valor_dash f_bebas">{{ $total_intencoes }}</div>
                </div>
            </a>

            <!-- <a href="{{ route('admin.distribuidores') }}">
               <div class="conj_dash">
                <div class="item_dash">Distribuidores</div>
                <div class="valor_dash f_bebas">{{ $total_distribuidores }}</div>
               </div>
              </a> -->

            <a href="{{ route('admin.emails') }}">
                <div class="conj_dash">
                    <div class="item_dash">Contatos</div>
                    <div class="valor_dash f_bebas">{{ $total_emails }}</div>
                </div>
            </a>

        </div>

    </div>

@endsection
