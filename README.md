# weabsh
Bash/Shell Script HTTP Server Library

### Hello World 
```
#!/bin/bash
source weabsh.sh

function exampleGet(){
  response "Hello World!"
}

function exampleGetWithHtmlResponse{
  response $(cat index.html)
}

get / exampleGet
get /html exampleGetWithHtmlResponse

listen 3000
```

This app starts a server and listens on port 3000 for connections. The app responds with “Hello World!” for requests to the root URL (/) or route. For every other path, it will respond with a 404 Not Found.
Explanation:
- `#!/bin/bash` :  to define what kind of interpreter to run.
- `source weabsh.sh` : to import the weabsh.sh (lib file)
- `function exampleGet(){...}` : to define a function that will be executed when there is an http request on the verb and path defined.
- `response "..."` : simply to give a http response
- `response $(cat index.html)` : give a http response with html content
- `get {path} {function to be execute}` : to define the http verb and path then what function to run
- `listen {port}` : to run the tcp socket on the defined port

### Running The App
You can run the app just like you would run a normal shell script.
```
bash app.sh
```
or
```
./app.sh
```
