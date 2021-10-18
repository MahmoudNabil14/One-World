
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}
class SocialUserCreateSuccessState extends SocialRegisterStates {}

class SocialUserCreateErrorState extends SocialRegisterStates {}

class SocialChangeRegisterSuffixState extends SocialRegisterStates {}
