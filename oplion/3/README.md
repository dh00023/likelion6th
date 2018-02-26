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

#### Controller와 View, Acition 동시에 생성하기

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

[실습](./frist_project)

## 3. CRUD 구현

Create / Read / Update / Delete 이다.

- 변수는 일시적으로 정보를 저장한다.
- DB는 영구적으로 정보를 저장한다.(많은 정보를 체계적으로 관리)


#### Get / Post

- get : 입력한 정보를 url에 노출한다.(정보를 보여줘도 상관 없을 때)
- post : 입력한 정보를 숨긴다.(url에 노출되지 않는다.)

#### CSRF
웹 페이지에 악성 코드나 링크를 포함하는 공격 방법이다.

```erb
<%= hidden_field_tag :authenticity_token, form_authenticity_token %>
```

### CR

#### Model 생성
```
$ rails g model Post title content:text
      invoke  active_record
      create    db/migrate/20180226143511_create_posts.rb
      create    app/models/post.rb
      invoke    test_unit
      create      test/models/post_test.rb
      create      test/fixtures/posts.yml

```

`migrate`, `model`파일이 생성된다.

- migrate에서는 테이블의 모양을 결정할 수 있다.

#### Model 확정 / 삭제
```
$ rails db:migrate
$ rails db:drop
```

#### Model / Controller
```rb
class HomeController < ApplicationController
  def create
  	@post = Post.new #테이블의 한 행을 추가
  	@post.title = params[:post_title] 
  	@post.content = params[:post_content]
  	@post.save #테이블에 써준 내용 모두 저장

  	redirect_to '/'
  end
end
```

#### Console 실행

```
$ rails c
```


### D

특정한 게시물을 삭제하기 위해서는 **id**를 통해서 삭제해야한다.

```rb
# routes
get 'home/destroy/:post_id'=>'home#destroy'
```
```erb
<a href="/home/destroy/<%= p.id %> "> 삭제</a>
```
```rb
def destroy
  post = Post.find(params[:post_id])
  post.destroy
  redirect_to '/'
end
```
각 게시물의 id를 전달해서 삭제를 해준다.

### U

```erb
<form action="/home/update/<%=@post.id%>" method="post">
  <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
  제목: <input type="text" name="post_title" value="<%=@post.title%>"><br><br>
  내용: <textarea name="post_content" ><%=@post.content%></textarea><br>
  <input type="submit" value="제출">
</form>
```
```rb
get 'home/edit/:post_id'=>'home#edit'
post 'home/update/:post_id'=>'home#update'
```
```rb
def edit
  @post = Post.find(params[:post_id])
end

def update
  post = Post.find(params[:post_id])
  post.title = params[:post_title] 
  post.content = params[:post_content]
  post.save #테이블에 써준 내용 모두 저장
  redirect_to '/'
end
```