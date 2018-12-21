From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Dec 2018 15:35:07 +0100
Subject: [LTP] [PATCH v2 1/4] cgroup_regression_test.sh ported to newlib
In-Reply-To: <20181220182149.48326-2-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181220182149.48326-2-cristian.marussi@arm.com>
Message-ID: <20181221143507.GB27446@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

...
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
...
> -cd $LTPROOT/testcases/bin
You left this even after second commit. It's not needed.

> +TST_TESTFUNC=do_test
> +TST_SETUP=do_setup
> +TST_CLEANUP=do_cleanup
> +TST_CNT=10
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="dmesg mountpoint mount umount cat kill find mkdir rmdir grep"
Test needs also using temporary directory (as it creates directories):
TST_NEEDS_TMPDIR=1


> -export TCID="cgroup_regression_test"
> -export TST_TOTAL=10
> -export TST_COUNT=1
> +. tst_test.sh

> -failed=0
> +do_setup()
> +{
> +	cd $LTPROOT/testcases/bin
And here.

...
> +do_cleanup()
> +{
> +	cd $LTPROOT/testcases/bin
One more time.

...
> -for ((cur = 1; cur <= $TST_TOTAL; cur++))
> +do_test()
>  {
> -	export TST_COUNT=$cur
> +	local cur=$1

>  	test_$cur
>  }

do_test() function is not needed at all, looping can be done automatically:
Remove underscore from test functions (s/test_([0-9]+)/test$1/)
and change setup: TST_TESTFUNC=test

See
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#user-content-2-3-1-basic-test-interface


Kind regards,
Petr
