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

@section('title', (isset($row) ? 'Editar' : 'Novo') . ' álbum')

@section('content')
    {{-- @section('buttons')
    @if (isset($row))
        <button class="btn btn-large excluir waves-effect" value="{{ isset($row) ? $row->id : null }}" data-tooltip="Excluir" data-link="{{ route('admin.fotos.delete') }}" style="border: none">
            <i class="material-icons">delete_forever</i>
        </button>
    @endif
@endsection --}}


    <ul class="tabs tabs-vertical">
        @foreach ($idiomas as $idioma)
            <li class="tab">
                <a href="#{{ limpa_string($idioma->sigla, '') }}">{{ $idioma->descricao }}</a>
            </li>
        @endforeach
    </ul>

@endsection
