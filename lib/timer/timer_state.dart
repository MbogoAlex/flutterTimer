import 'package:equatable/equatable.dart';

sealed class TimerState extends Equatable {
  final int duration;
  const TimerState({required this.duration});

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}

class TimerInitialState extends TimerState {
  const TimerInitialState({required super.duration});
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress({required super.duration});
}

class TimerRunPause extends TimerState {
  const TimerRunPause({required super.duration});
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(duration: 0);
}
