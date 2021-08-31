<?php

namespace App\Models\Admin;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class FotoModel extends Authenticatable
{

    use HasFactory, Notifiable;

    protected $table = 'tb_album';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    private $order = [
        null,
        'descricao',
        'status',
    ];

    public function getAlbum($find = null)
    {

        $get = $this->select('*');

        if (!is_null($find)) {
            $get->where('id', $find);
            return $get;
        }

        if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
            $get->where(function ($get) {
                $search = $_GET['search']['value'];
                $get->orWhere('id', 'like', $search . '%')
                    ->orWhere('descricao', 'like', $search . '%')
                    ->orWhere('status', 'like', $search . '%');
            });
        }

        // Order By
        if (isset($_GET['order']) && $_GET['order'][0]['column'] != 0) {
            $orderBy[$this->order[$_GET['order'][0]['column']]] = $_GET['order'][0]['dir'];
        } else {
            $orderBy[$this->order[1]] = 'desc';
        }

        foreach ($orderBy as $key => $val) {
            $get->orderBy($key, $val);
        }

        return $get->paginate($_GET['length'] ?? 50);

    }

    public function getLastAlbum()
    {
        return $this->select(DB::raw('MAX(id) AS id'))->first();
    }

    public function getFotos($find = null)
    {

        $get = $this->select('*');

        $get->from('tb_attachment');

        $get->where('id_modulo', $find);
        $get->where('modulo', 'album');

        if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
            $get->where(function ($get) {
                $search = $_GET['search']['value'];
                $get->orWhere('id', 'like', $search . '%')
                    ->orWhere('descricao', 'like', $search . '%')
                    ->orWhere('status', 'like', $search . '%');
            });
        }

        // Order By
        if (isset($_GET['order']) && $_GET['order'][0]['column'] != 0) {
            $orderBy[$this->order[$_GET['order'][0]['column']]] = $_GET['order'][0]['dir'];
        } else {
            $orderBy[$this->order[1]] = 'desc';
        }

        foreach ($orderBy as $key => $val) {
            $get->orderBy($key, $val);
        }

        return $get->paginate($_GET['length'] ?? null);

    }

    public function create($request)
    {

        $traducao = [];
        $data = [
            'nome' => $request->nome,
            'slug' => limpa_string(sha1(uniqid($request->nome))),
            'titulo' => null,
            'descricao' => null,
            'status' => isset($request->status) ? $request->status : '0',
        ];

        // Gravar imagem de capa
        $path = 'assets/embaixada/img/galeria/thumbs/';
        $origName = null;
        $fileName = null;
        $imagem = null;

        if ($request->file('imagem')) {

            $file = $request->file('imagem');

            $fileName = sha1($file->getClientOriginalName());
            $fileExt = $file->getClientOriginalExtension();

            $imgName = explode('.', ($file->getClientOriginalName()));

            $origName = limpa_string($imgName[count($imgName) - 2], '_') . '.' . $fileExt;
            $imagem = limpa_string($fileName) . '.' . $fileExt;

            $file->storeAs($path, $imagem);

        }

        if (!is_null($imagem)) {
            $data['imagem'] = $path . $imagem;
        }

        foreach ($_POST as $ind => $val) {
            $lang = explode(':', $ind);
            if (count($lang) == 2) {
                $traducao[$lang[1]][$lang[0]] = $val;
            }
        }

        $data['titulo'] = !empty($traducao['titulo']) ? json_encode($traducao['titulo']) : null;
        $data['descricao'] = !empty($traducao['descricao']) ? json_encode($traducao['descricao']) : null;

        if ($id = $this->insertGetId($data)) {

            // Gravar Fotos no álbum
            $path = 'assets/embaixada/img/galeria/' . $id . '/';
            $origName = null;
            $fileName = null;
            $imagem = null;

            if ($request->file('arquivo')) {

                $file = $request->file('arquivo');

                foreach ($file as $f) {

                    $fileName = $f->getClientOriginalName();
                    $fileExt = $f->getClientOriginalExtension();
                    $fileExt = $fileExt != '' ? '.' . $fileExt : '.txt';

                    $imgName = explode('.', ($f->getClientOriginalName()));

                    $origName = limpa_string($imgName[count($imgName) - 2 > 0 ? count($imgName) - 2 : 0], '_') . $fileExt;
                    $arquivo = sha1(limpa_string($fileName)) . $fileExt;

                    $issetFoto = $this->from('tb_attachment')
                        ->select('path')
                        ->where('path', $path . $arquivo)
                        ->where('id_modulo', $request->id)
                        ->where('modulo', 'album')
                        ->get()
                        ->first();

                    if (!isset($issetFoto)) {

                        $f->storeAs($path, $arquivo);

                        $files = [
                            'id_modulo' => $id,
                            'modulo' => 'album',
                            'path' => $path . $arquivo,
                            'realname' => $origName,
                            'author' => Session::get('userdata')['nome'],
                            'titulo' => null,
                            'descricao' => null,
                            'clicks' => 0,
                            'url' => null,
                            'size' => $f->getSize(),
                        ];

                        $insert = $this->from('tb_attachment')->insert($files);

                    }

                }

            }

            return true;

        }

        return false;

    }

    public function edit($request, $field = null)
    {

        if (is_null($field)) {

            // Gravar Fotos no álbum
            $path = 'assets/embaixada/img/galeria/' . $request->id . '/';
            $origName = null;
            $fileName = null;
            $imagem = null;

            if ($request->file('arquivo')) {

                $file = $request->file('arquivo');

                foreach ($file as $f) {

                    $fileName = $f->getClientOriginalName();
                    $fileExt = $f->getClientOriginalExtension();
                    $fileExt = $fileExt != '' ? '.' . $fileExt : '.txt';

                    $imgName = explode('.', ($f->getClientOriginalName()));

                    $origName = limpa_string($imgName[count($imgName) - 2 > 0 ? count($imgName) - 2 : 0], '_') . $fileExt;
                    $arquivo = sha1(limpa_string($fileName)) . $fileExt;

                    $issetFoto = $this->from('tb_attachment')
                        ->select('path')
                        ->where('path', $path . $arquivo)
                        ->where('id_modulo', $request->id)
                        ->where('modulo', 'album')
                        ->get()
                        ->first();

                    if (!isset($issetFoto)) {

                        $f->storeAs($path, $arquivo);

                        $files = [
                            'id_modulo' => $request->id,
                            'modulo' => 'album',
                            'path' => $path . $arquivo,
                            'realname' => $origName,
                            'author' => Session::get('userdata')['nome'],
                            'titulo' => null,
                            'descricao' => null,
                            'clicks' => 0,
                            'url' => null,
                            'size' => $f->getSize(),
                        ];

                        $insert = $this->from('tb_attachment')->insert($files);

                    }

                }

            }

            $traducao = [];
            $data = [
                'nome' => $request->nome,
                'slug' => limpa_string(uniqid(sha1($request->nome))),
                'titulo' => null,
                'descricao' => null,
                'status' => isset($request->status) ? $request->status : '0',
            ];

            // Gravar imagem de capa
            $path = 'assets/embaixada/img/galeria/thumbs/';
            $origName = null;
            $fileName = null;
            $imagem = null;

            if ($request->file('imagem')) {

                $file = $request->file('imagem');

                $fileName = sha1($file->getClientOriginalName());
                $fileExt = $file->getClientOriginalExtension();

                $imgName = explode('.', ($file->getClientOriginalName()));

                $origName = limpa_string($imgName[count($imgName) - 2], '_') . '.' . $fileExt;
                $imagem = limpa_string($fileName) . '.' . $fileExt;

                $file->storeAs($path, $imagem);

            }

            if (!is_null($imagem)) {
                $data['imagem'] = $path . $imagem;
            }

            foreach ($_POST as $ind => $val) {
                $lang = explode(':', $ind);
                if (count($lang) == 2 && !is_null($val)) {
                    $traducao[$lang[1]][$lang[0]] = $val;
                }
            }

            $data['titulo'] = !empty($traducao['titulo']) ? json_encode($traducao['titulo']) : null;
            $data['descricao'] = !empty($traducao['descricao']) ? json_encode($traducao['descricao']) : null;

            return $this->where('id', $request->id)->update($data);

        } else {

            $data = [$field => $request->value];

            return $this->whereIn('id', $request->id)->update($data);

        }

    }

    public function remove($id)
    {

        return $this->whereIn('id', $id)->delete();

    }

    public function remove_file($id)
    {

        if (is_array($id)) {
            $column = 'id_modulo';
        } else {
            $column = 'id';
        }

        $files = $this->from('tb_attachment')
            ->select('path')
            ->where($column, $id)
            ->get();

        if (isset($files)) {

            foreach ($files as $file) {

                $file = public_path($file->path);

            }

            $un = file_exists($file) ? unlink($file) : true;

            if ($un) {
                return $this->from('tb_attachment')->where($column, $id)->delete();
            }

            return true;

        }

        return false;

    }

}
