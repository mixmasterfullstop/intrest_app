import 'package:flutter/material.dart';
void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
title: "simple interest calculator App ",
    home: SIform(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),

  ));
}
 class SIform extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }


 }
 class _SIformState extends State<SIform>{
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['rupees','Dollars','Pounds'];
  var _displayResult='';
  var _currentSelectedItem;

  TextEditingController principalControlled = TextEditingController();
  TextEditingController aroiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSelectedItem = _currencies[0];

}

  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculator App"),),
      body: Form(key: _formkey,
    child: Padding(padding:EdgeInsets.all(_minimumPadding*2 ) ,
       // margin: EdgeInsets.all(_minimumPadding*2),
        child: ListView(
          children: <Widget>[ getImageAsset(),
         Padding(
           padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
      child:
           TextFormField(keyboardType: TextInputType.number,
            style: textStyle,
            controller: principalControlled,
            validator: (String value){
             if(value.isEmpty)
               return 'please enter principal';
            },
            decoration: InputDecoration(
              labelText:'Principal',
              hintText: 'Enter Principal e.g 1200',
              labelStyle: textStyle,errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),

              )
            ),
          ),)
           ,Padding(
            padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child:
        TextFormField(keyboardType: TextInputType.number,style: textStyle,
            controller: aroiControlled,validator:(String Value){
          if(Value.isEmpty)
            return 'enter intrest';
          else(Value == Value.toString());
          },
            decoration: InputDecoration(
                labelText:'Interest',
                labelStyle: textStyle,errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                hintText: 'In percentage',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),

                )
            ),
          ),),
           Padding(
             padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
             child: Row(
              children: <Widget>[
                Expanded(child:
                TextFormField(keyboardType: TextInputType.number,style: textStyle,controller: termControlled,
                validator: (String value){
                  if(value.isEmpty)
                    return 'enter term';
                },
                decoration: InputDecoration(
                    labelText:'Term',
                    hintText: 'Time in years',labelStyle: textStyle,errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),

                    )
                ),
              )),
                Container(width: _minimumPadding*5,),
               Expanded(child:
                DropdownButton<String>(
                  items: _currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),

                    );
                  }).toList(),
                  value: _currentSelectedItem,
                  onChanged: (String newValueSelected){
_onDropDownSelectedItem(newValueSelected);
                  },
                ),)

              ],

            ),),
            Padding(padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Row(
              children: <Widget>[
                Expanded(child: RaisedButton(child: Text("Calculate",),color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: (){
                  setState(() {
                    if(_formkey.currentState.validate())
                  this._displayResult=  _calculateTotalReturns();
                  });

                })),Expanded(child: RaisedButton(child: Text("Reset",),
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                  setState(() {
                    _resultReset();
                  });

                    }))
              ],
            ),),
            Padding(padding: EdgeInsets.all(_minimumPadding*2),
            child: Text('$_displayResult',style: textStyle,),)
          ],
        ),
      ),
    ));
  }
  Widget getImageAsset(){
AssetImage assetImage = AssetImage('images/money.png');
Image image = Image(image: assetImage, height:125.0 , width: 125.0,);

return Container(child: image,margin: EdgeInsets.all(_minimumPadding *10),);
  }

  void _onDropDownSelectedItem(newValueSelected){
setState(() {
  this._currentSelectedItem = newValueSelected;
});

  }
  String _calculateTotalReturns(){
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(aroiControlled.text);
    double term = double.parse(termControlled.text);
    double totalAmountPayable = principal+(principal*roi*term)/100;
String result = "After $term years your investment will be $totalAmountPayable";
return result;
  }
  void _resultReset(){
    principalControlled.text = "";
    aroiControlled.text = "";
    termControlled.text = "";
    _currentSelectedItem = _currencies[0];

  }
 }