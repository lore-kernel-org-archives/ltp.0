From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 04 Jun 2021 15:43:34 +0100
Subject: [LTP] [RFC PATCH 0/3] build: make check target
In-Reply-To: <20210603183827.24339-1-pvorel@suse.cz>
References: <20210603183827.24339-1-pvorel@suse.cz>
Message-ID: <87wnr9itbd.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
> actually, there are 3 targets: check, check-c, check-shell.

Usually, if you only want to make a sub group of tests. Then you cd into
the sub directory and do 'make'.

So why do we need three targets?

Just an idea, but maybe in a future patch this could run some actual
tests as well? A lot of the old syscall tests would be fine to run in
CI. More likely if they fail it is due to LTP library changes than a
kernel bug on the host.

>
> Previous attempt: make: Add make check target + run.sh [1].
> This is built on the top of patchset tst_net.sh: Allow to skip
> initialization [2]. Hope this time library check will made it :).
>
> I plan to wrap tests with a script in the future, which will parse
> expected output, i.e. approach from #312 [3].
>
> It's not ready due several problems, but for curious here is a test run:
> https://github.com/pevik/ltp/runs/2739826773
>
> 1) I made something wrong, I have no idea how to fix this error:
> make[1]: Entering directory 'ltp/lib'
> ../include/mk/generic_trunk_target.inc:105: warning: overriding recipe for target 'check-c'
> ../include/mk/generic_leaf_target.inc:110: warning: ignoring old recipe for target 'check-c'
> ../include/mk/generic_trunk_target.inc:105: warning: overriding recipe for target 'check-shell'
> ../include/mk/generic_leaf_target.inc:118: warning: ignoring old recipe for target 'check-shell'
>
> 2) I obviously have problem with out-of-tree build
> https://github.com/pevik/ltp/runs/2739826612?check_suite_focus=true
> where path of shell tests (which are in src directory only) is obviously
> broken:
> make[2]: *** No rule to make target 'shell/tst_check_driver.sh', needed by 'check-shell'.  Stop.
> 20
> make[1]: *** [/__w/ltp/ltp/include/mk/generic_trunk_target.inc:105: check-shell] Error 2
> 21
> make[1]: Leaving directory '/__w/ltp/ltp-build/lib'
>
> 3)  tst_bool_expr fails on some systems when run via make check:
> https://github.com/pevik/ltp/runs/2739826773?check_suite_focus=true
> But it runs ok when running normally. It might be dash issue
> (it's on Debian).
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20190924182841.4528-1-pvorel@suse.cz/
> [2] https://patchwork.ozlabs.org/project/ltp/list/?series=247078
> [3] https://github.com/linux-test-project/ltp/issues/312
>
> Petr Vorel (3):
>   make: Add make check{,-c,-shell} targets
>   build.sh: Add support for make check
>   CI: Run also make check
>
>  .github/workflows/ci.yml            |  3 +++
>  Makefile                            | 21 ++++++++++++++++++++-
>  build.sh                            | 18 +++++++++++++++++-
>  include/mk/generic_leaf_target.inc  | 25 ++++++++++++++++++++++---
>  include/mk/generic_trunk_target.inc |  4 ++--
>  lib/newlib_tests/Makefile           |  8 ++++++++
>  6 files changed, 72 insertions(+), 7 deletions(-)
>
> -- 
> 2.31.1


-- 
Thank you,
Richard.
