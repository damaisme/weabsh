# Bash/Shell Script http server

function handleRequest() {
  while read line; do
    echo $line
    trline=`echo $line | tr -d '[\r\n]'`

    [ -z "$trline" ] && break

    HEADLINE_REGEX='(.*?)\s(.*?)\sHTTP.*?'

    [[ "$trline" =~ $HEADLINE_REGEX ]] &&
      REQUEST=$(echo $trline | sed -E "s/$HEADLINE_REGEX/\1 \2/")
      REQUEST_VERB=$(echo $REQUEST | cut -d " " -f 1)
      REQUEST_PATH=$(echo $REQUEST | cut -d " " -f 2)
  done

  case "$REQUEST_VERB" in
  "GET")
    for path in "${!getStore[@]}"; do
      if [ "$path" = "$REQUEST_PATH" ]; then
        eval "${getStore[$path]}"
      else
        notfound
      fi
    done
  ;;
  "POST")
    for path in "${!postStore[@]}"; do
      if [ "$path" = "$REQUEST_PATH" ]; then
        eval "${postStore[$path]}"
      else
        notfound
      fi
    done
  ;;
  "PATCH")
    for path in "${!patchStore[@]}"; do
      if [ "$path" = "$REQUEST_PATH" ]; then
        eval "${patchStore[$path]}"
      else
        notfound
      fi
    done
  ;;
  "PUT")
    for path in "${!putStore[@]}"; do
      if [ "$path" = "$REQUEST_PATH" ]; then
        eval "${putStore[$path]}"
      else
        notfound
      fi
    done
  ;;
  "DELETE")
    for path in "${!deleteStore[@]}"; do
      if [ "$path" = "$REQUEST_PATH" ]; then
        eval "${deleteStore[$path]}"
      else
        notfound
      fi
    done
  ;;
  *) notfound;;
  esac
}

function response(){
    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n$1" > response
}

function notfound(){
  echo -e "HTTP/1.1 404 NotFound\r\n\r\n\r\nNot Found" > response
}

function listen(){
  ### Create the response FIFO
  rm -f response
  mkfifo response

  echo "Listening on $1..."
  while true; do
    cat response | nc -lN $1 | handleRequest
  done
}

declare -A getStore
declare -A postStore
declare -A putStore
declare -A patchStore
declare -A deleteStore


function get(){
  getStore[$1]=$2
}
function post(){
  postStore[$1]=$2
}
function delete(){
  deleteStore[$1]=$2
}
function put(){
  putStore[$1]=$2
}
function patch(){
  patchStore[$1]=$2
}



