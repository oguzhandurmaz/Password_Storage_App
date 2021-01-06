class Result<T>{
  Result();

  factory Result.success(T value) = SuccessState<T>;
  factory Result.error(T message) = ErrorState<T>;
  factory Result.loading([T message]) = LoadingState<T>;
  factory Result.idle(T message) = IdleState<T>;

}

class SuccessState<T> extends Result<T>{
  SuccessState(this.value): super();
  final T value;
}
class ErrorState<T> extends Result<T>{
  ErrorState(this.message): super();
  final T message;
}
class LoadingState<T> extends Result<T>{
  LoadingState([this.message]): super();
  final T message;
}

class IdleState<T> extends Result<T>{
  IdleState(this.message) : super();
  final T message;
}