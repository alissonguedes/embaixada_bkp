<?php

use App\Models\Admin\ConfigModel;

if (!function_exists('get_config')) {

	function get_config($config)
	{

		$cfg = new ConfigModel();

		return $cfg -> getConfig($config) -> first() -> value ?? null;

	}
}

use Illuminate\Support\Carbon;

function tradutor($traducao, $lang = null, $except = '' ) {

	$idioma = is_null($lang) ? ( isset($_COOKIE['idioma']) ? $_COOKIE['idioma'] : get_config('language') ) : $lang;

	// Formata a data e hora de acordo com o Idioma
	if ( is_object($traducao)) {

		$date = (string) $traducao;

		switch($idioma) {

			case 'en' : $formato = 'Y-m-d h:ia'; break;
			case 'pt-br' : $formato = 'd/m/Y H\hi'; break;
			case 'hr' : $formato = 'd-m-y h:ia'; break;

		}

		return  date($formato, strtotime($date));

	}

	$return = is_string($traducao) ? json_decode($traducao, true) : $traducao;

	if ( is_array($return) && array_key_exists($idioma, $return)) {

		if ( !empty($return[$idioma]) ) {
			return $return[$idioma];
		}

	} else {

		return tradutor([$idioma => $traducao]);

	}

	$catch = [
		'en' => 'Translation not available for this language',
		'hr' => 'A fordítás nem érhetó el ezen a nyelven',
		'pt-br' => 'Tradução não disponível para este idioma'
	];

	$except = !empty($except) ? $except : $catch;
	return $except[$idioma];

}

if (!function_exists('hashCode')) {
	function hashCode($str)
	{
		return !empty($str) ? substr(hash('sha512', $str), 0, 50) : null;
	}
}

function configuracoes() {

}

/**
 * Remove caratecres especiais
 * Converte todos os caracteres de um arquivo para caixa baixa
 * Remove espaçamentos
 */
function limpa_string($string, $replace = '-')
{
	$output = [];
	$a = ['Á' => 'a', 'À' => 'a', 'Â' => 'a', 'Ä' => 'a', 'Ã' => 'a', 'Å' => 'a', 'á' => 'a', 'à' => 'a', 'â' => 'a', 'ä' => 'a', 'ã' => 'a', 'å' => 'a', 'a' => 'a', 'Ç' => 'c', 'ç' => 'c', 'Ð' => 'd', 'É' => 'e', 'È' => 'e', 'Ê' => 'e', 'Ë' => 'e', 'é' => 'e', 'è' => 'e', 'ê' => 'e', 'ë' => 'e', 'Í' => 'i', 'Î' => 'i', 'Ï' => 'i', 'í' => 'i', 'ì' => 'i', 'î' => 'i', 'ï' => 'i', 'Ñ' => 'n', 'ñ' => 'n', 'O' => 'o', 'Ó' => 'o', 'Ò' => 'o', 'Ô' => 'o', 'Ö' => 'o', 'Õ' => 'o', 'ó' => 'o', 'ò' => 'o', 'ô' => 'o', 'ö' => 'o', 'õ' => 'o', 'ø' => 'o', 'œ' => 'o', 'Š' => 'o', 'Ú' => 'u', 'Ù' => 'u', 'Û' => 'u', 'Ü' => 'u', 'U' => 'u', 'ú' => 'u', 'ù' => 'u', 'û' => 'u', 'ü' => 'u', 'Y' => 'y', 'Ý' => 'y', 'Ÿ' => 'y', 'ý' => 'y', 'ÿ' => 'y', 'Ž' => 'z', 'ž' => 'z'];
	$string = strtr($string, $a);
	$regx = [' ', '.', '+', '@', '#', '!', "$", '%', '¨', '&', '*', '(', ')', '_', '-', '+', '=', ';', ':', ',', '\\', '|', '£', '¢', '¬', '/', '?', '°', '´', '`', '{', '}', '[', ']', 'ª', 'º', '~', '^', "\'", "\""];

	$replacement = str_replace($regx, '|', trim(strtolower($string)));
	$explode = explode('|', $replacement);

	for ($i = 0; $i < count($explode); $i++) {
		if (!empty($explode[$i])) {
			$output[] = trim($explode[$i]);
		}
	}

	return implode($replace, $output);

}
