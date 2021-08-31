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

@section('title', (isset($row) ? 'Editar' : 'Novo') . ' notícia')

@section('buttons')
    @if (isset($row))
        <button class="btn btn-large excluir waves-effect" value="{{ isset($row) ? $row->id : null }}" data-tooltip="Excluir" data-link="{{ route('admin.noticias.delete') }}" style="border: none">
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

    <form method="post" action="{{ route('admin.noticias.insert') }}" novalidate enctype="multipart/form-data" autocomplete="off">

        <!-- Informações -->
        <div id="informations">

            <!-- BEGIN título -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label>Nome da notícia</label>
                        <input type="text" name="descricao" id="descricao" value="{{ isset($row) ? $row->descricao : null }}" autofocus="autofocus">
                    </div>
                </div>
            </div>
            <!-- END título -->

            <!-- BEGIN Idioma -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field">
                        <label>Idioma Padrão da notícia</label>
                        <select name="idioma">
                            <option value="" disabled="disabled" selected="selected">Selecione o idioma padrão
                                da notícia</option>
                            @foreach ($idiomas as $lang)
                                <option value="{{ $lang->sigla }}" {{ configuracoes('language') === $lang->sigla || (isset($row) && $row->idioma == $lang->sigla) ? 'selected="selected"' : null }}>{{ $lang->descricao . ' (' . $lang->sigla . ')' }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>
            <!-- END Idioma -->

            <!-- BEGIN imagem de capa -->
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
                            <input type="file" name="arquivo[]" multiple="multiple">
                        </div>
                        <div class="file-path-wrapper">
                            <input type="text" class="file-path validate" placeholder="Selecione um arquivo">
                        </div>
                    </div>
                </div>
            </div>
            <!-- END imagem de capa -->


            <!-- BEGIN Status -->
            <div class="row mb-3">

                <div class="col s12">
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
                                <label>Título</label>
                                <input type="text" name="{{ $idioma->sigla }}:titulo" id="title" value="{{ isset($row) && !is_null($titulo) ? $titulo[$idioma->sigla] : null }}" autofocus="autofocus">
                            </div>
                        </div>
                    </div>
                    <!-- END título -->

                    <!-- BEGIN descrição -->
                    <div class="row">
                        <div class="col s12 mb-1">
                            <div class="input-field">
                                <label>Subtítulo</label>
                                <input type="text" name="{{ $idioma->sigla }}:subtitulo" id="subtitulo" value="{{ isset($row) && !is_null($subtitulo) ? $subtitulo[$idioma->sigla] : null }}">
                            </div>
                        </div>
                    </div>
                    <!-- END descrição -->

                    <!-- BEGIN Texto -->
                    <div class="row">
                        <div class="col s12 mb-1">
                            <div class="input-field">
                                <textarea name="{{ $idioma->sigla }}:texto" class="editor full--editor" placeholder="Texto da notícia" style="min-height: 600px !important;"><?= isset($row) && !is_null($texto) ? $texto[$idioma->sigla] : null ?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END Texto -->

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
