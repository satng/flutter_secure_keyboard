import 'package:flutter/material.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WithSecureKeyboardExample(),
    );
  }
}

class WithSecureKeyboardExample extends StatefulWidget {
  @override
  _WithSecureKeyboardExampleState createState() => _WithSecureKeyboardExampleState();
}

class _WithSecureKeyboardExampleState extends State<WithSecureKeyboardExample> {
  final _secureKeyboardController = SecureKeyboardController();

  final _passwordEditor = TextEditingController();
  final _passwordTextFieldFocusNode = FocusNode();

  final _pinCodeEditor = TextEditingController();
  final _pinCodeTextFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Set the WithSecureKeyboard widget as the top-level widget
    // in the build function so that the secure keyboard works properly.
    return WithSecureKeyboard(
      controller: _secureKeyboardController,
      keyInputMonitorPadding: EdgeInsets.zero,
      child: Scaffold(
        appBar: AppBar(
          title: Text('flutter_secure_keyboard'),
        ),
        body: _buildContentView(),
      ),
    );
  }

  Widget _buildContentView() {
    // We recommend using the ListView widget to prevent widget overflow.
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        _buildPasswordTextField(),
        SizedBox(height: 12.0),
        _buildPinCodeTextField(),
      ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password'),
        TextFormField(
          controller: _passwordEditor,
          focusNode: _passwordTextFieldFocusNode,
          // We recommended to set false to prevent the software keyboard from opening.
          enableInteractiveSelection: false,
          obscureText: false,
          onTap: () {
            _secureKeyboardController.show(
              type: SecureKeyboardType.ALPHA_NUMERIC,
              focusNode: _passwordTextFieldFocusNode,
              initText: _passwordEditor.text,
              hideKeyInputMonitor:true,
              hintText: 'password',
              shuffleNumericKey: false,
              // Use onCharCodesChanged to have text entered in real time.
              onCharCodesChanged: (List<int> charCodes) {
                _passwordEditor.text = String.fromCharCodes(charCodes);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPinCodeTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PinCode'),
        TextFormField(
          controller: _pinCodeEditor,
          focusNode: _pinCodeTextFieldFocusNode,
          // We recommended to set false to prevent the software keyboard from opening.
          enableInteractiveSelection: false,
          obscureText: true,
          onTap: () {
            _secureKeyboardController.show(
              type: SecureKeyboardType.NUMERIC,
              focusNode: _pinCodeTextFieldFocusNode,
              initText: _pinCodeEditor.text,
              hideKeyInputMonitor:true,
              hintText: 'pinCode',
              shuffleNumericKey: false,
              // Use onDoneKeyPressed to allow text to be entered when you press the done key,
              // or to do something like encryption.
              onDoneKeyPressed: (List<int> charCodes) {
                _pinCodeEditor.text = String.fromCharCodes(charCodes);
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _secureKeyboardController.dispose();
    _passwordEditor.dispose();
    _pinCodeEditor.dispose();
  }
}
