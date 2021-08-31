@extends('admin.layouts.form')

@php
$disabled = null;
$editavel = null;
$input_label_hidden = null;
@endphp

@if (session()->get('userdata')['id_grupo'] > 1)

    {? $disabled = isset($row) && $row->editavel === '0' ? 'disabled="disabled"' : false; ?}

    @if ($disabled)
        {? $input_label_hidden = $row -> label; ?}
        {? $editavel = $row->editavel; ?}
    @else
        {? $editavel = 1; ?}
    @endif

@endif

@section('title', (isset($row) ? 'Editar' : 'Novo') . ' página')

@section('buttons')
    @if (isset($row))
        <button class="btn btn-large excluir waves-effect" value="{{ isset($row) ? $row->id : null }}" data-tooltip="Excluir" data-link="{{ route('admin.paginas.delete') }}" style="border: none">
            <i class="material-icons">delete_forever</i>
        </button>
    @endif
@endsection

@section('tabs')
    <ul class="tabs">
        <li class="tab"><a href="#informations">Informações</a></li>
        @foreach ($idiomas as $idioma)
            <li class="tab">
                <a href="#{{ limpa_string($idioma->sigla, '') }}">{{ $idioma->descricao }}</a>
            </li>
        @endforeach
    </ul>
@endsection

