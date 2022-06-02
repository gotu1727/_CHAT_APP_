import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsappclone/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color appColorGreen = Color(0XFF4354AE);
const Color chatLeftColor = Color(0XFFf5f5f5);
const Color chatRightColor = Color(0XFFe1fec6);
const Color chatReplyRightColor = Color(0XFFcee8ba);
const Color appColorBlue = Color(0XFF60A89C);
const Color appColor = Color(0xFF34C759);
const Color appColorBlack = Colors.black;
const Color appColorWhite = Colors.white;
const Color appColorGrey = Colors.grey;

String normalStyle = 'Montserrat';

const Color settingColoryellow = Color(0xFFf6cd00);
const Color settingColorGreen = Color(0xFFf00aca6);
const Color settingColorBlue = Color(0xFF007dff);
const Color settingColorRed = Color(0xFFff3429);
const Color settingColorpink = Color(0xFFff2b54);
const Color settingColorChat = Color(0xFF47d86a);

const Color callColor1 = Color(0XFF738464);
const Color callColor2 = Color(0XFF9b7573);
SharedPreferences preferences;
String userID = '';
String mobNo = '';
String cCode = '';
String fullMob = '';
String globalName = '';
String globalImage = '';
String serverKey =
    "AAAAJJI8tkw:APA91bFmgIQf887JDIUQrKgm28kkM7RDHmmVSwCL5Unc39YHGPRqVKgHErhn8gMnS13IMlyz4UaNjR6L-z0TMOXhiuR2WYRr37LEomB-fVKi3omVb_qDM0GAdQW2VGz3zkHQCFfTgxpz";
String noImage =
    'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png';

String videoImage =
    'https://old.dpsu.gov.ua/templates/scms_default/images/noVideo.jpg';

List<Contact> _contacts;
var mobileContacts = [];
List<Contact> allcontacts;
List<String> localImage = [];
var savedContactUserId = [];

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment alignment;
  final String fontFamily;

  const CustomText(
      {Key key,
      this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.alignment,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: Text(' $text',
            style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily)));
  }
}

class CustomButtom extends StatelessWidget {
  final Color color;
  final String title;
  final Function onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final BorderRadius borderRadius;
  final String fontFamily;
  CustomButtom(
      {this.color,
      this.title,
      this.onPressed,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.borderRadius,
      this.fontFamily});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      color: color,
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
            fontFamily: fontFamily),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      onPressed: onPressed,
    );
  }
}

Widget loader() {
  return Container(
    height: 60,
    width: 60,
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.transparent),
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
  );
}

// ignore: must_be_immutable
class CustomtextField extends StatefulWidget {
  final TextInputType keyboardType;
  final Function onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onEditingComplate;
  final Function onSubmitted;
  final dynamic controller;
  final int maxLines;
  final dynamic onChange;
  final String errorText;
  final String hintText;
  final String labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget suffixIcon;

  final Widget prefixIcon;
  CustomtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _CustomtextFieldState createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(
          color: Colors.black, fontFamily: 'Montserrat', fontSize: 14),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.black),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: widget.hintText,
        focusColor: Colors.black,
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
            color: Colors.grey[600], fontFamily: "Montserrat", fontSize: 13),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColorGreen, width: 1.8),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomtextField3 extends StatefulWidget {
  final TextInputType keyboardType;
  final Function onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onEditingComplate;
  final Function onSubmitted;
  final dynamic controller;
  final int maxLines;
  final dynamic onChange;
  final String errorText;
  final String hintText;
  final String labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget suffixIcon;
  final textAlign;

  final Widget prefixIcon;
  CustomtextField3(
      {this.keyboardType,
      this.onTap,
      this.focusNode,
      this.textInputAction,
      this.onEditingComplate,
      this.onSubmitted,
      this.controller,
      this.maxLines,
      this.onChange,
      this.errorText,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.readOnly = false,
      this.autoFocus = false,
      this.prefixIcon,
      this.suffixIcon,
      this.textAlign});

  @override
  _CustomtextFieldState3 createState() => _CustomtextFieldState3();
}

