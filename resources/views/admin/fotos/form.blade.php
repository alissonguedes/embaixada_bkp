@extends('admin.layouts.app')

@section('title', 'Fotos')

    @php
    $disabled = null;
    $editavel = null;
    $input_label_hidden = null;
    @endphp

    @if (session()->get('userdata')['id_grupo'] > 1):

        {? $disabled = isset($row) && $row->editavel === '0' ? 'disabled="disabled"' : null; ?}

        @if ($disabled)
            {? $input_label_hidden = '<input type="hidden" name="label" value="' . $row->label . '">'; ?}
            {? $editavel = $row->editavel; ?}
        @else
            {? $editavel = 1; ?}
        @endif

    @endif

@section('content')

    <div class="container_right panel">

        <!-- Header search bar starts -->
        <div class="title_pg f_avante" style="place-content: start;">

            <button data-href="{{ route('admin.fotos') }}"
                class="btn btn-flat btn-small btn-floating transparent waves-effect waves-light white-text bt_ac btn-flat mr-1"
                data-tooltip="Voltar">
                <i class="material-icons">arrow_back</i>
            </button>

            <div class="mr-2">Fotos - {{ !isset($row) ? 'Adicionar' : 'Editar' }}</div>

        </div>
        <!-- Header search bar Ends -->

        <!-- BEGIN panel-content -->
        <div class="panel-content">

            <!-- BEGIN panel-header -->
            <div class="panel-header no-border">

                <!-- BEGIN Toolbar -->
                <div class="toolbar bts_acao f_bebas">

                    <div class="buttons">

                        <!-- BEGIN Lista de Botões -->
                        <div class="buttons show-buttons">

                            @if (isset($row))
                                <button class="btn btn-large excluir waves-effect"
                                    value="{{ isset($row) ? $row->id : null }}" data-tooltip="Excluir"
                                    data-link="{{ route('admin.fotos.delete') }}" style="border: none">
                                    <i class="material-icons">delete_forever</i>
                                </button>
                                <div class="divider"></div>
                            @endif

                        </div>
                        <!-- END Lista de Botões -->

                    </div>

                </div>
                <!-- END Toolbar -->

            </div>
            <!-- END panel-header -->

            <!-- BEGIN panel-body -->
            <div class="area_dashboard panel-body pl-0 pr-0 pt-1">

                <form method="post" action="{{ route('admin.fotos.insert') }}" novalidate enctype="multipart/form-data"
                    autocomplete="off">

                    <div class="row">

                        <!-- Informações -->
                        <div class="col l6 s12" id="informations">

                            <!-- BEGIN título -->
                            <div class="row">
                                <div class="input-field amber-text amber-border mb-2">
                                    <label class="grey-text">Nome do álbum</label>
                                    <input type="text" name="nome" id="nome" class="box_input amber-text"
                                        value="{{ isset($row) ? $row->nome : null }}" autofocus="autofocus">
                                </div>
                            </div>
                            <!-- END título -->

							<!-- BEGIN título -->
							<div class="row">
								<div class="col l6 no-padding">
									<div class="input-field amber-text mb-2">
										<label class="grey-text">Tradução:</label>
										<br>
									</div>
								</div>
							</div>
							<!-- END título -->

                            <!-- BEGIN Tradução -->
                            {? $traducao = ( isset($row) && ! empty($row -> titulo) ? json_decode($row->titulo,true) : null )?}
                            @foreach ($idiomas as $idioma)
                                <div class="row">
                                    <div class="col l12 no-padding">
                                        <div class="input-field amber-text amber-border mb-2">
                                            <label class="grey-text">{{ $idioma->descricao }}</label>
                                            <input type="text" name="{{ $idioma->sigla }}:titulo"
                                                id="sigla:{{ $idioma->sigla }}" class="box_input amber-text"
                                                value="{{ $traducao[$idioma->sigla] ?? null }}">
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                            <!-- END Tradução -->

                            <!-- BEGIN Status -->
                            <div class="row">

                                <div class="col s1 no-margin no-padding">
                                    <span for="status" class="active grey-text"
                                        style="font-size: 1rem; font-family: roboto;">Status</span>
                                </div>

                                <div class="col s2">
                                    <label>
                                        <input type="checkbox" name="status" id="status"
                                            {{ !isset($row) || $row->status === '1' ? 'checked="checked"' : null }}
                                            class="indigo" value="1">
                                        <span>Ativo</span>
                                    </label>
                                </div>

                            </div>
                            <!-- END Status -->

                            <!-- BEGIN imagem de capa -->
                            <div class="row">
                                <div class="input-field media conj_img_edit">
                                    <div class="img_icon_pdf image_view z-depth-4 material-icons">
                                        @if (isset($row) && $row->imagem)
                                            <img src="{{ asset($row->imagem) }}" class="img_cem materialboxed original">
                                            <input type="hidden" name="original_name">
                                        @endif
                                    </div>
                                    <div class="nome_arquivo" data-placeholder="Imagem de capa">
                                    </div>
                                    <div class="bt_excluir waves-effect redefinir amber"
                                        style="{{ isset($row) && !empty($row->imagem) ? 'display: none;' : '' }}">
                                        <i class="material-icons">undo</i>
                                    </div>
                                    <div class="btn_add_new_image waves-effect image_alt amber">
                                        <i class="material-icons">add_photo_alternate</i>
                                    </div>
                                    <input type="file" name="imagem" id="img_perfil" accept="image">
                                </div>
                            </div>
                            <!-- END imagem de capa -->

                            <!-- BEGIN imagens do álbum -->
                            <div class="row">
                                <div class="input-field media conj_img_edit">
                                    <div class="nome_arquivo" data-placeholder="Selecione as imagens do álbum">
                                    </div>
                                    <div class="bt_excluir waves-effect redefinir amber"
                                        style="{{ isset($row) && !empty($row->imagem) ? 'display: none;' : '' }}">
                                        <i class="material-icons">undo</i>
                                    </div>
                                    <div class="btn_add_new_image waves-effect image_alt amber">
                                        <i class="material-icons">upload</i>
                                    </div>
                                    <input type="file" name="arquivo[]" id="img_album" accept="image" multiple>
                                </div>
                            </div>
                            <!-- END imagem do álbum -->

                            <!-- LISTAGEM DE ARQUIVOS -->

                            <div class="row">

                                @if (isset($row))

                                    @php
                                        $page = new App\Models\Admin\FotoModel();
                                        $arquivos = $page->getFotos($row->id);
                                    @endphp

                                    @if (isset($arquivos))
                                        <div class="input-field media">
                                            <div class="grey-text">
                                                <span class="count-files">{{ count($arquivos) }}</span>
                                                @if (count($arquivos) > 1) arquivos
                                                cadastrados @else arquivo cadastrado @endif
                                            </div>
                                            <br>
                                            <ul class="collection" style="max-height: 300px; overflow-y: scroll;">
                                                @foreach ($arquivos as $file)
                                                    <li class="collection-item avatar" id="file_{{ $file->id }}">
                                                       <div class="circle">
														   <img src="{{ asset($file->path) }}" alt=""
														   class="materialboxed">
														</div>
                                                        <p>{{ $file->realname }}</p>
                                                        <span class="title grey-text"
                                                            data-tooltip="{{ asset($file->path) }}" data-position="top"
                                                            style="display: block; max-width: 70%; overflow: hidden; word-wrap: nowrap; text-overflow: ellipsis;">{{ asset($file->path) }}</span>
                                                        <a href="javascript:void(0);"
                                                            data-url="{{ route('admin.fotos.delete.file', [$row->id, $file->id]) }}"
                                                            id="{{ $file->id }}"
                                                            class="secondary-content btn-floating btn-small amber waves-effect right remover_arquivo">
                                                            <i class="material-icons black-text">close</i></a>
                                                        <input type="hidden" name="arquivos[]" value="{{ $file->path }}">
                                                    </li>
                                                @endforeach
                                            </ul>
                                        </div>
                                    @endif
                                @endif

                            </div>

                        </div>
                        <!-- END Informações -->

                    </div>

                    <div class="row">

                        <div class="col l6 s12 mt-3">

                            <div class="row">
                                <button type="submit"
                                    class="amber btn col btn-large black-text waves-effect">Salvar</button>
                            </div>

                            <input type="hidden" name="acao" value="login">
                            <input type="hidden" name="id" value="{{ isset($row) ? $row->id : null }}">
                            <input type="hidden" name="_method" value="{{ isset($row) ? 'put' : 'post' }}">

                            @if (!isset($row))
                                <input type="hidden" name="editavel" value="{{ $editavel }}">
                            @endif

                            <input type="hidden" name="dicionario"
                                value="{{ isset($row) ? $row->id_dicionario : null }}">
                            {{ $input_label_hidden }}

                        </div>

                    </div>

                </form>

            </div>
            <!-- END panel-body -->


        </div>
        <!-- END panel-content -->

    </div>

@endsection
