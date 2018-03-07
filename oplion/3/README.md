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

## 4. 레일즈 심화

### View Helper

- `link_to` : `<a>`를 레일즈에서 더 간단하게 쓸 수 있는 방법이다.

```erb
<a href = "/posts/destroy/<%=post.id%>">삭제</a>
<%=link_to '삭제', "/posts/destroy/#{post.id}">
```

**여기서 `""`안에 `#{}`을 사용한다는 점을 유의해야한다.**

- **route**

`as:`로 간단하게 이름을 설정할 수 있다.
```rb
get 'home/destroy/:post_id'=>'home#destroy',as: 'post_destroy'
```
```erb
<%= link_to '삭제3', post_destroy_path(post_id: p.id) %>
```

## 5. Scaffold & Restful

migrate / controller / model / view / route를 한번에 만들어 주는 것이다.

```
$ rails g scaffold post title:string content:text
      invoke  active_record
      create    db/migrate/20180301144540_create_posts.rb
      create    app/models/post.rb
      invoke    test_unit
      create      test/models/post_test.rb
      create      test/fixtures/posts.yml
      invoke  resource_route
       route    resources :posts
      invoke  scaffold_controller
      create    app/controllers/posts_controller.rb
      invoke    erb
      create      app/views/posts
      create      app/views/posts/index.html.erb
      create      app/views/posts/edit.html.erb
      create      app/views/posts/show.html.erb
      create      app/views/posts/new.html.erb
      create      app/views/posts/_form.html.erb
      invoke    test_unit
      create      test/controllers/posts_controller_test.rb
      invoke    helper
      create      app/helpers/posts_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/posts/index.json.jbuilder
      create      app/views/posts/show.json.jbuilder
      create      app/views/posts/_post.json.jbuilder
      invoke  test_unit
      create    test/system/posts_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/posts.coffee
      invoke    scss
      create      app/assets/stylesheets/posts.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```

#### RESTful
무엇(resource)을 어떻게(HTTP method) 할 지 표현 하는 것이다.
- HTTP method : GET / POST / PUT / PATCH / DELETE

```rb
resources :posts
```
```
$ rails routes
  Prefix Verb   URI Pattern               Controller#Action
     root GET    /                         posts#index
    posts GET    /posts(.:format)          posts#index
          POST   /posts(.:format)          posts#create
 new_post GET    /posts/new(.:format)      posts#new
edit_post GET    /posts/:id/edit(.:format) posts#edit
     post GET    /posts/:id(.:format)      posts#show
          PATCH  /posts/:id(.:format)      posts#update
          PUT    /posts/:id(.:format)      posts#update
          DELETE /posts/:id(.:format)      posts#destroy
```

#### form_for

```erb
<%= form_for(post) do |form| %>
  <% if post.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h2>

      <ul>
      <% post.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :title %>
    <%= form.text_field :title, id: :post_title %>
  </div>

  <div class="field">
    <%= form.label :content %>
    <%= form.text_area :content, id: :post_content %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

`form_for`는 레일즈 helper이다. 새 게시물인지 이미 만들어진 게시물인지 판별해 create, update action에 자동으로 보내준다.

- `before_action` : action이 실행되기 이전에 실행해라. 즉, 해당하는 액션의 가장 윗줄에 삽입되도록 하는 것이다.
```rb
  before_action :set_post, only: [:show, :edit, :update, :destroy]

...

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
```
즉, `@post = Post.find(params[:id])`는 show, edit, update, destroy 액션이 실행되기 전에 실행된다.

#### Controller

- `respond_to` : 지정된 형식에 따라 다른 템플릿을 출력
- `redirect_to` : 뒤의 특정 페이지로 돌아가라
- falsh : redirect 전후로만 데이터를 저장하고 싶을 때, 현재 요청과 다음 요청에서만 정보를 저장한다. 
  - `flash[:notice]` 성공했을때 
  - `flash[:alert]` 실패했을때
  - 레일즈에서는 이것도 줄여서 표현하고 있다.
```rb
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
```

- Strong Parameter : 받고 싶은 것만 받자(보안 강화)

```rb
    def post_params
      params.require(:post).permit(:title, :content)
    end
