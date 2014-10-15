sudo nsenter --target $(docker inspect --format {{.State.Pid}} haproxy) --mount --uts --ipc --net --pid
