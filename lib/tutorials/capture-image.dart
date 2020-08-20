import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
/*

Image Capture
	camera
	path
	path_finder


StatelessWidget
	Life Cycle -> build function
				  i.e. simply return a widget and its gonna show it

StatefulWidget

	Life Cycle -> we have different functions
			      which shall be maintained in the State of Widget

	createState() -> create a state for the Widget, but this is not a method where we manage our code

	mounted(true/false) -> intermediate widget state which shall mount the widget on UI
	its an internal function, we dont use it

	//overridable
	initState() -> kind of constructor
				   here we must write some initiailization code
				   gets executed just before build function

	// overridable
	didChangeDependencies()	-> this is executed immediately after initState
							   only once, after initState
							   Whenver some dependent child widgets they change the state this will be excuted

	//mandatory
	build()
			i.e. simply return a widget and its gonna show it
			here, State will be linked with the built Widget

	didUpdateWidget()
		configuration changes in the device eg: device rotation may be

	setState() -> re-build the widget

	deactivate() -> State of Widget can be removed from widget tree internally when not in use,
	hence deactivate is executed

	dispose() -> destructor i.e. whenever widget is destroyed, dispose will be executed:)

 */

class CaptureImagePage extends StatefulWidget{

  CameraDescription camera;

  CaptureImagePage({Key key, @required this.camera}) : super(key: key);

  createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage>{

  CameraController controller;

  Future<void> controllerFuture;

  @override
  void initState() {
    super.initState(); // Parent initState must be executed

    controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );

    controllerFuture = controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAPTURE IMAGE"),
      ),
      body: FutureBuilder<void>(
        future: controllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            return CameraPreview(controller);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async{
            // In case user press the Floating Button, before initialization of CameraController
            // We must wait till controllerFuture is not properly returned back
            await controllerFuture;

            //String name = "Image_${DateTime.now()}.png";
            // The capture Image must ne saved in some path
            final imagePath = join( (await getTemporaryDirectory()).path, 'tempImage.png');
            controller.takePicture(imagePath);

            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCapturedImagePage(imagePath: imagePath,),));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose(); // Parent dispose must be executed
    controller.dispose(); // release the memory resources
  }
}

class ShowCapturedImagePage extends StatelessWidget{

  String imagePath;

  ShowCapturedImagePage({Key key, @required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imagePath),
      ),
      body: Image.file(File(imagePath)),
    );
  }

}