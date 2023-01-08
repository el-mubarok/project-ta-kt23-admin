import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class WidgetInput extends StatefulWidget {
  WidgetInput({
    Key? key,
    required this.hint,
    this.label,
    required this.type,
    required this.onChanged,
    VoidCallback? onFocused,
    this.readOnly = false,
    this.hasError = false,
    this.errorMessage = "",
    this.hasPadding = true,
    this.isPrice = false,
    this.isTextArea = false,
    this.initialValue,
    this.textController,
    this.keyValue,
    this.icon,
    this.hasClearButton = false,
    this.onClearButton,
    this.isRequired = false,
    this.isPassword = false,
  })  : onFocused = onFocused ?? (() {}),
        super(key: key);

  final String hint;
  final String? label;
  final TextInputType type;
  final ValueChanged<String> onChanged;
  final VoidCallback onFocused;
  final bool readOnly;
  final bool hasError;
  final String errorMessage;
  final bool hasPadding;
  final bool isPrice;
  final bool isTextArea;
  final String? initialValue;
  final TextEditingController? textController;
  final String? keyValue;
  final HeroIcons? icon;
  final bool hasClearButton;
  final VoidCallback? onClearButton;
  final bool isRequired;
  final bool isPassword;

  @override
  State<StatefulWidget> createState() => _WidgetInput();
}

class _WidgetInput extends State<WidgetInput> {
  TextEditingController textController = TextEditingController();
  bool isError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.hasPadding
          ? const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            )
          : null,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.label != null
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "${widget.label}${widget.isRequired ? '*' : ''}",
                    style: TextStyle(
                      color: widget.isRequired &&
                              (widget.textController?.text ?? "").isEmpty
                          ? AppColors.primary
                          : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primary,
              ),
            ),
            child: TextFormField(
              controller: widget.textController,
              textInputAction:
                  widget.isTextArea ? TextInputAction.newline : null,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              validator: (value) {
                return widget.isRequired
                    ? (value == null || value.isEmpty ? "" : null)
                    : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: widget.isTextArea ? 16 : 0,
                  horizontal: 4,
                ),
                labelText: widget.hint,
                hintText: widget.hint,
                hintStyle: const TextStyle(),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: true,
                labelStyle: const TextStyle(
                  color: Colors.black45,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: widget.hasError ? Colors.red : Colors.black54,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                errorStyle: const TextStyle(
                  height: 0,
                ),
                fillColor: Colors.white,
                prefixIcon: widget.icon != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: HeroIcon(
                          widget.icon ?? HeroIcons.academicCap,
                          size: 28,
                        ),
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 16,
                ),
                suffixIcon: widget.hasClearButton
                    ? GestureDetector(
                        onTap: () {
                          widget.textController?.clear();
                          widget.onClearButton!();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            right: 16,
                          ),
                          child: HeroIcon(
                            HeroIcons.xCircle,
                            style: HeroIconStyle.mini,
                            size: 24,
                          ),
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 16,
                ),
              ),
              keyboardType: widget.type,
              minLines: widget.isTextArea ? 2 : 1,
              maxLines: widget.isTextArea ? 8 : 1,
              onChanged: (String value) {
                widget.onChanged(value);
              },
              readOnly: widget.readOnly,
              showCursor: widget.readOnly ? false : true,
              obscureText: widget.isPassword,
              onTap: () {
                widget.onFocused();
              },
            ),
          ),
          //
          Visibility(
            visible: widget.hasError,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 14,
                    color: Colors.red,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                  ),
                  Text(
                    widget.errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
