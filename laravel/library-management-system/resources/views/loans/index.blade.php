<!DOCTYPE html>
<html lang="tr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loan List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

    <div class="position-fixed bottom-0 end-0 m-4" style="z-index: 1050;">
        <a href="{{ route('dashboard') }}" class="btn btn-dark btn-lg shadow-lg d-flex align-items-center gap-2 rounded-pill px-4 py-2 opacity-90 hover-opacity-100">
            <span>Dashboard</span>
        </a>
    </div>

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-secondary m-0">Loans Management</h2>
            <a href="{{ route('loans.create') }}" class="btn btn-primary shadow-sm">Add New Loan</a>
        </div>

        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col" class="ps-4 py-3">Book</th>
                            <th scope="col" class="py-3">Member</th>
                            <th scope="col" class="py-3">Is Returned?</th>
                            <th scope="col" class="text-end pe-4 py-3">Return</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($loans as $loan)
                        <tr class="{{ $loan->is_overdue ? 'table-danger' : '' }}">
                            <td class="ps-4 fw-semibold text-dark">
                                {{ $loan->book->title }}
                            </td>
                            <td>
                                <span class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2 fw-medium">
                                    {{ $loan->member->name }}
                                </span>
                            </td>
                            <td>
                                @if (!is_null($loan->returned_at))
                                    <span class="badge bg-success">Returned</span>
                                @elseif ($loan->is_overdue)
                                    <span class="badge bg-danger">Overdue</span>
                                @else
                                    <span class="badge bg-warning text-dark">In the Member</span>
                                @endif
                            </td>
                            <td class="text-end pe-4">
                                @if (is_null($loan->returned_at))
                                <form action="{{ route('loans.return', $loan->id) }}" method="POST" class="d-inline">
                                    @csrf
                                    <button type="submit" class="btn btn-sm btn-outline-primary ms-2">Return</button>
                                </form>
                                @endif
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>

</html>