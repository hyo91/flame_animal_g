import 'dart:ui';
import 'package:flame/components.dart';
// 게임 기본 기능
import 'package:flame/game.dart';
// 게임 기본 구조
import 'components/player/player.dart';
// 내가 만든 파일
import 'package:flame/events.dart';
// 터치 입력이나 키보드 이벤트 처리 ex) 터치시 덤픔, 오브젝트 끌어서 이동,wasd 이동, 등

class MainGame extends FlameGame with HasKeyboardHandlerComponents {
  // HasKeyboardHandlerComponents = 'package:flame/events.dart /
  // FlameGame ='package:flame/game.dart'; 여기서 가져옴. maingame는 flamegame 기능을 상속 받음
  // with = dart 기능 flamegame 기능 상속받은 maingame클래스에 h~기능도 주입
  MainGame();
  //

  // 나중에 초기화(late)
  late Player _player;
  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'otter_sprite_pack/otter_idle_1.png',
      'otter_sprite_pack/otter_idle_2.png',
      'otter_sprite_pack/otter_idle_3.png',
      'otter_sprite_pack/otter_idle_4.png',
    ]);

    _player = Player(
      // Player의 초기 위치 (바닥은 해당 값을 기준으로 계산함)
      position: Vector2(128, canvasSize.y - 70),
    );

    // add : 해당 메서드를 사용하여 게임에 추가.
    // add(_background);
    add(_player);
  }
}
