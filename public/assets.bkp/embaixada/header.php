<!doctype html>
<!--[if lt IE 8 ]><html class="ie ie7" lang="pt-bt"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="pt-br"> <![endif]-->
<!--[if (gte IE 8)|!(IE)]><!--><html lang="pt-br">
<!--<![endif]-->

<head>
  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
  <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script src="js/rolagem.js" type="text/javascript"></script>
  <script src="js/lightbox.js"></script>
  <script src="js/circle_plugin.js"></script>
  <script type="text/javascript" src="js/easySlider1.7.js"></script>
  <script type="text/javascript" src="js/customizado.js"></script>
  <script type="text/javascript" src="js/rhinoslider-1.05.min.js"></script>
  <script type="text/javascript" src="js/mousewheel.js"></script>
  <script type="text/javascript" src="js/easing.js"></script>
  <script type="text/javascript" src="engine1/jquery.js"></script>
  <script type="text/javascript" src="js/customizado.js"></script>
  <script type="text/javascript" src="js/jssor.slider.mini.js"></script>
  <script type="text/javascript" src="js/jquery.scrollbox.js"></script>
  <script type="text/javascript" src="js/depoimento.js"></script>
  <script type="text/javascript" src="js/sss.js"></script>
  <script type="text/javascript" src="js/jquery.pikachoose.min.js"></script>
  <script type="text/javascript" src="js/jquery.touchwipe.min.js"></script>


  <script language="javascript">
    $(document).ready(
      function (){
        $("#pikame").PikaChoose();
      });
  </script>


<script>
$(function(){
    $("#bt_menu, #bt_login, #bt_midia, #bt_projetos, #bt_doador, #bt_x").click(function(e){
        el = $(this).data('element');
        $(el).toggle();
    });
});
</script>

<script>
  $(window).on('load', function (){
    document.getElementById("carregando").style.display = "none";
    document.getElementById("corpo").style.display = "block";
  })

  /*var intervalo = setInterval(function (){
    clearInterval(intervalo);

    document.getElementById("carregando").style.display = "none";
    document.getElementById("corpo").style.display = "block";
  },5000
);*/
</script>


