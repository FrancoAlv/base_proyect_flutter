

sealed class GetListCatError{

}


class LimitCannotBeLessZero extends GetListCatError{

}

class PageCannotBeLessZero extends GetListCatError{

}

class ArrayWithoutElements extends GetListCatError{

}

class ErrorHttpCat extends GetListCatError{

}