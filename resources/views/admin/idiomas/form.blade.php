@extends('admin.layouts.app')

@section('title', 'Menus')

    @php
    $disabled = null;
    $editavel = null;
    $input_label_hidden = null;
    @endphp

    @if (session()->get('userdata')['id_grupo'] > 1):

        {? $disabled = isset($row) && $row->editavel === '0' ? 'disabled="disabled"' : null; ?}

        @if ($disabled)
            {? $input_label_hidden = '<input type="hidden" name="label" value="{{ $row->label }}">'; ?}
            {? $editavel = $row->editavel; ?}
        @else
            {? $editavel = 1; ?}
        @endif

    @endif


@section('content')

    <div class="container_right panel">

        <!-- Header search bar starts -->
        <div class="title_pg f_avante" style="place-content: start;">

            <button data-href="{{ url('admin/idiomas') }}"
                class="btn btn-flat btn-small btn-floating transparent waves-effect waves-light white-text bt_ac btn-flat mr-1"
                data-tooltip="Voltar">
                <i class="material-icons">arrow_back</i>
            </button>

            <div class="mr-2">Menus - {{ !isset($row) ? 'Adicionar' : 'Editar' }}</div>

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
                                    data-link="{{ url('menus') }}" style="border: none">
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

                <form method="post" action="{{ route('admin.idiomas') }}" novalidate enctype="multipart/form-data"
                    autocomplete="off">

                    <!-- BEGIN descrição -->
                    <div class="row">
                        <div class="col l6 no-padding">
                            <div class="input-field amber-text mb-2">
                                <label class="grey-text">Idioma</label>
                                <input type="text" name="label" id="label" class="box_input amber-border"
                                    value="{{ isset($row) ? $row->descricao : null }}" {{ $disabled }}
                                    autofocus="autofocus">
                            </div>
                        </div>
                    </div>
                    <!-- END descrição -->

                    <!-- BEGIN sigla -->
                    <div class="row">
                        <div class="col l6 no-padding">
                            <div class="input-field amber-text mb-2">
                                <label class="grey-text">Sigla</label>
                                <input type="text" name="sigla" id="sigla" class="box_input amber-border"
                                    value="{{ isset($row) ? $row->sigla : null }}" {{ $disabled }}
                                    autofocus="autofocus">
                            </div>
                        </div>
                    </div>
                    <!-- END sigla -->

                    <!-- BEGIN icone -->
                    <div class="row">
                        <div class="col l6 no-padding">
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
                    </div>
                    <!-- END icone -->

                    <!-- BEGIN Status -->
                    <div class="row mt-1">

                        <div class="col s1 no-margin no-padding">
                            <span for="status" class="active grey-text"
                                style="font-size: 1rem; font-family: roboto;">Status</span>
                        </div>

                        <div class="col s2">
                            <label>
                                <input type="checkbox" name="status" id="status"
                                    {{ !isset($row) || (isset($row) && $row->status === '1') ? 'checked="checked"' : null }}
                                    class="indigo" value="1">
                                <span>Ativo</span>
                            </label>
                        </div>

                    </div>
                    <!-- END Status -->

                    <div class="row">

                        <div class="col l6 s12 mt-3">

                            <div class="row">
                                <button type="submit"
                                    class="amber btn col btn-large black-text waves-effect">Salvar</button>
                            </div>

                            <input type="hidden" name="acao" value="login">

                            <input type="hidden" name="id" value="{{ isset($row) ? $row->id : null }}">

                            <input type="hidden" name="_method" value="{{ isset($row) ? 'put' : 'post' }}">

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
