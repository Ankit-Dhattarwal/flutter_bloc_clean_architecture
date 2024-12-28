
/*
  -- core can't depend on other features
  -- other features can depend on cores

 */
class User{
  final String id;
  final String email;
  final String name;

  User({
   required this.id,
   required this.email,
   required this.name
});
}