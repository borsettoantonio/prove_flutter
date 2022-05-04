import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../model/model.dart';
import '../util/utils.dart';
import '../util/dbhelper.dart';

// Menu item
const menuDelete = "Delete";
const List<String> menuOptions = <String>[menuDelete];

class DocDetail extends StatefulWidget {
  final Doc doc;
  final DbHelper dbh = DbHelper();

  DocDetail(this.doc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DocDetailState();
}

class DocDetailState extends State<DocDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final int daysAhead = 5475; // 15 years in the future

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController expirationCtrl = TextEditingController();
  //MaskedTextController(mask: '0000-00-00');

  bool fqYearCtrl = true;
  bool fqHalfYearCtrl = true;
  bool fqQuarterCtrl = true;
  bool fqMonthCtrl = true;
  bool fqLessMonthCtrl = true;

  // Initialization code
  void _initCtrls() {
    titleCtrl.text = widget.doc.title;
    expirationCtrl.text = widget.doc.expiration;

    fqYearCtrl = Val.intToBool(widget.doc.fqYear);
    fqHalfYearCtrl = Val.intToBool(widget.doc.fqHalfYear);
    fqQuarterCtrl = Val.intToBool(widget.doc.fqQuarter);
    fqMonthCtrl = Val.intToBool(widget.doc.fqMonth);
  }

  // Date Picker & Date functions
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = DateTime.now();
    var initialDate = DateUtils1.convertToDate(initialDateString) ?? now;

    initialDate = (initialDate.year >= now.year && initialDate.isAfter(now)
        ? initialDate
        : now);

    DatePicker.showDatePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        DateTime dt = date;
        String r = DateUtils1.ftDateAsStr(dt);
        expirationCtrl.text = r;
      });
    }, currentTime: initialDate);
  }

  // Upper Menu
  void _selectMenu(String value) async {
    switch (value) {
      case menuDelete:
        if (widget.doc.id == -1) {
          return;
        }
        await _deleteDoc(widget.doc.id!);
    }
  }

  // Delete doc
  Future<void> _deleteDoc(int id) async {
    await widget.dbh.deleteDoc(widget.doc.id!);
    Navigator.pop(context, true);
  }

  // Save doc
  void _saveDoc() {
    widget.doc.title = titleCtrl.text;
    widget.doc.expiration = expirationCtrl.text;

    widget.doc.fqYear = Val.boolToInt(fqYearCtrl);
    widget.doc.fqHalfYear = Val.boolToInt(fqHalfYearCtrl);
    widget.doc.fqQuarter = Val.boolToInt(fqQuarterCtrl);
    widget.doc.fqMonth = Val.boolToInt(fqMonthCtrl);

    if (widget.doc.id! > -1) {
      debugPrint("_update->Doc Id: " + widget.doc.id.toString());
      widget.dbh.updateDoc(widget.doc);
      Navigator.pop(context, true);
    } else {
      Future<int> idd = widget.dbh.getMaxId();
      idd.then((result) {
        debugPrint("_insert->Doc Id: " + widget.doc.id.toString());
        widget.doc.id = result + 1;
        widget.dbh.insertDoc(widget.doc);
        Navigator.pop(context, true);
      });
    }
  }

  // Submit form
  void _submitForm() {
    final FormState form = _formKey.currentState!;

    if (!form.validate()) {
      showMessage('Some data is invalid. Please correct.');
    } else {
      _saveDoc();
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    _initCtrls();
  }

  @override
  Widget build(BuildContext context) {
    // const String cStrDays = "Enter a number of days";
    TextStyle tStyle = Theme.of(context).textTheme.subtitle1!;
    String ttl = widget.doc.title;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(ttl != "" ? widget.doc.title : "New Document"),
            actions: (ttl == "")
                ? <Widget>[]
                : <Widget>[
                    PopupMenuButton(
                      onSelected: _selectMenu,
                      itemBuilder: (BuildContext context) {
                        return menuOptions.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ]),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SafeArea(
              top: false,
              bottom: false,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"))
                    ],
                    controller: titleCtrl,
                    style: tStyle,
                    validator: (val) => Val.validateTitle(val),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: 'Enter the document name',
                      labelText: 'Document Name',
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      controller: expirationCtrl,
                      maxLength: 10,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today),
                          hintText: 'Expiry date (i.e. ' +
                              DateUtils1.daysAheadAsStr(daysAhead) +
                              ')',
                          labelText: 'Expiry Date'),
                      keyboardType: TextInputType.number,
                      validator: (val) => DateUtils1.isValidDate(val)
                          ? null
                          : 'Not a valid future date',
                    )),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, expirationCtrl.text);
                      }),
                    )
                  ]),
                  Row(children: const <Widget>[
                    Expanded(child: Text(' ')),
                  ]),
                  Row(children: <Widget>[
                    const Expanded(child: Text('a: Alert @ 1.5 & 1 year(s)')),
                    Switch(
                        value: fqYearCtrl,
                        onChanged: (bool value) {
                          setState(() {
                            fqYearCtrl = value;
                          });
                        }),
                  ]),
                  Row(children: <Widget>[
                    const Expanded(child: Text('b: Alert @ 6 months')),
                    Switch(
                        value: fqHalfYearCtrl,
                        onChanged: (bool value) {
                          setState(() {
                            fqHalfYearCtrl = value;
                          });
                        }),
                  ]),
                  Row(children: <Widget>[
                    const Expanded(child: Text('c: Alert @ 3 months')),
                    Switch(
                        value: fqQuarterCtrl,
                        onChanged: (bool value) {
                          setState(() {
                            fqQuarterCtrl = value;
                          });
                        }),
                  ]),
                  Row(children: <Widget>[
                    const Expanded(child: Text('d: Alert @ 1 month or less')),
                    Switch(
                        value: fqMonthCtrl,
                        onChanged: (bool value) {
                          setState(() {
                            fqMonthCtrl = value;
                          });
                        }),
                  ]),
                  Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: ElevatedButton(
                        child: const Text("Save"),
                        onPressed: _submitForm,
                      )),
                ],
              ),
            )));
  }
}
