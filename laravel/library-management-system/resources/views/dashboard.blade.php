<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Library Automation - Dashboard') }}
        </h2>
    </x-slot>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <div class="py-12 bg-light">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            <div class="row row-cols-1 row-cols-md-5 g-3 mb-5">
                <div class="col">
                    <div class="card border-0 shadow-sm bg-primary text-white h-100 rounded-3">
                        <div class="card-body d-flex flex-column justify-content-center p-3">
                            <h6 class="text-white-50 text-uppercase fw-bold small mb-2">Total Books</h6>
                            <h2 class="m-0 display-6 fw-bold">{{ $totalBooks }}</h2>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card border-0 shadow-sm bg-info text-white h-100 rounded-3">
                        <div class="card-body d-flex flex-column justify-content-center p-3">
                            <h6 class="text-white-50 text-uppercase fw-bold small mb-2">Total Authors</h6>
                            <h2 class="m-0 display-6 fw-bold">{{ $totalAuthors }}</h2>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card border-0 shadow-sm bg-success text-white h-100 rounded-3">
                        <div class="card-body d-flex flex-column justify-content-center p-3">
                            <h6 class="text-white-50 text-uppercase fw-bold small mb-2">Total Members</h6>
                            <h2 class="m-0 display-6 fw-bold">{{ $totalMembers }}</h2>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card border-0 shadow-sm bg-warning text-dark h-100 rounded-3">
                        <div class="card-body d-flex flex-column justify-content-center p-3">
                            <h6 class="text-dark-50 text-uppercase fw-bold small mb-2">Active Loans</h6>
                            <h2 class="m-0 display-6 fw-bold">{{ $activeLoans }}</h2>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card border-0 shadow-sm bg-danger text-white h-100 rounded-3">
                        <div class="card-body d-flex flex-column justify-content-center p-3">
                            <h6 class="text-white-50 text-uppercase fw-bold small mb-2">Overdue Books</h6>
                            <h2 class="m-0 display-6 fw-bold">{{ $overdueLoans }}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-3 p-4 bg-white">
                <h4 class="fw-bold text-secondary mb-4">Quick Management Links</h4>
                <div class="row g-3">
                    
                    <div class="col-md-3">
                        <div class="border rounded-3 p-3 text-center h-100 d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-bold text-dark mb-2">Authors</h5>
                                <p class="text-muted small">Manage book authors and their biographies.</p>
                            </div>
                            <a href="{{ route('authors.index') }}" class="btn btn-outline-info w-100 mt-3">Go to Authors</a>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="border rounded-3 p-3 text-center h-100 d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-bold text-dark mb-2">Books</h5>
                                <p class="text-muted small">Add, list, update or delete library books.</p>
                            </div>
                            <a href="{{ route('books.index') }}" class="btn btn-outline-primary w-100 mt-3">Go to Books</a>
                        </div>
                    </div>
                    
                    <div class="col-md-3">
                        <div class="border rounded-3 p-3 text-center h-100 d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-bold text-dark mb-2">Members</h5>
                                <p class="text-muted small">Manage readers, edit contact details and profiles.</p>
                            </div>
                            <a href="{{ route('members.index') }}" class="btn btn-outline-success w-100 mt-3">Go to Members</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="border rounded-3 p-3 text-center h-100 d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-bold text-dark mb-2">Loans & Returns</h5>
                                <p class="text-muted small">Track book issues, due dates and return actions.</p>
                            </div>
                            <a href="{{ route('loans.index') }}" class="btn btn-outline-warning text-dark w-100 mt-3">Go to Loans</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</x-app-layout>