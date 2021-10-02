import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:news_application/shared/styles/colors.dart';
import 'package:photo_view/photo_view.dart';

import 'constants.dart';

String shareText =
    ' ${"visit-us-on-facebook".tr().toString()} http://www.facebook.com/alyemennetblog';
// List<String> languages= [
//   "english".tr().toString(),
//   "arabic".tr().toString(),
// ];

// List<String> themeItems = [
//   "auto".tr().toString(),
//   "light".tr().toString(),
//   "dark".tr().toString()
// ];

Future<List<File>?>? selectFiles({bool allowMultiple = true}) async {
  List<File> _files = [];
  try {
    final files = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (files == null) return _files;
    for (var file in files.files) {
      _files.add(File(file.path!));
    }
    return _files;
  } catch (e) {
    print(e);
  }
}

Image defaultImageLogo({fit}) => Image.asset(
      'assets/images/logo.png',
      fit: fit,
    );

defaultMaterialButton({required Function onPressed, required Widget child}) =>
    Builder(
        builder: (context) => MaterialButton(
              onPressed: () {
                onPressed();
              },
              // highlightColor:   Colors.white.withOpacity(0.0),
              splashColor: Colors.white.withOpacity(0.0),
              child: child,
            ));

defaultItemListView({required Widget child, required Function() onPressed}) =>
    defaultMaterialButton(
      onPressed: onPressed,
      child: Container(
        child: child,
      ),
    );

defaultImage({required String imageUrl}) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: FadeInImage(
          imageErrorBuilder: (context, error, stackTrace) => Container(),
          image: NetworkImage(imageUrl),
          width: 120,
          height: 120,
          fit: BoxFit.fill,
          placeholder: const AssetImage('assets/images/logo.png'),
        ),
      ),
    );

Widget defaultFloatingActionButton(
        {required IconData icon, required Function onPressed}) =>
    Builder(builder: (context) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () => onPressed(),
        child: Icon(
          icon,
          color: Theme.of(context).cardColor,
        ),
      );
    });

Widget defaultTextFormField({
  required TextEditingController textEditingController,
  required BuildContext context,
  FocusNode? focusNode,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator<String>? validator,
  FormFieldSetter<String>? onSaved,
  ValueChanged<String>? onChanged,
  TextInputType keyboardType = TextInputType.text,
  String hintText = "",
  int maxLength = 8000,
  TextInputAction? textInputAction,
  required String key,
}) =>
    Directionality(
      textDirection:
          intl.Bidi.detectRtlDirectionality(textEditingController.text)
              ? TextDirection.rtl
              : TextDirection.ltr,
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        key: ValueKey(key),
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: null,
        style: Theme.of(context).textTheme.headline4,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          hintTextDirection: Directionality.of(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintStyle: Theme.of(context).textTheme.subtitle1,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      ),
    );

Widget defaultDropdownButton({
  required BuildContext context,
  IconData icon = Icons.arrow_drop_down_circle_sharp,
  required List list,
  required value,
  Widget? hint,
  VoidCallback? onTap,
  required onChanged,
  FormFieldSetter? onSaved,
}) =>
    DropdownButtonFormField(
      isDense: false,
      icon: Icon(
        icon,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
      ),
      value: value,
      hint: hint,
      isExpanded: true,
      dropdownColor: Theme.of(context).backgroundColor,
      onTap: onTap,
      style: Theme.of(context).textTheme.headline4,
      onChanged: onChanged,
      onSaved: onSaved,
      items: list.map((val) {
        return DropdownMenuItem(value: val, child: Text(val.title));
      }).toList(),
    );

