@extends('admin.layouts.form')

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

@section('buttons')
    {{-- @if (isset($row))
        <button class="btn btn-large excluir waves-effect" value="{{ isset($row) ? $row->id : null }}"
            data-tooltip="Excluir" data-link="{{ route('admin.links.delete') }}" style="border: none">
            <i class="material-icons">delete_forever</i>
        </button>
        <div class="divider"></div>
    @endif --}}
@endsection

@section('title', 'Links Rápidos - ' . (!isset($row) ? 'Adicionar' : 'Editar'))

@section('form')
    <form method="post" action="{{ route('admin.links.insert') }}" novalidate enctype="multipart/form-data"
        autocomplete="off">

        <div class="row">

            <!-- Informações -->
            <div class="col l6 s12" id="informations">

                <!-- BEGIN Título -->
                <div class="row">
                    <div class="col l12 no-padding">
                        <div class="input-field mb-2">
                            <label>Título do link</label>
                            <input type="text" name="titulo" id="titulo" class="box_input"
                                value="{{ $row->titulo ?? null }}">
                        </div>
                    </div>
                </div>
                <!-- END Título -->

                <!-- BEGIN Tradução -->
                {? $traducao = ( isset($row) && ! empty($row -> descricao) ? json_decode($row->descricao,true) : null); ?}
                @foreach ($idiomas as $idioma)
                    <div class="row">
                        <div class="col l12 no-padding">
                            <div class="input-field mb-2">
                                <label>{{ $idioma->descricao }}</label>
                                <input type="text" name="{{ $idioma->sigla }}:descricao" id="sigla:{{ $idioma->sigla }}"
                                    class="box_input" value="{{ $traducao[$idioma->sigla] ?? null }}">
                            </div>
                        </div>
                    </div>
                @endforeach
                <!-- END Tradução -->

                {{-- <!-- BEGIN Menus -->
                            <div class="row">
                                <div class="input-field mb-2">
                                    <label>Menu da página</label>
                                    <select name="menu">
                                        <option value="" disabled="disabled" selected="selected">Selecione o menu da página</option>
                                        @foreach ($menus as $menu)
                                            <option value="{{ $menu->id }}"
                                                {{ (isset($row) && $row->id_menu == $menu->id ) || ( ! isset($row) && $menu -> link == 'pagina-inicial') ? 'selected=selected' : null }}>{{ $menu->label }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <!-- END Menus --> --}}

                <!-- BEGIN URL -->
                <div class="row">
                    <div class="col l12 no-padding">
                        <div class="input-field mb-2">
                            <label>URL da página</label>
                            <input type="text" name="link" id="link" class="box_input" value="{{ $row->link ?? null }}">
                        </div>
                    </div>
                </div>
                <!-- END URL -->

                <!-- BEGIN imagem -->
                <div class="row">
                    <div class="input-field media conj_img_edit">
                        <div class="img_icon_pdf image_view z-depth-4 material-icons">
                            @if (isset($row) && $row->imagem)
                                <img src="{{ asset($row->imagem) }}" class="img_cem materialboxed original">
                                <input type="hidden" name="original_name">
                            @endif
                        </div>
                        <div class="nome_arquivo" data-placeholder="Selecione um ícone">
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
                <!-- END imagem -->

                <!-- BEGIN Status -->
                <div class="row">

                    <div class="col s1 no-margin no-padding">
                        <span for="status" class="active grey-text"
                            style="font-size: 1rem; font-family: roboto;">Status</span>
                    </div>

                    <div class="col s2">
                        <label>
                            <input type="checkbox" name="status" id="status"
                                {{ !isset($row) || $row->status === '1' ? 'checked="checked"' : null }} class="indigo"
                                value="1">
                            <span>Ativo</span>
                        </label>
                    </div>

                </div>
                <!-- END Status -->

            </div>
            <!-- END Informações -->

        </div>

        <div class="row">

            <div class="col l6 s12 mt-3">

                <div class="row">
                    <button type="submit" class="amber btn col btn-large black-text waves-effect">Salvar</button>
                </div>

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
