<?php

namespace App\Models\Admin;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class DicionarioModel extends Model
{
    use HasFactory, Notifiable;

	protected $table = 'tb_sys_dicionario';

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
		'label',
		'status',
		null
	];

	public function getIdiomas($find = null) {

		$get = $this -> select('*');

		if ( !is_null($find) ) {
			$get -> where('id', $find);
			return $get ;
		}

		if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
            $get->where(function ($get) {
                $search = $_GET['search']['value'];
                $get->orWhere('id', 'like', $search . '%')
                    ->orWhere('label', 'like', $search . '%')
                    ->orWhere('status', 'like', $search . '%');
            });
        }

		// Order By
		if (isset($_GET['order']) && $_GET['order'][0]['column'] != 0 ) {
			$orderBy[$this -> order[$_GET['order'][0]['column']]] = $_GET['order'][0]['dir'];
		} else {
			$orderBy[$this -> order[1]] = 'desc';
		}

		foreach($orderBy as $key => $val) {
			$get -> orderBy($key, $val);
		}

		return $get -> paginate( 2 ?? $_GET['start']);

	}


}
