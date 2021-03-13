@extends('main.layouts.app')

<?php $titulo = tradutor('__HOME_PAGE__'); ?>

@section('title', $titulo)
@section('content')

    <!--arte página inicial-->
    <div class="area_art">
        <img src="{{ asset('img/arte.jpg') }}"
             class="img_cem">
    </div>

    <!--base page-->
    <div class="base_top">
        <img src="{{ asset('img/top_banner.png') }}"
             class="img_cem">
    </div>

    <div class="atalhos">
        <!--tudo fixo-->

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/pessoas.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho translate">{{ tradutor('quero_obter_um_visto') }}</div>
            </div>
        </a>

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/bandeiras.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho translate">{{ tradutor('procuro_servicos_para_cidadaos_angolanos') }}</div>
            </div>
        </a>

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/chapeu.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho">{{ tradutor('quero_estudar_na_hungria') }}</div>
            </div>
        </a>

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/trofeu.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho">{{ tradutor('procuro_oportunidade_de_negocios') }}</div>
            </div>
        </a>

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/aviao.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho">{{ tradutor('quero_visitar_a_hungria') }}</div>
            </div>
        </a>

        <!--atalho-->
        <a href="">
            <div class="bt_atalho">
                <div class="icon_atalho"><img src="{{ asset('img/icon/terra.png') }}"
                         class="img_cem"></div>
                <div class="txt_atalho">{{ tradutor('procuro_informacoes_sobre_politica_hungara') }}</div>
            </div>
        </a>
    </div>

    @if (isset($destaques) && $destaques->count() > 0)
        <div class="container">

            <!--novidades-->
            <div class="area_novidades">

                @foreach ($destaques as $news)

                    {? $titulo = json_decode($news->titulo, true); ?}
                    {? $subtitulo = json_decode($news->subtitulo, true); ?}

                    <a href="{{ route('noticias.id', $news->slug) }}">
                        <div class="novidade">

                            @if (!empty($news->imagem))
                                <div class="img_novidade"
                                     style="min-height: 210px;">
                                    <img src="{{ asset($news->imagem) }}"
                                         class="img_cem">
                                </div>
                            @endif

                            <div class="data">{{ date('d/m/Y h:ia', strtotime($news->date_time)) }}</div>
                            <div class="title_nov">{{ tradutor($titulo) }}</div>
                            <div class="resume_nov">{{ tradutor($subtitulo) }}</div>

                        </div>
                    </a>

                @endforeach

            </div>

            <a href="{{ route('noticias') }}">
                <div class="bt_vertodas">{{ tradutor('ver_todas_as_atualidades') }}</div>
            </a>

        </div>

    @else

        <span>{{ tradutor('nao_exitem_noticias_publicadas_no_momento') }}</span>

    @endif

@endsection
