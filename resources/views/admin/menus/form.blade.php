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

@section('title', (isset($row) ? 'Editar' : 'Novo') . ' menu')

@section('buttons')
    @if (isset($row))
        <button class="btn btn-large excluir waves-effect" value="{{ isset($row) ? $row->id : null }}" data-tooltip="Excluir" data-link="{{ route('admin.paginas.delete') }}" style="border: none">
            <i class="material-icons">delete_forever</i>
        </button>
    @endif
@endsection

{{-- @section('tabs')
<ul class="tabs">
<li class="tab"><a href="#informations">Informações</a></li>
@foreach ($idiomas as $idioma)
<li class="tab">
<a href="#{{ limpa_string($idioma->sigla, '') }}">{{ $idioma->descricao }}</a>
</li>
@endforeach
</ul>
@endsection --}}

@section('form')

    <form method="post" action="{{ route('admin.menus.insert') }}" novalidate enctype="multipart/form-data" autocomplete="off">

        <!-- BEGIN título -->
        <div class="row">
            <div class="col s12 mb-1">
                <div class="input-field mb-2">
                    <label class="">Rótulo</label>
                    <input type="text" {{ !$disabled ? 'name=label' : null }} id="label" class="box_input" value="{{ isset($row) ? $row->label : null }}" {{ $disabled }} autofocus="autofocus">
                </div>
            </div>
        </div>
        <!-- END título -->

        <!-- BEGIN título -->
        <div class="row">
            <div class="col s12 mb-1">
                <div class="input-field">
                    <label class=" mb-10">Tradução:</label>
                    <br>
                    <br>
                </div>
            </div>
        </div>
        <!-- END título -->

        {? $traducao = ( isset($row) && ! empty($row -> traducao) ? json_decode($row->traducao,true) : null); ?}
        @foreach ($idiomas as $idioma)
            <div class="row">
                <div class="col s12 mb-1">
                    <div class="input-field mb-2">
                        <label class="">{{ $idioma->descricao }}</label>
                        <input type="text" name="traducao:{{ $idioma->sigla }}" id="{{ $idioma->sigla }}" class="box_input" value="{{ $traducao[$idioma->sigla] ?? null }}">
                    </div>
                </div>
            </div>
        @endforeach

        <!-- BEGIN Status -->
        <div class="row mt-2">

            <div class="col s12 mb-1">
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

        <!-- BEGIN Editável -->
        @if (session()->get('userdata')['id_grupo'] === 1)
            <div class="row mt-2">

                <div class="col s12 mb-1">
                    <label for="editavel">Editável</label>
                    <div class="switch right">
                        <label class=" no-margin">
                            {? $checked = !isset($row) || (isset($row) && $row->editavel === '1') ? 'checked="checked"' : null; ?}
                            <input type="checkbox" name="editavel" id="editavel" value="1" {{ $checked }}>
                            <span class="lever no-margin"></span>
                        </label>
                    </div>
                </div>

            </div>
        @endif
        <!-- END Editável -->

        <div class="row">

            <div class="col s12 mb-1 mt-3">

                <button type="submit" class="btn btn-small right waves-effect">
                    <i class="material-icons left">save</i> Salvar
                </button>
                <button type="reset" data-action="back" class="btn btn-small right mr-2 waves-effect">
                    <i class="material-icons left">arrow_back</i> Cancelar
                </button>

                <input type="hidden" name="acao" value="login">
                <input type="hidden" name="id" value="{{ isset($row) ? $row->id : null }}">
                <input type="hidden" name="_method" value="{{ isset($row) ? 'put' : 'post' }}">

                <input type="hidden" name="dicionario" value="{{ isset($row) ? $row->id_dicionario : null }}">

                @if (session()->get('userdata')['id_grupo'] > 1)

                    <input type="hidden" name="editavel" value="{{ $editavel }}">

                    @if (!is_null($input_label_hidden))
                        <input type="hidden" name="label" value="{{ $input_label_hidden }}">
                    @endif

                @endif

            </div>

        </div>

    </form>

@endsection
