<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Loan extends Model
{
    protected $fillable = [
    'book_id',
    'member_id',
    'borrowed_at', 
    'due_at', 
    'returned_at'];

    public function getIsOverdueAttribute()
    {
        return is_null($this->returned_at) && Carbon::parse($this->due_at)->isPast();
    }

    public function book() {
        return $this->belongsTo(Book::class);
    }

    public function member() {
        return $this->belongsTo(Member::class);
    }
}
