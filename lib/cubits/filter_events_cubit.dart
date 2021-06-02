import 'package:bloc/bloc.dart';

class FilterEventsCubit extends Cubit<int> {
  FilterEventsCubit(int newFilter) : super(newFilter);

  void changeFilter(int newFilter) => emit(newFilter);
}
