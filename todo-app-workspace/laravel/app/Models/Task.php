<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Task extends Model
{
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'priority',
        'due_at',
    ];

    protected function casts() : array 
    {
        return[
        'due_at' => 'datetime',
        'completed_at' => 'datetime',
    ];
    }

    public function users() {
        return $this->belongsToMany(User::class);
    }

    public function getIsOverdueAttribute(): bool {
        if($this->completed_at){
            return false;
        }

        if($this->due_at && $this->due_at->isPast()){
            return true;
        }

        return false;
    }
}
