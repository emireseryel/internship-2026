<!DOCTYPE html>
<html lang="tr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

    <div class="position-fixed bottom-0 start-0 m-4" style="z-index: 1050;">
        <a href="{{ route('dashboard') }}" class="btn btn-dark btn-lg shadow-lg d-flex align-items-center gap-2 rounded-pill px-4 py-2 opacity-90 hover-opacity-100">
            <span>Dashboard</span>
        </a>
    </div>

    <div class="container my-5">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-secondary m-0">Books Management</h2>
            <a href="{{ route('books.create') }}" class="btn btn-primary shadow-sm">Add New Book
            </a>
        </div>


        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col" class="ps-4 py-3">Book</th>
                            <th scope="col" class="ps-4 py-3">ISBN</th>
                            <th scope="col" class="ps-4 py-3">Avaible/Total Books</th>
                            <th scope="col" class="ps-4 py-3">Authors</th>
                            <th scope="col" class="text-end pe-4 py-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($books as $book)
                        <tr>
                            <td class="ps-4 fw-semibold text-dark">
                                {{ $book->title}}
                            </td>

                            <td>
                                <span class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2 fw-medium">
                                    {{ $book->isbn }}
                                </span>
                            </td>

                            <td class="ps-4 fw-semibold text-dark" align-items-center>
                                {{ $book->total_copies - $book->loans()->whereNull('returned_at')->count() }} / {{ $book->total_copies }}
                            </td>

                            <td>
                                {{ $book->authors->implode('name', ', ')}}
                            </td>

                            <td class="text-end pe-4">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="{{ route('books.edit', $book->id) }}" class="btn btn-sm btn-outline-warning rounded-2 px-3"> Edit
                                    </a>

                                    <form action="{{ route('books.destroy', $book->id) }}"
                                        method="POST" class="d-inline m-0">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-2 px-3" onclick="return confirm('Are you sure you want to delete?')"> Sil
                                        </button>
                                    </form>
                                </div>
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