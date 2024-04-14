class Counter{
  int _counter = 0;
  int get value => _counter;

  void incrementCounter(){
    _counter++;
  }

  void restartCounter(){
    _counter = 0;
  }
}