<!DOCTYPE html>
<!--[if lt IE 8 ]><html class="ie ie7" lang="pt-bt"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="pt-br"> <![endif]-->
<!--[if (gte IE 8)|!(IE)]><!-->
<html lang="<?= !isset($_COOKIE['idioma']) ? get_config('language') : $_COOKIE['idioma'] ?>">
<!--<![endif]-->

<head>

    <meta charset="utf-8">
    <meta name="Organização Atos" content="Organização Atos">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="index, follow">

    <title><?= tradutor('__PAGE_TITLE__') ?> - @yield('title')</title>

    @include('main.layouts.styles')

</head>

<body>

    @include('main.layouts.header')

    @section('container')
        @yield('content')
    @show

    @include('main.layouts.footer')

    @include('main.layouts.scripts')

</body>

</html>
