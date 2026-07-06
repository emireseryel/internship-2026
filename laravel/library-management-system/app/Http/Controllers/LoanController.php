<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;
use App\Models\Member;
use App\Models\Loan;
class LoanController extends Controller
{
    public function index()
    {
        $loans = Loan::has('book')->has('member')->get();

        return view('loans.index', compact('loans'));
    }

    public function create() {
        $books=Book::all();
        $members=Member::all();
        return view('loans.create', compact('books', 'members'));
    }

    public function createLoan(Book $book) {
        $members=Member::all();
        return view('loans.createLoan',compact('book','members'));
    }

    public function createLoanForMember(Member $member) {
        $books=Book::all();
        return view('loans.createLoanForMember',compact('books','member'));
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'book_id' => 'required|exists:books,id',
            'member_id' => 'required|exists:members,id',
        ]);

        $book = Book::findOrFail($request->book_id);
        $activeLoansCount = $book->loans()->whereNull('returned_at')->count();

        if($activeLoansCount >= $book->total_copies){
            return redirect()->back()->withErrors(['book_id' => 'There is no avalible book. '])->withInput();
        }

        $hasSameBook = Loan::where('member_id',$request->member_id)
            ->where('book_id',$request->book_id)->whereNull('returned_at')->exists();

        if($hasSameBook){
            return redirect()->back()->withErrors(['book_id' => 'This member already has an active loan for this book.'])->withInput();
        }

        $memberLoanCount = Loan::where('member_id', $request->member_id)->whereNull('returned_at')->count();

        if($memberLoanCount>=3){
            return redirect()->back()->withErrors(['member_id' => 'This member already has 3 active loan for this book.'])->withInput();
        }

        Loan::create([
            'book_id'   => $request->book_id,
            'member_id' => $request->member_id,
            'borrowed_at' => now(), 
            'due_at'    => now()->addDays(14), 
        ]);

        return redirect()->route('loans.index')->with('success', 'Book loaned successfully.');
    }

    public function returnBook(Loan $loan) {
        $loan->returned_at = now();
        $loan->save();

        return redirect()->back()->with('success','Book has returned.');
    }

    
}
