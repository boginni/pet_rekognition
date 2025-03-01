class Either<L, R> {
  final L? _left;
  final R? _right;

  Either.left(this._left) : _right = null;

  Either.right(this._right) : _left = null;

  L get left => _left as L;

  R get right => _right as R;

  bool get isLeft => _left != null;

  bool get isRight => _right != null;

  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    if (isLeft) {
      return onLeft(left);
    }

    return onRight(right);
  }
}
