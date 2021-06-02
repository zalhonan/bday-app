import 'package:bloc/bloc.dart';

// * кубит для хранения индекса навигации
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changePage(int newPageIndex) => emit(newPageIndex);
}
