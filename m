From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 4 Oct 2019 12:48:36 +0200
Subject: [LTP] [PATCH v2] lsmod01: Add kernel module
In-Reply-To: <20191004103414.GE1231@rei>
References: <20190927092024.97928-1-lkml@jv-coder.de>
 <20191004103414.GE1231@rei>
Message-ID: <635c345d-18f8-6f2e-e658-648251d32e65@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Am 04.10.2019 um 12:34 schrieb Cyril Hrubis:
> Hi!
>> Forgot calling cleanup in v1
>>
>> The test fails, if no kernel module is loaded. Now at least one module is
>> always loaded.
>>
>> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> ---
>>   testcases/commands/.gitignore          |  1 +
>>   testcases/commands/lsmod/Makefile      | 15 +++++++++++++++
>>   testcases/commands/lsmod/lsmod01.sh    | 26 ++++++++++++++++++++++++++
>>   testcases/commands/lsmod/ltp_lsmod01.c | 26 ++++++++++++++++++++++++++
>>   4 files changed, 68 insertions(+)
>>   create mode 100644 testcases/commands/lsmod/ltp_lsmod01.c
>>
>> diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
>> index 0ed343881..ed5e13e29 100644
>> --- a/testcases/commands/.gitignore
>> +++ b/testcases/commands/.gitignore
>> @@ -2,3 +2,4 @@
>>   /ldd/datafiles/*.obj.so
>>   /eject/eject_check_tray
>>   /insmod/ltp_insmod01.ko
>> +/lsmod/ltp_lsmod01.ko
>> diff --git a/testcases/commands/lsmod/Makefile b/testcases/commands/lsmod/Makefile
>> index 2af91b3de..8fc3b1436 100644
>> --- a/testcases/commands/lsmod/Makefile
>> +++ b/testcases/commands/lsmod/Makefile
>> @@ -13,10 +13,25 @@
>>   #    GNU General Public License for more details.
>>   #
>>   
>> +ifneq ($(KERNELRELEASE),)
>> +
>> +obj-m := ltp_lsmod01.o
>> +
>> +else
>> +
>>   top_srcdir		?= ../../..
>>   
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +REQ_VERSION_MAJOR       := 2
>> +REQ_VERSION_PATCH       := 6
>> +MAKE_TARGETS            := ltp_lsmod01.ko
>> +
>>   include $(top_srcdir)/include/mk/env_pre.mk
>>   
>>   INSTALL_TARGETS		:= lsmod01.sh
>>   
>> +include $(top_srcdir)/include/mk/module.mk
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> +
>> +endif
>> diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
>> index ad170dcd4..7f9dd284e 100755
>> --- a/testcases/commands/lsmod/lsmod01.sh
>> +++ b/testcases/commands/lsmod/lsmod01.sh
>> @@ -5,13 +5,37 @@
>>   #
>>   # Test basic functionality of lsmod command.
>>   
>> +TST_CLEANUP=cleanup
>>   TST_TESTFUNC=lsmod_test
>>   TST_NEEDS_TMPDIR=1
>>   TST_NEEDS_CMDS="lsmod"
>> +TST_NEEDS_MODULE="ltp_lsmod01.ko"
>>   . tst_test.sh
>>   
>> +inserted=0
>> +
>> +cleanup()
>> +{
>> +	if [ $inserted -ne 0 ]; then
>> +		tst_res TINFO "running rmmod ltp_lsmod01"
>> +		rmmod ltp_lsmod01
>> +		if [ $? -ne 0 ]; then
>> +			tst_res TWARN "failed to rmmod ltp_lsmod01"
>> +		fi
>> +		inserted=0
>> +	fi
>> +}
>> +
>> +
>>   lsmod_test()
>>   {
>> +	insmod "$TST_MODPATH"
>> +	if [ $? -ne 0 ]; then
>> +		tst_res TFAIL "insmod failed"
>> +		return
>> +	fi
>> +	inserted=1
> This should be in the test setup. Also can insert the module only and
> only if /proc/modules is empty?
You are right, I will change it
>
>>   	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
>>   	if [ -z "$lsmod_output" ]; then
>>   		tst_res TFAIL "Failed to parse the output from lsmod"
>> @@ -34,6 +58,8 @@ lsmod_test()
>>   		return
>>   	fi
>>   
>> +	cleanup
> If you define the cleanup in TST_CLEANUP the library will call it for
> you, do not call it yourself here.

No, if no TST_SETUP is defined, the library will not call it.
See tst_test.sh:31:
if[ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
 ??? ???? -z "$TST_NO_CLEANUP" ]; then
 ??? $TST_CLEANUP
fi
But since I'm going to move the module loading into setup,
I can remove this.

>
>>   	tst_res TPASS "'lsmod' passed."
>>   }
>>   
>> diff --git a/testcases/commands/lsmod/ltp_lsmod01.c b/testcases/commands/lsmod/ltp_lsmod01.c
>> new file mode 100644
>> index 000000000..8ba786276
>> --- /dev/null
>> +++ b/testcases/commands/lsmod/ltp_lsmod01.c
>> @@ -0,0 +1,26 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (c) 2016 Fujitsu Ltd.
>> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> + *
>> + * Description:
>> + *  This is a kernel loadable module programme used by lssmod01.sh
>> + *  testcase which inserts this module for test of lsmod command.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +
>> +static int test_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void test_exit(void)
>> +{
>> +
>> +}
>> +
>> +module_init(test_init);
>> +module_exit(test_exit);
> You are missing the GPL license here, without it the module will taint
> the kernel.
I will add it.