Widget defaultBorderContainer({required child}) => Container(
      decoration: BoxDecoration(
        border: Border.all(color: reverseColorLight),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );

Widget defaultPhotoView(
        {required File value,
        required Function onPressed,
        disableGestures = true}) =>
    PhotoView(
      onTapDown: (context, details, controllerValue) {
        onPressed();
      },
      disableGestures: disableGestures,
      imageProvider: FileImage(value),
      initialScale: disableGestures
          ? PhotoViewComputedScale.covered
          : PhotoViewComputedScale.contained,
      errorBuilder: (context, error, stackTrace) => Center(
        child: IconButton(
          onPressed: () {},
          color: Colors.white.withOpacity(0.5),
          icon: const Icon(
            Icons.refresh,
            color: Colors.black,
          ),
        ),
      ),
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
    );

Future<dynamic> defaultConfirmDialog({
  required BuildContext context,
}) async {
  AlertDialog alertDialog = AlertDialog(
    content: SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "do-you-want-to-delete-the-post".tr().toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "yes".tr().toString(),
                  )),
              const SizedBox(
                width: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "no".tr().toString(),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
  return await showDialog(context: context, builder: (context) => alertDialog);
}

defaultElevatedButton(
        {required Function onPressed,
        required Widget child,
        double width = 150}) =>
    SizedBox(
      height: 48,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Center(child: child),
      ),
    );

defaultSelectableText(
        {required String text,
        TextStyle? style,
        TextAlign textAlign = TextAlign.justify}) =>
    SelectableText(
      text,
      textAlign: textAlign,
      style: style,
      textDirection: intl.Bidi.detectRtlDirectionality(text)
          ? TextDirection.rtl
          : TextDirection.ltr,
      toolbarOptions: const ToolbarOptions(
        copy: true,
        selectAll: true,
      ),
    );

Widget defaultAutoSizeText(
        {required String text,
        required BuildContext context,
        TextAlign textAlign = TextAlign.justify}) =>
    AutoSizeText(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headline4,
      wrapWords: false,
      maxFontSize: 13,
      minFontSize: 12,
      textDirection: intl.Bidi.detectRtlDirectionality(text)
          ? TextDirection.rtl
          : TextDirection.ltr,
      overflow: TextOverflow.ellipsis,
      maxLines: 5,
    );

Widget defaultDismissible({
  required Widget child,
  required String key,
  DismissDirection direction = DismissDirection.none,
  required Function(DismissDirection direction) onDismissed,
  Future<bool?> Function(DismissDirection direction)? confirmDismiss,
}) =>
    Dismissible(
      direction: direction,
      key: Key(key),
      onDismissed: onDismissed,
      confirmDismiss: confirmDismiss,
      child: child,
      background: Container(
          margin: EdgeInsetsDirectional.only(
              top: direction == DismissDirection.down ? 30 : 0,
              start: direction == DismissDirection.down ? 0 : 30),
          alignment: direction == DismissDirection.down
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.centerStart,
          child: const Icon(
            Icons.delete,
            color: reverseColorDark,
          )),
      secondaryBackground: Container(
          margin: const EdgeInsetsDirectional.only(end: 30),
          alignment: AlignmentDirectional.centerEnd,
          child: const Icon(Icons.edit, color: reverseColorDark)),
    );

defaultDivider() => Builder(builder: (context) {
      return Builder(builder: (context) {
        return Divider(
          thickness: 0.4,
          height: 0.0,
          color: Theme.of(context).dividerColor,
          indent: MediaQuery.of(context).size.width * 0.045,
          endIndent: MediaQuery.of(context).size.width * 0.045,
          // endIndent: MediaQuery.of(context).size.width*0.9,
        );
      });
    });

Widget defaultGroupListTile({
  required String groupTitle,
  required List<Widget> groupElements,
}) =>
    Column(
      children: [
        Builder(builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              groupTitle,
              style: Theme.of(context).textTheme.overline,
            ),
          );
        }),
        Column(
          children: groupElements,
        ),
        defaultDivider(),
      ],
    );

Widget defaultListTile(
        {required String title,
        required String subtitle,
        GestureTapCallback? onTap}) =>
    Builder(builder: (context) {
      return ListTile(
        autofocus: true,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        title: Text(title, style: Theme.of(context).textTheme.headline2),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.subtitle1),
        onTap: onTap,
      );
    });
