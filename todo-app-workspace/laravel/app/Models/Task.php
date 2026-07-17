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
        
    ];

    protected $casts = [
        'due_at' => 'date_time',
        'completed_at' => 'date_time',
    ];

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
