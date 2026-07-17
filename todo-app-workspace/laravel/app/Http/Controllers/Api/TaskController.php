<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\TaskResource;
use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index(Request $request) {
        $query = $request->user()->tasks();

        if($query->has('status')){
            if($request->query('status') === 'completed'){
                $query->whereNotNull('completed_at');
            }else if ($request->query('status') === 'active'){
                $query->whereNull('completed_at');
            }
        }

        $tasks = $query->latest()->get();

        return TaskResource::collection($tasks);
    }

    public function store(Request $request) {
        $validated = $request->validate([
        'title' => 'required|string',
        'description' => 'nullable|string',
        'priority' => 'nullable|string|in:low,medium,high',
        'due_at' => 'nullable|date',
        ]);

        $task = $request->user()->tasks()->create([
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
            'priority' => $validated['priority'] ?? 'medium',
            'due_at' => $validated['due_at'] ?? null,
        ]);

        return new TaskResource($task);
    }

    public function update(Request $request,Task $task) {
        if($task->user_id != $request->user->id){
            return response()->json([
                'message' => 'Error 403-Forbidden.'
            ], 403);
        }

        $validated = $request->validate([
        'title' => 'required|string',
        'description' => 'nullable|string',
        'priority' => 'nullable|string|in:low,medium,high',
        'due_at' => 'nullable|date',
        ]);

        $task->update($validated);

        return new TaskResource($task);
    }

    public function destroy(Request $request,Task $task) {
        if($task->user_id != $request->user->id){
            return response()->json([
                'message' => 'Error 403-Forbidden.'
            ], 403);
        }

        $task->delete();
        return response()->json(['message' => 'Task deleted.']);
    }

    public function complete(Request $request, Task $task) {
        if($task->user_id != $request->user->id){
            return response()->json([
                'message' => 'Error 403-Forbidden.'
            ], 403);
        }

        $task->completed_at = $task->completed_at ? null : now();
        $task->save();

        return new TaskResource($task);
    }
}
