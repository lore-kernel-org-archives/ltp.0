From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 10:46:32 +0200
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <CAEemH2c-zTLkh2N2UpA=DSiq1tSJ=072S6j+PVoUz_yUaKjD-Q@mail.gmail.com>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
 <YJvkFTUWS2iuZ00H@pevik>
 <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
 <a4154e09-8ae3-beb3-13d5-c92126177ed5@jv-coder.de>
 <CAEemH2c-zTLkh2N2UpA=DSiq1tSJ=072S6j+PVoUz_yUaKjD-Q@mail.gmail.com>
Message-ID: <YKN+6EXxlU4o7mZE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi Joerg,

> > > -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> > > +trap "tst_brk TBROK 'test interrupted'" INT
> > This would require something like
> > trap "tst_brk TBROK 'test terminated'" TERM
> > or
> > trap "_tst_do_exit" TERM

> > Otherwise the test is terminated very roughly, without executing
> > cleanup, which is probably not a good idea.
+1

> Yes, seems I didn't realize this needs cleanup as well.

> But I'd still suggest keeping SIGINT here for catching Ctrl^C for users :).
+1


> > But that introduces the next problem: A short deadlock between
> > _tst_kill_test and _tst_cleanup_timer,
> > because _tst_cleanup_timer waits for the termination of the timeout
> > process and vice versa.
> > Another problem is, that a SIGTERM originating from some other location
> > could look like a timeout.

> Yes, and that's the reason why I didn't trap SIGTERM simply in the main process.


> > I am currently thinking about the following solution, to mitigate most
> > problems:
> > The timeout process sends SIGUSR1 (or maybe SIGALRM?) only to the main
> > test process and blocks TERM.
> > The main process can print, that it ran into a timeout, send a sigterm
> > to its processs group (while ignoring TERM itself).
> > Then it can unset $_tst_setup_timer_pid safely, because it knows it was
> > triggered by the timeout process and execute _tst_do_exit.

> > If the timeout process does not see the termination of the main process,
> > it can still send SIGKILL to the whole process group.


> It probably will be work but looks a bit confusing since that involves
> more signals.

> In conclusion, I think we maybe have such situations to be solved:

> 1. SIGINT (Ctrl^C) for terminating the main process and do cleanup
> correctly before a timeout
> 2. Test finish normally and retrieves the _tst_timeout_process in the
> background via SIGTERM(sending by _tst_cleanup_timer)
> 3. Test timeout occurs and _tst_kill_test sending SIGTERM to
> terminating all process, and the main process do cleanup work
> 4. Test timeout occurs but still have process alive after
> _tst_kill_test sending SIGTERM, then sending SIGKILL to the whole
> group

> So, I'm now thinking can we just introduce a knob(variable) for skipping
> the _tst_cleanup_timer works in timeout mode, then it will not have a
> deadlock anymore.

+1

> How about:

I'm not sure if we're not getting too late for these changes. Because it'll be
just on us to test that (community probably have run these changes). But I'd
still prefer to fix it.

If we don't fix it, I'd be at least for fixing wrong redirection order (2>&1 >
/dev/null) introduced by me in 25ad54dba.

> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -16,12 +16,14 @@ export TST_COUNT=1
>  export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
>  export TST_LIB_LOADED=1
> +export TST_TIMEOUT_OCCUR=0

>  . tst_ansi_color.sh
>  . tst_security.sh

>  # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT
> +trap "TST_TIMEOUT_OCCUR=1; tst_brk TBROK 'test timeouted'" TERM

>  _tst_do_exit()
>  {
> @@ -48,7 +50,9 @@ _tst_do_exit()
>                 [ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
>         fi

> -       _tst_cleanup_timer
> +       if ["$TST_TIMEOUT_OCCUR" = 0 ]; then
> +               _tst_cleanup_timer
> +       fi

>         if [ $TST_FAIL -gt 0 ]; then
>                 ret=$((ret|1))
> @@ -439,18 +443,18 @@ _tst_kill_test()
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
> +       while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
>                 tst_res TINFO "Test is still running, waiting ${i}s"
>                 sleep 1
>                 i=$((i-1))
>         done

> -       if kill -0 $pid 2>&1 > /dev/null; then
> +       if kill -0 $pid >/dev/null 2>&1; then
>                 tst_res TBROK "Test still running, sending SIGKILL"
>                 kill -KILL -$pid
>         fi

LGTM, I'll try to test it today.

Kind regards,
Petr
