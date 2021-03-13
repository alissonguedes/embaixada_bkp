@extends('main.layouts.app')

{? $titulo_pag = 'Fotos' ?}

@section('title', $titulo_pag)

@section('content')

    <div class="title_pg">{{ $titulo_pag }}</div>

    <div class="geral">

        @if (isset($album))

            <div class="subtitlepage">{{ tradutor(json_decode($album->titulo, true)) }}</div>
            <div class="datapost">{{ tradutor($album->created_at) }}</div>

            <div class="texto_pagina">

                <?php $fotos = $pagina_model->getFotos($album->slug); ?>

                @if (!empty($album->capa) && file_exists(public_path($album->capa)))
                    <div class="pikachoose"
                         style="margin-bottom: 50px;">
                        <ul id="pikame">
                            @foreach ($fotos as $f)
                                <li><img src="{{ asset($f->imagem) }}"
                                         class="img_cem"></li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                @if (isset($albuns))

                    <div class="s_item"
                         style="clear: both;">Veja também:</div>

                    @foreach ($albuns as $a)

                        @if ($a->id != $album->id)
                            <a href="{{ url('fotos/' . $a->slug) }}">
                                <div class="conj_item_cont">
                                    <div class="img_item_cont">
                                        @if (!empty($a->capa) && file_exists(public_path($a->capa)))
                                            <img src="{{ asset($a->capa) }}"
                                                 class="img_cem">
                                        @endif
                                    </div>
                                    <div class="info_item_cont">
                                        <div class="title_itemm_cont">
                                            {{ tradutor(json_decode($a->titulo, true)) }}
                                        </div>
                                        <div class="data_item">
                                            {{ tradutor($a->created_at) }}
                                        </div>
                                    </div>
                                </div>
                            </a>
                        @endif

                    @endforeach

                @endif

            </div>

        @else

            Álbum não disponível ou inexistente

        @endif

    </div>

@endsection
