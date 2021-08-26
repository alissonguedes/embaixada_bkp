 @if (session()->has('userdata'))
     <aside class="sidenav-main sidenav-light sidenav-active-square scrollbar nav-lock nav-expanded">

         <div class="brand-sidebar">

             <h1 class="logo-wrapper">
                 <img src="{{ asset('assets/tacticweb/img/ltw.png') }}" class="img_cem">
             </h1>

         </div>

         <ul id="slide-out"
             class="scrollbar scrollbar-primary sidenav sidenav-collapsible leftside-navigation collapsible sidenav-fixed menu-shadow"
             data-menu="menu-navigation" data-collapsible="menu-accordion">

             <li>
                 <a href="{{ route('admin.dashboard') }}" class="waves-effect waves-cyan">
                     {{-- <i class="material-icons">home</i> --}}
                     Dashboard
                 </a>
             </li>
             {{-- <li>
                 <a href="{{ route('admin.banners') }}">
                     Banners
                 </a>
             </li> --}}
             <li>
                 <a href="{{ route('admin.menus') }}">
                     Menus do site
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.paginas') }}">
                     Páginas
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.noticias') }}">
                     Notícias
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.fotos') }}">
                     Galeria de Fotos
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.links') }}">
                     Links Rápidos
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.contato') }}">
                     Contato
                 </a>
             </li>
             {{-- <li>
                 <a href="{{ route('admin.intencoes') }}">
                     Intenções de Compra
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.distribuidores') }}">
                     Distribuidores
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.emails') }}">
                     E-mail
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.emails.template') }}">
                     Editar Template de e-mail
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.localidades') }}">
                     Localidades
                 </a>
             </li>
             <li>
				 <a href="{{ route('admin.dicionario') }}">
					Dicionário
				</a>
			</li> --}}
             <li>
                 <a href="{{ route('admin.usuarios') }}">
                     Gerenciar Usuários
                 </a>
             </li>
             <li>
                 @if (session()->get('userdata')['id_grupo'] == 1)
                     <a href="{{ route('admin.idiomas') }}">
                         Gerenciar Idiomas
                     </a>
                 @endif
             </li>
             <li>
                 <a href="{{ asset('/') }}" target="_blank">
                     Acessar o site
                 </a>
             </li>
             <li>
                 <a href="{{ route('admin.auth.logout') }}">
                     Sair
                 </a>
             </li>
         </ul>

         <a href="#" data-target="slide-out"
             class="sidenav-trigger btn-sidenav-toggle btn-floating btn-medium waves-effect waves-light hide-on-large-only">
             <div class="bt_mob" id="menu_mob" data-element=".menu_dashboard">
                 <img src="img/bt_mob.png" class="img_cem">
             </div>
             {{-- <i class="material-icons">menu</i> --}}
         </a>

     </aside>
 @endif