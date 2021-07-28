@extends('main.layouts.app')

@if (!isset($row)) {
    {{ exit(view('main.paginas.404')) }}
@endif

<?php $title = tradutor($title->traducao); ?>

@section('title', $title)

@section('content')

    <div class="title_pg">{{ $title }}</div>

    <br>
    <br>
    <br>

    <div class="geral">

        @if (isset($row))

            @foreach ($row as $news)

                {? $titulo = json_decode($news->titulo, true) ?}
                {? $subtitulo = json_decode($news->subtitulo, true) ?}
                {? $data_add = $news->created_at ?}

                <a href="{{ route('noticias.id', $news->slug) }}">

                    <div class="conj_item_cont">

                        @if (!empty($news->imagem))
                            <div class="img_item_cont">
                                <img src="{{ asset($news->imagem) }}" class="img_cem">
                            </div>
                        @endif

                        <div class="info_item_cont">

                            <div class="title_itemm_cont">
                                {{ tradutor($titulo) }}
                                <div class="subtitlepage" style="font-size: 16px; font-weight: normal;">
                                    {{ tradutor($subtitulo) }}
                                </div>
                            </div>

                            <div class="data_item">
                                {{ tradutor($data_add) }}
                            </div>

                        </div>

                    </div>

                </a>

            @endforeach

        @else

            <span data-translate="nao_exitem_noticias_publicadas_no_momento">Não existem notícias publicadas no
                momento.</span>

        @endif

        {{-- <div class="paginacao">
		<ul>
		<li><div class="n_page n_select">01</div></li>
		<li><div class="n_page">02</div></li>
		<li><div class="n_page">03</div></li>
		<li><div class="n_page">04</div></li>
		<li><div class="n_page">05</div></li>
		</ul>
	</div> --}}
        <!--fim conteúdo-->

    </div>

@endsection