```

#### form_for vs form_tag

- `form_for` : **특정한 모델 편집** ex) 게시물 생성, 수정


- `form_tag` : **범용적인 입력 양식** ex)검색 키워드, 조건
```erb
<%= form_tag("/home/create", method: "post") do %>
  <%= label_tag "post_title",'제목'%>
  <%= text_field_tag 'post_title',nil,placeholder: '제목을 입력해주세요.' %><br>
  <%= label_tag "post_content",'내용'%>
  <%= text_area_tag 'post_content',nil,placeholder: '내용을 입력해주세요.' %><br>
  <%= submit_tag '제출' %>
<% end %>
```
이때 tag에서 제목, 내용, placeholder순서를 지켜야한다.

- 공통점
  1. 자동으로 CSRF 방지 코드 삽입
  2. 기본 method는 POST

## 레일즈 심화2

### 1. 회원가입기능

#### 모델 생성
```
$ rails g model User name email password_digest
$ rails db:migrate
```

비밀번호를 암호화하기 위해서 `password_digest`로 컬럼명을 지정한다.

#### 암호화
```
gem 'bcrypt', '~> 3.1.7'
```
```
$ bundle install
```
```ruby
# user.rb
class User < ApplicationRecord
  has_secure_password
end
```
```ruby
User.create(name: 'lion', email: 
'lion@likelion.org', password: '123456')
```
로 생성하면 저장이 될때는 password가 bcrypt암호화가 되어서 password_digest에 저장된다.

```
#<User id: 1, name: "lion", email: "lion@likelion.org", password_digest: "$2a$10$x04aTFR5bs06aKqlgET3s.On6RDhPdtKK3vMzu08FSj...", created_at: "2018-03-07 06:49:31", updated_at: "2018-03-07 06:49:31">
```
```ruby
$ user.authenticate('1234')
=> false
$ user.authenticate('123456')
=> true(관련정보나옴)
```

#### controller

```
$ rails g controller Users new create
```
```ruby
# routes
resources :users
```
```ruby
# new.html.erb
<%= form_tag(users_path) do %>
  name : <%= text_field_tag 'name' %><br>
  email : <%= text_field_tag 'email' %><br>
  password : <%= password_field_tag 'password' %><br>
  <%= submit_tag '제출' %>
<% end -%>
```
```ruby
class UsersController < ApplicationController
  def new
  end

  def create
    User.create(name: params[:name],email: params[:email],password: params[:password])
    redirect_to '/'
  end
end
```

### 2. 로그인 만들기

**stateless protocol** : 요청을 받으면 서버에서 응답을 보내고 거기서 끝, 일정한 정보를 지속적으로 들고 있을 수 없다.

#### session
일정시간(브라우저 종료시까지) 반 영구적으로 상태를 유지(서버)
- 로그인, 장바구니

```
$ rails g controller Sessions new create destroy
```
```ruby
# routes
resources :sessions, only: [:new, :create, :destroy]
```

```erb
<!-- sessions/new.html.erb -->
<%= form_tag(sessions_path) do %>
  email : <%= text_field_tag 'email' %>
  password : <%= password_field_tag 'password' %>
  <%= submit_tag '제출' %>
<% end %>
```
```ruby
# sessions controller

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
  else
      flash[:alert] = '로그인에 실패하셨습니다.'
      redirect_to new_session_path
  end
  end

  def destroy
    session.delete(:user_id)

    redirect_to '/'
  end
end
```
```erb
<!-- application.html.erb -->
<% if session[:user_id] %>
  <li><%=User.find_by(id: session[:user_id]).name %></li>
  <%= link_to '로그아웃', session_path(session[:user_id]),method: 'delete'%>
      
<% else %>
  <%= link_to '회원가입',new_user_path %>
  <%= link_to '로그인',new_session_path %>
<% end %>
```

#### cookie
사용자의 브라우저에 저장되는 텍스트 정보(클라이언트)
쿠키를 통해 세션을 구현한다.

