
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  final String addresses;
 
  const Search({Key? key,required this.addresses}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController pickupcontroller = TextEditingController();
  TextEditingController dropupcontroller = TextEditingController();


  final List<Map<String, dynamic>> _alllocation = [
    {"id":"1","StreetAddress":"Dharan BusPark Gurash line","City":"Dharan","Postal_Code":""},
    {"id":"2","StreetAddress":"BusPark Dharan Paathibhara line","City":"Dharan"},
    {"id":"3","StreetAddress":"Hotel Gajur Palace Dharan","City":"Dharan"},
    {"id":"4","StreetAddress":"Ghopa Hospital Dharan","City":"Dharan"},
    {"id":"1","StreetAddress":"Dharan BusPark Gurash line","City":"Dharan"},
    {"id":"2","StreetAddress":"BusPark Dharan Paathibhara line","City":"Dharan"},
    {"id":"3","StreetAddress":"Hotel Gajur Palace Dharan","City":"Dharan"},
    {"id":"4","StreetAddress":"Ghopa Hospital Dharan","City":"Dharan"},
  ];

   List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _alllocation;
    super.initState();
  }


    // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _alllocation;
    } else {
      results = _alllocation
          .where((user) =>
              user["StreetAddress"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
  
  

  
  @override
  Widget build(BuildContext context) {
    pickupcontroller.text = widget.addresses; 
   
    return Scaffold(
      body: Column(children: [
        Container(
          height: 215.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7))
              ]),
          child: Padding(
            padding: EdgeInsets.only(
                left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.0,),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.pop(context);
                          }),
                          child: Icon(Icons.arrow_back)
                          ),
                        Center(
                          child: Text("Set Drop Off",style: TextStyle(fontSize: 18,fontFamily: "Brand-Bold"),),

                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Image.asset("Uber Clone Resources/images/pickicon.png",height: 16.0,width: 16.0,),
                        SizedBox(width: 18.0,),
                        Expanded(
                          child:Container(
                        
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                            


                          ),
                          child: Padding(
                            padding:EdgeInsets.all(12.0),
                            child: TextField(
                              controller: pickupcontroller,
                              decoration: InputDecoration(
                                hintText: "PickUp Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11,top: 8,bottom: 8),
                              ),
                            ),),
                          
                        ))
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("Uber Clone Resources/images/desticon.png",height: 16.0,width: 16.0,),
                        SizedBox(width: 18.0,),
                        Expanded(
                          child:Container(
                            
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                            


                          ),
                          child: Padding(
                            padding:EdgeInsets.all(12.0),
                            child: TextField(
                              onChanged: (value) => _runFilter(value),
                              controller: dropupcontroller,
                              decoration: InputDecoration(
                                hintText: "Where to ?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11,top: 8,bottom: 8),
                              ),
                            ),),
                          
                        ))
                      ],
                    ),
                  ],
                ),
          ),
        ),
        SizedBox(height: 1.0,),
       
            Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                       
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundUsers[index]["id"]),
                          color: Colors.grey[300],
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: ListTile(
                            leading:  Image.asset("Uber Clone Resources/images/pickicon.png",height: 16.0,width: 16.0,),
                            title: Text(_foundUsers[index]['StreetAddress']),
                            subtitle: Text(
                                '${_foundUsers[index]["StreetAddress"].toString()} , Dharan'),
                             onTap: (){
                                  dropupcontroller.text = '${_foundUsers[index]["StreetAddress"].toString()}';
                                },
                                
                          ),
                        ),
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 16),
                      ),
                      
              ),
             
                
              
        
      ]),
    );
  }
 
 

 
}
