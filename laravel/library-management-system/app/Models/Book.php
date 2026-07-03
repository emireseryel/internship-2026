<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Book extends Model
{   
    protected $fillable = ['title', 'total_copies', 'isbn'];
    
    public function authors(){
        return $this->belongsToMany(Author::class);
    }

    public function loans() {
        return $this->hasMany(Loan::class);
    }
}
