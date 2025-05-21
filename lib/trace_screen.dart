import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracing/trace_bloc.dart';
import 'package:tracing/trace_event.dart';

class TraceScreen extends StatelessWidget {
  const TraceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trace the Line')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            BlocBuilder<TraceBloc, TraceState>(
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 20,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.deepPurple, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Tracing line
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 8,
                        height: state.tracePosition + 12.5,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    // Movable circle (draggable)
                    if (state.tracePosition < 175)
                      Positioned(
                        top: state.tracePosition,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            context.read<TraceBloc>().add(
                              TraceMoveEvent(details.delta.dy),
                            );
                          },
                          child: const Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      )
                    else
                      // When tracing is complete, show the trace line fully filled
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 200, // Full height of the line
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
