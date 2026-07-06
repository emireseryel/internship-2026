<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Loan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>

<body>
    <div class="container col-md-6 mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-warning text-dark">
                <h5 class="mb-0">Create New Loan</h5>
            </div>
            <div class="card-body">
                <form method="POST" action="{{ route('loans.store') }}">
                    @csrf
                    <input type="hidden" name="member_id" value="{{ $member->id }}">
                    <label class="form-lable">Member</label>
                        <h4 class="mb-3"> {{ $member->name }}</h4>
                    </select>

                    <label class="form-lable">Books</label>
                    <select name="book_id" multiple class="form-select mb-3 w-50" required>
                        @foreach ($books as $book)
                        <option value="{{ $book->id }}">
                            {{ $book->title }}
                        </option>
                        @endforeach
                    </select>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="{{ route('members.index') }}" class="btn btn-danger shadow-sm fixed">Back</a>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

</html>