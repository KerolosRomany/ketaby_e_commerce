abstract class BooksStates {}

class InitialBooksState extends BooksStates {}
class HomeSuccessfulGetAllBooksState extends BooksStates {}
class BooksSuccessfulGetResultsFromSearch extends BooksStates {}
class BooksSuccessfulGetSpecificBookState extends BooksStates {}
class HomeSuccessfulGetFavoriteBooksState extends BooksStates {}
class BooksChangeFavoriteIconState extends BooksStates {}