<script type="text/javascript" src="js/jssor.slider.mini.js"></script>

    <!-- use jssor.slider.debug.js instead for debug -->
    <script>
        jQuery(document).ready(function ($) {

            var jssor_1_SlideoTransitions = [
              [{b:5500,d:3000,o:-1,r:240,e:{r:2}}],
              [{b:-1,d:1,o:-1,c:{x:51.0,t:-51.0}},{b:0,d:1000,o:1,c:{x:-51.0,t:51.0},e:{o:7,c:{x:7,t:7}}}],
              [{b:-1,d:1,o:-1,sX:9,sY:9},{b:1000,d:1000,o:1,sX:-9,sY:-9,e:{sX:2,sY:2}}],
              [{b:-1,d:1,o:-1,r:-180,sX:9,sY:9},{b:2000,d:1000,o:1,r:180,sX:-9,sY:-9,e:{r:2,sX:2,sY:2}}],
              [{b:-1,d:1,o:-1},{b:3000,d:2000,y:180,o:1,e:{y:16}}],
              [{b:-1,d:1,o:-1,r:-150},{b:7500,d:1600,o:1,r:150,e:{r:3}}],
              [{b:10000,d:2000,x:-379,e:{x:7}}],
              [{b:10000,d:2000,x:-379,e:{x:7}}],
              [{b:-1,d:1,o:-1,r:288,sX:9,sY:9},{b:9100,d:900,x:-1400,y:-660,o:1,r:-288,sX:-9,sY:-9,e:{r:6}},{b:10000,d:1600,x:-200,o:-1,e:{x:16}}]
            ];

            var jssor_1_options = {
              $AutoPlay: true,
              $SlideDuration: 2000,
              $SlideEasing: $Jease$.$OutQuint,
              $CaptionSliderOptions: {
                $Class: $JssorCaptionSlideo$,
                $Transitions: jssor_1_SlideoTransitions
              },
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

            //responsive code begin
            //you can remove responsive code if you don't want the slider scales while window resizing
            function ScaleSlider() {
                var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
                if (refSize) {
                    refSize = Math.min(refSize, 1920);
                    jssor_1_slider.$ScaleWidth(refSize);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }
            ScaleSlider();
            $(window).bind("load", ScaleSlider);
            $(window).bind("resize", ScaleSlider);
            $(window).bind("orientationchange", ScaleSlider);
            //responsive code end
        });
    </script>







<!--- CONFIGURAÇÕES BÁSICAS
   ================================================== -->
	<meta charset="utf-8">
	<title>Embaixada de Angola na Hungria</title>
	<meta name="Organização Atos" content="Organização Atos">

  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <meta name="robots" content="index, follow">

   <!-- Mobile Especificações Metas
  ================================================== -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- CSS
   ================================================== -->
	<link rel="stylesheet" href="css/layout.css">
  <link rel="stylesheet" href="css/internas.css">
  <link rel="stylesheet" href="css/lightbox.css">
  <link href="css/sss.css" rel="stylesheet">
  <link type="text/css" href="css/css3.css" rel="stylesheet" />



   <!-- Favicons
	================================================== -->
	<link rel="shortcut icon" href="favicon.png" >
</head>

<body>


<header>
  <!--img_bandeira_angola-->
  <div class="simbolo_angola">
    <img src="img/simbolo_angola.png" class="img_cem">
  </div>

  <!--barra de pesquisa-->
  <div class="head_1">
    <form method="post" action="">
      <input type="text" name="busca" class="barrabusca" placeholder="Procurar"><!--fixo-->
      <div class="bt_busca">
        <img src="img/lupa.png" class="img_cem">
      </div>
    </form>
  </div>

  <!--barra um-->
  <div class="head_2">

    <!--logo-->
    <div class="insignia">
      <img src="img/insignia.png" class="img_cem">
    </div>
    <div class="nome_site">
      <div class="nome1">EMBAIXADA DA REPÚBLICA</div><!--fixo-->
      <div class="nome2">DE ANGOLA NA HUNGRIA</div><!--fixo-->
    </div>

    <!--idioma-->
    <div class="idioma">
      <div class="text_idioma">Selecione o idioma</div><!--fixo-->
      <a href="#"><div class="icon_idioma"><img src="img/flag/pt.jpg" class="img_cem"></div></a><!--português-->
      <a href="#"><div class="icon_idioma"><img src="img/flag/en.jpg" class="img_cem"></div></a><!--inglês-->
      <a href="#"><div class="icon_idioma"><img src="img/flag/hn.jpg" class="img_cem"></div></a><!--hungaro-->
    </div>

  </div>

  <!--barra dois-->
  <nav class="menu">
    <a href="index.php"><div class="lk" data-element=".menu" id="bt_menu">INÍCIO</div></a>
    <a href="embaixada.php"><div class="lk" data-element=".menu" id="bt_menu">EMBAIXADA</div></a>
    <a href="sector_consular.php"><div class="lk" data-element=".menu" id="bt_menu">SECTOR CONSULAR</div></a>
    <a href="angola.php"><div class="lk" data-element=".menu" id="bt_menu">ANGOLA</div></a>
    <a href="relacoes.php"><div class="lk" data-element=".menu" id="bt_menu">RELAÇÕES BILATERAIS</div></a>
    <a href="novidades_list.php"><div class="lk" data-element=".menu" id="bt_menu">NOVIDADES</div></a>
    <a href="fotos_list.php"><div class="lk" data-element=".menu" id="bt_menu">FOTOS</div></a>
  </nav>

  <!--botão mobile-->
  <div class="bt_menu_mob" data-element=".menu" id="bt_menu">
    <img src="img/bt_mob.png" class="img_cem">
  </div>

  <!--design_header-->
  <div class="design_header">
    <img src="img/top_black.png" class="img_cem">
  </div>

</header>
