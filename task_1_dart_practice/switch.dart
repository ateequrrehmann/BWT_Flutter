void main() {
  String userRole = "admin";
  print("Checking User Role");

  switch (userRole) {
    case "admin":
      print("You have full access");
      break;
    case "editor":
      print("You have access to edit only");
      break;
    case "viewer":
      print("You can view the content only");
      break;
    default:
      print("Invalid user Role.");
  }
}
