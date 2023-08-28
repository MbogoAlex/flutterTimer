import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time/bloc/timer_bloc.dart';
import 'package:flutter_time/screens/actions.dart';
import 'package:flutter_time/ticker.dart';

import 'background.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(
        ticker: Ticker(),
      ),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Timer"),
      ),
      body: const Stack(
        children: [
          BackGround(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: TimerText(),
                ),
              ),
              ScreenActions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select(
      (TimerBloc bloc) => bloc.state.duration,
    );
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minuteStr:$secondStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
