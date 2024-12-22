import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_events.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_state.dart';

class CounterPage extends StatelessWidget {
   CounterPage({super.key});

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

           BlocBuilder<CounterBloc, CounterState>(
               builder: (BuildContext context, state) {
                 if( state is CounterInitialState){
                   return Text('${state.count}', style: textStyle());
                 }
                 else if( state is CounterIncrementState){
                   return Text('${state.incCount}', style: textStyle());
                 }
                 else if( state is CounterDecrementState){
                   return Text('${state.decCount}', style: textStyle());
                 }else{
                   return Container();
                 }
               },
           ),
          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                BlocProvider.of<CounterBloc>(context).add(CounterIncrementEvent(incCount: count++));
              }, child: Text("+", style: textStyle(),)),
              const SizedBox(width: 20,),
              ElevatedButton(onPressed: () {
                BlocProvider.of<CounterBloc>(context).add(CounterDecrementEvent(decCount: count--));
              }, child: Text("-", style: textStyle(),))
            ],
          ),
        ],
      ),
    );
  }

  textStyle(){
    return TextStyle(color: Colors.black, fontSize: 16);
  }
}
