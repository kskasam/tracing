abstract class TraceEvent {}

class TraceMoveEvent extends TraceEvent {
  final double delta;
  TraceMoveEvent(this.delta);
}

// Bloc State
class TraceState {
  final double tracePosition;
  TraceState(this.tracePosition);
}
