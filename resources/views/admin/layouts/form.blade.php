@extends('admin.layouts.app')

@section('search')
    <button data-action="back" class="btn btn-flat btn-small btn-floating transparent waves-effect waves-light white-text btn-flat mr-1"
        data-tooltip="Voltar">
        <i class="material-icons">arrow_back</i>
    </button>
@endsection

@section('content')

    <div class="panel">

        <!-- BEGIN panel-content -->
        <div class="panel-content">

            <!-- BEGIN panel-header -->
            <div class="panel-header">

                <!-- BEGIN Toolbar -->
                <div class="toolbar bts_acao f_bebas">

                    <div class="buttons">

                        <!-- BEGIN Lista de Botões -->
                        <div class="buttons show-buttons">

							@section('buttons')
							@show

                        </div>
                        <!-- END Lista de Botões -->

                    </div>

                </div>
                <!-- END Toolbar -->

            </div>
            <!-- END panel-header -->

            <!-- BEGIN panel-body -->
            <div class="panel-body pl-0 pr-0 pt-1">

                @section('form') @show

        </div>
        <!-- END panel-body -->

    </div>
    <!-- END panel-content -->

</div>

@endsection
