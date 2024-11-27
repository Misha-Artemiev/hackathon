REQUEST SYNTAX

register: json { request: "register", username: $username, password: $password} -> 
  response: json {status: "droped"} or json {status: "approved", token: $token}

login: json { request: "login", username: $username, password: $password} -> 
  response: json {status: "droped"} or json {status: "approved", token: $token}

record mood: json { request: "record", token: $token, mood: $mood} -> 
  response: json {status: "droped"} or json {status: "approved"}

get mood: json { request: "get", token: $token} ->
  response: json {status: "droped"} or json {status: "approved", mood: 2DArray[[$mood, $date],[$mood, $date]]}
