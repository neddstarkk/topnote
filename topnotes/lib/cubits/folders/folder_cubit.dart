import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  FolderCubit() : super(FolderInitial());
}
