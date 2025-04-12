import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);
  final PageController controller = PageController();
  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state + 1);
    }
  }

  void setPage(int index) => emit(index);

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
