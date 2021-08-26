@extends('main.layouts.app')

@php $titulo = tradutor([
    'en' => 'Home Page',
    'hr' => 'Kezdőlap',
    'pt-br' => 'Página Inicial',
]); @endphp

@section('title', tradutor($titulo))
@section('content')

<!--arte página inicial-->
<div class="area_art">
    <img src="{{ asset('assets/embaixada/img/arte.jpg') }}" class="img_cem">
</div>

<!--base page-->
<div class="base_top">
    <img src="{{ asset('assets/embaixada/img/top_banner.png') }}" class="img_cem">
</div>

@if ($link)
    <div class="atalhos">

        @foreach ($link as $ln)
            <a href="{{ $ln->link }}">
                <div class="bt_atalho">
                    <div class="icon_atalho"><img src="{{ asset($ln->imagem) }}" class="img_cem"></div>
                    <div class="txt_atalho translate">{{ tradutor($ln->descricao) }}</div>
                </div>
            </a>
        @endforeach

    </div>
@endif

@if (isset($destaques) && $destaques->count() > 0)
    <div class="container mil-pixels">

        <!--novidades-->
        <div class="area_novidades">

            @foreach ($destaques as $news)

                {? $titulo = json_decode($news->titulo, true); ?}
                {? $subtitulo = json_decode($news->subtitulo, true); ?}

                <a href="{{ route('noticias.id', $news->slug) }}">
                    <div class="novidade">

                        @if (!empty($news->imagem))
                            <div class="img_novidade" style="min-height: 210px;">
                                <img src="{{ asset($news->imagem) }}" class="img_cem">
                            </div>
                        @endif

                        <span class="data">{{ date('d/m/Y h:ia', strtotime($news->date_time)) }}</span>
                        <h3 class="title_nov" style="">{{ tradutor($titulo) }}</h3>
                        <p class="resume_nov">{{ tradutor($subtitulo) }}</p>

                    </div>
                </a>

            @endforeach

        </div>

        <a href="{{ route('noticias') }}">
            <div class="bt_vertodas">
                {{ tradutor([
    'en' => 'See all updates',
    'hr' => 'Az összes frissítés megtekintése',
    'pt-br' => 'Ver todas as atualidades',
]) }}
            </div>
        </a>

    </div>

@else

    <span>{{ tradutor([
    'en' => 'There are no news published at the moment.',
    'hr' => 'Jelenleg nincsenek közzétett hírek.',
    'pt-br' => 'Não há notícias publicadas no momento.',
]) }}</span>

@endif

@endsection
