extension GreetUser on String? {
  String helloUser() {
    if (this != null) {
      return "Hello ${this!.split(' ').first.toUpperCase()}";
    }
    return "";
  }
}