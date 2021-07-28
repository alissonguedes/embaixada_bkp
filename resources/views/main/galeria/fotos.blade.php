@extends('main.layouts.app')

{? $title = tradutor($page->titulo); ?}
@section('title', $title)

@section('content')

    <div class="title_pg">{{ tradutor($album->titulo) }}</div>

    <div class="geral">

        @if (isset($album))

            <div class="subtitlepage">{{ tradutor($album->titulo) }}</div>
            <div class="datapost">{{ tradutor($album->created_at) }}</div>

            <div class="texto_pagina">

                @php
                    $pagina_model = new \App\Models\Main\PaginaModel();
                    $fotos = $pagina_model->getFotos($album->slug);
                @endphp

                <div class="pikachoose" style="margin-bottom: 50px;">
                    <ul id="pikame">
                        @foreach ($fotos as $f)
                            <li><img src="{{ asset($f->path) }}" class="img_cem"></li>
                        @endforeach
                    </ul>
                </div>

                @if (isset($albuns))

                    <div class="s_item" style="clear: both;">
                        {{ tradutor([
							'en' => 'See too',
							'hr' => 'Lásd is',
							'pt-br' => 'Veja também',
						]) }}
                    </div>

                    @foreach ($albuns as $a)

                        @if ($a->id != $album->id)
                            <a href="{{ url($page->link . '/' . $a->slug) }}">
                                <div class="conj_item_cont">
                                    <div class="img_item_cont">
                                        @if (!empty($a->imagem) && file_exists(public_path($a->imagem)))
                                            <img src="{{ asset($a->imagem) }}" class="img_cem">
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
