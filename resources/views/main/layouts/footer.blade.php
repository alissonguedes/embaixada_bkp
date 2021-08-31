<div class="clearfix"></div>
{{-- <div class="title_area_preta">{{ tradutor('conheca_mais_a_hungria') }}</div>

    @php $foto = new App\Models\Main\PaginaModel(); @endphp
    @php $albuns = $foto->getUltimosAlbuns(); @endphp

    <!--fixo-->
    <div class="container3">
        @if (isset($albuns))
            @foreach ($albuns as $album)
                <!--fotos-->
                @if (!empty($album->capa) && file_exists(public_path($album->capa)))
                    <a href="{{ url('fotos/' . $album->titulo_slug) }}">
                        <div class="fotos">
                            <div class="img_fotos"><img src="{{ asset($album->capa) }}" class="img_cem"></div>
                            <div class="nome_galeria">Budapeste</div>
                        </div>
                    </a>
                @endif
            @endforeach
        @endif
    </div> --}}

<div class="area_preta_bottom">
    <img src="{{ asset('assets/embaixada/img/top_middle.png') }}" class="img_cem">
</div>

<footer>

    <div class="cols_footer mil-pixel">

        <div class="col_footer1">

            <div class="conj_contact">
                <!--logo-->
                <div class="insignia">
                    <img src="{{ asset(get_config('site_logo')) }}" class="img_cem">
                </div>
                <div class="nome_site">
                    <div class="nome1">
                        {{ tradutor(['en' => 'EMBASSY OF THE REPUBLIC', 'hr' => 'A KÖZTÁRSASÁG NAGYKÖVETSÉGE', 'pt-br' => 'EMBAIXADA DA REPÚBLICA']) }}
                    </div>
                    <!--fixo-->
                    <div class="nome2">
                        {{ tradutor(['en' => 'OF ANGOLA IN HUNGARY', 'hr' => 'ANGOLA MAGYARORSZÁGON', 'pt-br' => 'DE ANGOLA NA HUNGRIA']) }}
                    </div>
                    <!--fixo-->
                </div>
            </div>

            <div class="social_icons">
                <a href="" target="_blank">
                    <div class="icon_social">
                        <img src="{{ asset('assets/embaixada/img/icon/whatsapp.png') }}" class="img_cem">
                    </div>
                </a>
                <a href="" target="_blank">
                    <div class="icon_social">
                        <img src="{{ asset('assets/embaixada/img/icon/telegram.png') }}" class="img_cem">
                    </div>
                </a>
                <a href="" target="_blank">
                    <div class="icon_social">
                        <img src="{{ asset('assets/embaixada/img/icon/instagram.png') }}" class="img_cem">
                    </div>
                </a>
                <a href="" target="_blank">
                    <div class="icon_social">
                        <img src="{{ asset('assets/embaixada/img/icon/facebook.png') }}" class="img_cem">
                    </div>
                </a>
                <a href="" target="_blank">
                    <div class="icon_social">
                        <img src="{{ asset('assets/embaixada/img/icon/youtube.png') }}" class="img_cem">
                    </div>
                </a>
            </div>

        </div>

        <div class="col_footer2">
            <div class="line1">

                <div class="conj_contact">
                    <div class="icon_contact"><img src="{{ asset('assets/embaixada/img/icon/local.png') }}"
                            class="img_cem"></div>
                    <div class="text_contact">
                        {{ get_config('address') }}, {{ get_config('address_nro') }}
                        <br>
                        {{ get_config('bairro') }} - {{ get_config('cidade') }}
                        {{ get_config('uf') }}
                        {{ get_config('pais') }}
                        {{-- Rua 51, nº 539 (Urbanização Harmonia) Lar do Patriota - Município de Talatona, Luanda, Angola --}}
                    </div>
                </div>

            </div>

            <div class="line2">

                <div class="conj_contact">
                    <div class="icon_contact"><img src="{{ asset('assets/embaixada/img/icon/fone.png') }}"
                            class="img_cem"></div>
                    <div class="text_contact">
                        {{ get_config('contact_phone') }}
                    </div>
                </div>

            </div>

            <div class="line2">

                <div class="conj_contact">
                    <div class="icon_contact"><img src="{{ asset('assets/embaixada/img/icon/mail.png') }}"
                            class="img_cem"></div>
                    <div class="text_contact">
                         {{ get_config('contact_email') }}
                    </div>
                </div>

            </div>

        </div>

    </div>

</footer>

<div class="footer2">

    <div class="mil-pixel">

        <div class="copyright">Embaixada da Angola na Hungria
            <?php echo date('Y'); ?>. Todos os direitos reservados.</div>
        <div class="dev">
            <a href="http://www.tacticweb.com.br" target="_blank">
                <div class="tw">
                </div>
            </a>
        </div>
    </div>

</div>
