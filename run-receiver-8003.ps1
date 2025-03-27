$env:ROCKET_PORT = "8003"
$env:APP_INSTANCE_ROOT_URL = "http://localhost:$($env:ROCKET_PORT)"
$env:APP_PUBLISHER_ROOT_URL = "http://localhost:8000"
$env:APP_INSTANCE_NAME = "Receiver 3"

cargo run
