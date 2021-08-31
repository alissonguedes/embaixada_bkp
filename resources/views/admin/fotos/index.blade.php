@extends('admin.layouts.app')

@section('title', 'Galeria - Álbuns')

@section('content')

    <div class="responsive-table">

        <div class="top flex mb-1">

            <div class="actions action-btns flex flex-col align-itens-center">

                <div class="show-buttons">
                    <button type="button" id="adicionar" class="btn btn-large waves-effect modal-trigger" data-target="modal-fotos" data-tooltip="Adicionar">
                        <i class="material-icons">
                            add
                        </i>
                    </button>
                </div>

            </div>

            <div class="clear"></div>

        </div>

        <div class="content pt-1" id="album">

            <div class="row">

                @if ($paginate->total() > 0)

                    @foreach ($paginate as $row)

                        <div id="file_{{ $row->id }}" class="col s12 m6 l3">
                            <div class="card album border-radius-2 bg-opacity-8">
                                <button class="dropdown-trigger btn btn-floating btn-small z-depth-2" href="#" data-target="dropdown_{{ $row->id }}">
                                    <i class="material-icons">more_horiz</i>
                                </button>
                                <ul id='dropdown_{{ $row->id }}' class='dropdown-content'>
                                    <li>
                                        <button id="{{ $row->id }}" class="modal-trigger" data-href="#" data-target="modal-fotos">
                                            <i class="material-icons">edit</i>
                                            Editar álbum
                                        </button>
                                    </li>
                                    <li>
                                        <button class="___class_+?15___" data-href="{{ route('admin.fotos.edit', $row->id) }}">
                                            <i class="material-icons">visibility</i>
                                            Adicionar/Editar fotos
                                        </button>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <button class="remover_arquivo" data-url="{{ route('admin.fotos.delete.album', $row->id) }}" id="{{ $row->id }}">
                                            <i class="material-icons">delete</i>
                                            Excluir álbum
                                        </button>
                                    </li>
                                </ul>
                                <div class="card-image">
                                    <img src="{{ asset($row->imagem) }}" class="responsive-img z-depth-4" alt="">
                                </div>
                                <div class="card-content">
                                    {{ $row->nome }}
                                </div>
                            </div>
                        </div>

                    @endforeach

                @endif

            </div>

        </div>

        <div class="row">

            <div class="col s11 m6 l3">

                <div id="modal-fotos" class="modal album" data-dismissible="false">

                    <form action="#" method="post">

                        <div class="modal-content">

                            <h4 class="modal-title mb-10">Renomear Álbum</h4>

                            <!-- BEGIN título -->
                            <div class="input-field">
                                <label>Nome do álbum</label>
                                <input type="text" name="nome" id="nome">
                                <i class="material-icons sufix help amber-text" data-tooltip="Esta é apenas a identificação do álbum na área administrativa.">help</i>
                            </div>
                            <!-- END título -->

                        </div>

                        <div class="modal-footer">

                            <button type="submit" class="btn inverse btn-small right waves-effect">
                                <i class="material-icons left">save</i> Salvar
                            </button>
                            <button type="reset" class="btn btn-small right mr-2 waves-effect waves-light modal-close">
                                <i class="material-icons left">close</i> Cancelar
                            </button>

                            <input type="hidden" name="id" value="{{ null }}">
                            <input type="hidden" name="_method" value="{{ null }}">

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

@endsection
