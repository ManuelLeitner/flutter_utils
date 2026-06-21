import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../extension.dart';

class NumberFormField<T extends num> extends StatelessWidget {
  final NumberEditingController? controller;
  final NumberFormat numberFormat;
  final T? initialValue;
  final FormFieldValidator<T?>? validator;
  final FormFieldSetter<T?>? onSaved;
  final ValueChanged<T?>? onChanged;

  final bool allowEmpty;
  final InputDecoration? decoration;

  final TextInputType? keyboardType;
  late final TextEditingController _textEditingController;

  NumberFormField({
    super.key,
    this.controller,
    NumberFormat? numberFormat,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.decoration,
    this.onChanged,
    required this.keyboardType,
    this.allowEmpty = false,
  }) : numberFormat = numberFormat ?? NumberFormat() {
    assert(controller == null || initialValue == null);
    _textEditingController = TextEditingController(
      text: initialValue == null ? "" : this.numberFormat.format(initialValue),
    );
    controller?._init(_textEditingController, this.numberFormat);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        if (!value) _reformat();
      },
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: _textEditingController,
        keyboardType: keyboardType,
        decoration: decoration,
        validator: (value) {
          var num = _tryParse<T>(numberFormat, value);
          if (num == null && !allowEmpty) return "Ungültige Zahl";
          return validator?.call(num);
        },
        onTapOutside: (_) {
          _reformat();
        },
        onSaved: (newValue) => onSaved?.call(_tryParse(numberFormat, newValue)),
        onChanged: (newValue) =>
            onChanged?.call(_tryParse(numberFormat, newValue)),
      ),
    );
  }

  void _reformat() {
    var num = _tryParse(numberFormat, _textEditingController.text);
    if (num != null) _textEditingController.text = numberFormat.format(num);
  }
}

T? _tryParse<T>(NumberFormat numberFormat, String? value) {
  if (value == null) return null;
  if (value.endsWith(numberFormat.currencySymbol)) {
    value = value.substring(
      0,
      value.length - numberFormat.currencySymbol.length,
    );
  }
  var val = numberFormat.tryParse(value.trim());
  if (typeEquals<T, int>() && val is! int) val = val?.toInt();
  if (typeEquals<T, double>() && val is! double) val = val?.toDouble();
  return val as T?;
}

String? requiredNumberValidator<T extends num>(T? value) {
  if (value == null) return "Zahl fehlt";
  return null;
}

class NumberEditingController<T extends num> extends TextEditingController {
  T _number;

  set number(T num) {
    _number = num;

    if (_textEditingController != null) {
      _textEditingController!.text = _numberFormat!.format(num);
    }
  }

  T get number => _number;

  NumberEditingController(this._number);

  TextEditingController? _textEditingController;
  NumberFormat? _numberFormat;

  void _init(
    TextEditingController textEditingController,
    NumberFormat numberFormat,
  ) {
    _textEditingController = textEditingController;
    _numberFormat = numberFormat;
    _textEditingController?.text = numberFormat.format(_number);
  }
}
