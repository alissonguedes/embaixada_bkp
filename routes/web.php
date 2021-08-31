<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Main\ApiController as API;
use App\Http\Controllers\Main\HomeController as Home;
use App\Http\Controllers\Main\PaginasController as Paginas;
use App\Http\Controllers\Main\NoticiasController as Noticias;

use App\Http\Controllers\Admin\ApiController;
use App\Http\Controllers\Admin\AuthController;
use App\Http\Controllers\Admin\HomeController as Dashboard;
use App\Http\Controllers\Admin\MenusController;
use App\Http\Controllers\Admin\IdiomasController;
use App\Http\Controllers\Admin\BannersController;
use App\Http\Controllers\Admin\NoticiasController;
use App\Http\Controllers\Admin\PaginasController;
use App\Http\Controllers\Admin\LinksRapidosController;
use App\Http\Controllers\Admin\FotosController;
use App\Http\Controllers\Admin\ContatoController;
use App\Http\Controllers\Admin\UsuariosController;

use  App\Models\Main\PaginaModel;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/



/** Rotas para a área administrativa */
Route::prefix('/admin') -> group(function($admin){

	Route::get('/', [AuthController::class, 'index']) -> name('admin.auth.index');
	Route::get('/dashboard', [Dashboard::class, 'index']) -> name('admin.dashboard');
	Route::get('/logout', [AuthController::class, 'logout']) -> name('admin.auth.logout');
	Route::get('/api/token', [ApiController::class, 'token']) -> name('api.token');
	Route::post('/api/tinymce', [ApiController::class, 'upload_img_tinymce']) -> name('api.tinymce');

	/** Login */
	Route::prefix('login') -> group(function() {

		Route::get('/', [AuthController::class, 'index']) -> name('admin.auth.index');
		Route::post('/', [AuthController::class, 'login']) -> name('admin.auth.login');

	});

	/** Banners */
	Route::prefix('banners') -> group(function(){

		Route::get('/', [BannersController::class, 'index']) -> name('admin.banners');
		Route::get('/add', [BannersController::class, 'show_form']) -> name('admin.banners.add');
		Route::get('/{id}', [BannersController::class, 'show_form']) -> name('admin.banners.edit') -> where('id', '[0-9]+');
		Route::post('/', [IdiomasController::class, 'insert']) -> name('admin.banners.insert');
		Route::put('/{id}', [BannersController::class, 'update']) -> name('admin.banners.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}/{valor}', [BannersController::class, 'replace']) -> name('admin.banners.patch') -> where('id', '[0-9]+');
		Route::delete('/', [BannersController::class, 'delete/$1']) -> name('admin.banners.delete');

	});

	/** Categorias */
	Route::prefix('categorias') -> group(function(){

		Route::get('/', [CategoriasController::class, 'index']) -> name('admin.categorias');
		Route::get('/add', [CategoriasController::class, 'show_form']) -> name('admin.categorias.add');
		Route::get('/{id}', [CategoriasController::class, 'show_form']) -> name('admin.categorias.edit') -> where('id', '[0-9]+');
		Route::post('/', [IdiomasController::class, 'insert']) -> name('admin.categorias.insert');
		Route::put('/', [CategoriasController::class, 'update']) -> name('admin.categorias.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}/{valor}', [CategoriasController::class, 'replace']) -> name('admin.categorias.patch') -> where('id', '[0-9]+');
		Route::delete('/', [CategoriasController::class, 'delete/$1']) -> name('admin.categorias.delete');

	});

	/** Menus */
	Route::prefix('menus') -> group(function(){

		Route::get('/', [MenusController::class, 'index']) -> name('admin.menus');
		Route::get('/add', [MenusController::class, 'show_form']) -> name('admin.menus.add');
		Route::get('/{id}', [MenusController::class, 'show_form']) -> name('admin.menus.edit') -> where('id', '[0-9]+');
		Route::post('/', [MenusController::class, 'insert']) -> name('admin.menus.insert');
		Route::put('/', [MenusController::class, 'update']) -> name('admin.menus.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [MenusController::class, 'replace']) -> name('admin.menus.patch');
		Route::delete('/', [MenusController::class, 'delete']) -> name('admin.menus.delete');

	});

	/** Idiomas */
	Route::prefix('idiomas') -> group(function(){

		Route::get('/', [IdiomasController::class, 'index']) -> name('admin.idiomas');
		Route::get('/add', [IdiomasController::class, 'show_form']) -> name('admin.idiomas.add');
		Route::get('/{id?}', [IdiomasController::class, 'show_form']) -> name('admin.idiomas.edit') -> where('id', '[0-9]+');
		Route::post('/', [IdiomasController::class, 'insert']) -> name('admin.idiomas.insert');
		Route::put('/', [IdiomasController::class, 'update']) -> name('admin.idiomas.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [IdiomasController::class, 'replace']) -> name('admin.idiomas.patch');
		Route::delete('/', [IdiomasController::class, 'delete']) -> name('admin.idiomas.delete');

	});

	/** Páginas */
	Route::prefix('paginas') -> group(function(){

		Route::get('/', [PaginasController::class, 'index']) -> name('admin.paginas');
		Route::get('/add', [PaginasController::class, 'show_form']) -> name('admin.paginas.add');
		Route::get('/{id}', [PaginasController::class, 'show_form']) -> name('admin.paginas.edit') -> where('id', '[0-9]+');
		Route::post('/', [PaginasController::class, 'insert']) -> name('admin.paginas.insert');
		Route::put('/', [PaginasController::class, 'update']) -> name('admin.paginas.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [PaginasController::class, 'replace']) -> name('admin.paginas.patch') -> where('id', '[0-9]+');
		Route::delete('/', [PaginasController::class, 'delete']) -> name('admin.paginas.delete');

		Route::delete('{id}/arquivo/{file}', [PaginasController::class, 'delete_file']) -> name('admin.paginas.delete.file');

	});

	/** Links Rápidos */
	Route::prefix('links') -> group(function(){

		Route::get('/', [LinksRapidosController::class, 'index']) -> name('admin.links');
		Route::get('/add', [LinksRapidosController::class, 'show_form']) -> name('admin.links.add');
		Route::get('/{id}', [LinksRapidosController::class, 'show_form']) -> name('admin.links.edit') -> where('id', '[0-9]+');
		Route::post('/', [LinksRapidosController::class, 'insert']) -> name('admin.links.insert');
		Route::put('/', [LinksRapidosController::class, 'update']) -> name('admin.links.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [LinksRapidosController::class, 'replace']) -> name('admin.links.patch') -> where('id', '[0-9]+');
		Route::delete('/', [LinksRapidosController::class, 'delete']) -> name('admin.links.delete');

		Route::delete('{id}/arquivo/{file}', [LinksRapidosController::class, 'delete_file']) -> name('admin.links.delete.file');

	});

	/** Notícias */
	Route::prefix('noticias') -> group(function(){

		Route::get('/', [NoticiasController::class, 'index']) -> name('admin.noticias');
		Route::get('/add', [NoticiasController::class, 'show_form']) -> name('admin.noticias.add');
		Route::get('/{id}', [NoticiasController::class, 'show_form']) -> name('admin.noticias.edit') -> where('id', '[0-9]+');
		Route::post('/', [NoticiasController::class, 'insert']) -> name('admin.noticias.insert');
		Route::put('/', [NoticiasController::class, 'update']) -> name('admin.noticias.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [NoticiasController::class, 'replace']) -> name('admin.noticias.patch') -> where('id', '[0-9]+');
		Route::delete('/', [NoticiasController::class, 'delete']) -> name('admin.noticias.delete');

	});

	/** Fotos */
	Route::prefix('fotos') -> group(function(){

		Route::get('/', [FotosController::class, 'index']) -> name('admin.fotos');
		Route::get('/add', [FotosController::class, 'show_form']) -> name('admin.fotos.add');
		Route::get('/{id}', [FotosController::class, 'show_form']) -> name('admin.fotos.edit') -> where('id', '[0-9]+');
		Route::post('/', [FotosController::class, 'insert']) -> name('admin.fotos.insert');
		Route::put('/', [FotosController::class, 'update']) -> name('admin.fotos.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [FotosController::class, 'replace']) -> name('admin.fotos.patch') -> where('id', '[0-9]+');
		Route::delete('/album/{id}', [FotosController::class, 'delete']) -> name('admin.fotos.delete.album') -> where('id', '[0-9]+');

		Route::delete('/fotos/{id}', [FotosController::class, 'delete_file']) -> name('admin.fotos.delete.file');

	});

	/** Contato */
	Route::prefix('contato') -> group(function(){

		// Route::get('/', [ContatoController::class, 'index']) -> name('admin.contato');
		Route::get('/', [ContatoController::class, 'show_form']) -> name('admin.contato');
		Route::get('/add', [ContatoController::class, 'show_form']) -> name('admin.contato.add');
		Route::get('/{id}', [ContatoController::class, 'show_form']) -> name('admin.contato.edit') -> where('id', '[0-9]+');
		Route::post('/', [ContatoController::class, 'insert']) -> name('admin.contato.insert');
		Route::put('/', [ContatoController::class, 'update']) -> name('admin.contato.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [ContatoController::class, 'replace']) -> name('admin.contato.patch') -> where('id', '[0-9]+');
		Route::delete('/', [ContatoController::class, 'delete']) -> name('admin.contato.delete');

	});

	/** Produtos */
	Route::prefix('produtos') -> group(function(){

		Route::get('/', [ProdutosController::class, 'index']) -> name('admin.produtos');
		Route::get('/add', [ProdutosController::class, 'show_form']) -> name('admin.produtos.add');
		Route::get('/{id}', [ProdutosController::class, 'show_form']) -> name('admin.produtos.edit') -> where('id', '[0-9]+');
		Route::post('/', [ProdutosController::class, 'insert']) -> name('admin.produtos.insert');
		Route::put('/', [ProdutosController::class, 'update']) -> name('admin.produtos.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [ProdutosController::class, 'replace']) -> name('admin.produtos.patch') -> where('id', '[0-9]+');
		Route::delete('/', [ProdutosController::class, 'delete']) -> name('admin.produtos.delete');

	});

	/** Distribuidores */
	Route::prefix('distribuidores') -> group(function(){

		Route::get('/', [DistribuidoresController::class, 'index']) -> name('admin.distribuidores');
		Route::get('/add', [DistribuidoresController::class, 'show_form']) -> name('admin.distribuidores.add');
		Route::get('/{id}', [DistribuidoresController::class, 'show_form']) -> name('admin.distribuidores.edit') -> where('id', '[0-9]+');
		Route::post('/', [DistribuidoresController::class, 'insert']) -> name('admin.distribuidores.insert');
		Route::put('/', [DistribuidoresController::class, 'update']) -> name('admin.distribuidores.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [DistribuidoresController::class, 'replace']) -> name('admin.distribuidores.patch') -> where('id', '[0-9]+');
		Route::delete('/', [DistribuidoresController::class, 'delete']) -> name('admin.distribuidores.delete');

	});

	/** Intenções */
	Route::prefix('intencoes') -> group(function(){

		Route::get('/', [IntencoesController::class, 'index']) -> name('admin.intencoes');
		Route::get('/add', [IntencoesController::class, 'show_form']) -> name('admin.intencoes.add');
		Route::get('/{id}', [IntencoesController::class, 'show_form']) -> name('admin.intencoes.edit') -> where('id', '[0-9]+');
		Route::post('/', [IntencoesController::class, 'insert']) -> name('admin.intencoes.insert');
		Route::put('/', [IntencoesController::class, 'update']) -> name('admin.intencoes.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [IntencoesController::class, 'replace']) -> name('admin.intencoes.patch') -> where('id', '[0-9]+');
		Route::delete('/', [IntencoesController::class, 'delete']) -> name('admin.intencoes.delete');

	});

	/** Usuários */
	Route::prefix('usuarios') -> group(function(){

		Route::get('/', [UsuariosController::class, 'index']) -> name('admin.usuarios');
		Route::get('/add', [UsuariosController::class, 'show_form']) -> name('admin.usuarios.add');
		Route::get('/{id}', [UsuariosController::class, 'show_form']) -> name('admin.usuarios.edit') -> where('id', '[0-9]+');
		Route::post('/', [UsuariosController::class, 'insert']) -> name('admin.usuarios.insert');
		Route::put('/', [UsuariosController::class, 'update']) -> name('admin.usuarios.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [UsuariosController::class, 'replace']) -> name('admin.usuarios.patch') -> where('id', '[0-9]+');
		Route::delete('/', [UsuariosController::class, 'delete']) -> name('admin.usuarios.delete');

	});

	/** Dicionario */
	Route::prefix('dicionario') -> group(function(){

		Route::get('/', [DicionarioController::class, 'index']) -> name('admin.dicionario');
		Route::get('/add', [DicionarioController::class, 'show_form']) -> name('admin.dicionario.add');
		Route::get('/{id}', [DicionarioController::class, 'show_form']) -> name('admin.dicionario.edit') -> where('id', '[0-9]+');
		Route::post('/', [DicionarioController::class, 'insert']) -> name('admin.dicionario.insert');
		Route::put('/', [DicionarioController::class, 'update']) -> name('admin.dicionario.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [DicionarioController::class, 'replace']) -> name('admin.dicionario.patch') -> where('id', '[0-9]+');
		Route::delete('/', [DicionarioController::class, 'delete']) -> name('admin.dicionario.delete');

	});

	/** E-mails */
	Route::prefix('emails') -> group(function(){

		Route::get('/', [EmailsController::class, 'index']) -> name('admin.emails');
		Route::get('/template', [EmailsController::class, 'index']) -> name('admin.emails.template');
		Route::get('/add', [EmailsController::class, 'show_form']) -> name('admin.emails.add');
		Route::get('/{id}', [EmailsController::class, 'show_form']) -> name('admin.emails.edit') -> where('id', '[0-9]+');
		Route::post('/', [EmailsController::class, 'insert']) -> name('admin.emails.insert');
		Route::put('/', [EmailsController::class, 'update']) -> name('admin.emails.put') -> where('id', '[0-9]+');
		Route::patch('/{campo}', [EmailsController::class, 'replace']) -> name('admin.emails.patch') -> where('id', '[0-9]+');
		Route::delete('/', [EmailsController::class, 'delete']) -> name('admin.emails.delete');

	});

});

/** Rotas para a área pública */
Route::prefix('/') -> group(function() {

	Route::get('/', [Home::class, 'index']);
	Route::get('/api/token', [API::class, 'token']) -> name('api.token');

	// ApiController
	Route::get('/api/translate/{lang}', [API::class, 'translate']) -> name('api.token');

	// HomeController
	Route::get('/', [Home::class, 'index']);
	Route::get('/home', [Home::class, 'index']) -> name('home');
	Route::get('/inicio', [Home::class, 'index']) -> name('home');
	Route::get('/home-page', [Home::class, 'index']) -> name('home');
	Route::get('/pagina-inicial', [Home::class, 'index']) -> name('home');

	// PageController
	// Route::get('/fotos', [Paginas::class, 'fotos']);
	// Route::get('/fotos/{album}', [Paginas::class, 'fotos']);

	// NoticiasController
	Route::get('/noticias', [Noticias::class, 'index']) -> name('noticias');
	Route::get('/noticias/{id}', [Noticias::class, 'show']) -> name('noticias.id');

	$menus = new PaginaModel();

	foreach ( $menus -> getMenus() as $menu) {
		Route::get('{' . $menu -> link . '}', [Paginas::class, 'index']);
		Route::get('{' . $menu -> link . '}/{param?}', [Paginas::class, 'index']);
	}

});
