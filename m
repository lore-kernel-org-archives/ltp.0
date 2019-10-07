From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Oct 2019 15:17:03 +0200
Subject: [LTP] [PATCH v3] lsmod01: Add kernel module
In-Reply-To: <20191007065017.86054-1-lkml@jv-coder.de>
References: <20191007065017.86054-1-lkml@jv-coder.de>
Message-ID: <20191007131702.GC20170@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
> index ad170dcd4..c761a91af 100755
> --- a/testcases/commands/lsmod/lsmod01.sh
> +++ b/testcases/commands/lsmod/lsmod01.sh
> @@ -5,11 +5,43 @@
>  #
>  # Test basic functionality of lsmod command.
>  
> +TST_CLEANUP=cleanup
> +TST_SETUP=setup
>  TST_TESTFUNC=lsmod_test
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_CMDS="lsmod"
> +TST_NEEDS_MODULE="ltp_lsmod01.ko"

Sigh, there is another problem here, this causes the library to exit the
test if the module does not exist, which disables the test in a case
that the module wasn't compiled i.e. kernel-devel wasn't installed, but
in the most cases the test will run just fine on such configuration.

I guess that we need to patch the library so that we can get a path to a
module without exitting the test. Maybe we should add
TST_GET_MODPATH="foo.ko" which will do the same as TST_NEEDS_MODULE but
will not exit the test if not found. Then we can check if "$TST_MODPATH"
is empty in the test setup just before we attempt insmod.

>  . tst_test.sh
>  
> +inserted=0
> +
> +setup()
> +{
> +	if [ -z "$(cat /proc/modules)" ]; then
> +		tst_res TINFO "Loading dummy kernel module"
> +		insmod "$TST_MODPATH"
> +		if [ $? -ne 0 ]; then
> +			tst_res TBROK "insmod failed"
> +			return
> +		fi
> +
> +		inserted=1
> +	fi
> +}
> +
> +cleanup()
> +{
> +	if [ $inserted -ne 0 ]; then
> +		tst_res TINFO "Unloading dummy kernel module"
> +		rmmod ltp_lsmod01
> +		if [ $? -ne 0 ]; then
> +			tst_res TWARN "rmmod failed"
> +		fi
> +		inserted=0
> +	fi
> +}
> +
> +
>  lsmod_test()
>  {
>  	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
> diff --git a/testcases/commands/lsmod/ltp_lsmod01.c b/testcases/commands/lsmod/ltp_lsmod01.c
> new file mode 100644
> index 000000000..19f9d9145
> --- /dev/null
> +++ b/testcases/commands/lsmod/ltp_lsmod01.c
> @@ -0,0 +1,28 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2016 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * Description:
> + *  This is a kernel loadable module programme used by lssmod01.sh
> + *  testcase which inserts this module for test of lsmod command.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +
> +static int test_init(void)
> +{
> +	return 0;
> +}
> +
> +static void test_exit(void)
> +{
> +
> +}
> +
> +MODULE_LICENSE("GPL");
> +
> +module_init(test_init);
> +module_exit(test_exit);
> -- 
> 2.20.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
