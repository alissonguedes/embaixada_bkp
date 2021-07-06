@extends('admin.layouts.app')

@section('title', 'Páginas')

    @php
    $disabled = null;
    $editavel = null;
    $input_label_hidden = null;
    @endphp

    @if (session()->get('userdata')['id_grupo'] > 1):

        {? $disabled = isset($row) && $row->editavel === '0' ? 'disabled="disabled"' : null; ?}

        @if ($disabled)
            {? $input_label_hidden = '<input type="hidden" name="label" value="{{ $row->label }}">' ?}
            {? $editavel = $row->editavel; ?}
        @else
            {? $editavel = 1; ?}
        @endif

    @endif


@section('content')

    <div class="container_right panel">

        <!-- Header search bar starts -->
        <div class="title_pg f_avante" style="place-content: start;">

            <button data-href="{{ route('admin.paginas') }}"
                class="btn btn-flat btn-small btn-floating transparent waves-effect waves-light white-text bt_ac btn-flat mr-1"
                data-tooltip="Voltar">
                <i class="material-icons">arrow_back</i>
            </button>

            <div class="mr-2">Paginas - {{ !isset($row) ? 'Adicionar' : 'Editar' }}</div>

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
                                    data-link="{{ route('admin.paginas.delete') }}" style="border: none">
                                    <i class="material-icons">delete_forever</i>
                                </button>
                                <div class="divider"></div>
                            @endif

                        </div>
                        <!-- END Lista de Botões -->

                    </div>

                    <ul class="tabs">
                        <li class="tab"><a href="#informations">Informações</a></li>
                        @foreach ($idiomas as $idioma)
                            <li class="tab">
                                <a href="#{{ limpa_string($idioma->sigla, '') }}">{{ $idioma->descricao }}</a>
                            </li>
                        @endforeach
                    </ul>

                </div>
                <!-- END Toolbar -->

            </div>
            <!-- END panel-header -->

            <!-- BEGIN panel-body -->
            <div class="area_dashboard panel-body pl-0 pr-0 pt-1">

                <form method="post" action="{{ route('admin.paginas.insert') }}" novalidate enctype="multipart/form-data"
                    autocomplete="off">

                    <div class="row">

                        <!-- Informações -->
                        <div class="col l6 s12" id="informations">

                            <!-- BEGIN título -->
                            <div class="row">
                                <div class="input-field amber-text amber-border mb-2">
                                    <label class="grey-text">Nome da página</label>
                                    <input type="text" name="descricao" id="descricao" class="box_input amber-text"
                                        value="{{ isset($row) ? $row->descricao : null }}" autofocus="autofocus">
                                </div>
                            </div>
                            <!-- END título -->

                            <!-- BEGIN Menus -->
                            <div class="row">
                                <div class="input-field amber-text amber-border mb-2">
                                    <label class="grey-text">Menu da página</label>
                                    <select name="menu">
                                        <option value="" disabled="disabled" selected="selected">Selecione o menu da página
                                        </option>
                                        @foreach ($menus as $menu)
                                            <option value="{{ $menu->id }}"
                                                {{ isset($row) && $row->id_menu == $menu->id ? 'selected="selected"' : null }}>{{ $menu->label }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <!-- END Menus -->

                            <!-- BEGIN Idioma -->
                            <div class="row">
                                <div class="input-field amber-text amber-border mb-2">
                                    <label class="grey-text">Idioma Padrão da página</label>
                                    <select name="idioma">
                                        <option value="" disabled="disabled" selected="selected">Selecione o idioma padrão da página</option>

                                        @foreach ($idiomas as $lang)
                                            <option value="{{ $lang->sigla }}"
                                                {{ configuracoes('language') === $lang->sigla || (isset($row) && $row->idioma == $lang->sigla) ? 'selected="selected"' : null }}>{{ $lang->descricao . ' (' . $lang->sigla . ')' }}</option>
                                        @endforeach

                                    </select>
                                </div>
                            </div>
                            <!-- END Idioma -->

                            <!-- BEGIN imagem -->
                            <div class="row">
                                <div class="input-field media conj_img_edit">
                                    <div class="nome_arquivo" data-placeholder="Selecione um arquivo">
                                    </div>
                                    <div class="bt_excluir waves-effect redefinir amber"
                                        style="{{ isset($row) && !empty($row->imagem) ? 'display: none;' : '' }}">
                                        <i class="material-icons">undo</i>
                                    </div>
                                    <div class="btn_add_new_image waves-effect image_alt amber">
                                        <i class="material-icons">upload</i>
                                    </div>
                                    <input type="file" name="arquivo[]" id="img_perfil" multiple>
                                </div>
                            </div>
                            <!-- END imagem -->

                            <!-- LISTAGEM DE ARQUIVOS -->

                            <div class="row">

                                @if (isset($row))

                                    @php
                                        $page = new App\Models\Admin\PaginaModel();
                                        $arquivos = $page->getAttach($row->id);
                                    @endphp

                                    @if (isset($arquivos))
                                        <div class="input-field media">
                                            <div class="grey-text">
                                                <span class="count-files">{{ count($arquivos) }}</span>
                                                @if (count($arquivos) > 1) arquivos cadastrados @else arquivo cadastrado @endif
                                            </div>
                                            <br>
                                            <ul class="collection scroller" style="max-height: 300px;">
                                                @foreach ($arquivos as $file)
                                                    <li class="collection-item avatar pl-3" id="file_{{ $file->id }}">
                                                        {{-- <img src="{{ asset($file->path) }}" alt=""
                                                            class="circle"> --}}
                                                        <p>{{ $file->realname }}</p>
                                                        <span class="title grey-text"
                                                            style="display: block; max-width: 70%; overflow: hidden; word-wrap: nowrap; text-overflow: ellipsis;">{{ asset($file->path) }}</span>
                                                        <a href="javascript:void(0);"
                                                            data-url="{{ route('admin.paginas.delete.file', [$row->id, $file->id]) }}"
                                                            id="{{ $file->id }}"
                                                            class="secondary-content btn-floating btn-small amber waves-effect right remover_arquivo">
                                                            <i class="material-icons black-text">close</i></a>
                                                        <input type="hidden" name="arquivos[]" value="{{ $file->path }}">
                                                    </li>
                                                @endforeach;
                                            </ul>
                                        </div>
                                    @endif
                                @endif

                            </div>

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

                        </div>
                        <!-- END Informações -->

                        <!-- BEGIN Idiomas -->
                        <div id="idiomas">

                            @foreach ($idiomas as $idioma)

                                {? $titulo = isset($row) && !empty($row -> titulo) ? json_decode($row -> titulo, true) : null; ?}
                                {? $subtitulo = isset($row) && !empty($row -> subtitulo) ? json_decode($row -> subtitulo, true) : null; ?}
                                {? $texto = isset($row) && !empty($row -> texto) ? json_decode($row -> texto, true) : null; ?}

                                <div id="{{ limpa_string($idioma->sigla, '') }}" class="col l6 s12">

                                    <div class="row">
                                        <span class="amber-text">IDIOMA: {{ $idioma->descricao }}</span>
                                    </div>

                                    <!-- BEGIN título -->
                                    <div class="row">
                                        <div class="input-field amber-text amber-border mb-2">
                                            <label class="grey-text">Título</label>
                                            <input type="text" name="{{ $idioma->sigla }}:titulo" id="title"
                                                class="box_input amber-text"
                                                value="{{ isset($row) ? $titulo[$idioma->sigla] : null }}"
                                                autofocus="autofocus">
                                        </div>
                                    </div>
                                    <!-- END título -->

                                    <!-- BEGIN descrição -->
                                    <div class="row">
                                        <div class="input-field amber-text amber-border mb-2">
                                            <label class="grey-text">Subtítulo</label>
                                            <input type="text" name="{{ $idioma->sigla }}:subtitulo" id="subtitulo"
                                                class="box_input amber-text"
                                                value="{{ isset($row) ? $subtitulo[$idioma->sigla] : null }}">
                                        </div>
                                    </div>
                                    <!-- END descrição -->

                                    <!-- BEGIN Texto -->
                                    <div class="row">
                                        <div class="input-field amber-border browser-default">
                                            <input type="text" name="{{ $idioma->sigla }}:texto"
                                                value="{{ isset($row) ? $texto[$idioma->sigla] : null }}"
                                                class="editor full--editor">
                                        </div>
                                    </div>
                                    <!-- END Texto -->

                                </div>

                            @endforeach

                        </div>
                        <!-- END Idiomas -->

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
