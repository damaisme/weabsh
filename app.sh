source weabsh.sh

function exampleGet(){
  response "example get request"
}

function examplePost(){
  response "example post request"
}

function examplePatch(){
  response "example patch request"
}

function examplePut(){
  response "example put request"
}

function exampleDelete(){
  response "example delete request"
}

get / exampleGet
post / examplePost
patch / examplePatch
put / examplePut
delete / exampleDelete

listen 3000
