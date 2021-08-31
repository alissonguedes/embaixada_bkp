@extends('admin.layouts.app')

@section('search')
    <button data-action="back" class="btn btn-flat btn-medium btn-floating waves-effect waves-light" data-tooltip="Voltar">
        <i class="material-icons">arrow_back</i>
    </button>
@endsection

@section('content')

@section('top-bar')
    <div class="top flex mb-1">
        <div class="actions action-btns flex-row align-itens-center">
            @yield('buttons')
            @yield('tabs')
        </div>
    </div>
@show

<div class="content mt-3 mb-4">
    <div class="row">
        <div class="col xl6 l9 m8 s12">
            <div class="card z-depth-1 bg-opacity-2">
                <div class="card-content">
                    <span class="card-title mb-3">@yield('title')</span>
                    @section('form') @show
                </div>
            </div>
        </div>
    </div>
</div>

@endsection
