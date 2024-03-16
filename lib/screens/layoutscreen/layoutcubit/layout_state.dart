abstract class LayoutState {}

class ChangCurrentIndexState extends LayoutState {}

class LayoutInitial extends LayoutState {}

class LayoutLodinState extends LayoutState {}

class LayoutSucsessState extends LayoutState {}

class LayoutFaluerState extends LayoutState {
  String ErrorMassege;
  LayoutFaluerState({required this.ErrorMassege});
}

class BannerLoadinState extends LayoutState {}

class SucsessBannerState extends LayoutState {}

class FiulerBannerState extends LayoutState {}

class SuccsessCatigoryState extends LayoutState {}

class FailuerCatigoryState extends LayoutState {}

class SuccsessProductState extends LayoutState {}

class FailureProdectState extends LayoutState {}

class SuccsessFavState extends LayoutState {}

class FailureFavState extends LayoutState {}

class AddOrRemoveStateSucsses extends LayoutState {}

class FRaluerAddOrRemoveState extends LayoutState {}

class SuccsessCartState extends LayoutState {}

class FailureCartState extends LayoutState {}

class AddToCartState extends LayoutState {}

class FailureAddtoCart extends LayoutState {}

class CarttLodinState extends LayoutState {}

class ChangePasswordLoadingState extends LayoutState {}

class ChangePasswordSucssesState extends LayoutState {}

class ChangePasswordFaluirState extends LayoutState {
  String error;
  ChangePasswordFaluirState({required this.error});
}

class UpdateUserDataLodingState extends LayoutState {}

class UpdateUserDataSuccsessState extends LayoutState {}

class UpdateUserDataFalurState extends LayoutState {
  String error;
  UpdateUserDataFalurState({required this.error});
}

class LogoutLodingState extends LayoutState {}

class LogoutSuccsessState extends LayoutState {}

class LogoutFaluerState extends LayoutState {
  String error;
  LogoutFaluerState({required this.error});
}

class AppIntialTheamState extends LayoutState {}

class AppDarkTheamState extends LayoutState {}

class AppLightTheamState extends LayoutState {}

class FavLodinState extends LayoutState {}
