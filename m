From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Mar 2021 16:59:51 +0800
Subject: [LTP] [PATCH 6/7] tst_test.sh: Run cleanup also after test
 timeout
In-Reply-To: <20210301220222.22705-7-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-7-pvorel@suse.cz>
Message-ID: <CAEemH2c2Bma-xXTcf+1M4CFVjM7ZQS36rV_6i9kJ6Es-19kghA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 2, 2021 at 6:02 AM Petr Vorel <pvorel@suse.cz> wrote:

> Also timeout requires to run a test cleanup (e.g. zram01.sh).
> Thus send first SIGINT, but keep also SIGKILL for safety reasons
> (after 5 sec to give some time to the cleanup function and
> _tst_check_security_modules()).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Originally posted in
>
> https://patchwork.ozlabs.org/project/ltp/patch/20210202101942.31328-1-pvorel@suse.cz/
>
> * renamed function
> * use signal names instead of numbers in kill parameters
>
>  testcases/lib/tst_test.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 58056e28b..097f672a1 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
>  . tst_security.sh
>
>  # default trap function
> -trap "tst_brk TBROK 'test interrupted'" INT
> +trap "tst_brk TBROK 'test interrupted or timed out'" INT
>
>  _tst_cleanup_timer()
>  {
> @@ -442,6 +442,14 @@ _tst_multiply_timeout()
>         return 0
>  }
>
> +_tst_run_timer()
>

Hmm, this name is not good than before, or rename to _tst_kill_timer_pid(),
_tst_stop_timer()?



> +{
> +       tst_res TBROK "test killed, timeout! If you are running on slow
> machine, try exporting LTP_TIMEOUT_MUL > 1"
> +       kill -INT -$pid
> +       sleep 5
> +       kill -KILL -$pid
> +}
> +
>  _tst_setup_timer()
>  {
>         TST_TIMEOUT=${TST_TIMEOUT:-300}
> @@ -465,8 +473,7 @@ _tst_setup_timer()
>         tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
>
>         _tst_cleanup_timer
> -
> -       sleep $sec && tst_res TBROK "test killed, timeout! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9
> -$pid &
> +       sleep $sec && _tst_run_timer &
>
>         _tst_setup_timer_pid=$!
>  }
> --
> 2.30.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210302/f675fe6c/attachment-0001.htm>
