From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Jan 2021 12:02:26 +0100
Subject: [LTP] [PATCH v4 1/3] tst_test.sh: Call cleanup function after
 test start
In-Reply-To: <X/bc+ZGQ6JPsg4YY@yuki.lan>
References: <20201217144424.19414-1-pvorel@suse.cz>
 <20201217144424.19414-2-pvorel@suse.cz> <X/bc+ZGQ6JPsg4YY@yuki.lan>
Message-ID: <X/bqQinLuCM4xlId@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > It does not make sense to run the test cleanup function when the setup
> > function has been run.

> Did you mean "setup function hasn't been run." here?

> As it is this sentence does not make any sense to me.
Yes, thanks!

> > And at least some network tests expect setup has been run before running
> > cleanup (e.g. tcp_fastopen_run.sh).

> > When shell API was introduced, cleanup function was run only if 1) setup
> > function was defined 2) and also run. That was inconsistent from C API,
> > thus e7dc14caa run it always.

> > But shell API is different from C API: tst_brk can be called from
> > tst_test.sh (or other library which is run before tst_run, e.g.
> > tst_net.sh). That was probably the reason, why detection via
> > $TST_SETUP_STARTED was introduced in initial shell API.

> > NOTE: using type is better than grep $TST_TEST_PATH, because cleanup
> > function can be in other library sourced by the test.

> > Fixes: e7dc14caa ("tst_test.sh: Run cleanup even setup is not defined")

> This still possibly break tests that would call tst_brk() in the middle
> of setup and expect the cleanup() to be executed, right?

> I guess that we would need TST_DO_CLEANUP that would be set in both
> cases i.e. before we run setup and also before we execute the tests.

> What about this:
Good catch, agree.
I'm going to merge with one runtime fix:
> -       if [ -n $TST_DO_CLEANUP -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
> +       if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then

Quotes are required otherwise we can get error:
/opt/ltp/testcases/bin/tst_test.sh: line 31: [: too many arguments

Kind regards,
Petr


> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 2417da140..94d95df6f 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -28,7 +28,7 @@ _tst_do_exit()
>         local ret=0
>         TST_DO_EXIT=1

> -       if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
> +       if [ -n $TST_DO_CLEANUP -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
>                 $TST_CLEANUP
>         fi

> @@ -582,6 +582,7 @@ tst_run()
>         [ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"

>         if [ -n "$TST_SETUP" ]; then
> +               TST_DO_CLEANUP=1
>                 $TST_SETUP
>         fi

> @@ -608,6 +609,7 @@ _tst_run_tests()
>         local _tst_data="$1"
>         local _tst_i

> +       TST_DO_CLEANUP=1
>         for _tst_i in $(seq ${TST_CNT:-1}); do
>                 if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
>                         _tst_run_test "$TST_TESTFUNC$_tst_i" $_tst_i "$_tst_data"
