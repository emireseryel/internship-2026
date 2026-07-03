<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Member;

class MemberController extends Controller
{
    public function index() {
        $members = Member::all();
        return view('members.index',compact('members'));
    }

    public function create() {
        return view('members.create');
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:members,email',
        ]);

        Member::create($validated);        
        
        return redirect()->route('members.index')->with('success','Member has added successfully.');
    }

    public function edit(Member $member) {
        return view('members.edit',compact('member'));
    }

    public function update(Member $member, Request $request) {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:members,email' . $member->id,
        ]);

        $member->update($validated);

        return redirect()->route('members.index')->with('success', 'Member has updated.');
    }

    public function destroy(Member $member) {
        $member->delete();

        return redirect()->route('members.index')->with('success', 'Member has deleted.');
    }
}
