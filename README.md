### 기본 사용법

![drag](https://github.com/user-attachments/assets/81f24d20-6e6f-4898-b81c-794de2517d03)

LongPress(꾹 누르기)를 통해 '할 일'을 움직일 수 있습니다.

![add](https://github.com/user-attachments/assets/a08ffcc3-408a-431e-a5fe-f4e54697ea58)

상단 + 버튼을 통해 '할 일'을 등록할 수 있습니다.

![edit](https://github.com/user-attachments/assets/73455634-07ea-4717-a4a3-be39b5a503ba)

![delete](https://github.com/user-attachments/assets/27acdae6-ac1b-407b-bb1f-36616ebb1f9f)

이미 존재하는 카드들을 클릭하면 수정 및 삭제가 가능합니다.

### Project Directory Structure

lib   
├── home   
│ ├── home_controller.dart  # todo-list 메인화면 GetXController   
│ └── home_page.dart        # todo-list 메인화면 UI   
│    
├── models    
│ ├── board_item_model.dart # board_item 모델 정의      
│ └── board_list_model.dart # board_list 모델 정의     
│    
└── main.dart   
