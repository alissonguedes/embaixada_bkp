@extends('main.layouts.app')

{? $title = tradutor($page->titulo); ?}
@section('title', $title)

@section('content')

    <div class="title_pg" style="text-transform: capitalize">
        {{ tradutor($title) }}
    </div>

    <div class="geral">
        @if (isset($albuns))

            <br>
            <br>

            @foreach ($albuns as $row)
                <a href="{{ url($page->link . '/' . $row->slug) }}">
                    <div class="conj_item_cont">
                        <div class="img_item_cont">
                            <img src="{{ asset($row->imagem) }}" class="img_cem">
                        </div>
                        <div class="info_item_cont">
                            <div class="title_itemm_cont">
                                {{ tradutor($row->titulo) }}
                            </div>
                            <div class="data_item">
                                {{ tradutor($row->created_at) }}
                            </div>
                        </div>
                    </div>
                </a>
            @endforeach

        @else

            Nenhum álbum cadastrado

        @endif

    </div>

@endsection
