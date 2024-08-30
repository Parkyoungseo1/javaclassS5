<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>채팅</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
	  let socket;
	
	  // 채팅시작버튼 클릭시 웹소켓에 연결하기..
	  function startChat() {
		  $("#endChatBtn").show();
      const username = document.getElementById('username').value;
      if (username) {
    	  // 1:1채팅처리일때는 웹소켓 접속시 마지막에 유저이름을 가지고 들어오게한다. 즉, 여러명의 유저들이 들어오게되면 변수명이 같기에 배열개념(, 로 분리)으로 들어오게된다.
        socket = new WebSocket('ws://192.168.50.20:9090/javaclassS/webSocket/endPoint/' + username);

        // 상대방 유저가 접속/종료 하거나, 메세지를 날릴때 처리되는 곳(모든 유저들이 메세지를 날리면 무조건 이곳을 통과한다.)
        socket.onmessage = (event) => {
        	// 메세지 들어올때 '메세지 data'의 텍스트문자에 'USER_LIST'로 시작할경우는 사용 유저가 새로 '접속'/'종료'한 경우이기에 currentUser콤보박스에 유저의 정보를 삽입/삭제 처리해야 한다.
      		alert(event.data);
        	if (event.data.startsWith("USER_LIST:")) {	// 신규 또는 종료 유저의 '삽입/삭제'처리이다.
            updateUserList(event.data.substring(10));	// USER_LIST이후부터 유저들이 배열(,)로 들어온다.
          } 
        	else {	// 일반 메세지일경우의 처리이다.
	          let dt = new Date();
	          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
	          let item = '<div class="d-flex flex-row mr-2"><span class="youWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
	          item += '<font color="brown">' + event.data.split(":")[0] + ' 로 부터</font><br/><font size="3">' + event.data.split(":")[1] + '</font></span></div>';
	          document.getElementById('messages').innerHTML += item;
	          document.getElementById('message').value = '';
	          document.getElementById('message').focus();
	          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);	// 스크롤바를 div마지막에 위치..
        	}
        };
        
        // 웹소켓 접속을 종료할때 처리되는 코드
        socket.onclose = () => {
          alert('채팅창에서 접속을 종료합니다.');
          document.getElementById('chat').style.display = 'none';
          document.getElementById('username').style.display = 'block';
          document.querySelector('button[onclick="startChat()"]').style.display = 'block';
        };

        // 소켓 접속후 기본 아이디를 화면에 출력시켜주고 있다.(접속 종료후도 계속 유지된다.)
        document.getElementById('chat').style.display = 'block';
        document.getElementById('username').style.display = 'none';
        document.querySelector('button[onclick="startChat()"]').style.display = 'none';
        document.getElementById('currentId').innerHTML = '<font color="red"><b>${sMid}</b></font>';
      }
	  }
	  
	  // 채팅 종료버튼을 클릭하면 소켓을 닫도록 처리한다.
	  function endChat() {
      location.reload();	// 다시 reload하므로서 새롭게 세션이 생성되기에 기존 세션이 사라져서 접속사용자 아이디도 리스트상에서 제거되게 된다.
      /* 소켓을 완전히 종료시키려면 아래코드를 추가해도 된다.
	    if (socket) {
        socket.close();
        $("#endChatBtn").hide();
	    }
      */
		}
	  
	  // 사용자가 새롭게 추가되거나 접속종료시에 회원목록을 업데이트 한다.
	  function updateUserList(userList) {
	    const users = userList.split(",");
	    /*
	    const usersElement = document.getElementById('users');
	    usersElement.innerHTML = '';  // Clear current list
	    users.forEach(user => {
        const item = document.createElement('li');
        item.textContent = user;
        usersElement.appendChild(item);
	    });
	    
	    const usersTargetElement = document.getElementById('target');
	    usersTargetElement.innerHTML = '';  // Clear current list
	    users.forEach(user => {
        const item2 = document.createElement('option');
        item2.textContent = user;
        usersTargetElement.appendChild(item2);
	    });
	    */
	    
	    const usersElement = document.getElementById('users');
	    usersElement.innerHTML = '';  // Clear current list
	    users.forEach(user => {
        const item = document.createElement('option');
        item.textContent = user;
        usersElement.appendChild(item);
	    });
		}
	
	  // 폼이 모두 로드되고 나면 아래 루틴을 처리해서 채팅접속자의 아이디를 화면에 출력할수 있게처리한다.
	  // 아래는 메세지 보내는 사용자의 메세지 출력폼에서 '전송'버튼을 눌렀을때 처리(socket.send())하는 함수이다.
	  document.addEventListener('DOMContentLoaded', () => {
      const form = document.getElementById('form');
      form.addEventListener('submit', (e) => {	// 전송버튼을 누르면 메세지를 화면에 출력시켜준다.
        e.preventDefault();		// 이전 스크립트 내용은 무시하고 아래의 내용을 처리하게 한다.
        const target = document.getElementById('targetUser').value;
        const message = document.getElementById('message').value;
        if (target && message) {
          socket.send(target + ":" + message);
          //const item = document.createElement('li');
          //item.textContent = "To " + target + ": " + message;
          //document.getElementById('messages').appendChild(item);
          let dt = new Date();
          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
          let item = '<div class="chattingBox d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
          item += '<font color="brown">' + target + ' 에게</font><br/><font size="3">' + message + '</font></span></div>';
          document.getElementById('messages').innerHTML += item;
          document.getElementById('message').value = '';
          document.getElementById('message').focus();
          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);	// 스크롤바를 div마지막에 위치..
        }
      });
	  });

	  
	  // 메세지 보내기(여러줄 처리하도록 함) - 메세지 입력후 엔터키 또는 시프트엔터키에 대한 처리후 메세지를 소켓에 보내주게한다.(socket.send())
	  $(function(){
		  $('#message').keyup(function(e) {
			  e.preventDefault();		// 이전 스크립트 내용은 무시하고 아래의 내용을 처리하게 한다.
        const target = document.getElementById('targetUser').value;
        const message = document.getElementById('message').value;
		  	if (e.keyCode == 13) {
		  		if(!e.shiftKey) {
			  		if(target != '' && $('#message').val().trim() != '') {
				  		let dt = new Date();
		          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
		          let item = '<div class="chattingBox d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
		          item += '<font color="brown">' + target + ' 에게</font><br/><font size="3">' + message + '</font></span></div>';
		          item = item.replaceAll("\n","<br/>");
		          document.getElementById('messages').innerHTML += item;
		          document.getElementById('message').value = '';
		          document.getElementById('message').focus();
				  		$('#currentMessage').scrollTop($('#currentMessage').prop('scrollHeight'));	// 스크롤바를 div마지막에 위치..
				  		socket.send(target + ":" + message.replaceAll("\n","<br/>"));
			  		}
		  		}
		  	}
		  });
	  });
	  
	  // 채팅할 유저 선책하기
	  /*
	  function targetUserChange() {
		  myform.targetUser.value = $("#target").val();
	  }
	  */
	  function userChange() {
		  myform.targetUser.value = $("#users").val();
		  myform.message.focus();
	  }
  </script>
  <style>
    body {
      background-color: #f0f2f5;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .container {
      max-width: 1000px;
      margin: 30px auto;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
      padding: 20px;
    }
    #chat-container {
      display: flex;
      height: 600px;
      border: 1px solid #ddd;
      border-radius: 10px;
      overflow: hidden;
    }
    #currentUser {
      width: 25%;
      height: 100%;
      border-right: 1px solid #ddd;
      padding: 10px;
      background-color: #f8f9fa;
    }
    #currentMessage {
      width: 75%;
      height: 100%;
      display: flex;
      flex-direction: column;
    }
    #messages {
      flex-grow: 1;
      overflow-y: auto;
      padding: 20px;
      background-color: #fff;
    }
    .messageBox {
      padding: 10px;
      background-color: #f1f0f0;
      border-top: 1px solid #ddd;
    }
    .myWord, .youWord {
      max-width: 70%;
      padding: 10px 15px;
      border-radius: 20px;
      margin-bottom: 10px;
      word-wrap: break-word;
    }
    .myWord {
      background-color: #0084ff;
      color: white;
      align-self: flex-end;
      margin-left: auto;
    }
    .youWord {
      background-color: #e4e6eb;
      color: black;
      align-self: flex-start;
    }
    #users {
      height: 100%;
    }
    #message {
      resize: none;
      height: 60px;
    }
    .btn-success {
      background-color: #0084ff;
      border-color: #0084ff;
    }
    .btn-success:hover {
      background-color: #0073e6;
      border-color: #0073e6;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h3 class="mb-4">채팅</h3>
  <div class="d-flex align-items-center mb-3">
    <label for="username" class="mr-2">접속중인 사용자 : </label>
    <span id="currentId" class="font-weight-bold mr-3"></span>
    <input type="text" id="username" value="${sMid}" readonly class="form-control mr-2" style="width: 150px;"/>
    <button onclick="startChat()" class="btn btn-primary mr-2">채팅시작</button>
    <button onclick="endChat()" id="endChatBtn" class="btn btn-secondary" style="display:none;">채팅종료</button>
  </div>
  <div id="chat" style="display:none;">
    <div id="chat-container">
      <div id="currentUser">
        <h5 class="mb-3">접속 중인 회원</h5>
        <select name="users" id="users" size="18" class="form-control" onchange="userChange()"></select>
      </div>
      <div id="currentMessage">
        <div id="messages"></div>
        <form name="myform" id="form" class="messageBox">
          <div class="input-group">
            <input type="text" name="targetUser" id="targetUser" autocomplete="off" placeholder="접속회원을 선택하세요" readonly class="form-control"/>
            <textarea name="message" id="message" placeholder="메세지를 입력하세요." class="form-control"></textarea>
            <div class="input-group-append">
              <button class="btn btn-success">전송</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>