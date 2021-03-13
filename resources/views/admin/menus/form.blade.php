@extends('admin.layouts.app')

@section('title', 'Menus')

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

@section('content')

    <div class="container_right panel">

        <!-- Header search bar starts -->
        <div class="title_pg f_avante"
             style="place-content: start;">

            <button data-href="{{ route('admin.menus') }}"
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

                            @if (isset($row) && $row->editavel === '1' && session()->get('userdata')['id_grupo'] > 1)
                                <button class="btn btn-large excluir waves-effect"
                                        value="{{ isset($row) ? $row->id : null }}"
                                        data-tooltip="Excluir"
                                        data-link="{{ route('admin.menus.delete') }}"
                                        style="border: none">
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

                <form method="post"
                      action="{{ route('admin.menus.insert') }}"
                      novalidate
                      enctype="multipart/form-data"
                      autocomplete="off">

                    <!-- BEGIN título -->
                    <div class="row">
                        <div class="col l6 no-padding">
                            <div class="input-field amber-text amber-border mb-2">
                                <label class="grey-text">Rótulo</label>
                                <input type="text"
                                       {{ !$disabled ? 'name=label' : null }}
                                       id="label"
                                       class="box_input"
                                       value="{{ isset($row) ? $row->label : null }}"
                                       {{ $disabled }}
                                       autofocus="autofocus">
                            </div>
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

                    {? $traducao = ( isset($row) && ! empty($row -> traducao) ? json_decode($row->traducao,true) : null )?}
                    @foreach ($idiomas as $idioma)
                        <div class="row">
                            <div class="col l6 no-padding">
                                <div class="input-field amber-text amber-border mb-2">
                                    <label class="grey-text">{{ $idioma->descricao }}</label>
                                    <input type="text"
                                           name="traducao:{{ $idioma->sigla }}"
                                           id="{{ $idioma->sigla }}"
                                           class="box_input amber-text"
                                           value="{{ $traducao[$idioma->sigla] ?? null }}">
                                </div>
                            </div>
                        </div>
                    @endforeach

                    <!-- BEGIN Status -->
                    <div class="row mt-1">

                        <div class="col s1 no-margin no-padding">
                            <span for="status"
                                  class="active grey-text"
                                  style="font-size: 1rem; font-family: roboto;">Status</span>
                        </div>

                        <div class="col s2">
                            <label>
                                <input type="checkbox"
                                       name="status"
                                       id="status"
                                       {{ !isset($row) || (isset($row) && $row->status === '1') ? 'checked="checked"' : null }}
                                       class="indigo"
                                       value="1">
                                <span>Ativo</span>
                            </label>
                        </div>

                    </div>
                    <!-- END Status -->

                    <!-- BEGIN Editável -->
                    @if (session()->get('userdata')['id_grupo'] === 1)
                        <div class="row mt-1">

                            <div class="col s1 no-margin no-padding">
                                <span for="editavel"
                                      class="active grey-text"
                                      style="font-size: 1rem; font-family: roboto;">Editável</span>
                            </div>

                            <div class="col s2">
                                <label>
                                    <input type="checkbox"
                                           name="editavel"
                                           id="editavel"
                                           {{ !isset($row) || (isset($row) && $row->editavel === '1') ? 'checked="checked"' : null }}
                                           class="indigo"
                                           value="1">
                                    <span>Ativo</span>
                                </label>
                            </div>

                        </div>
                    @endif
                    <!-- END Editável -->

                    <div class="row">

                        <div class="col l6 s12 mt-3">

                            <div class="row">
                                <button type="submit"
                                        class="amber btn col btn-large black-text waves-effect">Salvar</button>
                            </div>

                            <input type="hidden"
                                   name="acao"
                                   value="login">
                            <input type="hidden"
                                   name="id"
                                   value="{{ isset($row) ? $row->id : null }}">
                            <input type="hidden"
                                   name="_method"
                                   value="{{ isset($row) ? 'put' : 'post' }}">

                            <input type="hidden"
                                   name="dicionario"
                                   value="{{ isset($row) ? $row->id_dicionario : null }}">

                            @if (session()->get('userdata')['id_grupo'] > 1)

                                <input type="hidden"
                                       name="editavel"
                                       value="{{ $editavel }}">

                                @if (!is_null($input_label_hidden))
                                    <input type="hidden"
                                           name="label"
                                           value="{{ $input_label_hidden }}">
                                @endif

                            @endif

                        </div>

                    </div>

                </form>

            </div>
            <!-- END panel-body -->

        </div>
        <!-- END panel-content -->

    </div>

@endsection
