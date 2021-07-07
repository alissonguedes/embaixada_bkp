<!--area preta-->
<div class="area_preta_top">
    <img src="{{ asset('assets/embaixada/img/top_middle.png') }}" class="img_cem">
</div>

<div class="area_preta">

    <div class="title_area_preta">{{ tradutor('conheca_mais_a_hungria') }}</div>

    <?php $foto = new App\Models\Main\PaginaModel(); ?>
    <?php $albuns = $foto->getUltimosAlbuns(); ?>

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
    </div>

</div>

<div class="area_preta_bottom">
    <img src="{{ asset('assets/embaixada/img/top_footer.png') }}" class="img_cem">
</div>

<div class="footer">

    <!--logo-->
    <div class="logo_footer">
        <div class="insignia">
            <img src="{{ asset('img/insignia.png') }}" class="img_cem">
        </div>
        <div class="nome_site">
            <div class="nome1" style="color: #000;">{{ tradutor('embaixada_da_republica') }}</div>
            <!--fixo-->
            <div class="nome2" style="color: #000;">{{ tradutor('de_angola_na_hungria') }}</div>
            <!--fixo-->
        </div>
    </div>

    {{-- <div class="socialmedia">
		<a href="" target="_blank"><div class="social"><img src="{{ asset('assets/embaixada/img/icon/facebook.png') }}" class="img_cem"></div></a>
		<a href="" target="_blank"><div class="social"><img src="{{ asset('assets/embaixada/img/img/icon/instagram.png') }}" class="img_cem"></div></a>
		<a href="" target="_blank"><div class="social"><img src="{{ asset('assets/embaixada/img/img/icon/twitter.png') }}" class="img_cem"></div></a>
	</div> --}}

</div>
