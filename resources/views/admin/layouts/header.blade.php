@section('title', 'Título da página')
@section('search-name', 'Pesquisar na página')

    <header class="page-topbar" id="header">
        <div class="navbar navbar-fixed">
            <nav class="navbar-main navbar-color nav-collapsible">

                <div class="nav-wrapper">
                    <div class="header">
                    @section('search')
                        <div class="header-search-wrapper hide-on-med-and-down grey-text">
                            <label for="search">
                                <i class="material-icons prefix">search</i>
                            </label>
                            <input type="search" name="search" id="search"
                                class="header-search-input z-depth-2 dataTable_search border-rounded"
                                placeholder="@yield('placeholder')" autocomplete="off">
                        </div>
                    @show
                    <div class="page-title">
                        @section('header')
                            <h5 class="title">@yield('title')</h5>
                        @show
                    </div>
                    @section('navbar-header')
                        <ul class="navbar-list right hide">
                            <li class="dropdown-language">
                                <a class="waves-effect waves-block waves-light translation-button" href="#"
                                    data-target="translation-dropdown">
                                    <span class="flag-icon flag-icon-gb"></span>
                                </a>
                                <ul class="dropdown-content" id="translation-dropdown" tabindex="0">
                                    <li class="dropdown-item" tabindex="0">
                                        <a class="grey-text text-darken-1" href="#!" data-language="en">
                                            <i class="flag-icon flag-icon-gb"></i>
                                            English
                                        </a>
                                    </li>
                                    <li class="dropdown-item" tabindex="0"><a class="grey-text text-darken-1" href="#!"
                                            data-language="fr">
                                            <i class="flag-icon flag-icon-fr"></i>
                                            French
                                        </a>
                                    </li>
                                    <li class="dropdown-item" tabindex="0"><a class="grey-text text-darken-1" href="#!"
                                            data-language="pt">
                                            <i class="flag-icon flag-icon-pt"></i>
                                            Portuguese
                                        </a>
                                    </li>
                                    <li class="dropdown-item" tabindex="0"><a class="grey-text text-darken-1" href="#!"
                                            data-language="de">
                                            <i class="flag-icon flag-icon-de"></i>
                                            German
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="hide-on-med-and-down">
                                <a class="waves-effect waves-block waves-light toggle-fullscreen"
                                    href="javascript:void(0);">
                                    <i class="material-icons">settings_overscan</i>
                                </a>
                            </li>
                            <li class="hide-on-large-only search-input-wrapper">
                                <a class="waves-effect waves-block waves-light search-button" href="javascript:void(0);">
                                    <i class="material-icons">search</i>
                                </a>
                            </li>
                            <li>
                                <a class="waves-effect waves-block waves-light notification-button"
                                    href="javascript:void(0);" data-target="notifications-dropdown">
                                    <i class="material-icons">
                                        notifications_none
                                        <small class="notification-badge">5</small>
                                    </i>
                                </a>
                                <ul class="dropdown-content" id="notifications-dropdown" tabindex="0">
                                    <li tabindex="0">
                                        <h6>NOTIFICATIONS<span class="new badge">5</span></h6>
                                    </li>
                                    <li class="divider" tabindex="0"></li>
                                    <li tabindex="0"><a class="black-text" href="#!"><span
                                                class="material-icons icon-bg-circle cyan small">add_shopping_cart</span> A
                                            new
                                            order has been placed!</a>
                                        <time class="media-meta grey-text darken-2" datetime="2015-06-12T20:50:48+08:00">2
                                            hours
                                            ago</time>
                                    </li>
                                    <li tabindex="0"><a class="black-text" href="#!"><span
                                                class="material-icons icon-bg-circle red small">stars</span> Completed the
                                            task</a>
                                        <time class="media-meta grey-text darken-2" datetime="2015-06-12T20:50:48+08:00">3
                                            days
                                            ago</time>
                                    </li>
                                    <li tabindex="0"><a class="black-text" href="#!"><span
                                                class="material-icons icon-bg-circle teal small">settings</span> Settings
                                            updated</a>
                                        <time class="media-meta grey-text darken-2" datetime="2015-06-12T20:50:48+08:00">4
                                            days
                                            ago</time>
                                    </li>
                                    <li tabindex="0"><a class="black-text" href="#!"><span
                                                class="material-icons icon-bg-circle deep-orange small">today</span>
                                            Director
                                            meeting started</a>
                                        <time class="media-meta grey-text darken-2" datetime="2015-06-12T20:50:48+08:00">6
                                            days
                                            ago</time>
                                    </li>
                                    <li tabindex="0"><a class="black-text" href="#!"><span
                                                class="material-icons icon-bg-circle amber small">trending_up</span>
                                            Generate
                                            monthly report</a>
                                        <time class="media-meta grey-text darken-2" datetime="2015-06-12T20:50:48+08:00">1
                                            week
                                            ago</time>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a class="waves-effect waves-block waves-light profile-button" href="javascript:void(0);"
                                    data-target="profile-dropdown">
                                    <span class="avatar-status avatar-online">
                                        <img src="../../../app-assets/images/avatar/avatar-7.png" alt="avatar">
                                        <i></i>
                                    </span>
                                </a>
                                <ul class="dropdown-content" id="profile-dropdown" tabindex="0">
                                    <li tabindex="0">
                                        <a class="grey-text text-darken-1" href="user-profile-page.html">
                                            <i class="material-icons">person_outline</i>
                                            Profile
                                        </a>
                                    </li>
                                    <li tabindex="0">
                                        <a class="grey-text text-darken-1" href="app-chat.html">
                                            <i class="material-icons">chat_bubble_outline</i>
                                            Chat</a>
                                    </li>
                                    <li tabindex="0">
                                        <a class="grey-text text-darken-1" href="page-faq.html">
                                            <i class="material-icons">help_outline</i>
                                            Help
                                        </a>
                                    </li>
                                    <li class="divider" tabindex="0"></li>
                                    <li tabindex="0">
                                        <a class="grey-text text-darken-1" href="user-lock-screen.html"><i
                                                class="material-icons">lock_outline</i>
                                            Lock
                                        </a>
                                    </li>
                                    <li tabindex="0">
                                        <a class="grey-text text-darken-1" href="user-login.html">
                                            <i class="material-icons">keyboard_tab</i>
                                            Logout
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a class="waves-effect waves-block waves-light sidenav-trigger" href="#"
                                    data-target="slide-out-right">
                                    <i class="material-icons">format_indent_increase</i>
                                </a>
                            </li>
                        </ul>
                    @show

                </div>

            </div>
            <nav class="display-none search-sm">
                <div class="nav-wrapper">
                    <form id="navbarForm">
                        <div class="input-field search-input-sm">
                            <input class="search-box-sm mb-0" type="search" required="" id="search"
                                placeholder="Explore Materialize" data-search="template-list">
                            <label class="label-icon active" for="search"><i
                                    class="material-icons search-sm-icon">search</i></label><i
                                class="material-icons search-sm-close">close</i>
                            <ul class="search-list collection search-list-sm display-none ps">
                                <div class="ps__rail-x" style="left: 0px; bottom: 0px;">
                                    <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                                </div>
                                <div class="ps__rail-y" style="top: 0px; right: 0px;">
                                    <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                                </div>
                            </ul>
                        </div>
                    </form>
                </div>
            </nav>
        </nav>
    </div>
</header>
