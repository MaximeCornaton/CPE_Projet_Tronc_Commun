import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pPage.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ControlPage extends BasePage {
  ControlPage({super.key}) : super(title: 'Contrôle');

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50.0),
            child: VideoPlayerWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: ControlButtons(),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late ChewieController _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      );
      await videoPlayerController.initialize();
      setState(() {
        _isInitialized = true;
      });

      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var borderRadius_ = BorderRadius.circular(10);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
                    Colors.grey),
        borderRadius: borderRadius_,
      ),
      child: Stack(
        children: [
          _isInitialized
              ? AspectRatio(
                  aspectRatio:
                      _chewieController.videoPlayerController.value.aspectRatio,
                  child: ClipRRect(
                    borderRadius: borderRadius_,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                )
              : Container(),
          if (!_isInitialized)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class ControlButtons extends StatefulWidget {
  const ControlButtons({Key? key}) : super(key: key);

  @override
  ControlButtonsState createState() => ControlButtonsState();
}

class ControlButtonsState extends State<ControlButtons> {
  bool _isMovingForward = false;
  bool _isMovingBackward = false;
  bool _isTurningLeft = false;
  bool _isTurningRight = false;

  void _moveForward(bool value) {
    setState(() {
      _isMovingForward = value;
    });
  }

  void _moveBackward(bool value) {
    setState(() {
      _isMovingBackward = value;
    });
  }

  void _turnLeft(bool value) {
    setState(() {
      _isTurningLeft = value;
    });
  }

  void _turnRight(bool value) {
    setState(() {
      _isTurningRight = value;
    });
  }

  void _stop() {
    setState(() {
      _isMovingForward = false;
      _isMovingBackward = false;
      _isTurningLeft = false;
      _isTurningRight = false;
    });
  }

  Widget _buildJoystickButton(
      IconData icon, bool isPressed, Function(bool) onPressedFunction) {
    return IconButton(
      onPressed: () => onPressedFunction(!isPressed),
      icon: Icon(icon),
      color: isPressed
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_up_rounded,
              _isMovingForward,
              _moveForward,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_left_rounded,
              _isTurningLeft,
              _turnLeft,
            ),
            const SizedBox(width: 50),
            _buildJoystickButton(
              Icons.keyboard_arrow_right_rounded,
              _isTurningRight,
              _turnRight,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_down_rounded,
              _isMovingBackward,
              _moveBackward,
            ),
          ],
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: _stop,
          child: const Text('Arrêter'),
        ),
      ],
    );
  }
}
