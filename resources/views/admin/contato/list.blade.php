{? $records = [] ?}

@if (isset($paginate))

    @foreach ($paginate as $row)

        <tr class="{{ $row->status === '0' ? 'blocked' : null }}"
            id="{{ $row->id }}"
            data-disabled="false">

            <td width="1%"
                data-disabled="true">
                <label>
                    <input type="checkbox"
                           name="id[]"
                           class="light-blue"
                           value="{{ $row->id }}"
                           data-status="{{ $row->status }}">
                    <span></span>
                </label>
            </td>
            <td>{{ $row->descricao }}</td>
            <td class="center-align"><i class="material-icons">{{ $row->status === '0' ? 'lock' : 'check' }}</i>
            </td>
            <td data-disabled="true">
                <button data-href="{{ route('admin.paginas.edit', $row->id) }}"
                        class="bt_edit btn-floating float-none">
                </button>
            </td>
        </tr>

    @endforeach


    <div id="pagination">

        <ul>
            <li>
                <button class="btn btn-small btn-floating waves-effect"
                        data-href="{{ !$paginate->onFirstPage() ? $paginate->previousPageUrl() : '#' }}"
                        {{ $paginate->onFirstPage() ? 'disabled' : null }}>
                    <i class="material-icons">keyboard_arrow_left</i>
                </button>
            </li>

            @for ($i = 1; $i <= $paginate->lastPage(); $i++)
                {? $class = ($i === $paginate -> currentPage() ) ? 'active' : null ?}
                <li>
                    <button data-href="{{ $paginate->currentPage() !== $i ? $paginate->url($i) : '#' }}"
                            class="btn btn-small btn-floating waves-effect {{ $class }}">{{ $i }}</button>
                </li>
            @endfor

            <li>
                <button class="btn btn-small btn-floating waves-effect"
                        data-href="{{ $paginate->currentPage() < $paginate->lastPage() ? $paginate->nextPageUrl() : '#' }}"
                        {{ $paginate->currentPage() === $paginate->lastPage() ? 'disabled' : null }}>
                    <i class="material-icons">keyboard_arrow_right</i>
                </button>
            </li>

        </ul>

    </div>

    <div id="info">
        <a href="#"
           class="amber-text">
            {{ $paginate->firstItem() }} - {{ $paginate->lastItem() }} / {{ $paginate->total() }}
        </a>
    </div>


@else

    <tr>
        <td>
            <div class="white-text pt-2 center-align">
                Nenhum registro encontrado.
            </div>
        </td>
    </tr>

    <div id="pagination">
        <ul>
            <li>
                <button class="btn btn-small btn-floating waves-effect"
                        data-href="#"
                        disabled="disabled">
                    <i class="material-icons">keyboard_arrow_left</i>
                </button>
            </li>
            <li>
                <button data-href="#"
                        class="btn btn-small btn-floating waves-effect active">0</button>
            </li>
            <li>
                <button class="btn btn-small btn-floating waves-effect"
                        data-href="#"
                        disabled="disabled">
                    <i class="material-icons">keyboard_arrow_right</i>
                </button>
            </li>
        </ul>
    </div>

    <div id="info">
        Nenhum registro encontrado
    </div>

@endif
