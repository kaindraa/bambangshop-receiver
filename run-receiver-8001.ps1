$env:ROCKET_PORT = "8001"
$env:APP_INSTANCE_ROOT_URL = "http://localhost:$($env:ROCKET_PORT)"
$env:APP_PUBLISHER_ROOT_URL = "http://localhost:8000"
$env:APP_INSTANCE_NAME = "Receiver 1"

cargo run
