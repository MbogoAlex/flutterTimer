import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time/bloc/timer_bloc.dart';
import 'package:flutter_time/timer/timer_event.dart';
import 'package:flutter_time/timer/timer_state.dart';

class ScreenActions extends StatelessWidget {
  const ScreenActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...switch (state) {
                TimerInitialState() => [
                    FloatingActionButton(
                      onPressed: () => BlocProvider.of<TimerBloc>(context).add(
                        TimerStarted(duration: state.duration),
                      ),
                      child: Icon(Icons.play_arrow),
                    ),
                  ],
                TimerRunInProgress() => [
                    FloatingActionButton(
                      onPressed: () => BlocProvider.of<TimerBloc>(context).add(
                        TimerPaused(),
                      ),
                      child: Icon(Icons.pause),
                    ),
                    FloatingActionButton(
                      onPressed: () => BlocProvider.of<TimerBloc>(context).add(
                        TimerReset(),
                      ),
                      child: Icon(Icons.play_arrow),
                    )
                  ],
                TimerRunPause() => [
                    FloatingActionButton(
                      onPressed: () => BlocProvider.of<TimerBloc>(context).add(
                        TimerResumed(),
                      ),
                      child: Icon(Icons.play_arrow),
                    ),
                  ],
                TimerRunComplete() => [
                    FloatingActionButton(
                      onPressed: () => BlocProvider.of<TimerBloc>(context).add(
                        TimerReset(),
                      ),
                      child: Icon(Icons.replay),
                    ),
                  ],
              }
            ],
          );
        });
  }
}
