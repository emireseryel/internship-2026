<?php

namespace App\Http\Controllers;

use App\Models\Author;
use Illuminate\Http\Request;

class AuthorController extends Controller
{
    public function index(){
        $authors = Author::withCount('books')->latest()->get();
        return view('authors.index',compact('authors'));
    }

    public function create(){
        return view('authors.create');
    }

    public function store(Request $request){
        $validated = $request->validate([
            'name' => 'required|string|unique:authors,name',
        ]);
        Author::create($validated);

        return redirect()->route('authors.index')->with('success','Author has added successfully.');
    }

    public function edit(Author $author)
    {
        return view('authors.edit', compact('author'));
    }

    public function update(Request $request, Author $author)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $author->update($validated);

        return redirect()->route('authors.index')->with('success', 'Author has updated.');
    }

    public function destroy(Author $author)
    {
        $author->delete();

        return redirect()->route('authors.index')->with('success', 'Author has deleted.');
    }

    public function show(Author $author) {
        $books = $author->books;
        return view('authors.show',compact('author','books'));
    }

}