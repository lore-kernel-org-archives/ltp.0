From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 16:22:33 +0200
Subject: [LTP] [PATCH v2 2/2] shell: Prevent orphan timeout sleep
 processes
In-Reply-To: <CAEemH2fucJPyeTL-HZJD92ves7GLMaMHcaPzi8kS_qWL+x=Hcg@mail.gmail.com>
References: <20210507103258.232174-1-lkml@jv-coder.de>
 <20210507103258.232174-3-lkml@jv-coder.de>
 <CAEemH2fucJPyeTL-HZJD92ves7GLMaMHcaPzi8kS_qWL+x=Hcg@mail.gmail.com>
Message-ID: <YJVNKebKn6jTvyG/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Joerg,

thanks both for your work!

> +++ b/lib/newlib_tests/shell/timeout03.sh
> @@ -32,7 +32,7 @@ do_test()
>  {
>         tst_res TINFO "testing killing test after TST_TIMEOUT"

> -       tst_sleep 2
> +       sleep 2
+1
Although tst_test.sh has many LTP custom binary dependencies I agree to use
simple sleep for seconds.

>         tst_res TFAIL "test: running after TST_TIMEOUT"
>  }

> @@ -40,7 +40,7 @@ cleanup()
>  {
>         tst_res TPASS "test run cleanup after timeout"

> -       tst_sleep 15 # must be higher than wait time in _tst_kill_test
> +       sleep 15 # must be higher than wait time in _tst_kill_test
and here.
>         tst_res TFAIL "cleanup: running after TST_TIMEOUT"
>  }

> diff --git a/lib/newlib_tests/shell/timeout04.sh
> b/lib/newlib_tests/shell/timeout04.sh
> index 0a6ba053c..c702905f3 100755
> --- a/lib/newlib_tests/shell/timeout04.sh
> +++ b/lib/newlib_tests/shell/timeout04.sh
> @@ -9,7 +9,7 @@ TST_TIMEOUT=1

>  do_test()
>  {
> -       tst_res TINFO "Start"
> +    tst_res TINFO "Start"
>      sleep 5
>      tst_res TFAIL "End"
>  }
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 7ceddff04..ed2699175 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -469,7 +469,7 @@ _tst_timeout_process()

>         sleep $sec &
>         sleep_pid=$!
> -       #trap "kill $sleep_pid; exit" TERM
> +       trap "kill $sleep_pid; exit" TERM
I guess trap use is needed, and commented out for testing.

>         wait $sleep_pid
>         _tst_kill_test
>  }


> ================
> (This below is not related to your patches)

> But there is another issue I found that the timeout03 can NOT
> be killed after timed out in calling cleanup(), the reason is
> tst_brk stop the _tst_kill_test running in the background so that
> it does not output as what we expected:
Good catch, I'll try to have a look as well.

Kind regards,
Petr

> # timeout03 1 TINFO: timeout per run is 0h 0m 1s
> # timeout03 1 TINFO: testing killing test after TST_TIMEOUT
> # timeout03 1 TBROK: Test timeouted, sending SIGINT! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> # timeout03 1 TBROK: test interrupted or timed out
> # timeout03 1 TPASS: test run cleanup after timeout
> # timeout03 1 TINFO: Test is still running, waiting 10s
> # timeout03 1 TINFO: Test is still running, waiting 9s
> # timeout03 1 TINFO: Test is still running, waiting 8s
> # timeout03 1 TINFO: Test is still running, waiting 7s
> # timeout03 1 TINFO: Test is still running, waiting 6s
> # timeout03 1 TINFO: Test is still running, waiting 5s
> # timeout03 1 TINFO: Test is still running, waiting 4s
> # timeout03 1 TINFO: Test is still running, waiting 3s
> # timeout03 1 TINFO: Test is still running, waiting 2s
> # timeout03 1 TINFO: Test is still running, waiting 1s
> # timeout03 1 TBROK: Test still running, sending SIGKILL
> # Killed
