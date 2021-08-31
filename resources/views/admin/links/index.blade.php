@extends('admin.layouts.app')

@section('title', 'Links')

@section('content')

    <div class="responsive-table">

        <div class="top flex mb-1">

            <div class="actions action-btns flex flex-col align-itens-center">

                <div class="hide-buttons">

                    <button class="btn btn-large update waves-effect" name="status" value="0" data-tooltip="" data-on="Bloquear" data-off="Desbloquear" data-link="{{ route('admin.links.patch', 'status') }}" data-method="patch">
                        <i class="material-icons" data-on="lock" data-off="lock_open"></i>
                    </button>

                    <div class="buttons selecteds-label white-text"></div>

                </div>

            </div>

            <div class="clear"></div>

        </div>

        <div class="content">

            <table class="table dataTable no-footer" data-link="{{ route('admin.links') }}">
                <thead>
                    <tr>
                        <th class="disabled sortable white-text" width="1%" data-orderable="false">
                            <label>
                                <input type="checkbox" class="amber" id="check-all">
                                <span> </span>
                            </label>
                        </th>
                        <th class="white-text">Titulo</th>
                        <th class="white-text center-align">Status</th>
                        <th class="disabled white-text center-align" data-orderable="false"></th>
                    </tr>
                </thead>
            </table>

        </div>

    </div>

@endsection
