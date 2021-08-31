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

@section('title', (isset($row) ? 'Editar' : 'Novo') . ' link')

@section('top-bar', '')

@section('form')

    <form method="post" action="{{ route('admin.links.insert') }}" novalidate enctype="multipart/form-data" autocomplete="off">

        <!-- Informações -->
        <div id="informations">

            <!-- BEGIN Título -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field mb-2">
                        <label>Título do link</label>
                        <input type="text" name="titulo" id="titulo" class="box_input" value="{{ $row->titulo ?? null }}">
                    </div>
                </div>
            </div>
            <!-- END Título -->

            <!-- BEGIN Tradução -->
            {? $traducao = ( isset($row) && ! empty($row -> descricao) ? json_decode($row->descricao,true) : null); ?}
            @foreach ($idiomas as $idioma)
                <div class="row">
                    <div class="col s12 mb-1">
                        <div class="input-field mb-2">
                            <label>{{ $idioma->descricao }}</label>
                            <input type="text" name="{{ $idioma->sigla }}:descricao" id="sigla:{{ $idioma->sigla }}" class="box_input" value="{{ $traducao[$idioma->sigla] ?? null }}">
                        </div>
                    </div>
                </div>
            @endforeach
            <!-- END Tradução -->

            <!-- BEGIN URL -->
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field mb-2">
                        <label>URL do link</label>
                        <input type="text" name="link" id="link" class="box_input" value="{{ $row->link ?? null }}">
                    </div>
                </div>
            </div>
            <!-- END URL -->

            <!-- BEGIN imagem -->
            <div class="row">
                <div class="col s12 mb-1">
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

        </div>
        <!-- END Informações -->

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
