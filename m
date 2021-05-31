From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 May 2021 14:49:33 +0200
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <20210518122610.17171-2-liwang@redhat.com>
References: <20210518122610.17171-1-liwang@redhat.com>
 <20210518122610.17171-2-liwang@redhat.com>
Message-ID: <YLTbXU1ZF4ZiXKdt@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/newlib_tests/shell/test_timeout.sh | 2 +-
>  lib/newlib_tests/shell/timeout03.sh    | 1 +
>  testcases/lib/tst_test.sh              | 9 +++++----
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
> index b05680cb1..9f31afa32 100755
> --- a/lib/newlib_tests/shell/test_timeout.sh
> +++ b/lib/newlib_tests/shell/test_timeout.sh
> @@ -28,7 +28,7 @@ timeout02.sh|  -10|0|  |2
>  timeout02.sh| -0.1|0|  |0
>  timeout02.sh| -1.1|0|  |2
>  timeout02.sh|-10.1|0|  |2
> -timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGINT
> +timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGTERM
>  timeout04.sh|     |0|  |  2|0|0|1|Verify that timeout is enforced
>  timeout02.sh|    2|1| 2|   |1|0|0|Test termination of timeout process
>  "
> diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
> index cd548d9a2..124e96a84 100755
> --- a/lib/newlib_tests/shell/timeout03.sh
> +++ b/lib/newlib_tests/shell/timeout03.sh
> @@ -30,6 +30,7 @@ TST_TIMEOUT=1
>  
>  do_test()
>  {
> +	trap "tst_res TINFO 'Sorry, timeout03 is still alive'" TERM
>  	tst_res TINFO "testing killing test after TST_TIMEOUT"
>  
>  	sleep 2
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 3a5651c01..66ffde4eb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,8 @@ export TST_LIB_LOADED=1
>  . tst_security.sh
>  
>  # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT
> +trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

I've been looking at this for a while and I think that we should unset
the _tst_setup_timer_pid at the end of the _tst_timeout_process()
instead, right?

Otherwise we will leave the timeout process sleeping if someone sends
SIGTERM to the test process from the outside, or do I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz
