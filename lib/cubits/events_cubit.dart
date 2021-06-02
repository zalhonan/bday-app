import 'package:bloc/bloc.dart';
import '../models/event.dart';

class EventsCubit extends Cubit<List<Event>> {
  EventsCubit(List<Event> newEventsList) : super(newEventsList);

  void nulling() => emit([]);
}
