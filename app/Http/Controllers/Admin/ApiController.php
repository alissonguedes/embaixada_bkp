<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class ApiController extends Controller
{

    public function __construct()
    {
    }

    public function translate($lang) {

        $translate = [];

        setcookie('idioma', $lang, time() + 60 * 60 * 24 * 30, '/');

        $tradutor = $this -> api -> getTranslate($lang);

        return json_encode(['idioma' => $lang]);

    }

	public function token(Request $request) {

		if ( Session::has('app_session') )
			return json_encode(['token' => Session::get('app_session')]);

		return json_encode([]);

	}

}
