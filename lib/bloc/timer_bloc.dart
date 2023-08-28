import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_time/ticker.dart';
import 'package:flutter_time/timer/timer_event.dart';
import 'package:flutter_time/timer/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;
  StreamSubscription? _streamSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitialState(duration: _duration)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
  }
  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(duration: event.duration));
    _streamSubscription?.cancel();
    _streamSubscription = _ticker.tick(event.duration).listen((duration) {
      add(TimerTicked(duration: duration));
    });
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(duration: event.duration)
          : TimerRunComplete(),
    );
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _streamSubscription?.pause();
      emit(TimerRunPause(duration: state.duration));
    }
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _streamSubscription?.resume();
      emit(TimerRunInProgress(duration: state.duration));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _streamSubscription?.cancel();
    emit(const TimerInitialState(duration: _duration));
  }
}
