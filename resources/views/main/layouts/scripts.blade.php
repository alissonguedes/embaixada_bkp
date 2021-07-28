<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="{{asset('assets/embaixada/js/lightbox.js')}}"></script>
<script src="{{asset('assets/embaixada/js/circle_plugin.js')}}"></script>
<script src="{{ asset('assets/plugins/materializecss/materialize.min.js') }}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/easySlider1.7.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/customizado.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/rhinoslider-1.05.min.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/mousewheel.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/easing.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/customizado.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/jssor.slider.mini.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/jquery.scrollbox.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/depoimento.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/sss.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/jquery.pikachoose.min.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/jquery.touchwipe.min.js')}}"></script>
<script type="text/javascript" src="{{asset('assets/embaixada/js/app.js')}}"></script>

<script language="javascript">
$(document).ready(
	function() {
		$("#pikame").PikaChoose();
		$(".dropdown-trigger").dropdown();

	});
$('[data-tooltip]').tooltip();
</script>

<script>
$(function() {
	$("#bt_menu, #bt_login, #bt_midia, #bt_projetos, #bt_doador, #bt_x").click(function(e) {
		el = $(this).data('element');
		$(el).toggle();
	});
});
</script>

<script>
$(window).on('load', function() {
	document.getElementById("carregando").style.display = "none";
	document.getElementById("corpo").style.display = "block";
})
</script>


<script type="text/javascript" src="{{asset('assets/embaixada/js/jssor.slider.mini.js')}}"></script>

<!-- use jssor.slider.debug.js instead for debug -->
<script>
jQuery(document).ready(function($) {

	var jssor_1_SlideoTransitions = [
		[{
			b: 5500,
			d: 3000,
			o: -1,
			r: 240,
			e: {
				r: 2
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1,
			c: {
				x: 51.0,
				t: -51.0
			}
		}, {
			b: 0,
			d: 1000,
			o: 1,
			c: {
				x: -51.0,
				t: 51.0
			},
			e: {
				o: 7,
				c: {
					x: 7,
					t: 7
				}
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1,
			sX: 9,
			sY: 9
		}, {
			b: 1000,
			d: 1000,
			o: 1,
			sX: -9,
			sY: -9,
			e: {
				sX: 2,
				sY: 2
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1,
			r: -180,
			sX: 9,
			sY: 9
		}, {
			b: 2000,
			d: 1000,
			o: 1,
			r: 180,
			sX: -9,
			sY: -9,
			e: {
				r: 2,
				sX: 2,
				sY: 2
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1
		}, {
			b: 3000,
			d: 2000,
			y: 180,
			o: 1,
			e: {
				y: 16
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1,
			r: -150
		}, {
			b: 7500,
			d: 1600,
			o: 1,
			r: 150,
			e: {
				r: 3
			}
		}],
		[{
			b: 10000,
			d: 2000,
			x: -379,
			e: {
				x: 7
			}
		}],
		[{
			b: 10000,
			d: 2000,
			x: -379,
			e: {
				x: 7
			}
		}],
		[{
			b: -1,
			d: 1,
			o: -1,
			r: 288,
			sX: 9,
			sY: 9
		}, {
			b: 9100,
			d: 900,
			x: -1400,
			y: -660,
			o: 1,
			r: -288,
			sX: -9,
			sY: -9,
			e: {
				r: 6
			}
		}, {
			b: 10000,
			d: 1600,
			x: -200,
			o: -1,
			e: {
				x: 16
			}
		}]
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
		} else {
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
