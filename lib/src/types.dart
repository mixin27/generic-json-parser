/// `Model.fromJson` callback type
// typedef FromJsonCallback<E> = E Function(Map<String, dynamic> json);
typedef FromJsonCallback<E, T> = E Function(T json);
