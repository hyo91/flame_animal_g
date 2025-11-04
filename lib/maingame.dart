import 'dart:ui';
import 'package:flame/components.dart';
// 게임 기본 기능
import 'package:flame/game.dart';
// 게임 기본 구조
import 'components/player/player.dart';
// 내가 만든 파일
import 'package:flame/events.dart';
// 터치 입력이나 키보드 이벤트 처리 ex) 터치시 점프, 오브젝트 끌어서 이동,wasd 이동, 등
import 'components/background/background1.dart';
// 배경
import 'components/background/foreground/foreground.dart';
// 전경
import 'components/obstacle/obstacle1.dart';

class MainGame extends FlameGame with HasKeyboardHandlerComponents {
  // HasKeyboardHandlerComponents = 'package:flame/events.dart /키보드 이벤트
  // FlameGame ='package:flame/game.dart'; 여기서 가져옴. maingame는 flamegame 기능을 상속 받음
  // with = dart 기능 flamegame 기능 상속받은 maingame클래스에 HasKeyb~기능도 주입
  MainGame();
  //
  late Background1 _background1;
  late Foreground _foreground;
  late Obstacle1 _obstacle1;

  // 나중에 초기화(late) (초기화 : 초기 값을 정함 / reset x ㅡㅡ)
  late Player _player;
  // late 변수 , _player변수를 Player로 지정만 해둔상태 값을 지정하지 않았기 때문에 late를 쓰지않으면 오류남

  @override
  // override = 부모 클래스의 메서드를 재정의
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
      // 점프 이미지
      'otter_sprite_pack/otter_jump_1.png',
      'otter_sprite_pack/otter_jump_2.png',
      'otter_sprite_pack/otter_jump_3.png',
      'otter_sprite_pack/otter_jump_4.png',
      // 달리는 이미지
      'otter_sprite_pack/otter_run_1.png',
      'otter_sprite_pack/otter_run_2.png',
      'otter_sprite_pack/otter_run_3.png',
      'background/parallax-mountain-bg.png',
      'background/parallax-mountain-foreground-trees.png',
      'background/parallax-mountain-montain-far.png',
      'background/parallax-mountain-mountains.png',
      'background/parallax-mountain-foreground-trees.png',
      'background/parallax-mountain-trees.png',

      'obstacle/obstacle1.png', // 장애물 이미지 추가
    ]);

    _background1 = Background1(gameSize: size);
    _foreground = Foreground();
    // 장애물 추가 (화면 오른쪽에 배치, )
    _obstacle1 = Obstacle1(
      position: Vector2(size.x + 100, size.y - 100),
      size: Vector2(80, 120),
    );

    _player = Player(
      // Player의 초기 위치 (바닥은 해당 값을 기준으로 계산함)
      position: Vector2(128, size.y - 75),
      size: Vector2(200, 200),
    );
    // Vector2란?
    // 2차원 공간에서 x, y 좌표를 나타내는 객체
    // 위치(position), 크기(size), 속도(velocity) 등 다양한 2D 벡터를 표현할 때 사

    // add : 해당 메서드를 사용하여 게임에 추가.
    add(_background1);
    add(_foreground);
    add(_player);
    add(_obstacle1);
  }
}

// flame 안에서 컴포넌트 로드 되는 순서 ㅐㅟㅐ
