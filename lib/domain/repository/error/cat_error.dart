
sealed class CatError{

}

class CatErrorHttp extends CatError{

    int code;
    String message;

    CatErrorHttp({required this.code,required this.message});

}

class CatErrorWithoutBody extends CatError{}








