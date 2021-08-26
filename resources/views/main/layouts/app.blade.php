<!DOCTYPE html>
<!--[if lt IE 8 ]><html class="ie ie7" lang="pt-bt"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="pt-br"> <![endif]-->
<!--[if (gte IE 8)|!(IE)]><!-->
<html lang="{{ !isset($_COOKIE['idioma']) ? get_config('language') : $_COOKIE['idioma'] }}">
<!--<![endif]-->

<head>
    <meta charset="utf-8">
    <meta name="Organização Atos" content="Organização Atos">
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="index, follow">

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="theme-color" content="{{ config('theme_color') }}">
    <meta name="apple-mobile-web-app-status-bar-style" content="{{ config('theme_color') }}">
    <meta name="msapplication-navbutton-color" content="{{ config('theme_color') }}">

    <title>{{ tradutor(get_config('site_title')) }} - @yield('title')</title>

    @include('main.layouts.styles')

</head>

{{-- <body> --}}

<body class="horizontal-layout page-header-light horizontal-menu 2-columns" data-open="click"
    data-menu="horizontal-menu" data-col="2-columns">

    @include('main.layouts.header')

    @section('container')
        @yield('content')
    @show

    @include('main.layouts.footer')

    @include('main.layouts.scripts')

</body>

</html>
