class Ticker {
  const Ticker();

  Stream<int> tick(int ticks) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

class Ticker2 {
  const Ticker2();

  Stream<int> tick(int ticks) async* {
    for (int i = ticks; i > 0; i--) {
      print(i);
      yield i;
      await Duration(seconds: 1);
    }
  }
}
