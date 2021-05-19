From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 19 May 2021 08:46:05 +0200
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <20210518122610.17171-2-liwang@redhat.com>
References: <20210518122610.17171-1-liwang@redhat.com>
 <20210518122610.17171-2-liwang@redhat.com>
Message-ID: <d70f9e5f-0008-02aa-e099-2a8243c4b3fa@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,


On 5/18/2021 2:26 PM, Li Wang wrote:

> Co-authored-by: Joerg Vehlow <lkml@jv-coder.de>
Please use Joerg Vehlow <joerg.vehlow@aox-tech.de> here, thanks.
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   lib/newlib_tests/shell/test_timeout.sh | 2 +-
>   lib/newlib_tests/shell/timeout03.sh    | 1 +
>   testcases/lib/tst_test.sh              | 9 +++++----
>   3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
> index b05680cb1..9f31afa32 100755
> --- a/lib/newlib_tests/shell/test_timeout.sh
> +++ b/lib/newlib_tests/shell/test_timeout.sh
> @@ -28,7 +28,7 @@ timeout02.sh|  -10|0|  |2
>   timeout02.sh| -0.1|0|  |0
>   timeout02.sh| -1.1|0|  |2
>   timeout02.sh|-10.1|0|  |2
> -timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGINT
> +timeout03.sh|     |0|12|137| | | |Test kill if test does not terminate by SIGTERM
Whoa what did I write there, that's hard to read :)
While you're at it, can you please change this to "Test is killed, if it 
does not terminate after SIGTERM"
>   timeout04.sh|     |0|  |  2|0|0|1|Verify that timeout is enforced
>   timeout02.sh|    2|1| 2|   |1|0|0|Test termination of timeout process
>   "
> diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
At the top of this file, there is a comment with the expected output, 
that should be corrected
> index cd548d9a2..124e96a84 100755
> --- a/lib/newlib_tests/shell/timeout03.sh
> +++ b/lib/newlib_tests/shell/timeout03.sh
> @@ -30,6 +30,7 @@ TST_TIMEOUT=1
>   
>   do_test()
>   {
> +	trap "tst_res TINFO 'Sorry, timeout03 is still alive'" TERM
We don't need this.
>   	tst_res TINFO "testing killing test after TST_TIMEOUT"
>   
>   	sleep 2
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 3a5651c01..66ffde4eb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,8 @@ export TST_LIB_LOADED=1
>   . tst_security.sh
>   
>   # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT
> +trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
>   
>   _tst_do_exit()
>   {
> @@ -439,9 +440,9 @@ _tst_kill_test()
>   {
>   	local i=10
>   
> -	trap '' INT
> -	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> -	kill -INT -$pid
> +	trap '' TERM
> +	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> +	kill -TERM -$pid
This works fine.
+Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
after my remarks are resolved.

But one more strange thing here.
I wonder why this even works. $pid is used in _tst_kill_test and defined 
in _tst_setup_timer as a local variable.
It looks like it is inherited through the call chain and since it is 
copied to the background process, it cannot be manipulated by the tests.
Still I would vote for changing this at some point, because it is highly 
confusing.

J?rg