@section('form')

    <form method="post" action="{{ route('admin.paginas.insert') }}" novalidate enctype="multipart/form-data" autocomplete="off">

        <!-- Informações -->
        <div id="informations">

            <!-- BEGIN título -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label class="___class_+?8___">Nome da página</label>
                        <input type="text" name="descricao" id="descricao" value="{{ isset($row) ? $row->descricao : null }}" autofocus="autofocus">
                    </div>
                </div>
            </div>
            <!-- END título -->

            <!-- BEGIN Menus -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label class="___class_+?12___">Menu da página</label>
                        <select name="menu">
                            <option value="" disabled="disabled" selected="selected">Selecione o menu da página</option>
                            @foreach ($menus as $menu)
                                <option value="{{ $menu->id }}" {{ isset($row) && $row->id_menu == $menu->id ? 'selected="selected"' : null }}>{{ $menu->label }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>
            <!-- END Menus -->

            <!-- BEGIN Subpágina -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label class="___class_+?16___">Grupo</label>
                        <select name="grupo">
                            <option value="" disabled="disabled" selected="selected">Selecione o grupo da página</option>
                            <option value="0">Nenhum</option>

                            @foreach ($paginas as $pag)
                                <option value="{{ $pag->id }}" {{ isset($row) && $row->id_pagina == $pag->id ? 'selected="selected"' : null }}>{{ $pag->descricao }}</option>
                            @endforeach

                        </select>
                    </div>
                </div>
            </div>
            <!-- END Subpágina -->

            <!-- BEGIN Idioma -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label class="___class_+?20___">Idioma Padrão da página</label>
                        <select name="idioma">
                            <option value="" disabled="disabled" selected="selected">Selecione o idioma padrão da página</option>

                            @foreach ($idiomas as $lang)
                                <option value="{{ $lang->sigla }}" {{ configuracoes('language') === $lang->sigla || (isset($row) && $row->idioma == $lang->sigla) ? 'selected="selected"' : null }}>{{ $lang->descricao . ' (' . $lang->sigla . ')' }}</option>
                            @endforeach

                        </select>
                    </div>
                </div>
            </div>
            <!-- END Idioma -->

            <!-- BEGIN Status -->
            <div class="row">
                <div class="col s12 mb-3">
                    <label for="status">Ativo</label>
                    <div class="switch right">
                        <label class=" no-margin">
                            {? $checked = !isset($row) || (isset($row) && $row->status === '1') ? 'checked="checked"' : null; ?}
                            <input type="checkbox" name="status" id="status" value="1" {{ $checked }}>
                            <span class="lever no-margin"></span>
                        </label>
                    </div>
                </div>
            </div>
            <!-- END Status -->

            @if (isset($row) && $row->tipo == 'galeria')

                {? $active = 'display: none !important'; ?}
                {? $inactive = null ?}
                {? $checked = 'checked=checked'; ?}

            @else

                {? $active = null; ?}
                {? $inactive = 'display: none !important;'; ?}
                {? $checked = null; ?}

            @endif

            <!-- BEGIN tipo-pagina -->
            <div class="row">
                <div class="col s12 mb-3">
                    <label for="tipo_pagina">Galeria de fotos</label>
                    <div class="switch tipo-pagina right">
                        <label class=" no-margin">
                            <input type="checkbox" name="tipo_pagina" id="tipo_pagina" value="galeria" {{ $checked }}>
                            <span class="lever no-margin"></span>
                        </label>
                    </div>
                </div>
            </div>
            <!-- END tipo-pagina -->


            <!-- BEGIN galeria -->
            <div id="galeria" style="{{ $inactive }}">
                <div class="row">
                    <div class="col s12 mb-3">
                        <div class="col no-margin no-padding">
                            <button type="button" class="btn inverse btn-small waves-effect modal-trigger" data-target="modal-galeria">
                                <i class="material-icons left">image</i>
                                Vincular Galeria
                            </button>
                        </div>
                    </div>
                </div>
                <div class="modal" id="modal-galeria">
                    <div class="modal-content">
                        @php
                            $fotos = new App\Models\Admin\FotoModel();
                        @endphp
                        @if (isset($row) && isset($fotos))
                            <ul class="collection">
                                @foreach ($fotos->getAlbum() as $foto)

                                    @php
                                        $issetAlbum = $fotos
                                            ->from('tb_pagina_album')
                                            ->select('id')
                                            ->where('id_album', $foto->id)
                                            ->where('id_pagina', $row->id)
                                            ->get()
                                            ->first();
                                        $checked = isset($issetAlbum) ? 'checked=checked' : null;
                                    @endphp

                                    <li class="collection-item">
                                        <label>
                                            <input type="checkbox" name="album[]" id="{{ $foto->id }}" value="{{ $foto->id }}" {{ $checked }}>
                                            <span>
                                            </span>
                                        </label>
                                    </li>
                                @endforeach
                            </ul>
                        @endif
                    </div>
                    <div class="modal-footer bordered">
                        <button type="button" class="btn btn-small btn-flat right mr-2 modal-close waves-effect">Feito</button>
                    </div>
                </div>
            </div>
            <!-- END galeria -->

            <!-- BEGIN files_upload -->
            <div id="files_upload" style="{{ $active }}">

                <!-- BEGIN imagem -->
                <div class="row">
                    <div class="col s12 mb-1">
                        {{-- <div class="input-field files input">
                            <div class="nome_arquivo" data-placeholder="Selecione um arquivo"></div>
                            <button type="button" class="btn btn-large waves-effect redefinir" style="{{ isset($row) && !empty($row->imagem) ? 'display: none;' : '' }}">
                                <i class="material-icons">undo</i>
                            </button>
                            <button type="button" class=" btn btn-large btn_add_new_image waves-effect image_alt amber">
                                <i class="material-icons">upload</i>
                            </button>
                            <input type="file" name="arquivo[]" id="img_perfil" multiple>
                        </div> --}}
                        <div class="file-field input-field">
                            <div class="btn">
                                <div class="file">
                                    <i class="material-icons">attach_file</i>
                                </div>
                            </div>
                            <input type="file" name="arquivo[]" multiple="multiple">
                            <div class="file-path-wrapper">
                                <input type="text" class="file-path validate" placeholder="Selecione um arquivo">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END imagem -->

                <!-- LISTAGEM DE ARQUIVOS -->

                <div class="row">

                    <div class="col s12">

                        @if (isset($row))

                            @php
                                $page = new App\Models\Admin\PaginaModel();
                                $arquivos = $page->getAttach($row->id);
                            @endphp

                            @if (isset($arquivos))
                                <div class="input-field media">
                                    <div class="___class_+?53___">
                                        <span class="count-files">{{ count($arquivos) }}</span>
                                        @if (count($arquivos) > 1)
                                            arquivos cadastrados
                                        @else
                                            arquivo cadastrado
                                        @endif
                                    </div>
                                    <br>
                                    <ul class="collection scroller" style="max-height: 300px;">
                                        @foreach ($arquivos as $file)
                                            <li class="collection-item avatar pl-3" id="file_{{ $file->id }}">
                                                {{-- <img src="{{ asset($file->path) }}" alt=""	class="circle"> --}}
                                                <p>{{ $file->realname }}</p>
                                                <span class="title ">{{ asset($file->path) }}</span>
                                                <button type="button" class="secondary-content btn btn-floating btn-small waves-effect right remover_arquivo" data-url="{{ route('admin.paginas.delete.file', [$row->id, $file->id]) }}" id="{{ $file->id }}" data-tooltip="Excluir">
                                                    <i class="material-icons">close</i>
                                                </button>
                                                <input type="hidden" name="arquivos[]" value="{{ $file->path }}">
                                            </li>
                                        @endforeach
                                    </ul>
                                </div>
                            @endif
                        @endif

                    </div>

                </div>

            </div>
            <!-- END files_upload -->

        </div>
        <!-- END Informações -->

        <!-- BEGIN Idiomas -->
        <div id="idiomas">

            @foreach ($idiomas as $idioma)

                {? $titulo = isset($row) && !empty($row -> titulo) ? json_decode($row -> titulo, true) : null; ?}
                {? $subtitulo = isset($row) && !empty($row -> subtitulo) ? json_decode($row -> subtitulo, true) : null; ?}
                {? $texto = isset($row) && !empty($row -> texto) ? json_decode($row -> texto, true) : null; ?}

                <div id="{{ limpa_string($idioma->sigla, '') }}">

                    <div class="row">
                        <div class="col s12 mb-1">
                            <span class="amber-text">IDIOMA: {{ $idioma->descricao }}</span>
                        </div>
                    </div>

                    <!-- BEGIN título -->
                    <div class="row">
                        <div class="col s12 mb-1">
                            <div class="input-field">
                                <label class="___class_+?66___">Título</label>
                                <input type="text" name="{{ $idioma->sigla }}:titulo" id="title" value="{{ isset($row) ? $titulo[$idioma->sigla] : null }}" autofocus="autofocus">
                            </div>
                        </div>
                    </div>
                    <!-- END título -->

                    <!-- BEGIN descrição -->
                    <div class="row">
                        <div class="col s12 mb-1">
                            <div class="input-field">
                                <label class="___class_+?70___">Subtítulo</label>
                                <input type="text" name="{{ $idioma->sigla }}:subtitulo" id="subtitulo" value="{{ isset($row) ? $subtitulo[$idioma->sigla] : null }}">
                            </div>
                        </div>
                    </div>
                    <!-- END descrição -->

                    <!-- BEGIN Texto -->
                    <div class="row">
                        <div class="col s12 mb-1">
                            <div class="input-field browser-default">
                                <input type="text" name="{{ $idioma->sigla }}:texto" value="{{ isset($row) ? $texto[$idioma->sigla] : null }}" class="editor full--editor">
                            </div>
                        </div>
                    </div>
                    <!-- END Texto -->

                </div>

            @endforeach

        </div>
        <!-- END Idiomas -->

        <div class="row">

            <div class="col s12 mt-3">

                <button type="submit" class="btn inverse btn-small right waves-effect">
                    <i class="material-icons left">save</i> Salvar
                </button>
                <button type="reset" data-action="back" class="btn btn-small right mr-2 waves-effect">
                    <i class="material-icons left">arrow_back</i> Cancelar
                </button>

                <input type="hidden" name="acao" value="login">
                <input type="hidden" name="id" value="{{ isset($row) ? $row->id : null }}">
                <input type="hidden" name="_method" value="{{ isset($row) ? 'put' : 'post' }}">

                @if (!isset($row))
                    <input type="hidden" name="editavel" value="{{ $editavel }}">
                @endif

                <input type="hidden" name="dicionario" value="{{ isset($row) ? $row->id_dicionario : null }}">
                {{ $input_label_hidden }}

            </div>

        </div>

    </form>

@endsection