class _CustomtextFieldState3 extends State<CustomtextField3> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: widget.textAlign,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: false,
        //  fillColor: Colors.black.withOpacity(0.5),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        errorStyle: TextStyle(color: Colors.white),
        errorText: widget.errorText,

        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),

        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white, width: 1.8),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white, width: 0.5),
        //   borderRadius: BorderRadius.circular(10),
        // ),
      ),
    );
  }
}

getContactsFromGloble() async {
  mobileContacts.clear();
  var getContacts = [];
  var newgetContacts = [];

  var contacts = (await ContactsService.getContacts(
          withThumbnails: false, iOSLocalizedLabels: iOSLocalizedLabels))
      .toList();

  _contacts = contacts;
  if (_contacts != null) {
    for (int i = 0; i < _contacts.length; i++) {
      Contact c = _contacts?.elementAt(i);
      getContacts.add(c.phones
          .map((e) => e.value.replaceAll(RegExp(r"\s+"), "").toString()));
    }
  }

  for (int i = 0; i < getContacts.length; i++) {
    newgetContacts.add(getContacts[i]
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("+93", "")
        .replaceAll("+358", "")
        .replaceAll("+355", "")
        .replaceAll("+213", "")
        .replaceAll("+1", "")
        .replaceAll("+376", "")
        .replaceAll("+244", "")
        .replaceAll("+1", "")
        .replaceAll("+1", "")
        .replaceAll("+54", "")
        .replaceAll("+374", "")
        .replaceAll("+297", "")
        .replaceAll("+247", "")
        .replaceAll("+61", "")
        .replaceAll("+672", "")
        .replaceAll("+43", "")
        .replaceAll("+994", "")
        .replaceAll("+1", "")
        .replaceAll("+973", "")
        .replaceAll("+880", "")
        .replaceAll("+1", "")
        .replaceAll("+375", "")
        .replaceAll("+32", "")
        .replaceAll("+501", "")
        .replaceAll("+229", "")
        .replaceAll("+93", "")
        .replaceAll("+355", "")
        .replaceAll("+213", "")
        .replaceAll("+1-684", "")
        .replaceAll("+376", "")
        .replaceAll("+244", "")
        .replaceAll("+1-264", "")
        .replaceAll("+672", "")
        .replaceAll("+1-268", "")
        .replaceAll("+54", "")
        .replaceAll("+374", "")
        .replaceAll("+297", "")
        .replaceAll("+61", "")
        .replaceAll("+43", "")
        .replaceAll("+994", "")
        .replaceAll("+1-242", "")
        .replaceAll("+973", "")
        .replaceAll("+880", "")
        .replaceAll("+1-246", "")
        .replaceAll("+375", "")
        .replaceAll("+32", "")
        .replaceAll("+501", "")
        .replaceAll("+229", "")
        .replaceAll("+1-441", "")
        .replaceAll("+975", "")
        .replaceAll("+591", "")
        .replaceAll("+387", "")
        .replaceAll("+267", "")
        .replaceAll("+55", "")
        .replaceAll("+246", "")
        .replaceAll("+1-284", "")
        .replaceAll("+673", "")
        .replaceAll("+359", "")
        .replaceAll("+226", "")
        .replaceAll("+257", "")
        .replaceAll("+855", "")
        .replaceAll("+237", "")
        .replaceAll("+1", "")
        .replaceAll("+238", "")
        .replaceAll("+1-345", "")
        .replaceAll("+236", "")
        .replaceAll("+235", "")
        .replaceAll("+56", "")
        .replaceAll("+86", "")
        .replaceAll("+61", "")
        .replaceAll("+61", "")
        .replaceAll("+57", "")
        .replaceAll("+269", "")
        .replaceAll("+682", "")
        .replaceAll("+506", "")
        .replaceAll("+385", "")
        .replaceAll("+53", "")
        .replaceAll("+599", "")
        .replaceAll("+357", "")
        .replaceAll("+420", "")
        .replaceAll("+243", "")
        .replaceAll("+45", "")
        .replaceAll("+253", "")
        .replaceAll("+1-767", "")
        .replaceAll("+1-809", "")
        .replaceAll("+1-829", "")
        .replaceAll("+1-849", "")
        .replaceAll("+670", "")
        .replaceAll("+593", "")
        .replaceAll("+20", "")
        .replaceAll("+503", "")
        .replaceAll("+240", "")
        .replaceAll("+291", "")
        .replaceAll("+372", "")
        .replaceAll("+251", "")
        .replaceAll("+500", "")
        .replaceAll("+298", "")
        .replaceAll("+679", "")
        .replaceAll("+358", "")
        .replaceAll("+33", "")
        .replaceAll("+689", "")
        .replaceAll("+241", "")
        .replaceAll("+220", "")
        .replaceAll("+995", "")
        .replaceAll("+49", "")
        .replaceAll("+233", "")
        .replaceAll("+350", "")
        .replaceAll("+30", "")
        .replaceAll("+299", "")
        .replaceAll("+1-473", "")
        .replaceAll("+1-671", "")
        .replaceAll("+502", "")
        .replaceAll("+44-1481", "")
        .replaceAll("+224", "")
        .replaceAll("+245", "")
        .replaceAll("+592", "")
        .replaceAll("+509", "")
        .replaceAll("+504", "")
        .replaceAll("+852", "")
        .replaceAll("+36", "")
        .replaceAll("+354", "")
        .replaceAll("+91", "")
        .replaceAll("+62", "")
        .replaceAll("+98", "")
        .replaceAll("+964", "")
        .replaceAll("+353", "")
        .replaceAll("+44-1624", "")
        .replaceAll("+972", "")
        .replaceAll("+39", "")
        .replaceAll("+225", "")
        .replaceAll("+1-876", "")
        .replaceAll("+81", "")
        .replaceAll("+44-1534", "")
        .replaceAll("+962", "")
        .replaceAll("+7", "")
        .replaceAll("+254", "")
        .replaceAll("+686", "")
        .replaceAll("+383", "")
        .replaceAll("+965", "")
        .replaceAll("+996", "")
        .replaceAll("+856", "")
        .replaceAll("+371", "")
        .replaceAll("+961", "")
        .replaceAll("+266", "")
        .replaceAll("+231", "")
        .replaceAll("+218", "")
        .replaceAll("+423", "")
        .replaceAll("+370", "")
        .replaceAll("+352", "")
        .replaceAll("+853", "")
        .replaceAll("+389", "")
        .replaceAll("+261", "")
        .replaceAll("+265", "")
        .replaceAll("+60", "")
        .replaceAll("+960", "")
        .replaceAll("+223", "")
        .replaceAll("+356", "")
        .replaceAll("+692", "")
        .replaceAll("+222", "")
        .replaceAll("+230", "")
        .replaceAll("+262", "")
        .replaceAll("+52", "")
        .replaceAll("+691", "")
        .replaceAll("+373", "")
        .replaceAll("+377", "")
        .replaceAll("+976", "")
        .replaceAll("+382", "")
        .replaceAll("+1-664", "")
        .replaceAll("+212", "")
        .replaceAll("+258", "")
        .replaceAll("+95", "")
        .replaceAll("+264", "")
        .replaceAll("+674", "")
        .replaceAll("+977", "")
        .replaceAll("+31", "")
        .replaceAll("+599", "")
        .replaceAll("+687", "")
        .replaceAll("+64", "")
        .replaceAll("+505", "")
        .replaceAll("+227", "")
        .replaceAll("+234", "")
        .replaceAll("+683", "")
        .replaceAll("+850", "")
        .replaceAll("+1-670", "")
        .replaceAll("+47", "")
        .replaceAll("+968", "")
        .replaceAll("+92", "")
        .replaceAll("+680", "")
        .replaceAll("+970", "")
        .replaceAll("+507", "")
        .replaceAll("+675", "")
        .replaceAll("+595", "")
        .replaceAll("+51", "")
        .replaceAll("+63", "")
        .replaceAll("+64", "")
        .replaceAll("+48", "")
        .replaceAll("+351", "")
        .replaceAll("+1-787", "")
        .replaceAll("+1-939", "")
        .replaceAll("+974", "")
        .replaceAll("+242", "")
        .replaceAll("+262", "")
        .replaceAll("+40", "")
        .replaceAll("+7", "")
        .replaceAll("+250", "")
        .replaceAll("+590", "")
        .replaceAll("+290", "")
        .replaceAll("+1-869", "")
        .replaceAll("+1-758", "")
        .replaceAll("+590", "")
        .replaceAll("+508", "")
        .replaceAll("+1-784", "")
        .replaceAll("+685", "")
        .replaceAll("+378", "")
        .replaceAll("+239", "")
        .replaceAll("+966", "")
        .replaceAll("+221", "")
        .replaceAll("+381", "")
        .replaceAll("+248", "")
        .replaceAll("+232", "")
        .replaceAll("+65", "")
        .replaceAll("+1-721", "")
        .replaceAll("+421", "")
        .replaceAll("+386", "")
        .replaceAll("+677", "")
        .replaceAll("+252", "")
        .replaceAll("+27", "")
        .replaceAll("+82", "")
        .replaceAll("+211", "")
        .replaceAll("+34", "")
        .replaceAll("+94", "")
        .replaceAll("+249", "")
        .replaceAll("+597", "")
        .replaceAll("+47", "")
        .replaceAll("+268", "")
        .replaceAll("+46", "")
        .replaceAll("+41", "")
        .replaceAll("+963", "")
        .replaceAll("+886", "")
        .replaceAll("+992", "")
        .replaceAll("+255", "")
        .replaceAll("+66", "")
        .replaceAll("+228", "")
        .replaceAll("+690", "")
        .replaceAll("+676", "")
        .replaceAll("+1-868", "")
        .replaceAll("+216", "")
        .replaceAll("+90", "")
        .replaceAll("+993", "")
        .replaceAll("+1-649", "")
        .replaceAll("+688", "")
        .replaceAll("+1-340", "")
        .replaceAll("+256", "")
        .replaceAll("+380", "")
        .replaceAll("+971", "")
        .replaceAll("+44", "")
        .replaceAll("+1", "")
        .replaceAll("+598", "")
        .replaceAll("+998", "")
        .replaceAll("+678", "")
        .replaceAll("+379", "")
        .replaceAll("+58", "")
        .replaceAll("+84", "")
        .replaceAll("+681", "")
        .replaceAll("+212", "")
        .replaceAll("+967", "")
        .replaceAll("+260", "")
        .replaceAll("+263", "")
        .replaceAll("  ", ",")
        .replaceAll(new RegExp(r'^0+(?=.)'), '')
        .replaceFirst(new RegExp(r'^0+'), '')
        .replaceAll("-", "")
        .trim()
        .toString());
  }

  mobileContacts.addAll(newgetContacts);
  splitMethod(newgetContacts);

  return newgetContacts;
}

splitMethod(contact) {
  contact.forEach((car) {
    if (car.indexOf(',') > -1) {
      car.split(',');

      for (var newData in car.split(',')) {
        mobileContacts.add(newData);
      }
    }
  });
}

Future<void> refreshGlobalContacts() async {
  var contacts = (await ContactsService.getContacts(
          withThumbnails: false, iOSLocalizedLabels: iOSLocalizedLabels))
      .toList();
  allcontacts = contacts;
}
