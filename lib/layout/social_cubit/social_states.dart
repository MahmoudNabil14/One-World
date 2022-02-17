
abstract class SocialStates{}
class SocialInitialState extends SocialStates{

}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);

}
class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

class SocialEditProfileState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialPostPhotoPickedSuccessState extends SocialStates{}

class SocialPostPhotoPickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateSuccessState extends SocialStates{}

class SocialUserUploadLoadingState extends SocialStates{}

class SocialCreatePostWithoutPhotoLoadingState extends SocialStates{}

class SocialCreatePostWithoutPhotoSuccessState extends SocialStates{}

class SocialCreatePostWithoutPhotoErrorState extends SocialStates{}

class SocialCreatePostWithPhotoLoadingState extends SocialStates{}

class SocialCreatePostWithPhotoSuccessState extends SocialStates{}

class SocialCreatePostWithPhotoErrorState extends SocialStates{}

class SocialRemovePostPhotos extends SocialStates{}

class SocialLikePostPhotos extends SocialStates{}

class SocialChangeIconDependOnFormField extends SocialStates{}

class SocialUpdatePostProfilePhotoWhenUserUpdatedSuccessState extends SocialStates{}

class SocialUpdatePostProfilePhotoWhenUserUpdatedErrorState extends SocialStates{}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}







