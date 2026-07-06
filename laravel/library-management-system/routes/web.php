<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\AuthorController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\LoanController;
use App\Http\Controllers\MemberController;
use Illuminate\Support\Facades\Route;
use App\Models\Book;
use App\Models\Member;
use App\Models\Loan;
use App\Models\Author;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    $totalBooks = Book::count();
    $totalMembers = Member::count();
    $totalAuthors = Author::count();
    $activeLoans = Loan::whereNull('returned_at')->count();
    
    // Gecikenleri bulmak için modeldeki getIsOverdueAttribute mantığını query'e döküyoruz:
    $overdueLoans = Loan::whereNull('returned_at')
                        ->where('due_at', '<', now())
                        ->count();

    return view('dashboard', compact('totalBooks', 'totalMembers', 'totalAuthors', 'activeLoans', 'overdueLoans'));
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::resource('authors', AuthorController::class);
    Route::resource('books', BookController::class);
    Route::get('/books/create/{givenAuthor}', [BookController::class, 'create'])->name('books.create');
    Route::post('/loans/{loan}/return', [App\Http\Controllers\LoanController::class, 'returnBook'])->name('loans.return');
    Route::get('/loans/create-loan/{book}', [LoanController::class, 'createLoan'])->name('loans.createLoan');
    Route::get('/loans/create-for-member/{member}', [LoanController::class, 'createLoanForMember'])->name('loans.createLoanForMember');
    Route::resource('loans', LoanController::class);
    
    Route::resource('members', MemberController::class);
});

require __DIR__ . '/auth.php';
