From: Li Wang <liwang@redhat.com>
Date: Tue, 18 May 2021 20:01:53 +0800
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <5eb244b9-f97b-7a53-9feb-1a0452f56843@jv-coder.de>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
 <YJvkFTUWS2iuZ00H@pevik>
 <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
 <a4154e09-8ae3-beb3-13d5-c92126177ed5@jv-coder.de>
 <CAEemH2c-zTLkh2N2UpA=DSiq1tSJ=072S6j+PVoUz_yUaKjD-Q@mail.gmail.com>
 <5eb244b9-f97b-7a53-9feb-1a0452f56843@jv-coder.de>
Message-ID: <CAEemH2fPHqu6CyFqvV5GkCijLWnjBBnqbjoaSV70pP9n9ojVeA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> > In conclusion, I think we maybe have such situations to be solved:
> >
> > 1. SIGINT (Ctrl^C) for terminating the main process and do cleanup
> > correctly before a timeout
> > 2. Test finish normally and retrieves the _tst_timeout_process in the
> > background via SIGTERM(sending by _tst_cleanup_timer)
> > 3. Test timeout occurs and _tst_kill_test sending SIGTERM to
> > terminating all process, and the main process do cleanup work
> > 4. Test timeout occurs but still have process alive after
> > _tst_kill_test sending SIGTERM, then sending SIGKILL to the whole
> > group
> >
> > So, I'm now thinking can we just introduce a knob(variable) for skipping
> > the _tst_cleanup_timer works in timeout mode, then it will not have a
> > deadlock anymore.
> This works of course and is the "simplest" solution, the only thing I do
> not like about this,
> is the fact, that SIGTERM send by something else (e.g. system shoutdown
> or process manager),
> is handled like timeouts are handled and reported as timeout. That's why
> I suggested introducing
> a new signal. But since this is probably rare, I could live without it.

Hmm, it wouldn't handle/report like a time-out if we break with "test
terminated"
output for a SIGTERM. If we do

     trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

in the main process, system will still send SIGTERM to the _tst_timeout_process
when shutting down, and the _tst_kill_test will never be called in that case.

>
>
> >
> > How about:
> >
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -16,12 +16,14 @@ export TST_COUNT=1
> >   export TST_ITERATIONS=1
> >   export TST_TMPDIR_RHOST=0
> >   export TST_LIB_LOADED=1
> > +export TST_TIMEOUT_OCCUR=0
> >
> >   . tst_ansi_color.sh
> >   . tst_security.sh
> >
> >   # default trap function
> > -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> > +trap "tst_brk TBROK 'test interrupted'" INT
> > +trap "TST_TIMEOUT_OCCUR=1; tst_brk TBROK 'test timeouted'" TERM
> This could also be done by "unset _tst_setup_timer_pid" or
> '_tst_setup_timer_pid=""'.

+1, 'unset _tst_setup_timer_pid' is a good idea, sorry I was blind
here when reading your previous email:).

> I guess even if a new variable is introduced, it should start with an _,
> because it is supposed to be internal to the framework?

Yes, but let's go with "unset _tst_setup_timer_pid" but not introduce
a new variable.

>
>
> >
> >   _tst_do_exit()
> >   {
> > @@ -48,7 +50,9 @@ _tst_do_exit()
> >                  [ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
> >          fi
> >
> > -       _tst_cleanup_timer
> > +       if ["$TST_TIMEOUT_OCCUR" = 0 ]; then
> > +               _tst_cleanup_timer
> > +       fi
> >
> >          if [ $TST_FAIL -gt 0 ]; then
> >                  ret=$((ret|1))
> > @@ -439,18 +443,18 @@ _tst_kill_test()
> >   {
> >          local i=10
> >
> > -       trap '' INT
> > -       tst_res TBROK "Test timeouted, sending SIGINT! If you are
> > running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> > -       kill -INT -$pid
> > +       trap '' TERM
> > +       tst_res TBROK "Test timeouted, sending SIGTERM! If you are
> > running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> If you post this as a patch, can you please fix "timeouted" => "timed out"?
> There is no word "timeouted" in the english language.

Sure. Thanks for your strict attitude on syntax.


> @Petr
> I wouldn't recommend getting the fix into the release.
> The problem is nothing new and does not fix a "real issue" at the moment,
> but has the risk of introducing something unexpected.
> Fixing the output redirection could be done without a major risk, I guess.

I will split the fix into two-part, one for errors redirection,
another for SIGTERM using.

Thanks for your review!


--
Regards,
Li Wang

