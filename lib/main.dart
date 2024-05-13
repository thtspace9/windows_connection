//
// // ok ********************************************
//
// // import 'dart:ffi' as ffi;
// // import 'package:ffi/ffi.dart';
// //
// // typedef HelloC = ffi.Pointer Function();
// // typedef HelloDart = ffi.Pointer Function();
// //
// // final myLibrary = ffi.DynamicLibrary.open('assets/usbPrinterSdkv_0_0_2.dll');
// //
// // final hello = myLibrary.lookupFunction<HelloC, HelloDart>('Hello');
// //
// // String helloWorld() {
// //   final resultPtr = hello();
// //   final result = resultPtr.toString();
// //   calloc.free(resultPtr);
// //   return result;
// // }
// //
// // void main() {
// //   print('Sultan The Super man: ');
// //   print(helloWorld());
// // }
//
//
//
//
//
//
//
// // ok ********************************************
//
// // import 'dart:ffi' as ffi;
// // import 'package:ffi/ffi.dart';
// //
// //
// // // Define typedefs for the native functions
// // typedef InitializeC = ffi.Uint8 Function();
// // typedef InitializeDart = int Function();
// //
// // typedef SendDataC = ffi.Void Function(ffi.Pointer<ffi.Int8> str);
// // typedef SendDataDart = void Function(ffi.Pointer<ffi.Int8> str);
// //
// // final myLibrary = ffi.DynamicLibrary.open('assets/usbPrinterSdkv_0_0_2.dll');
// //
// // // Look up the functions from the library
// // final initialize = myLibrary.lookupFunction<InitializeC, InitializeDart>('Initialize');
// // final sendData = myLibrary.lookupFunction<SendDataC, SendDataDart>('sendData');
// //
// // // Dart function to initialize the printer
// // bool initializePrinter() {
// //   return initialize() != 0; // Assuming 0 indicates failure, and non-zero indicates success
// // }
// //
// // // Dart function to send data to the printer
// // void sendToPrinter(String str) {
// //   final pointer = str.toNativeUtf8(); // Convert Dart string to UTF-8 encoded pointer
// //   sendData(pointer.cast<ffi.Int8>()); // Call the native function with the string pointer
// //   calloc.free(pointer); // Free the allocated memory
// // }
// //
// //
// // void main() {
// //   // Initialize the printer
// //   bool isPrinterInitialized = initializePrinter();
// //   print('Printer initialized: $isPrinterInitialized');
// //
// //   // Send data to the printer
// //   sendToPrinter('Your data to be sent to the printer');
// // }
//
//
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'dart:ffi' as ffi;
// import 'package:ffi/ffi.dart';
//
// // Define typedefs for the new native functions
// final myLibrary = ffi.DynamicLibrary.open('assets/usbPrinterSdkv0.0.5.dll');
//
//
//  /// Initialize printer section
//  typedef InitializeC = ffi.Uint8 Function();
//  typedef InitializeDart = int Function();
//  final initialize = myLibrary.lookupFunction<InitializeC, InitializeDart>('Initialize');
//
//  bool initializePrinter() {
//   return initialize() != 0;
//  }
//
//
// typedef SendByteListC = ffi.Uint8 Function(ffi.Pointer<ffi.Int32> list, ffi.Int32 height, ffi.Int32 width);
// typedef SendByteListDart = int Function(ffi.Pointer<ffi.Int32> list, int height, int width);
// final sendByteList = myLibrary.lookupFunction<SendByteListC, SendByteListDart>('sendByteList');
//
// void sendByteListToPrinter(List<int> list, int height, int width) {
//   final pointer = calloc<ffi.Int32>(list.length); // Allocate memory for the list
//   for (var i = 0; i < list.length; i++) {
//     pointer[i] = list[i];
//   }
//   print(pointer);
//   print(height);
//   print(width);
//   sendByteList(pointer, height, width); // Send the byte list to the printer
//   calloc.free(pointer); // Free the allocated memory
// }
//
//
//
// bool isPrinterInitialized = false;
// void main() {
//   // Initialize the printer
//   isPrinterInitialized = initializePrinter();
//   print('Printer initialized: $isPrinterInitialized');
//   runApp(const MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: ImageToUint8List(),
//     );
//   }
// }
//
// class ImageToUint8List extends StatefulWidget {
//   @override
//   _ImageToUint8ListState createState() => _ImageToUint8ListState();
// }
//
// class _ImageToUint8ListState extends State<ImageToUint8List> {
//   final String _assetImagePath = 'assets/Image_20231127171204.jpg';
//   Uint8List? _imageData;
//   final pixels = <int>[];
//   int bytesPerPixel=3;
//
//   int height = 832;
//   int width = 832;
//
//   Future<void> _convertToUint8List() async {
//     final ByteData data = await DefaultAssetBundle.of(context).load(_assetImagePath);
//     List<int> bytes = data.buffer.asUint8List();
//     img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
//     if (image != null) {
//       img.Image resizedImage = img.copyResize(image, width: 832, height: 832);
//       _imageData = resizedImage.getBytes();
//
//       //final img.Image? image = img.decodeImage(_imageData);
//       bytesPerPixel = _imageData!.length ~/ (resizedImage.width * resizedImage.height);
//        print("bytesPerPixel");
//       print("Resize Image: $bytesPerPixel");
//       //print("Unit8list Data: $_imageData");
//     }
//   }
//
//   Future<void> convertDataToPixel(Uint8List imageData) async {
//     print('kkkkkkkkkkk:${imageData.length}');
//
//     for (int i = 0; i < imageData.length - 1; i += bytesPerPixel) {
//       // Make sure to check that 'i + 3' does not exceed the array's length
//
//       int R = imageData[i];
//       int G = imageData[i + 1];
//       int B = imageData[i + 2];
//
//       pixels.add(R);
//       pixels.add(G);
//       pixels.add(B);
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image to Uint8List to RGB'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:[
//             Text('SDk Result: $isPrinterInitialized'),
//
//            Image(image: AssetImage(_assetImagePath), width: 200, height: 200),
//
//             ElevatedButton(
//               onPressed: _convertToUint8List,
//               child: const Text('Convert unit8List Image')),
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: (){
//                 convertDataToPixel(_imageData!);
//               },
//               child: const Text('Convert Pixel Data')),
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: (){
//                 //print('Pixel Data : $pixels');
//                 sendByteListToPrinter(pixels, height, width);
//               },
//               child: const Text('Print Section'),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'dart:ffi' as ffi;
// // import 'package:ffi/ffi.dart';
// //
// // final myLibrary = ffi.DynamicLibrary.open('assets/usbPrinterSdkv_0_0_4.dll');
// //
// // // Define function types
// // typedef SendByteListC = ffi.Void Function(ffi.Pointer<ffi.Uint8> list, ffi.Int32 height, ffi.Int32 width);
// // typedef SendByteListDart = void Function(ffi.Pointer<ffi.Uint8> list, int height, int width);
// //
// // void sendByteList(List<int> bytes, int height, int width) {
// //   // Allocate memory for the list in the native heap.
// //   final pointer = calloc<ffi.Uint8>(bytes.length);
// //
// //   // Copy the Dart list elements into the native memory.
// //   for (int i = 0; i < bytes.length; i++) {
// //     pointer[i] = bytes[i];
// //   }
// //
// //   // Call the native function.
// //   final sendByteListFunction = myLibrary.lookupFunction<SendByteListC, SendByteListDart>('sendByteList');
// //   sendByteListFunction(pointer, height, width);
// //
// //   // Free the allocated memory.
// //   calloc.free(pointer);
// // }
// //
// // void main() {
// //   // Example usage
// //   // Sample image data (3x3 pixels)
// //   List<int> bytes = [
// //     255, 0, 0,   // Red
// //     0, 255, 0,   // Green
// //     0, 0, 255,   // Blue
// //     255, 255, 0, // Yellow
// //     255, 0, 255, // Magenta
// //     0, 255, 255, // Cyan
// //     128, 128, 128, // Gray
// //     255, 255, 255, // White
// //     0, 0, 0,       // Black
// //   ];
// //   int height = 3; // Image height
// //   int width = 3;  // Image width
// //   sendByteList(bytes, height, width);
// // }
//
//
//
//
//
//
//
//
// // import 'dart:ffi' as ffi;
// //
// // /// angeln Sir Sdk Call
// // final myLibrary = ffi.DynamicLibrary.open('assets/Dll1.dll');
// //
// // typedef AddC = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
// // typedef AddDart = int Function(int a, int b);
// //
// //
// // final add = myLibrary.lookupFunction<AddC, AddDart>('Add');
// //
// // void main() {
// //   final result = add(1,8);
// //   print(result);
// // }





//*****************************************************SDK-8********************************************//



import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

// Define typedefs for the new native functions
final myLibrary = ffi.DynamicLibrary.open('assets/usbPrinterSdkv_8.dll');

typedef InitializeC = ffi.Uint8 Function();
typedef InitializeDart = int Function();
final initialize = myLibrary.lookupFunction<InitializeC, InitializeDart>('Initialize');

bool initializePrinter() {
  return initialize() != 0;
}

typedef SendByteListC = ffi.Uint8 Function(ffi.Pointer<ffi.Int32> list, ffi.Int32 height, ffi.Int32 width);
typedef SendByteListDart = int Function(ffi.Pointer<ffi.Int32> list, int height, int width);
final sendByteList = myLibrary.lookupFunction<SendByteListC, SendByteListDart>('sendByteList');

void sendByteListToPrinter(List<int> list, int height, int width) {
  final pointer = calloc<ffi.Int32>(list.length); // Allocate memory for the list
  for (var i = 0; i < list.length; i++) {
    pointer[i] = list[i];
  }
  sendByteList(pointer, height, width); // Send the byte list to the printer
  calloc.free(pointer); // Free the allocated memory
}

typedef PrinterListC = ffi.Pointer<ffi.Pointer<Utf8>> Function();
typedef PrinterListDart = ffi.Pointer<ffi.Pointer<Utf8>> Function();
final printerList = myLibrary.lookupFunction<PrinterListC, PrinterListDart>('PrinterList');

List<String> getPrinterList() {
  // Call the native function
  final printerListPointer = printerList();

  // Iterate through the list of printer names until reaching a null pointer
  final List<String> printerNames = [];
  int i = 0;
  while (printerListPointer[i] != ffi.nullptr) {
    printerNames.add(printerListPointer[i]!.cast<Utf8>().toDartString());
    i++;
  }

  // Free the allocated memory for the pointer array
  calloc.free(printerListPointer);

  return printerNames;
}

typedef SetPrinterC = ffi.Void Function(ffi.Int32 num);
typedef SetPrinterDart = void Function(int num);
final setPrinter = myLibrary.lookupFunction<SetPrinterC, SetPrinterDart>('setPrinter');

void selectPrinter(int num) {
  setPrinter(num);
}

bool isPrinterInitialized = false;

void main() {
  // Initialize the printer
  isPrinterInitialized = initializePrinter();
  print('Printer initialized: $isPrinterInitialized');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageToUint8List(),
    );
  }
}

