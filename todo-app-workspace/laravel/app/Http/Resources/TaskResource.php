<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TaskResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
        'id' => $this->id,
        'title' => $this->title,
        'description' => $this->description,
        'priority' => $this->priority,
        'due_at' => $this->due_at ? $this->due_at->toIso8601String() : null,
        'completed_at' => $this->completed_at ? $this->completed_at->toIso8601String() : null,
        'is_overdue' => $this->is_overdue,
        'created_at' => $this->created_at->toIso8601String(),
    ];
    }
}
