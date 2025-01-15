part of 'widgets.dart';

TextFormField appTextFields({
  TextEditingController? controller,
  required String hintText,
  required IconData icon,
  required bool obscureText,
  required Function(String) onChanged,
  required AutovalidateMode autovalidateMode,
  required String? Function(String?)? validator,
  required TextInputType keyboardType,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      counterText: '',
      icon: Icon(icon),
    ),
    obscureText: obscureText,
    onChanged: onChanged,
    autovalidateMode: autovalidateMode,
    validator: validator,
    keyboardType: keyboardType,
  );
}

TextFormField appPasswordTextFields({
  TextEditingController? controller,
  required void Function() onPressed,
  required bool obscureText,
  required Function(String) onChanged,
  required AutovalidateMode autovalidateMode,
  required TextInputType keyboardType,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: Kstrings.password,
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      counterText: '',
      icon: Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        onPressed: onPressed,
      ),
    ),
    obscureText: obscureText,
    onChanged: onChanged,
    autovalidateMode: autovalidateMode,
    validator: (value) {
      if (value!.isEmpty) {
        return Kstrings.passwordIsEmpty;
      }
      if (value.length < 6) {
        return Kstrings.passwordIsShort;
      }

      if (value.length > 15) {
        return Kstrings.passwordIsLong;
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return Kstrings.passwordContainNumber;
      }
      if (!value.contains(RegExp(r'[a-z]'))) {
        return Kstrings.passwordContainLower;
      }
      return null;
    },
    keyboardType: keyboardType,
  );
}
