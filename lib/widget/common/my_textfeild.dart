
import 'package:flyro/export.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? isObSecure;
  final bool? haveLabel;
  final bool? isReadOnly;
  final double? marginBottom;
  final double? radius;
  final int? maxLines;
  final double? labelSize;
  final double? hintsize;
  final FocusNode? focusNode;
  final Color? filledColor;
  final Color? focusedFillColor;
  final bool? autoFocus;
  final Color? bordercolor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? focusBorderColor;
  final Widget? prefix;
  final Widget? suffix;
  final FontWeight? labelWeight;
  final FontWeight? hintWeight;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final bool? showPasswordToggle;
  final bool? isPin;
  final List<TextInputFormatter>? inputFormatters;
  final String? obscuringCharacter;
  final TextStyle? style;
  final TextAlign? textAlign;

  const MyTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 18.0,
    this.maxLines = 1,
    this.filledColor,
    this.focusedFillColor,
    this.hintColor,
    this.labelColor,
    this.haveLabel = true,
    this.labelSize,
    this.hintsize,
    this.prefix,
    this.suffix,
    this.autoFocus = false,
    this.labelWeight,
    this.hintWeight,
    this.keyboardType,
    this.isReadOnly = false,
    this.onTap,
    this.bordercolor,
    this.focusBorderColor,
    this.focusNode,
    this.radius = 22.0,
    this.height = 70.0,
    this.width,
    this.validator,
    this.showPasswordToggle = false,
    this.isPin = false,
    this.inputFormatters,
    this.obscuringCharacter = '•',
    this.style,
    this.textAlign,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _isFocused = widget.focusNode?.hasFocus ?? false);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  Widget _buildPasswordToggle(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: ThemeColors.inputHint(context),
        size: 20,
      ),
      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
    );
  }

@override
Widget build(BuildContext context) {
  final defaultFilledColor = ThemeColors.inputBackground(context);
  final defaultFocusedFillColor = ThemeColors.inputBackground(context);
  final defaultFocusBorderColor = ThemeColors.focused(context);
  final defaultHintColor = ThemeColors.inputHint(context);
  final defaultTextColor = ThemeColors.text(context);
  final defaultErrorColor = ThemeColors.error(context);
  final defaultLabelColor = ThemeColors.text(context);

  return Padding(
    padding: EdgeInsets.only(bottom: widget.marginBottom ?? 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restore the external label
        if (widget.haveLabel == true && widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: widget.labelSize ?? 16.0,
                fontWeight: widget.labelWeight ?? FontWeight.w500,
                color: widget.labelColor ?? defaultLabelColor,
              ),
            ),
          ),
        Container(
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 12.0),
            color: _isFocused
                ? widget.focusedFillColor ?? defaultFocusedFillColor
                : widget.filledColor ?? defaultFilledColor,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          child: TextFormField(
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: widget.isPin == true
                ? TextInputType.number
                : widget.keyboardType,
            inputFormatters: widget.isPin == true
                ? [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : widget.inputFormatters,
            obscureText: (widget.isObSecure ?? false) && !_isPasswordVisible,
            obscuringCharacter: widget.obscuringCharacter ?? '•',
            textAlign: widget.textAlign ?? TextAlign.start,
            style: widget.style ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: defaultTextColor,
                ),
            maxLines: widget.maxLines ?? 1,
            readOnly: widget.isReadOnly ?? false,
            controller: widget.controller,
            autofocus: widget.autoFocus ?? false,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: _isFocused
                  ? widget.focusedFillColor ?? defaultFocusedFillColor
                  : widget.filledColor ?? defaultFilledColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                borderSide: BorderSide(
                  color: widget.focusBorderColor ?? defaultFocusBorderColor,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                borderSide: BorderSide(
                  color: defaultErrorColor,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                borderSide: BorderSide(
                  color: defaultErrorColor,
                  width: 2,
                ),
              ),
              prefixIcon: widget.prefix != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: widget.prefix,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              suffixIcon: widget.showPasswordToggle == true
                  ? _buildPasswordToggle(context)
                  : widget.suffix != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: widget.suffix,
                        )
                      : null,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              // Only show hint text, not label
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: defaultHintColor,
                fontWeight: FontWeight.w400,
              ),
              errorStyle: const TextStyle(
                height: 0,
                fontSize: 0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}}
// ========== CONVENIENCE CONSTRUCTORS ==========
extension MyTextFieldPresets on MyTextField {
  
  static MyTextField email({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Email',
    String hint = 'Enter your email address',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    keyboardType: TextInputType.emailAddress,
    onChanged: onChanged,
    validator: validator,
    prefix: SvgPicture.asset(
      Assets.emailfilled,
      height: 20.0,
      color: context?.icon,
    ),
    showPasswordToggle: false,
  );

  static MyTextField password({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Password',
    String hint = 'Enter your password',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    bool showToggle = true,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    isObSecure: true,
    showPasswordToggle: showToggle,
    onChanged: onChanged,
    validator: validator,
    prefix: SvgPicture.asset(
      Assets.lockfilled,
      height: 20.0,
      color: context?.icon,
    ),
  );

  static MyTextField search({
    BuildContext? context,
    TextEditingController? controller,
    String hint = 'Search flights...',
    ValueChanged<String>? onChanged,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    onChanged: onChanged,
    haveLabel: false,
    prefix: SvgPicture.asset(
      Assets.searchunfilled,
      height: 18.0,
      color: context?.icon,
    ),
  );

  static MyTextField name({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Full Name',
    String hint = 'Enter your full name',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    keyboardType: TextInputType.name,
    onChanged: onChanged,
    validator: validator,
    prefix: SvgPicture.asset(
      Assets.personfilled,
      height: 20.0,
      color: context?.icon,
    ),
  );

  static MyTextField phone({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Phone Number',
    String hint = 'Enter your phone number',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    keyboardType: TextInputType.phone,
    onChanged: onChanged,
    validator: validator,
    prefix: SvgPicture.asset(
      Assets.phonefilled,
      height: 20.0,
      color: context?.icon,
    ),
  );

  static MyTextField multiline({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Message',
    String hint = 'Write your message here...',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int maxLines = 4,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    maxLines: maxLines,
    keyboardType: TextInputType.multiline,
    onChanged: onChanged,
    validator: validator,
  );

  static MyTextField pin({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'PIN',
    String hint = '0',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    isPin: true,
    haveLabel: false,
    keyboardType: TextInputType.number,
    onChanged: onChanged,
    validator: validator,
    textAlign: TextAlign.center,
  );

  static MyTextField amount({
    BuildContext? context,
    TextEditingController? controller,
    String label = 'Amount',
    String hint = '0.00',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    label: label,
    hint: hint,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: onChanged,
    validator: validator,
    prefix: SvgPicture.asset(
      Assets.money,
      height: 20.0,
      color: context?.icon,
    ),
  );
}