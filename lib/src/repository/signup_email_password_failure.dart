
class SignUpWithEmailAndPasswordFailure {
  final String message;
  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);
   factory SignUpWithEmailAndPasswordFailure.code(String code) {
     switch (code){
       case 'weak- password':
         return SignUpWithEmailAndPasswordFailure.code('Please Enter a stronger password.');
       case 'invalid-email':
         return  SignUpWithEmailAndPasswordFailure.code('Email is not valid or badly formatted');
       case 'email-already-in-use':
         return SignUpWithEmailAndPasswordFailure.code('An account already exists for that email');
       default:
         return  SignUpWithEmailAndPasswordFailure.code('');

     }
   }
}