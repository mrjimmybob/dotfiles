function comfy
    set pidfile /tmp/comfyui.pid

    switch "$argv[1]"
        case stop
            if not test -f $pidfile
                echo "Not running"
                return 0
            end

            set pid (string trim -- (cat $pidfile 2>/dev/null))

            if test -n "$pid"; and kill -0 $pid 2>/dev/null
                kill $pid 2>/dev/null
                sleep 1
                kill -0 $pid 2>/dev/null; and kill -9 $pid 2>/dev/null
            end

            rm -f $pidfile
            echo "Stopped"

        case restart
	    echo "Restarting ComfyUI Web interface on http://127.0.0.1:8188"
            comfy stop
            sleep 1
            comfy start

	case open
	    echo "Launching ComfyUI Web interface on http://127.0.0.1:8188"
	    xdg-open http://127.0.0.1:8188

        case start ''
            if test -f $pidfile
                set pid (string trim -- (cat $pidfile 2>/dev/null))

                if test -n "$pid"; and kill -0 $pid 2>/dev/null
                    echo "Already running (PID: $pid)"
                    return 0
                end

                rm -f $pidfile
            end

            pushd ~/ai/comfyui >/dev/null
            source ~/venvs/comfyui/bin/activate.fish

            python main.py >/tmp/comfyui.log 2>&1 &
            set pid $last_pid
            echo $pid >$pidfile

            popd >/dev/null

            echo "Started (PID: $pid)"
	    echo "Open ComfyUI Web interface at http://127.0.0.1:8188"

        case '*'
            echo "Usage: comfy [start|stop|restart|open]"
            return 1
    end
end
