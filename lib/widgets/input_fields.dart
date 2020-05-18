import 'package:flutter/material.dart';


class InputFields extends StatelessWidget {
 
 final IconData icon;
 final String hint;
 final bool obscure;
 final Stream<String> stream;
 final Function(String) onChanged;
 
 InputFields({this.icon, this.hint, this.obscure, this.stream, this.onChanged});
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
         onChanged: onChanged,
         decoration: InputDecoration(
          errorText: snapshot.hasError ? snapshot.error : null,
          contentPadding: EdgeInsets.fromLTRB(5, 30, 30, 30),
          icon: Icon(icon, color: Colors.white,),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.purple),
          ),
         ),
         style: TextStyle(color: Colors.white),
         obscureText: obscure,
        );
      }
    );
  }
}
