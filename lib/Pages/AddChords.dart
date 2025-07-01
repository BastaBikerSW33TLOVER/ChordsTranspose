import 'package:flutter/material.dart';

class Addchords extends StatefulWidget {


  const Addchords({super.key});

  @override
  State<Addchords> createState() => _AddchordsState();
}

class _AddchordsState extends State<Addchords> {

  final _formkey = GlobalKey<FormState>();
  String _title ='';
  String _key = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
      ),
      body: Container(
        margin: EdgeInsets.all(8),

        child: Form(
          key: _formkey,
            child: Column(
          children: [
            Text('Add Chords'),

            Container(
              child: (
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Ex. Napakasakit Kuya Eddie',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black87)

                  )
                ),
              )
              ),

            ),

            Container(
              child: (
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Key',
                        hintText: 'Ex. C#',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black87)

                        )
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
   return'Please Fill all slots';

    }
          return null;
                      },

                  )
              ),

            ),
 Container(
   child: Column(
     children: [
       ElevatedButton(onPressed:(){

         if(_formkey.currentState!.validate()){
           print('nice');
    }
    },
        child: Text('Save'))
     ],
   ),


 ),


            Container(
              margin: EdgeInsets.symmetric(vertical: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(onPressed: (){},
                    child: Text('Save'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.lightBlue),),
                ],

              ),
            )


          ],
        )
        )


      ),
floatingActionButton: FloatingActionButton(
  onPressed: (){
    Navigator.pushNamed(context, '/add');
  },
  child: Icon(Icons.icecream),
),

    );
  }
}

