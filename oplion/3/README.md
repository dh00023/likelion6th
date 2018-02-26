# Rails

## 1. MVC

- 디자인 패턴 : 축적된 노하우를 정리한 것
- MVC(Model - View - Controller)는 Rails의 디자인 패턴이다.

## 2. VC 구현

- 액션 : 실질적으로 요청을 처리
- 컨트롤러 : 액션들의 모음

#### Rails project 생성

```
$ rails new project_name
```

#### controller 생성

```
$ rails g controller home
```

#### Controller와 View 동시에 생성하기

```
$ rails g controller home index attack defense
```

**action에서 데이터를 처리하고 view에서는 그 결과를 보여준다.**
**단,action과 view의 이름은 통일되어야 연결된다.**

#### erb란?
`.erb`는 ruby코드를 쓸 수 있는 html의 확장판이다.
erb는 embeded ruby의 줄임말이다.

`application.html.erb` 파일이 레일즈 프로젝트에 생성되어있다. 여기에 기본적인 구조는 생성되어있고, 우리가 만드는 view파일은 `<%= yield %>`에 포함되는 부분이다.

#### 서버실행

```
$ rails s
```
종료는 `control`+`c`이다. 
서버를 실행하면 `localhost:3000`에서 확인할 수 있다.

#### 경로

`config/routes.rb`에서 경로를 설정한다.
```rb
Rails.application.routes.draw do
	root 'home#index' # 홈경로 설정
	get 'attack',to: 'home#attack'
	get 'defense'=> 'home#defense' # ,to:와 =>는 같은 의미
end
```

#### params
params는 우리가 보내는 정보가 저장된 보따리이다.
`.erb`에서는 `<%=%>`안에 루비코드를 써야한다.
이때 instance 변수(`@`)를 써야지 저장된 정보를 전달할 수 있다.