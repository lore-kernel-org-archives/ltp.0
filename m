From: Li Wang <liwang@redhat.com>
Date: Thu, 6 May 2021 20:23:32 +0800
Subject: [LTP] [RFC] Shell API timeout sleep orphan processes
In-Reply-To: <651cb158-c640-e0b5-a2f2-4b77efcfa288@jv-coder.de>
References: <f781c0d8-6707-56ba-fa14-e0dbc1b645a1@jv-coder.de>
 <YJDvIcgdl8ae58YB@pevik> <5fdefbf3-2b4e-f44b-6cb2-c133ecf36975@jv-coder.de>
 <YJEKFLmcKvnHvlIV@pevik> <651cb158-c640-e0b5-a2f2-4b77efcfa288@jv-coder.de>
Message-ID: <CAEemH2dp4PT=AeEzjkhi3e_BnVbgWL6JvA3xQok5mHbAV9ig5A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg, Petr,

On Tue, May 4, 2021 at 6:34 PM Joerg Vehlow <lkml@jv-coder.de> wrote:
>
> Hi Petr,
>
> >>>> The only way to fix this really portable I can think of is moving the
> >>>> timeout code (including the logic in _tst_kill_test) into c code. This way
> >>>> there would only be one binary, that can be killed flawlessly.
> >>> Maybe set -m would be enough. But sure, rewriting C is usually the best approach
> >>> for shell problems, we use quite a lot of C helpers for shell already.
> >> I will send the patch, if this introduces any new issues, we can still
> >> switch to a c based implementation.
> > Thank you!
>
> I guess I will not submit the fix with set -m...
> My colleague working testing on a new target just ran into a problem
> with out fix using set -m.
> For busybox sh, it only works, if a tty is allocated, otherwise it
> refuses to enable job monitor mode and the whole construct fails...
>
> Since using the monitor mode only exploits the side effect, that it
> creates a process group and we already found a first issue, I think the
> only solution is switching to a c-based solution for the timeout stuff.
> Personally I like that it is written in shell script, but I see no other
> option to do it in pure shell. There is no builtin way, to create a
> process group and just redirecting the output of sleep to null does not
> seem to be a very good solution to me, because there would still be a
> lot of orphans around.

(Sorry for the late reply, I was just back from the Holidays)

Before we decide to rewrite in C, can we think about this below method?

--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -26,7 +26,7 @@ trap "tst_brk TBROK 'test interrupted or timed out'" INT
 _tst_cleanup_timer()
 {
        if [ -n "$_tst_setup_timer_pid" ]; then
-               kill $_tst_setup_timer_pid 2>/dev/null
+               kill -TERM $_tst_setup_timer_pid 2>/dev/null
                wait $_tst_setup_timer_pid 2>/dev/null
        fi
 }
@@ -486,7 +486,7 @@ _tst_setup_timer()
        tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"

        _tst_cleanup_timer
-       sleep $sec && _tst_kill_test &
+       (trap 'kill $!; exit' TERM; sleep $sec & wait $! && _tst_kill_test)&

        _tst_setup_timer_pid=$!
 }


-- 
Regards,
Li Wang