class ImageToUint8List extends StatefulWidget {
  const ImageToUint8List({Key? key}) : super(key: key);

  @override
  _ImageToUint8ListState createState() => _ImageToUint8ListState();
}

class _ImageToUint8ListState extends State<ImageToUint8List> {
  final String _assetImagePath = 'assets/Image_20231127171204.jpg';
  Uint8List? _imageData;
  final pixels = <int>[];
  int bytesPerPixel = 3;

  int height = 832;
  int width = 832;

  Future<void> _convertToUint8List() async {
    final ByteData data = await DefaultAssetBundle.of(context).load(_assetImagePath);
    final List<int> bytes = data.buffer.asUint8List();
    final img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      final img.Image resizedImage = img.copyResize(image, width: 832, height: 832);
      _imageData = resizedImage.getBytes();

      bytesPerPixel = _imageData!.length ~/ (resizedImage.width * resizedImage.height);
    }
  }

  Future<void> convertDataToPixel(Uint8List imageData) async {
    for (int i = 0; i < imageData.length - 1; i += bytesPerPixel) {
      int R = imageData[i];
      int G = imageData[i + 1];
      int B = imageData[i + 2];

      pixels.add(R);
      pixels.add(G);
      pixels.add(B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image to Uint8List to RGB'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SDk Result: $isPrinterInitialized'),

            Image(image: AssetImage(_assetImagePath), width: 200, height: 200),

            ElevatedButton(
              onPressed: _convertToUint8List,
              child: const Text('Convert unit8List Image'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                convertDataToPixel(_imageData!);
              },
              child: const Text('Convert Pixel Data'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                List<String> printerList = getPrinterList();
                print('Printer List: $printerList');
              },
              child: const Text('Fetch Printer List'),
            ),

            ElevatedButton(
              onPressed: () {
                selectPrinter(0); // Select the first printer, change index as required
              },
              child: const Text('Select Printer'),
            ),

            ElevatedButton(
              onPressed: () {
                sendByteListToPrinter(pixels, height, width);
              },
              child: const Text('Print'),
            ),


          ],
        ),
      ),
    );
  }
}
