import 'dart:async';

enum ActionEvent { increment, decrement, reset }

class CounterBlock {
  final _countValueStreamController = StreamController<int>();

  StreamSink<int> get countValueSink => _countValueStreamController.sink;

  Stream<int> get countValueStream => _countValueStreamController.stream;

  final _eventBtnStreamController = StreamController<ActionEvent>();

  StreamSink<ActionEvent> get eventBtnSink => _eventBtnStreamController.sink;

  Stream<ActionEvent> get eventBtnStream => _eventBtnStreamController.stream;

  CounterBlock() {
    int count = 0;
    eventBtnStream.listen((event) {
      if (event == ActionEvent.increment) {
        count++;
      } else if (event == ActionEvent.decrement) {
        count--;
      } else if (event == ActionEvent.reset) {
        count = 0;
      }

      countValueSink.add(count);
    });
  }

  dispose() {
    _eventBtnStreamController.close();
    _countValueStreamController.close();
  }
}
