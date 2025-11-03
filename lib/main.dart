import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'maingame.dart';

Future<void> main() async {
  // dart에서 비동기함수 사용할때 Future<void> 사용
  // 생략해도 자동으로 future로 변환되지만 명시적으로 표시하는게 좋음
  WidgetsFlutterBinding.ensureInitialized();
  // flutter 엔진과 프레임워크바인딩 초기화
  // 일반적으로 runapp 호출 시 자동으로 초기화 되지만 네이티브 플랫폼 기능 사용 시(runapp 전에 사용되기 때문에) 수동으로 먼저 초기화 시키는게 안전

  // 가로 방향 고정
  await SystemChrome.setPreferredOrientations([
    // 시스템 ui 제어 객체 services.dart 에서 가져옴
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    // controlled : 해당 값은 'true'로 설정되면 게임 루프가 제어되고 고정된 FPS로 실행됨.
    // gameFactory : 'SeokbongRoom' 객체를 만들기 위한 팩토리 함수 지정
    // SeokbongRoom 게임 오브젝트를 생성 -> GameWidget 초기화 -> 어플리케이션 실행(RunApp), controlled가 true 이므로 게임 루프가 제어되고 고정된 FPS로 게임이 실행됨.
    const GameWidget<MainGame>.controlled(gameFactory: MainGame.new),
  );
}
