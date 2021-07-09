<?php

namespace App\Models\Main;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LinkModel extends Model
{

    protected $table = 'tb_link';
    use HasFactory;

    private $limit;

	private $order = [
		null,
		'id',
		'descricao',
		'status',
	];

	public function getLink($find = null, $limit = null) {

		$get = $this -> select('*');

		if ( !is_null($find) ) {
			$get -> where('id', $find);
			$get -> orWhere('slug', $find);
			return $get -> first();
		}

		if (isset($_GET['search']['value']) && !empty($_GET['search']['value'])) {
			$get->where(function ($get) {
				$search = $_GET['search']['value'];
				$get->orWhere('id', 'like', $search . '%')
					->orWhere('descricao', 'like', $search . '%')
					->orWhere('status', 'like', $search . '%');
			});
		}

		$get -> where('status', '1');

		// Order By
		if (isset($_GET['order']) && $_GET['order'][0]['column'] != 0 ) {
			$orderBy[$this -> order[$_GET['order'][0]['column']]] = $_GET['order'][0]['dir'];
		} else {
			$orderBy[$this -> order[1]] = 'asc';
		}

		foreach($orderBy as $key => $val) {
			$get -> orderBy($key, $val);
		}

		return $get -> paginate($limit);

	}

}
