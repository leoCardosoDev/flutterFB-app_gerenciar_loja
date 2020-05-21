import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
 
 final _controller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Dialog(
     child: Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
       mainAxisSize: MainAxisSize.min,
       children: <Widget>[
        TextField(
         controller: _controller,
         decoration: InputDecoration(
          hintText: 'Adicione um tamanho',
         ),
        ),
        Container(
         alignment: Alignment.centerRight,
          child: FlatButton(
           child: Text('Adicionar'),
           textColor: Colors.purple,
           onPressed: (){
            if(_controller.text != '') Navigator.of(context).pop(_controller.text);
           },
          ),
        ),
       ],
      ),
     ),
    );
  }
}
