APP_PATH = "/var/www/gollum"

worker_processes 2
working_directory APP_PATH

listen "unix:tmp/unicorn_gollum.sock", :backlog => 1024

pid "tmp/unicorn.pid"

stderr_path "log/unicorn/stderr.log"
stdout_path "log/unicorn/stdout.log"

preload_app true
check_client_connection false
