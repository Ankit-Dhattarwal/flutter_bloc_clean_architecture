

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_events.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState>{

  CounterBloc():super(CounterInitialState(count: 0)){

    on<CounterIncrementEvent>((event, emit){
      emit(CounterIncrementState(incCount: event.incCount + 1));
    });

    on<CounterDecrementEvent>((event, emit){

      emit(CounterDecrementState(decCount: event.decCount - 1));
    });
  }
}