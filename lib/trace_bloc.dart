// Bloc Implementation
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracing/trace_event.dart';

class TraceBloc extends Bloc<TraceEvent, TraceState> {
  final double minPosition = 0;
  final double maxPosition = 175;

  TraceBloc() : super(TraceState(0)) {
    on<TraceMoveEvent>((event, emit) {
      double newPosition = state.tracePosition + event.delta;
      if (newPosition < minPosition) newPosition = minPosition;
      if (newPosition > maxPosition) newPosition = maxPosition;
      emit(TraceState(newPosition));
    });
  }
}
