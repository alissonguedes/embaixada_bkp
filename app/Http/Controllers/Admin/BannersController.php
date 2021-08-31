<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class BannersController extends Controller
{

    public function index(Request $request)
    {

        if (!Session::has('userdata')) {

            if ($request->ajax()) {
                return abort(403);
            } else {
                return redirect()->route('admin.auth.login');
            }

        }

        return response(view('admin.banners.index'), 200);

    }

}
