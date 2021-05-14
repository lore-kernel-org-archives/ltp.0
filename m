From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 09:53:43 +0200
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
 <YJvkFTUWS2iuZ00H@pevik>
 <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
Message-ID: <YJ4sh7zBOZxQy1S0@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > FYI I tried to use both SIGINT and SIGTERM, but there was some problem.
> > But I guess it was my error. Please *add* SIGTERM (keep SIGINT).

> Yes, we'd better keep SIGINT for ctrl^c action and use SIGTERM
> additionally for process terminating.

> Does this below (rough solution in my mind) work for you?
LGTM, but Joerg, Metan, could you please have a look?

> diff --git a/lib/newlib_tests/shell/timeout03.sh
> b/lib/newlib_tests/shell/timeout03.sh
> index cd548d9a2..f39f5712a 100755
> --- a/lib/newlib_tests/shell/timeout03.sh
> +++ b/lib/newlib_tests/shell/timeout03.sh
> @@ -30,6 +30,7 @@ TST_TIMEOUT=1

>  do_test()
>  {
> +       trap "echo 'Sorry, timeout03 is still alive'" TERM
Any reason why not use tst_res TINFO? (working on bash).
>         tst_res TINFO "testing killing test after TST_TIMEOUT"

>         sleep 2
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 28c2052d6..d7c9791e9 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
>  . tst_security.sh

>  # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT

>  _tst_do_exit()
>  {
> @@ -439,18 +439,18 @@ _tst_kill_test()
>  {
>         local i=10

> -       trap '' INT
> -       tst_res TBROK "Test timeouted, sending SIGINT! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> -       kill -INT -$pid
> +       trap '' TERM
> +       tst_res TBROK "Test timeouted, sending SIGTERM! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> +       kill -TERM -$pid
>         tst_sleep 100ms

> -       while kill -0 $pid 2>&1 > /dev/null && [ $i -gt 0 ]; do
> +       while kill -0 $pid &>/dev/null && [ $i -gt 0 ]; do
FYI: &> is a bashism (we need to keep the original).
>                 tst_res TINFO "Test is still running, waiting ${i}s"
>                 sleep 1
>                 i=$((i-1))
>         done

> -       if kill -0 $pid 2>&1 > /dev/null; then
> +       if kill -0 $pid &>/dev/null; then
And here as well.

>                 tst_res TBROK "Test still running, sending SIGKILL"
>                 kill -KILL -$pid
>         fi

Kind regards,
Petr
