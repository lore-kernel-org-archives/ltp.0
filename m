From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 May 2021 13:44:10 +0200
Subject: [LTP] [PATCH v3 2/4] shell: Prevent orphan timeout sleep
 processes
In-Reply-To: <20210508055109.16914-3-liwang@redhat.com>
References: <20210508055109.16914-3-liwang@redhat.com>
Message-ID: <YJkcikSmQeNwzDY1@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/lib/newlib_tests/shell/timeout04.sh
> +++ b/lib/newlib_tests/shell/timeout04.sh
> @@ -9,7 +9,7 @@ TST_TIMEOUT=1
>  
>  do_test()
>  {
> -	tst_res TINFO "Start"
> +    tst_res TINFO "Start"
>      sleep 5
>      tst_res TFAIL "End"
>  }

This should be really fixed in the previous patch rather than here.

Other than this the rest looks good.

With the indentation fix moved to previous patch:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 951518785..ed2699175 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -23,14 +23,6 @@ export TST_LIB_LOADED=1
>  # default trap function
>  trap "tst_brk TBROK 'test interrupted or timed out'" INT
>  
> -_tst_cleanup_timer()
> -{
> -	if [ -n "$_tst_setup_timer_pid" ]; then
> -		kill $_tst_setup_timer_pid 2>/dev/null
> -		wait $_tst_setup_timer_pid 2>/dev/null
> -	fi
> -}
> -
>  _tst_do_exit()
>  {
>  	local ret=0
> @@ -463,6 +455,25 @@ _tst_kill_test()
>  	fi
>  }
>  
> +_tst_cleanup_timer()
> +{
> +	if [ -n "$_tst_setup_timer_pid" ]; then
> +		kill -TERM $_tst_setup_timer_pid 2>/dev/null
> +		wait $_tst_setup_timer_pid 2>/dev/null
> +	fi
> +}
> +
> +_tst_timeout_process()
> +{
> +	local sleep_pid
> +
> +	sleep $sec &
> +	sleep_pid=$!
> +	trap "kill $sleep_pid; exit" TERM
> +	wait $sleep_pid
> +	_tst_kill_test
> +}
> +
>  _tst_setup_timer()
>  {
>  	TST_TIMEOUT=${TST_TIMEOUT:-300}
> @@ -486,7 +497,8 @@ _tst_setup_timer()
>  	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
>  
>  	_tst_cleanup_timer
> -	sleep $sec && _tst_kill_test &
> +
> +	_tst_timeout_process &
>  
>  	_tst_setup_timer_pid=$!
>  }
> -- 
> 2.30.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
