<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Author</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    </head>

    <body>
        <div class="container col-md-6 mt-5">
            <div class="card shadow-sm">
                @csrf
                @method('PUT')
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0">{{ $author->name }}'s Books</h5>
                </div>

                @foreach ($books as $book)
                <div class="card-body p-1">
                    <h3 class="mb-0">- {{ $book->title }}</h3>
                </div>
                @endforeach

                <div class="d-grid gap-2 mb-3 mx-3 d-md-flex justify-content-md-end">
                    <a href="{{ route('authors.index') }}" class="btn btn-danger shadow-sm fixed">Back</a>
                    <a href="{{ route('books.create', $author->id) }}"
                        class="btn btn-success shadow-sm fixed"> Add New Book</a>
                </div>
            </div>
        </div>
        </div>

    </body>

    </html>
</body>

</html>