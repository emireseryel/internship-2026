<?php

namespace App\Http\Controllers;
use App\Models\Book;
use App\Models\Author;
use Illuminate\Http\Request;

class BookController extends Controller
{
    public function index(){
        $books=Book::with('authors')->get();
        return view('books.index',compact('books'));
    }

    public function create(Author $givenAuthor) {
        $authors=Author::all();
        return view('books.create',compact('authors','givenAuthor'));
    }

    public function store(Request $request){
        $validated = $request->validate([
            'title' => 'required|string',
            'total_copies' => 'required|integer|min:0',
            'authors_ids' => 'required|exists:authors,id',
            'isbn' => 'required|string',
        ]);
        $book = Book::create(collect($validated)->only(['title', 'total_copies', 'isbn'])->all());
        $book->authors()->attach($validated['authors_ids']);

        return redirect()->route('books.index')->with('success','Book has added successfully.');
    }

    public function edit(Book $book) {
        $authors = Author::all();
        return view('books.edit',compact('book','authors'));
    }

    public function update(Request $request,Book $book) {
        $validated = $request->validate([
            'title' => 'required|string',
            'total_copies' => 'integer',
            'authors_ids' => 'array',
            'isbn' => 'required|string',
        ]);

        $book->update(collect($validated)->only(['title', 'total_copies', 'isbn'])->all());

        $book->authors()->sync($validated['authors_ids']);

        return redirect()->route('books.index')->with('success', 'Book has updated.');
    }

    public function destroy(Book $book) {
        $book->authors()->detach();
        $book->delete();

        return redirect()->route('books.index')->with('success', 'Book has deleted.');
    }

}