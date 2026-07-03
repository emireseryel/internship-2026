<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
    <div class="container col-md-6 mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-warning text-dark">
                <h5 class="mb-0">Edit the Book</h5>
            </div>
            <div class="card-body">
                <form method="POST" action="{{ route('books.update',$book->id) }}">
                    @csrf
                    @method('PUT')
                    <div class="mb-3 w-50">
                        <label for="title" class="form-lable">Books Title</label>
                        <input type="text" name="title" class="form-control" value="{{ $book->title }}" required>
                    </div>

                    <select name="authors_ids[]" multiple  class="form-select w-50">
                            @foreach ($authors as $author)
                                <option value="{{ $author->id }}" @selected($book->authors->contains($author->id))>
                                    {{ $author->name }}
                                </option>
                            @endforeach
                    </select>

                    <div class="mb-3 w-25">
                        <label for="total_copies" class="form-label ">Number of Copies</label>
                        <input type="number" name="total_copies" class="form-control" 
                        value="{{ $book->total_copies }}" required>
                    </div>

                    <div class="mb-3 w-25">
                        <label for="isbn" class="form-label ">ISBN</label>
                        <input type="string" name="isbn" class="form-control" 
                        value="{{ $book->isbn }}" required>
                    </div>


                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="{{ route('books.index') }}" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Update</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>