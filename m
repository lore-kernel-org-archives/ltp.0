From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 7 May 2021 06:48:35 +0200
Subject: [LTP] [RFC] Shell API timeout sleep orphan processes
In-Reply-To: <CAEemH2dp4PT=AeEzjkhi3e_BnVbgWL6JvA3xQok5mHbAV9ig5A@mail.gmail.com>
References: <f781c0d8-6707-56ba-fa14-e0dbc1b645a1@jv-coder.de>
 <YJDvIcgdl8ae58YB@pevik> <5fdefbf3-2b4e-f44b-6cb2-c133ecf36975@jv-coder.de>
 <YJEKFLmcKvnHvlIV@pevik> <651cb158-c640-e0b5-a2f2-4b77efcfa288@jv-coder.de>
 <CAEemH2dp4PT=AeEzjkhi3e_BnVbgWL6JvA3xQok5mHbAV9ig5A@mail.gmail.com>
Message-ID: <c9a17829-a7bb-288e-a9fd-2af387b12f1e@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> (Sorry for the late reply, I was just back from the Holidays)
>
> Before we decide to rewrite in C, can we think about this below method?
>
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -26,7 +26,7 @@ trap "tst_brk TBROK 'test interrupted or timed out'" INT
>   _tst_cleanup_timer()
>   {
>          if [ -n "$_tst_setup_timer_pid" ]; then
> -               kill $_tst_setup_timer_pid 2>/dev/null
> +               kill -TERM $_tst_setup_timer_pid 2>/dev/null
>                  wait $_tst_setup_timer_pid 2>/dev/null
>          fi
>   }
> @@ -486,7 +486,7 @@ _tst_setup_timer()
>          tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
>
>          _tst_cleanup_timer
> -       sleep $sec && _tst_kill_test &
> +       (trap 'kill $!; exit' TERM; sleep $sec & wait $! && _tst_kill_test)&
>
>          _tst_setup_timer_pid=$!
>   }
Thanks, good idea. This looks like it works. My tests are passing. I 
will test this a bit more.
Although I already submitted a rewrite in c, I would prefer this 
solution, maybe with a bit improved readability.
I will post a new patch when I finished testing later today.

J?rg
