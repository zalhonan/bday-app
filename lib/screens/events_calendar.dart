import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/navigation_cubit.dart';

class EventsCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text('Dats Calendar. Go home'),
          onPressed: () {
            context.read<NavigationCubit>().changePage(0);
          },
        ),
      ),
    );
  }
}
