import 'dart:ui';
import 'package:flame/components.dart';
// 게임 기본 기능
import 'package:flame/game.dart';
// 게임 기본 구조
import 'components/player/player.dart';
// 내가 만든 파일
import 'package:flame/events.dart';
// 터치 입력이나 키보드 이벤트 처리 ex) 터치시 점프, 오브젝트 끌어서 이동,wasd 이동, 등

class MainGame extends FlameGame with HasKeyboardHandlerComponents {
  // HasKeyboardHandlerComponents = 'package:flame/events.dart /키보드 이벤트임
  // FlameGame ='package:flame/game.dart'; 여기서 가져옴. maingame는 flamegame 기능을 상속 받음
  // with = dart 기능 flamegame 기능 상속받은 maingame클래스에 HasKeyb~기능도 주입
  MainGame();
  //

  // 나중에 초기화(late) (초기화 : 초기 값을 정함 / reset x ㅡㅡ)
  late Player _player;
  // late 변수 , _player변수를 Player로 지정만 해둔상태 값을 지정하지 않았기 때문에 late를 쓰지않으면 오류남

  @override
  Future<void> onLoad() async {
    // Future<void> =  비동기 함수의 반환값.  <void> = 아직 값이 없음
    //비동기 함수 = 파일을 로드 하는 동안 다른 코드가 멈추지 않음
    // onLoad 메서드: 게임화면 전에 호출
    await images.loadAll([
      // await = 이 작업이 끝날때까지 다른건 실행 x async 애서만 사용 가능
      // images : flamegame 클래스의 이미지 관리 객체
      // loadAll([..]) 파일 여러개를 한번에 관리
      'otter_sprite_pack/otter_idle_1.png',
      'otter_sprite_pack/otter_idle_2.png',
      'otter_sprite_pack/otter_idle_3.png',
      'otter_sprite_pack/otter_idle_4.png',
    ]);

    _player = Player(
      // Player의 초기 위치 (바닥은 해당 값을 기준으로 계산함)
      position: Vector2(128, canvasSize.y - 75),
      size: Vector2(200, 200),
    );
    // Vector2란?
    // 2차원 공간에서 x, y 좌표를 나타내는 객체
    // 위치(position), 크기(size), 속도(velocity) 등 다양한 2D 벡터를 표현할 때 사

    // add : 해당 메서드를 사용하여 게임에 추가.
    // add(_background);
    add(_player);
  }
}
