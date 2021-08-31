@extends('admin.layouts.app')

@section('title', 'Galeria - Álbuns')

@section('content')

    <div class="responsive-table">

        <div class="top flex mb-1">

            <div class="actions action-btns flex flex-col align-itens-center">

                <div class="show-buttons">
                    <button type="button" class="btn btn-large waves-effect" data-href="{{ route('admin.fotos.add') }}" data-tooltip="Adicionar">
                        <i class="material-icons">
                            add
                        </i>
                    </button>
                </div>

                <div class="hide-buttons">

                    <button class="btn btn-large waves-effect translator" data-link="{{ route('admin.dicionario') }}" data-tooltip="Traduzir" style="border: none">
                        <i class="material-icons">translate</i>
                    </button>

                    <button class="btn btn-large update waves-effect" name="status" value="0" data-tooltip="" data-on="Bloquear" data-off="Desbloquear" data-link="{{ route('admin.fotos.patch', 'status') }}" data-method="patch">
                        <i class="material-icons" data-on="lock" data-off="lock_open"></i>
                    </button>

                    <button class="btn btn-large excluir waves-effect" disabled="disabled" data-link="{{ route('admin.fotos.delete') }}" style="border: none" data-tooltip="Excluir">
                        <i class="material-icons">delete_forever</i>
                    </button>

                    <div class="buttons selecteds-label white-text"></div>

                </div>

            </div>

            <div class="clear"></div>

        </div>

        <div class="content pt-1">

            {{-- <table class="table dataTable no-footer" data-link="{{ route('admin.fotos') }}">
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
            </table> --}}

            <div class="masonry-gallery-wrapper">
                <div class="popup-gallery">
                    <div class="gallery-sizer"></div>
                    <div class="row">
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/1.png" target="_top" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/1.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/2.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/2.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/3.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/3.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/4.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/4.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/5.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/5.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/6.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/6.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/7.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/7.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/8.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/8.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/9.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/9.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/10.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/10.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/11.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/11.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/12.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/12.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/13.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/13.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/14.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/14.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/15.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/15.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/16.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/16.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/17.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/17.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/18.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/18.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/19.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/19.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/20.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/20.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/21.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/21.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/22.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/22.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/23.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/23.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col s12 m6 l4 xl2">
                            <div>
                                <a href="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/24.png" target="_top" title="The Cleaner">
                                    <img src="https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/gallery/24.png" class="responsive-img mb-10" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

@endsection
