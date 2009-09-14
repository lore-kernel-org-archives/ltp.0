Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mn5tL-0006Fi-TG
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 07:22:27 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mn5tH-00007s-5w
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 07:22:27 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8E7CRid026769
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Sep 2009 01:12:27 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8E7MHw0200392
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Sep 2009 01:22:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8E7MGp9027205
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Sep 2009 01:22:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AADCDC3.8000600@cn.fujitsu.com>
References: <4AA72EC0.2000404@cn.fujitsu.com>
	<1252483110.5006.25.camel@subratamodak.linux.ibm.com>
	<4AADCDC3.8000600@cn.fujitsu.com>
Date: Mon, 14 Sep 2009 12:52:01 +0530
Message-Id: <1252912921.6877.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for memcgroup
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>, ltp-list <ltp-list@lists.sourceforge.net>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <balbir@in.ibm.com>

Hi Shi,

Thanks for re-posting the patch. I have added your tests to LTP. Thanks
for contributing again.

Regards--
Subrata

On Mon, 2009-09-14 at 12:59 +0800, Shi Weihua wrote:
> Subrata Modak wrote:
> > Hi Shi,
> > 
> > Thanks once again for contributing the Memcgroup functional and Stress
> > tests. Please find some of my comments below:
> > 
> > On Wed, 2009-09-09 at 12:27 +0800, Shi Weihua wrote:
> <snip>
> >> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/Makefile ltp-full-20090831.memcgroup/testcases/kernel/controllers/Makefile
> >> --- ltp-full-20090831.orig/testcases/kernel/controllers/Makefile	2009-09-07 18:14:49.000000000 -0400
> >> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/Makefile	2009-09-07 18:15:49.000000000 -0400
> >> @@ -17,6 +17,7 @@ SUBDIRS += cgroup_fj
> >>  SUBDIRS += cpuctl
> >>  SUBDIRS += cpuctl_fj
> >>  SUBDIRS += memctl
> >> +SUBDIRS += memcgroup
> > 
> > Is it necessary to create a separate sub-directory called 'memcgroup'
> > when 'memcg' already exists. Can you please merge your present tests
> > under some common directory like:
> > 
> >      1. move "controllers/memcg" to "controllers/memcg/regression",
> >      2. Create "controllers/memcg/functional", and
> >      3. Create "controllers/memcg/stress", to put the new tests,
> > 
> 
> Ok. Three directory was created in the latest version.
> 
> <snip>
> > 
> > which are not cleaned up even after the tests have completed execution.
> > This is making the tests fail when it is run again. So, please clean
> > this up:
> > 
> >      1. After normal test run,
> >      2. Check before the actual test run if it exists (if the earlier
> >         tests was abruptly terminated leaving these directories dirty),
> >         and cleanup before the tests begin,
> 
> Ok. A cleanup function has beed added in the latest version.
> 
> > 
> > Following is the test results for the new tests that you are proposing
> > to be added on my machine:
> > 
> > # uname -a
> > Linux 2.6.30-gcov #1 SMP Tue Aug 25 20:49:10 IST 2009 i686 i686 i386
> > GNU/Linux,
> > 
> > Please also find my comments inlined:
> > ==================================================================================================
> <snip>
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5712 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   14  TPASS  :  process 5712 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5721 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   15  TPASS  :  process 5721 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5733 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   16  TPASS  :  process 5733 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5744 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   17  TPASS  :  process 5744 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5755 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   18  TPASS  :  process 5755 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5765 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   19  TPASS  :  process 5765 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5774 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > memcgroup_function_test   20  TPASS  :  process 5774 is killed
> > /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5783 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
> > 
> > *** ....<Can the above messages be appropriately handled ??>....
> 
> You meaned the message like as "***.sh: line xxx: (pid) Killed ***" should be deleted?
> But these messges are occured by the current running script, they can not be deleted. 
> Of course, the command like as "./memcgroup_function_test.sh > /dev/null" can delete 
> these messages, but the normal output (e.g. memcgroup_function_test   20  TPASS  :  process 5774 is killed)
> will be deleted too.
> 
> > 
> > memcgroup_function_test   21  TPASS  :  process 5783 is killed
> > memcgroup_function_test   22  TPASS  :  input=4095, limit_in_bytes=4096
> > memcgroup_function_test   23  TPASS  :  input=4097, limit_in_bytes=8192
> > memcgroup_function_test   24  TPASS  :  input=1, limit_in_bytes=4096
> > memcgroup_function_test   25  TFAIL  :  return value is 1
> > memcgroup_function_test   26  TPASS  :  return value is 1
> > memcgroup_function_test   27  TPASS  :  return value is 1
> > memcgroup_function_test   28  TPASS  :  return value is 1
> > memcgroup_function_test   29  TPASS  :  force memory succeeded
> > memcgroup_function_test   30  TPASS  :  force memory failed as expected
> > memcgroup_function_test   31  TPASS  :  return value is 0
> > memcgroup_function_test   32  TPASS  :  return value is 0
> > memcgroup_function_test   33  TPASS  :  return value is 0
> > memcgroup_function_test   34  TPASS  :  return value is 0
> > memcgroup_function_test   35  TPASS  :  return value is 1
> > memcgroup_function_test   36  TPASS  :  rss=4096/4096, cache=0/0
> > memcgroup_function_test   36  TPASS  :  rss=0/0, cache=0/0
> > memcgroup_function_test   37  TPASS  :  rss=4096/4096, cache=0/0
> > memcgroup_function_test   37  TPASS  :  rss=0/0, cache=0/0
> > memcgroup_function_test   38  TPASS  :  rss=4096/4096, cache=0/0
> > memcgroup_function_test   38  TPASS  :  rss=0/0, cache=0/0
> > 
> > *** ....<The numbering seems to be wrong here>....
> 
> It's correct. Some cases will output TPASS/TFAIL twice. Don't worry about it.
> 
> > 
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=110 termination_type=exited termination_id=1 corefile=no
> > cutime=29 cstime=268
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=memcgroup_stress stime=1252484403
> > cmdline="      memcgroup_stress_test.sh"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > Wed Sep  9 13:50:07 IST 2009
> > incrementing stop
> > incrementing stop
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=265 termination_type=driver_interrupt termination_id=15
> > 
> > *** ....<The stress tests seems to be not executing at all. What can be
> > the reason behind the "driver_interrupt" ?? >....
> 
> Sorry, I can not reproduce your problem on my machine(x86).
> [root@F8-i386 ltp-full-20090831.memcg]# uname -a
> Linux F8-i386 2.6.31-rc5 #3 SMP Mon Aug 10 15:20:54 EDT 2009 i686 i686 i386 GNU/Linux
> 
> The latest version as following.
> 
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
>  runtest/controllers                                                    |    4
>  testcases/kernel/controllers/memcg/Makefile                            |   18
>  testcases/kernel/controllers/memcg/README                              |   42
>  testcases/kernel/controllers/memcg/functional/Makefile                 |   23
>  testcases/kernel/controllers/memcg/functional/memcg_function_test.sh   |  562 ++++++++++
>  testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c      |   31
>  testcases/kernel/controllers/memcg/functional/memcg_process.c          |  319 +++++
>  testcases/kernel/controllers/memcg/memcg_regression_test.sh            |  225 ----
>  testcases/kernel/controllers/memcg/memcg_test_1.c                      |   71 -
>  testcases/kernel/controllers/memcg/memcg_test_2.c                      |   53
>  testcases/kernel/controllers/memcg/memcg_test_4.c                      |   62 -
>  testcases/kernel/controllers/memcg/memcg_test_4.sh                     |   48
>  testcases/kernel/controllers/memcg/regression/Makefile                 |   16
>  testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh |  225 ++++
>  testcases/kernel/controllers/memcg/regression/memcg_test_1.c           |   71 +
>  testcases/kernel/controllers/memcg/regression/memcg_test_2.c           |   53
>  testcases/kernel/controllers/memcg/regression/memcg_test_4.c           |   62 +
>  testcases/kernel/controllers/memcg/regression/memcg_test_4.sh          |   48
>  testcases/kernel/controllers/memcg/stress/Makefile                     |   23
>  testcases/kernel/controllers/memcg/stress/memcg_process_stress.c       |  109 +
>  testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh         |  125 ++
>  21 files changed, 1717 insertions(+), 473 deletions(-)
> 
> diff -urpN ltp-full-20090831.orig/runtest/controllers ltp-full-20090831.memcg/runtest/controllers
> --- ltp-full-20090831.orig/runtest/controllers	2009-08-31 01:15:37.000000000 -0400
> +++ ltp-full-20090831.memcg/runtest/controllers	2009-09-14 08:25:34.000000000 -0400
> @@ -1,5 +1,7 @@
>  #DESCRIPTION:Resource Management testing
>  cgroup		cgroup_regression_test.sh
> -memcg		memcg_regression_test.sh
> +memcg_regression	memcg_regression_test.sh
> +memcg_function		memcg_function_test.sh
> +memcg_stress		memcg_stress_test.sh
>  cgroup_fj	run_cgroup_test_fj.sh
>  controllers	test_controllers.sh
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/Makefile ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/Makefile
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/Makefile	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/Makefile	2009-09-11 11:05:53.000000000 -0400
> @@ -0,0 +1,23 @@
> +CFLAGS += -Wall -O2 -g -Wextra
> +LDLIBS += -lm
> +
> +SRCS=$(wildcard *.c)
> +OBJECTS=$(patsubst %.c,%.o,$(SRCS))
> +TARGETS=$(patsubst %.c,%,$(SRCS))
> +
> +all: $(TARGETS)
> +
> +$(TARGETS): %: %.o
> +
> +install:
> +	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../../bin/$$i ; chmod +x $$i ; done
> +
> +test:
> +	@./memcgroup_function_test.sh
> +
> +clean:
> +	rm -f $(TARGETS) $(OBJECTS)
> +
> +uninstall:
> +
> +.DEFAULT: ;
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	2009-09-11 13:12:57.000000000 -0400
> @@ -0,0 +1,562 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
> +##                                                                            ##
> +################################################################################
> +
> +cd $LTPROOT/testcases/bin
> +export TCID="memcg_function_test"
> +export TST_TOTAL=38
> +export TST_COUNT=0
> +
> +grep -w memory /proc/cgroups 2>&1 > /dev/null
> +if [ $? -ne 0 ]; then
> +	echo "WARNING:";
> +	echo "Kernel does not support for memory resource controller";
> +	echo "Skipping all memcgroup testcases....";
> +	exit 0
> +fi
> +
> +TEST_PATH=$PWD
> +
> +PASS=0
> +FAIL=1
> +
> +PAGESIZE=`./memcg_getpagesize`
> +HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
> +HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
> +
> +cur_id=0
> +failed=0
> +
> +# Record the test result of a test case
> +#
> +# $1 - The result of the test case, $PASS or $FAIL
> +# $2 - The output information
> +result()
> +{
> +	pass=$1
> +	info="$2"
> +
> +	if [ $pass -eq $PASS ]; then
> +		tst_resm TPASS "$info"
> +	else
> +		tst_resm TFAIL "$info"
> +		failed=$(( $failed + 1 ))
> +	fi
> +}
> +
> +# Check rss size and cache size from memory.stat
> +#
> +# $1 - Expected rss size
> +# $2 - Expected cache size
> +check_mem_stat()
> +{
> +	case $cur_id in
> +	"11"|"12"|"13")
> +		# result() will be called in test_failcnt(),not here
> +		return
> +		;;
> +	*)
> +		;;
> +	esac
> +
> +	rss=`cat memory.stat | grep rss | head -n 1 | cut -d " " -f 2`
> +	cache=`cat memory.stat | grep cache | head -n 1 | cut -d " " -f 2`
> +
> +	if [ "$1" = "$rss" ] && [ "$2" = "$cache" ] ; then
> +		pass=$PASS
> +	else
> +		pass=$FAIL
> +	fi
> +
> +	result $pass "rss=$rss/$1, cache=$cache/$2"
> +}
> +
> +# Run test cases which checks memory.stat after make
> +# some memory allocation
> +#
> +# $1 - the parameters of 'process', such as --shm
> +# $2 - the -s parameter of 'process', such as 4096
> +# $3 - the expected rss size
> +# $4 - the expected pagecache size
> +# $5 - check after free ?
> +test_mem_stat()
> +{
> +	$TEST_PATH/memcg_process $1 -s $2 &
> +	sleep 1
> +	echo $! > tasks
> +	/bin/kill -s SIGUSR1 $! 2> /dev/null
> +	sleep 1
> +
> +	check_mem_stat $3 $4
> +
> +	/bin/kill -s SIGUSR1 $! 2> /dev/null
> +	sleep 1
> +	if [ $5 -eq 1 ]; then
> +		check_mem_stat 0 0
> +	fi
> +	/bin/kill -s SIGINT $! 2> /dev/null
> +}
> +
> +# Test if memory.failcnt > 0, which means page reclamation
> +# occured
> +test_failcnt()
> +{
> +	failcnt=`cat memory.failcnt`
> +	if [ $failcnt -gt 0 ]; then
> +		pass=$PASS
> +	else
> +		pass=$FAIL
> +	fi
> +
> +	result $pass "failcnt=$failcnt"
> +}
> +
> +# Test process will be killed due to exceed memory limit
> +#
> +# $1 - the value of memory.limit_in_bytes
> +# $2 - the parameters of 'process', such as --shm
> +# $3 - the -s parameter of 'process', such as 4096
> +test_proc_kill()
> +{
> +	echo $1 > memory.limit_in_bytes
> +	$TEST_PATH/memcg_process $2 -s $3 &
> +	pid=$!
> +	sleep 1
> +	echo $pid > tasks
> +
> +	/bin/kill -s SIGUSR1 $pid 2> /dev/null
> +	sleep 1
> +	ps -p $pid > /dev/null 2> /dev/null
> +	if [ $? -ne 0 ]; then
> +		result $PASS "process $pid is killed"
> +	else
> +		/bin/kill -s SIGINT $pid 2> /dev/null
> +		result $FAIL "process $pid is not killed"
> +	fi
> +}
> +
> +# Test memory.limit_in_bytes will be aligned to PAGESIZE
> +#
> +# $1 - user input value
> +# $2 - expected value
> +test_limit_in_bytes()
> +{
> +	echo $1 > memory.limit_in_bytes
> +	limit=`cat memory.limit_in_bytes`
> +	if [ $limit -eq $2 ]; then
> +		result $PASS "input=$1, limit_in_bytes=$limit"
> +	else
> +		result $FAIL "input=$1, limit_in_bytes=$limit"
> +	fi
> +}
> +
> +# Test memory controller doesn't charge hugepage
> +#
> +# $1 - the value of /proc/sys/vm/nr_hugepages
> +# $2 - the parameters of 'process', --mmap-file or --shm
> +# $3 - the -s parameter of 'process', such as $HUGEPAGESIZE
> +# $4 - 0: expected failure, 1: expected success
> +test_hugepage()
> +{
> +	TMP_FILE=$TEST_PATH/tmp
> +	nr_hugepages=`cat /proc/sys/vm/nr_hugepages`
> +
> +	mkdir /hugetlb
> +	mount -t hugetlbfs none /hugetlb
> +
> +	echo $1 > /proc/sys/vm/nr_hugepages
> +
> +	$TEST_PATH/memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
> +	sleep 1
> +
> +	/bin/kill -s SIGUSR1 $! 2> /dev/null
> +	sleep 1
> +
> +	check_mem_stat 0 0
> +
> +	echo "TMP_FILE:"
> +	cat $TMP_FILE
> +
> +	if [ $4 -eq 0 ]; then
> +		test -s $TMP_FILE
> +		if [ $? -eq 0 ]; then
> +			result $PASS "allocate hugepage failed as expected"
> +		else
> +			/bin/kill -s SIGUSR1 $! 2> /dev/null
> +			/bin/kill -s SIGINT $! 2> /dev/null
> +			result $FAIL "allocate hugepage shoud fail"
> +		fi
> +	else
> +		test ! -s $TMP_FILE
> +		if [ $? -eq 0 ]; then
> +			/bin/kill -s SIGUSR1 $! 2> /dev/null
> +			/bin/kill -s SIGINT $! 2> /dev/null
> +			result $PASS "allocate hugepage succeeded"
> +		else
> +			result $FAIL "allocate hugepage failed"
> +		fi
> +	fi
> +
> +	sleep 1
> +	rm -rf $TMP_FILE
> +	umount /hugetlb
> +	rmdir /hugetlb
> +	echo $nr_hugepages > /proc/sys/vm/nr_hugepages
> +}
> +
> +# Test the memory charge won't move to subgroup
> +#
> +# $1 - memory.limit_in_bytes in parent group
> +# $2 - memory.limit_in_bytes in sub group
> +test_subgroup()
> +{
> +	mkdir subgroup
> +	echo $1 > memory.limit_in_bytes
> +	echo $2 > subgroup/memory.limit_in_bytes
> +
> +	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
> +	sleep 1
> +	echo $! > tasks
> +	/bin/kill -s SIGUSR1 $! 2> /dev/null
> +	sleep 1
> +	check_mem_stat $PAGESIZE 0
> +
> +	cd subgroup
> +	echo $! > tasks
> +	check_mem_stat 0 0
> +
> +	# cleanup
> +	cd ..
> +	echo $! > tasks
> +	/bin/kill -s SIGINT $! 2> /dev/null
> +	sleep 1
> +	rmdir subgroup
> +}
> +
> +# Case 1 - 10: Test the management and counting of memory
> +testcase_1()
> +{
> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE 0 0
> +}
> +
> +testcase_2()
> +{
> +	test_mem_stat "--mmap-file" $PAGESIZE 0 $PAGESIZE 0
> +}
> +
> +testcase_3()
> +{
> +	test_mem_stat "--shm -k 3" $PAGESIZE 0 $PAGESIZE 0
> +}
> +
> +testcase_4()
> +{
> +	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE \
> +		      $PAGESIZE $(($PAGESIZE*2)) 0
> +}
> +
> +testcase_5()
> +{
> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE 0 0
> +}
> +
> +testcase_6()
> +{
> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE 0 1
> +}
> +
> +testcase_7()
> +{
> +	test_mem_stat "--mmap-file" $PAGESIZE 0 $PAGESIZE 1
> +}
> +
> +testcase_8()
> +{
> +	test_mem_stat "--shm -k 8" $PAGESIZE 0 $PAGESIZE 1
> +}
> +
> +testcase_9()
> +{
> +	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE \
> +		      $PAGESIZE $(($PAGESIZE*2)) 1
> +}
> +
> +testcase_10()
> +{
> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE 0 1
> +}
> +
> +# Case 11 - 13: Test memory.failcnt
> +testcase_11()
> +{
> +	echo $PAGESIZE > memory.limit_in_bytes
> +	test_mem_stat "--mmap-anon" $(($PAGESIZE*2)) $PAGESIZE 0 0
> +	test_failcnt
> +}
> +
> +testcase_12()
> +{
> +	echo $PAGESIZE > memory.limit_in_bytes
> +	test_mem_stat "--mmap-file" $(($PAGESIZE*2)) 0 $PAGESIZE 0
> +	test_failcnt
> +}
> +
> +testcase_13()
> +{
> +	echo $PAGESIZE > memory.limit_in_bytes
> +	test_mem_stat "--shm" $(($PAGESIZE*2)) 0 $PAGESIZE 0
> +	test_failcnt
> +}
> +
> +# Case 14 - 15: Test mmap(locked) + alloc_mem > limit_in_bytes
> +testcase_14()
> +{
> +	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2))
> +}
> +
> +testcase_15()
> +{
> +	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2))
> +}
> +
> +# Case 16 - 18: Test swapoff + alloc_mem > limi_in_bytes
> +testcase_16()
> +{
> +	swapoff -a
> +	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE*2))
> +	swapon -a
> +}
> +
> +testcase_17()
> +{
> +	swapoff -a
> +	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE*2))
> +	swapon -a
> +}
> +
> +testcase_18()
> +{
> +	swapoff -a
> +	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE*2))
> +	swapon -a
> +}
> +
> +# Case 19 - 21: Test limit_in_bytes == 0
> +testcase_19()
> +{
> +	test_proc_kill 0 "--mmap-anon" $PAGESIZE
> +}
> +
> +testcase_20()
> +{
> +	test_proc_kill 0 "--mmap-file" $PAGESIZE
> +}
> +
> +testcase_21()
> +{
> +	test_proc_kill 0 "--shm -k 21" $PAGESIZE
> +}
> +
> +# Case 22 - 24: Test limit_in_bytes will be aligned to PAGESIZE
> +testcase_22()
> +{
> +	test_limit_in_bytes $((PAGESIZE-1)) $PAGESIZE
> +}
> +
> +testcase_23()
> +{
> +	test_limit_in_bytes $((PAGESIZE+1)) $((PAGESIZE*2))
> +}
> +
> +testcase_24()
> +{
> +	test_limit_in_bytes 1 $PAGESIZE
> +}
> +
> +# Case 25 - 28: Test invaild memory.limit_in_bytes
> +testcase_25()
> +{
> +	echo -1 > memory.limit_in_bytes 2> /dev/null
> +#	result $(( !($? != 0) ))  "return value is $?"  //lizf
> +	result $(( !($? == 0) ))  "return value is $?"
> +}
> +
> +testcase_26()
> +{
> +	echo 1.0 > memory.limit_in_bytes 2> /dev/null
> +	result $(( !($? != 0) )) "return value is $?"
> +}
> +
> +testcase_27()
> +{
> +	echo 1xx > memory.limit_in_bytes 2> /dev/null
> +	result $(( !($? != 0) )) "return value is $?"
> +}
> +
> +testcase_28()
> +{
> +	echo xx > memory.limit_in_bytes 2> /dev/null
> +	result $(( !($? != 0) )) "return value is $?"
> +}
> +
> +# Case 29 - 35: Test memory.force_empty
> +testcase_29()
> +{
> +	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
> +	pid=$!
> +	sleep 1
> +	echo $pid > tasks
> +	/bin/kill -s SIGUSR1 $pid 2> /dev/null
> +	sleep 1
> +	echo $pid > ../tasks
> +
> +	echo 1 > memory.force_empty
> +	if [ $? -eq 0 ]; then
> +		result $PASS "force memory succeeded"
> +	else
> +		result $FAIL "force memory failed"
> +	fi
> +
> +	/bin/kill -s SIGINT $pid 2> /dev/null
> +}
> +
> +testcase_30()
> +{
> +	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
> +	pid=$!
> +	sleep 1
> +	echo $pid > tasks
> +	/bin/kill -s SIGUSR1 $pid 2> /dev/null
> +	sleep 1
> +
> +	echo 1 > memory.force_empty 2> /dev/null
> +	if [ $? -ne 0 ]; then
> +		result $PASS "force memory failed as expected"
> +	else
> +		result $FAIL "force memory should fail"
> +	fi
> +
> +	/bin/kill -s SIGINT $pid 2> /dev/null
> +}
> +
> +testcase_31()
> +{
> +	echo 0 > memory.force_empty 2> /dev/null
> +	result $? "return value is $?"
> +}
> +
> +testcase_32()
> +{
> +	echo 1.0 > memory.force_empty 2> /dev/null
> +	result $? "return value is $?"
> +}
> +
> +testcase_33()
> +{
> +	echo 1xx > memory.force_empty 2> /dev/null
> +	result $? "return value is $?"
> +}
> +
> +testcase_34()
> +{
> +	echo xx > memory.force_empty 2> /dev/null
> +	result $? "return value is $?"
> +}
> +
> +testcase_35()
> +{
> +	# writing to non-empty top mem cgroup's force_empty
> +	# should return failure
> +	echo 1 > /memcg/memory.force_empty 2> /dev/null
> +	result $(( $? )) "return value is $?"
> +}
> +
> +# Case 36 - 38: Test that group and subgroup have no relationship
> +testcase_36()
> +{
> +	test_subgroup $PAGESIZE $((2*PAGESIZE))
> +}
> +
> +testcase_37()
> +{
> +	test_subgroup $PAGESIZE $PAGESIZE
> +}
> +
> +testcase_38()
> +{
> +	test_subgroup $PAGESIZE 0
> +}
> +
> +shmmax=`cat /proc/sys/kernel/shmmax`
> +if [ $shmmax -lt $HUGEPAGESIZE ]; then
> +	echo $(($HUGEPAGESIZE)) > /proc/sys/kernel/shmmax
> +fi
> +
> +cleanup()
> +{
> +	if [ -e /dev/memcg ]; then
> +		umount /dev/memcg 2>/dev/null
> +		rmdir /dev/memcg 2>/dev/null
> +	fi
> +}
> +
> +
> +do_mount()
> +{
> +	cleanup;
> +
> +	mkdir /dev/memcg 2> /dev/null
> +	mount -t cgroup -omemory memcg /dev/memcg
> +}
> +
> +# Run all the test cases
> +for ((i = 1; i <= $TST_TOTAL; i++))
> +{
> +	export TST_COUNT=$(( $TST_COUNT + 1 ))
> +	cur_id=$i
> +
> +	do_mount;
> +
> +	# prepare
> +	mkdir /dev/memcg/$i 2> /dev/null
> +	cd /dev/memcg/$i
> +
> +	# run the case
> +	testcase_$i
> +
> +	# clean up
> +	sleep 1
> +	cd $TEST_PATH
> +	rmdir /dev/memcg/$i
> +
> +	cleanup;
> +}
> +
> +echo $shmmax > /proc/sys/kernel/shmmax
> +
> +if [ $failed -ne 0 ]; then
> +	exit 1
> +else
> +	exit 0
> +fi
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_getpagesize.c	2009-09-11 10:55:14.000000000 -0400
> @@ -0,0 +1,31 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +int main(void)
> +{
> +	printf("%d\n", getpagesize());
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_process.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_process.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/functional/memcg_process.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/functional/memcg_process.c	2009-09-11 10:55:14.000000000 -0400
> @@ -0,0 +1,319 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <signal.h>
> +#include <err.h>
> +#include <limits.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/shm.h>
> +
> +int fd;
> +
> +int flag_exit;
> +int flag_allocated;
> +
> +int opt_mmap_anon;
> +int opt_mmap_file;
> +int opt_mmap_lock1;
> +int opt_mmap_lock2;
> +int opt_shm;
> +int opt_hugepage;
> +
> +int key_id;		/* used with opt_shm */
> +unsigned long memsize;
> +
> +#define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
> +
> +#define MMAP_ANON	(SCHAR_MAX + 1)
> +#define MMAP_FILE	(SCHAR_MAX + 2)
> +#define MMAP_LOCK1	(SCHAR_MAX + 3)
> +#define MMAP_LOCK2	(SCHAR_MAX + 4)
> +#define SHM		(SCHAR_MAX + 5)
> +#define HUGEPAGE	(SCHAR_MAX + 6)
> +
> +const struct option long_opts[] = {
> +	{ "mmap-anon",	0, NULL, MMAP_ANON	},
> +	{ "mmap-file",	0, NULL, MMAP_FILE	},
> +	{ "mmap-lock1",	0, NULL, MMAP_LOCK1	},
> +	{ "mmap-lock2",	0, NULL, MMAP_LOCK2	},
> +	{ "shm",	0, NULL, SHM		},
> +	{ "hugepage",	0, NULL, HUGEPAGE	},
> +	{ "size",	1, NULL, 's'		},
> +	{ "key",	1, NULL, 'k'		},
> +	{ NULL,		0, NULL, 0		},
> +};
> +
> +/*
> + * process_options: read options from user input
> + */
> +void process_options(int argc, char *argv[])
> +{
> +	int c;
> +	char *end;
> +
> +	while (1) {
> +		c = getopt_long(argc, argv, "s:k:", long_opts, NULL);
> +		if (c == -1)
> +			break;
> +
> +		switch (c) {
> +		case 's':
> +			memsize = strtoul(optarg, &end, 10);
> +			if (*end != '\0')
> +				errx(1, "wrong -s argument!");
> +			break;
> +		case 'k':
> +			key_id = atoi(optarg);
> +			break;
> +		case MMAP_ANON:
> +			opt_mmap_anon = 1;
> +			break;
> +		case MMAP_FILE:
> +			opt_mmap_file = 1;
> +			break;
> +		case MMAP_LOCK1:
> +			opt_mmap_lock1 = 1;
> +			break;
> +		case MMAP_LOCK2:
> +			opt_mmap_lock2 = 1;
> +			break;
> +		case SHM:
> +			opt_shm = 1;
> +			break;
> +		case HUGEPAGE:
> +			opt_hugepage = 1;
> +			break;
> +		default:
> +			errx(1, "unknown option!\n");
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * touch_memory: force allocating phy memory
> + */
> +void touch_memory(char *p, int size)
> +{
> +	int i;
> +	int pagesize = getpagesize();
> +
> +	for (i = 0; i < size; i += pagesize)
> +		p[i] = 0xef;
> +}
> +
> +void mmap_anon()
> +{
> +	static char *p;
> +
> +	if (!flag_allocated) {
> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +		if (p == MAP_FAILED)
> +			err(1, "mmap(anonymous) failed");
> +		touch_memory(p, memsize);
> +	} else {
> +		if (munmap(p, memsize) == -1)
> +			err(1, "munmap(anonymous) failed");
> +	}
> +}
> +
> +void mmap_file()
> +{
> +	static char *p;
> +	static int fd_hugepage;
> +	int fd_tmp;
> +
> +	if (!flag_allocated) {
> +		if (opt_hugepage) {
> +			fd_hugepage = open(FILE_HUGEPAGE,
> +					   O_CREAT | O_RDWR, 0755);
> +			if (fd_hugepage < 0)
> +				err(1, "open hugepage file failed");
> +			fd_tmp = fd_hugepage;
> +		} else
> +			fd_tmp = fd;
> +
> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
> +			 MAP_SHARED, fd_tmp, 0);
> +		if (p == MAP_FAILED) {
> +			if (opt_hugepage)
> +				unlink(FILE_HUGEPAGE);
> +			err(1, "mmap(file) failed");
> +		}
> +		touch_memory(p, memsize);
> +	} else {
> +		if (!munmap(p, memsize) == -1)
> +			err(1, "munmap(file) failed");
> +
> +		if (opt_hugepage) {
> +			close(fd_hugepage);
> +			unlink(FILE_HUGEPAGE);
> +		}
> +	}
> +}
> +
> +void mmap_lock1()
> +{
> +	static char *p;
> +
> +	if (!flag_allocated) {
> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
> +			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0, 0);
> +		if (p == MAP_FAILED)
> +			err(1, "mmap(lock) failed");
> +	} else {
> +		if (munmap(p, memsize) == -1)
> +			err(1, "munmap(lock) failed");
> +	}
> +}
> +
> +void mmap_lock2()
> +{
> +	static char *p;
> +
> +	if (!flag_allocated) {
> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +		if (p == MAP_FAILED)
> +			err(1, "mmap failed");
> +
> +		if (!mlock(p, memsize))
> +			err(1, "mlock failed");
> +	} else {
> +		if (!munmap(p, memsize) == -1)
> +			err(1, "munmap failed");
> +	}
> +}
> +
> +void shm()
> +{
> +	static char *p;
> +	static int shmid;
> +	unsigned long flag;
> +
> +	key_t key;
> +
> +	if (!flag_allocated) {
> +		flag = IPC_CREAT | SHM_R | SHM_W;
> +		if (opt_hugepage)
> +			flag |= SHM_HUGETLB;
> +
> +		key = ftok("/dev/null", key_id);
> +		if (key == -1)
> +			err(1, "ftok() failed\n");
> +
> +		shmid = shmget(key, memsize, flag);
> +		if (shmid == -1)
> +			err(1, "shmget() failed\n");
> +		shmctl(shmid, IPC_RMID, NULL);
> +
> +		shmid = shmget(key, memsize, flag);
> +		if (shmid == -1)
> +			err(1, "shmget() failed\n");
> +
> +		p = shmat(shmid, NULL, 0);
> +		if (p == (void *)-1) {
> +			shmctl(shmid, IPC_RMID, NULL);
> +			err(1, "shmat() failed\n");
> +		}
> +		touch_memory(p, memsize);
> +	} else {
> +		if (shmdt(p) == -1)
> +			err(1, "shmdt() failed\n");
> +		if (shmctl(shmid, IPC_RMID, NULL) == -1)
> +			err(1, "shmctl() failed\n");
> +	}
> +}
> +
> +/*
> + * sigint_handler: handle SIGINT by set the exit flag.
> + */
> +void sigint_handler(int __attribute__((unused)) signo)
> +{
> +	flag_exit = 1;
> +}
> +
> +/*
> + * sigusr_handler: handler SIGUSR
> + *
> + * When we receive SIGUSR, we allocate some memory according
> + * to the user input when the process started.
> + *
> + * When we receive SIGUSR again, we will free all the allocated
> + * memory.
> + */
> +void sigusr_handler(int __attribute__((unused)) signo)
> +{
> +	if (opt_mmap_anon)
> +		mmap_anon();
> +
> +	if (opt_mmap_file)
> +		mmap_file();
> +
> +	if (opt_mmap_lock1)
> +		mmap_lock1();
> +
> +	if (opt_mmap_lock2)
> +		mmap_lock2();
> +
> +	if (opt_shm)
> +		shm();
> +
> +	flag_allocated = !flag_allocated;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct sigaction sigint_action;
> +	struct sigaction sigusr_action;
> +
> +	fd = open("/dev/zero", O_RDWR);
> +	if (fd < 0)
> +		err(1, "open /dev/zero failed");
> +
> +	memset(&sigint_action, 0, sizeof(sigint_action));
> +	sigint_action.sa_handler = &sigint_handler;
> +	sigaction(SIGINT, &sigint_action, NULL);
> +
> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
> +	sigusr_action.sa_handler = &sigusr_handler;
> +	sigaction(SIGUSR1, &sigusr_action, NULL);
> +
> +	process_options(argc, argv);
> +
> +	while (!flag_exit)
> +		sleep(1);
> +
> +	close(fd);
> +
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/Makefile ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/Makefile
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/Makefile	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/Makefile	2009-09-14 08:16:31.000000000 -0400
> @@ -1,16 +1,10 @@
> -CFLAGS += -Wall
> -CPPFLAGS += -I../../../../include -I../libcontrollers
> -LDLIBS += -L../../../../lib/ -lltp
> +SUBDIRS = functional regression stress
> 
> -SRCS    = $(wildcard *.c)
> -
> -TARGETS = $(patsubst %.c,%,$(SRCS))
> -
> -all:    $(TARGETS)
> -
> -clean:
> -	rm -f $(TARGETS) *.o
> +all:
> +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
> 
>  install:
> -	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
> +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
> 
> +clean:
> +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_regression_test.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_regression_test.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_regression_test.sh	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_regression_test.sh	1969-12-31 19:00:00.000000000 -0500
> @@ -1,225 +0,0 @@
> -#! /bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> -##                                                                            ##
> -## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> -##                                                                            ##
> -################################################################################
> -
> -cd $LTPROOT/testcases/bin
> -
> -export TCID="memcg_regression_test"
> -export TST_TOTAL=4
> -export TST_COUNT=1
> -
> -if [ "$USER" != root ]; then
> -	tst_brkm TBROK ignored "Test must be run as root"
> -	exit 0
> -fi
> -
> -tst_kvercmp 2 6 30
> -if [ $? -eq 0 ]; then
> -	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
> -	exit 0
> -fi
> -
> -nr_bug=`dmesg | grep -c "kernel BUG"`
> -nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
> -nr_warning=`dmesg | grep -c "^WARNING"`
> -nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> -
> -# check_kernel_bug - check if some kind of kernel bug happened
> -check_kernel_bug()
> -{
> -	new_bug=`dmesg | grep -c "kernel BUG"`
> -	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
> -	new_warning=`dmesg | grep -c "^WARNING"`
> -	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> -
> -	# no kernel bug is detected
> -	if [ $new_bug -eq $nr_bug -a $new_warning -eq $nr_warning -a \
> -	     $new_null -eq $nr_null -a $new_lockdep -eq $nr_lockdep ]; then
> -		return 1
> -	fi
> -
> -	# some kernel bug is detected
> -	if [ $new_bug -gt $nr_bug ]; then
> -		tst_resm TFAIL "kernel BUG was detected!"
> -	fi
> -	if [ $new_warning -gt $nr_warning ]; then
> -		tst_resm TFAIL "kernel WARNING was detected!"
> -	fi
> -	if [ $new_null -gt $nr_null ]; then
> -		tst_resm "kernel NULL pointer dereference!"
> -	fi
> -	if [ $new_lockdep -gt $nr_lockdep ]; then
> -		tst_resm "kernel lockdep warning was detected!"
> -	fi
> -
> -	nr_bug=$new_bug
> -	nr_null=$new_null
> -	nr_warning=$new_warning
> -	nr_lockdep=$new_lockdep
> -
> -	failed=1
> -	return 0
> -}
> -
> -#---------------------------------------------------------------------------
> -# Bug:    The bug was, while forking mass processes, trigger memcgroup OOM,
> -#         then NULL pointer dereference may be hit.
> -# Kernel: 2.6.25-rcX
> -# Links:  http://lkml.org/lkml/2008/4/14/38
> -# Fix:    commit e115f2d89253490fb2dbf304b627f8d908df26f1
> -#---------------------------------------------------------------------------
> -test_1()
> -{
> -	mkdir memcg/0/
> -	echo 0 > memcg/0/memory.limit_in_bytes
> -
> -	./memcg_test_1
> -
> -	rmdir memcg/0/
> -
> -	check_kernel_bug
> -	if [ $? -eq 1 ]; then
> -		tst_resm TPASS "no kernel bug was found"
> -	fi
> -}
> -
> -#---------------------------------------------------------------------------
> -# Bug:    Shrink memory might never return, unless send signal to stop it.
> -# Kernel: 2.6.29
> -# Links:  http://marc.info/?t=123199973900003&r=1&w=2
> -#         http://lkml.org/lkml/2009/2/3/72
> -# Fix:    81d39c20f5ee2437d71709beb82597e2a38efbbc
> -#---------------------------------------------------------------------------
> -test_2()
> -{
> -	./memcg_test_2 &
> -	pid1=$!
> -	sleep 1
> -
> -	mkdir memcg/0
> -	echo $pid1 > memcg/0/tasks
> -
> -	# let pid1 'test_2' allocate memory
> -	/bin/kill -SIGUSR1 $pid1
> -	sleep 1
> -
> -	# shrink memory
> -	echo 1 > memcg/0/memory.limit_in_bytes 2>&1 &
> -	pid2=$!
> -
> -	# check if 'echo' will exit and exit with failure
> -	for tmp in $(seq 0 4); do
> -		sleep 1
> -		ps -p $! > /dev/null
> -		if [ $? -ne 0 ]; then
> -			wait $pid2
> -			if [ $? -eq 0 ]; then
> -				tst_resm TFAIL "echo should return failure"
> -				failed=1
> -				kill -9 $pid1 $pid2 > /dev/null 2>&1
> -				wait $pid1 $pid2
> -				rmdir memcg/0
> -			fi
> -			break
> -		fi
> -	done
> -
> -	if [ $tmp -eq 5 ]; then
> -		tst_resm TFAIL "'echo' doesn't exit!"
> -		failed=1
> -	else
> -		tst_resm TPASS "EBUSY was returned as expected"
> -	fi
> -
> -	kill -9 $pid1 $pid2 > /dev/null 2>&1
> -	wait $pid1 $pid2 > /dev/null 2>&1
> -	rmdir memcg/0
> -}
> -
> -#---------------------------------------------------------------------------
> -# Bug:    crash when rmdir a cgroup on IA64
> -# Kernel: 2.6.29-rcX
> -# Links:  http://marc.info/?t=123235660300001&r=1&w=2
> -# Fix:    commit 299b4eaa302138426d5a9ecd954de1f565d76c94
> -#---------------------------------------------------------------------------
> -test_3()
> -{
> -	mkdir memcg/0
> -	for pid in `cat memcg/tasks`; do
> -		echo $pid > memcg/0/tasks 2> /dev/null
> -	done
> -
> -	for pid in `cat memcg/0/tasks`; do
> -		echo $pid > memcg/tasks 2> /dev/null
> -	done
> -	rmdir memcg/0
> -
> -	check_kernel_bug
> -	if [ $? -eq 1 ]; then
> -		tst_resm TPASS "no kernel bug was found"
> -	fi
> -}
> -
> -#---------------------------------------------------------------------------
> -# Bug:    the memcg's refcnt handling at swapoff was wrong, causing crash
> -# Kernel: 2.6.29-rcX
> -# Links:  http://marc.info/?t=123208656300004&r=1&w=2
> -# Fix:    commit 85d9fc89fb0f0703df6444f260187c088a8d59ff
> -#---------------------------------------------------------------------------
> -test_4()
> -{
> -	./memcg_test_4.sh
> -
> -	check_kernel_bug
> -	if [ $? -eq 1 ]; then
> -		tst_resm TPASS "no kernel bug was found"
> -	fi
> -
> -	# test_4.sh might be killed by oom, so do clean up here
> -	killall -9 memcg_test_4 2> /dev/null
> -	killall -9 memcg_test_4.sh 2> /dev/null
> -	swapon -a
> -}
> -
> -# main
> -
> -mkdir memcg/
> -
> -for cur in $(seq 1 $TST_TOTAL); do
> -	export TST_COUNT=$cur
> -
> -	mount -t cgroup -o memory xxx memcg/
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "failed to mount memory subsytem"
> -		continue
> -	fi
> -
> -	test_$cur
> -
> -	umount memcg/
> -done
> -
> -rmdir memcg/
> -
> -exit $failed
> -
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_1.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_1.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_1.c	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_1.c	1969-12-31 19:00:00.000000000 -0500
> @@ -1,71 +0,0 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/*                                                                            */
> -/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> -/*                                                                            */
> -/******************************************************************************/
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -
> -#define MAP_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED)
> -
> -#define LOOP		40
> -
> -int main(void)
> -{
> -	char buf[10];
> -	int i;
> -	int loop;
> -	int pid;
> -	int size = getpagesize();
> -	int fd = open("memcg/0/tasks", O_WRONLY);
> -
> -	if (fd < 0)
> -		return 1;
> -
> -	for (loop = 0; loop < LOOP; loop++) {
> -		for (i = 0; i < 10; i++) {
> -			pid = fork();
> -			if (pid == 0) {
> -				char *p;
> -
> -				sprintf(buf, "%d", getpid());
> -				write(fd, buf, 10);
> -				fsync(fd);
> -
> -				p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> -					 MAP_FLAGS, 0, 0);
> -
> -				return 0;
> -			}
> -		}
> -
> -		for (i = 0; i < 10; i++)
> -			wait(NULL);
> -	}
> -
> -	close(fd);
> -
> -	return 0;
> -}
> -
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_2.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_2.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_2.c	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_2.c	1969-12-31 19:00:00.000000000 -0500
> @@ -1,53 +0,0 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/*                                                                            */
> -/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> -/*                                                                            */
> -/******************************************************************************/
> -
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <sys/mman.h>
> -#include <signal.h>
> -
> -void sigusr_handler(int __attribute__((unused)) signo)
> -{
> -	char *p;
> -	int size = getpagesize() * 2;
> -
> -	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> -		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0, 0);
> -	if (p == MAP_FAILED)
> -		exit(1);
> -}
> -
> -int main(void)
> -{
> -	struct sigaction sigusr_action;
> -
> -	memset(&sigusr_action, 0, sizeof(sigusr_action));
> -	sigusr_action.sa_handler = &sigusr_handler;
> -	sigaction(SIGUSR1, &sigusr_action, NULL);
> -
> -	while (1)
> -		sleep(1);
> -
> -	return 0;
> -}
> -
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_4.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_4.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_4.c	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_4.c	1969-12-31 19:00:00.000000000 -0500
> @@ -1,62 +0,0 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/*                                                                            */
> -/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> -/*                                                                            */
> -/******************************************************************************/
> -
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <sys/mman.h>
> -
> -#define MEM_SIZE	(1024 * 1024 * 100)
> -
> -void sigusr_handler(int __attribute__((unused)) signo)
> -{
> -	char *p;
> -	int i;
> -	int pagesize = getpagesize();
> -
> -	p = mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE,
> -		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -	if (p == MAP_FAILED) {
> -		fprintf(stderr, "failed to allocate memory!\n");
> -		exit(1);
> -	}
> -
> -	for (i = 0; i < MEM_SIZE; i += pagesize)
> -		p[i] = 'z';
> -}
> -
> -int main(void)
> -{
> -	struct sigaction sigusr_action;
> -
> -	memset(&sigusr_action, 0, sizeof(sigusr_action));
> -	sigusr_action.sa_handler = &sigusr_handler;
> -	sigaction(SIGUSR1, &sigusr_action, NULL);
> -
> -	while (1)
> -		sleep(1);
> -
> -	return 0;
> -}
> -
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_4.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_4.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/memcg_test_4.sh	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/memcg_test_4.sh	1969-12-31 19:00:00.000000000 -0500
> @@ -1,48 +0,0 @@
> -#! /bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> -##                                                                            ##
> -## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> -##                                                                            ##
> -################################################################################
> -
> -# attach current task to memcg/0/
> -mkdir memcg/0
> -echo $$ > memcg/0/tasks
> -
> -./memcg_test_4 &
> -pid=$!
> -sleep 1
> -
> -# let $pid allocate 100M memory
> -/bin/kill -SIGUSR1 $pid
> -sleep 1
> -
> -# shrink memory, and then 80M will be swapped
> -echo 40M > memcg/0/memory.limit_in_bytes
> -
> -# turn off swap, and swapoff will be killed
> -swapoff -a
> -sleep 1
> -echo $pid > memcg/tasks 2> /dev/null
> -echo $$ > memcg/tasks 2> /dev/null
> -
> -# now remove the cgroup
> -rmdir memcg/0
> -
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/README ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/README
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/README	2009-08-31 01:15:54.000000000 -0400
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/README	2009-09-11 11:15:35.000000000 -0400
> @@ -3,7 +3,47 @@ TEST SUITE:
>  The directory memcg contains the tests related to memory resource controller.
>  Those testcases can reproduce bugs we found.
> 
> +There are total 44 testcases that have been added. These testcases
> +contain the regression test, basis operation test and stress test of memctl.
> +
> +NOTE: the test can be run by root only.
> +
>  TESTS AIM:
> 
> -The aim of the tests is to track any future regressions.
> +The aim of the tests is to track any future regressions, test the functionality
> +of memctl..
> +
> +FILES DESCRIPTION:
> +
> +functional/memcgroup_function_test.sh
> +--------------------
> +This script runs all the 38 testcases of basis operation.
> +
> +functional/memcgroup_getpagesize.c
> +--------------------
> +The program gets page size through getpagesize().
> +
> +functional/memcgroup_process.c
> +--------------------
> +The program allocates some memory according to the user input when received SIGUSR.
> +And, it frees all the allocated when received SIGUSR again.
> +
> +stress/memcgroup_stress_test.sh
> +--------------------
> +This script runs all the 2 testcases of stress test.
> +
> +stress/memcgroup_process_stress.c
> +--------------------
> +The program allocates some memory in a specified time period when received SIGUSR. 
> +
> +regression/memcg_regression_test.sh
> +--------------------
> +This script runs all the 4 testcases of regression test.
> +
> +regression/memcg_test_*.c/sh
> +--------------------
> +The programs run each regression test.
> 
> +README
> +------
> +The one you have gone through.
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/Makefile ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/Makefile
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/Makefile	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/Makefile	2009-09-11 11:05:40.000000000 -0400
> @@ -0,0 +1,16 @@
> +CFLAGS += -Wall
> +CPPFLAGS += -I../../../../../include -I../../libcontrollers
> +LDLIBS += -L../../../../../lib/ -lltp
> +
> +SRCS    = $(wildcard *.c)
> +
> +TARGETS = $(patsubst %.c,%,$(SRCS))
> +
> +all:    $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS) *.o
> +
> +install:
> +	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../../bin/$$i ; chmod +x $$i ; done
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	2009-08-31 01:15:54.000000000 -0400
> @@ -0,0 +1,225 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> +##                                                                            ##
> +################################################################################
> +
> +cd $LTPROOT/testcases/bin
> +
> +export TCID="memcg_regression_test"
> +export TST_TOTAL=4
> +export TST_COUNT=1
> +
> +if [ "$USER" != root ]; then
> +	tst_brkm TBROK ignored "Test must be run as root"
> +	exit 0
> +fi
> +
> +tst_kvercmp 2 6 30
> +if [ $? -eq 0 ]; then
> +	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
> +	exit 0
> +fi
> +
> +nr_bug=`dmesg | grep -c "kernel BUG"`
> +nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
> +nr_warning=`dmesg | grep -c "^WARNING"`
> +nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> +
> +# check_kernel_bug - check if some kind of kernel bug happened
> +check_kernel_bug()
> +{
> +	new_bug=`dmesg | grep -c "kernel BUG"`
> +	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
> +	new_warning=`dmesg | grep -c "^WARNING"`
> +	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
> +
> +	# no kernel bug is detected
> +	if [ $new_bug -eq $nr_bug -a $new_warning -eq $nr_warning -a \
> +	     $new_null -eq $nr_null -a $new_lockdep -eq $nr_lockdep ]; then
> +		return 1
> +	fi
> +
> +	# some kernel bug is detected
> +	if [ $new_bug -gt $nr_bug ]; then
> +		tst_resm TFAIL "kernel BUG was detected!"
> +	fi
> +	if [ $new_warning -gt $nr_warning ]; then
> +		tst_resm TFAIL "kernel WARNING was detected!"
> +	fi
> +	if [ $new_null -gt $nr_null ]; then
> +		tst_resm "kernel NULL pointer dereference!"
> +	fi
> +	if [ $new_lockdep -gt $nr_lockdep ]; then
> +		tst_resm "kernel lockdep warning was detected!"
> +	fi
> +
> +	nr_bug=$new_bug
> +	nr_null=$new_null
> +	nr_warning=$new_warning
> +	nr_lockdep=$new_lockdep
> +
> +	failed=1
> +	return 0
> +}
> +
> +#---------------------------------------------------------------------------
> +# Bug:    The bug was, while forking mass processes, trigger memcgroup OOM,
> +#         then NULL pointer dereference may be hit.
> +# Kernel: 2.6.25-rcX
> +# Links:  http://lkml.org/lkml/2008/4/14/38
> +# Fix:    commit e115f2d89253490fb2dbf304b627f8d908df26f1
> +#---------------------------------------------------------------------------
> +test_1()
> +{
> +	mkdir memcg/0/
> +	echo 0 > memcg/0/memory.limit_in_bytes
> +
> +	./memcg_test_1
> +
> +	rmdir memcg/0/
> +
> +	check_kernel_bug
> +	if [ $? -eq 1 ]; then
> +		tst_resm TPASS "no kernel bug was found"
> +	fi
> +}
> +
> +#---------------------------------------------------------------------------
> +# Bug:    Shrink memory might never return, unless send signal to stop it.
> +# Kernel: 2.6.29
> +# Links:  http://marc.info/?t=123199973900003&r=1&w=2
> +#         http://lkml.org/lkml/2009/2/3/72
> +# Fix:    81d39c20f5ee2437d71709beb82597e2a38efbbc
> +#---------------------------------------------------------------------------
> +test_2()
> +{
> +	./memcg_test_2 &
> +	pid1=$!
> +	sleep 1
> +
> +	mkdir memcg/0
> +	echo $pid1 > memcg/0/tasks
> +
> +	# let pid1 'test_2' allocate memory
> +	/bin/kill -SIGUSR1 $pid1
> +	sleep 1
> +
> +	# shrink memory
> +	echo 1 > memcg/0/memory.limit_in_bytes 2>&1 &
> +	pid2=$!
> +
> +	# check if 'echo' will exit and exit with failure
> +	for tmp in $(seq 0 4); do
> +		sleep 1
> +		ps -p $! > /dev/null
> +		if [ $? -ne 0 ]; then
> +			wait $pid2
> +			if [ $? -eq 0 ]; then
> +				tst_resm TFAIL "echo should return failure"
> +				failed=1
> +				kill -9 $pid1 $pid2 > /dev/null 2>&1
> +				wait $pid1 $pid2
> +				rmdir memcg/0
> +			fi
> +			break
> +		fi
> +	done
> +
> +	if [ $tmp -eq 5 ]; then
> +		tst_resm TFAIL "'echo' doesn't exit!"
> +		failed=1
> +	else
> +		tst_resm TPASS "EBUSY was returned as expected"
> +	fi
> +
> +	kill -9 $pid1 $pid2 > /dev/null 2>&1
> +	wait $pid1 $pid2 > /dev/null 2>&1
> +	rmdir memcg/0
> +}
> +
> +#---------------------------------------------------------------------------
> +# Bug:    crash when rmdir a cgroup on IA64
> +# Kernel: 2.6.29-rcX
> +# Links:  http://marc.info/?t=123235660300001&r=1&w=2
> +# Fix:    commit 299b4eaa302138426d5a9ecd954de1f565d76c94
> +#---------------------------------------------------------------------------
> +test_3()
> +{
> +	mkdir memcg/0
> +	for pid in `cat memcg/tasks`; do
> +		echo $pid > memcg/0/tasks 2> /dev/null
> +	done
> +
> +	for pid in `cat memcg/0/tasks`; do
> +		echo $pid > memcg/tasks 2> /dev/null
> +	done
> +	rmdir memcg/0
> +
> +	check_kernel_bug
> +	if [ $? -eq 1 ]; then
> +		tst_resm TPASS "no kernel bug was found"
> +	fi
> +}
> +
> +#---------------------------------------------------------------------------
> +# Bug:    the memcg's refcnt handling at swapoff was wrong, causing crash
> +# Kernel: 2.6.29-rcX
> +# Links:  http://marc.info/?t=123208656300004&r=1&w=2
> +# Fix:    commit 85d9fc89fb0f0703df6444f260187c088a8d59ff
> +#---------------------------------------------------------------------------
> +test_4()
> +{
> +	./memcg_test_4.sh
> +
> +	check_kernel_bug
> +	if [ $? -eq 1 ]; then
> +		tst_resm TPASS "no kernel bug was found"
> +	fi
> +
> +	# test_4.sh might be killed by oom, so do clean up here
> +	killall -9 memcg_test_4 2> /dev/null
> +	killall -9 memcg_test_4.sh 2> /dev/null
> +	swapon -a
> +}
> +
> +# main
> +
> +mkdir memcg/
> +
> +for cur in $(seq 1 $TST_TOTAL); do
> +	export TST_COUNT=$cur
> +
> +	mount -t cgroup -o memory xxx memcg/
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "failed to mount memory subsytem"
> +		continue
> +	fi
> +
> +	test_$cur
> +
> +	umount memcg/
> +done
> +
> +rmdir memcg/
> +
> +exit $failed
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_1.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_1.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_1.c	2009-08-31 01:15:54.000000000 -0400
> @@ -0,0 +1,71 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#define MAP_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED)
> +
> +#define LOOP		40
> +
> +int main(void)
> +{
> +	char buf[10];
> +	int i;
> +	int loop;
> +	int pid;
> +	int size = getpagesize();
> +	int fd = open("memcg/0/tasks", O_WRONLY);
> +
> +	if (fd < 0)
> +		return 1;
> +
> +	for (loop = 0; loop < LOOP; loop++) {
> +		for (i = 0; i < 10; i++) {
> +			pid = fork();
> +			if (pid == 0) {
> +				char *p;
> +
> +				sprintf(buf, "%d", getpid());
> +				write(fd, buf, 10);
> +				fsync(fd);
> +
> +				p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +					 MAP_FLAGS, 0, 0);
> +
> +				return 0;
> +			}
> +		}
> +
> +		for (i = 0; i < 10; i++)
> +			wait(NULL);
> +	}
> +
> +	close(fd);
> +
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_2.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_2.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_2.c	2009-08-31 01:15:54.000000000 -0400
> @@ -0,0 +1,53 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <signal.h>
> +
> +void sigusr_handler(int __attribute__((unused)) signo)
> +{
> +	char *p;
> +	int size = getpagesize() * 2;
> +
> +	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0, 0);
> +	if (p == MAP_FAILED)
> +		exit(1);
> +}
> +
> +int main(void)
> +{
> +	struct sigaction sigusr_action;
> +
> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
> +	sigusr_action.sa_handler = &sigusr_handler;
> +	sigaction(SIGUSR1, &sigusr_action, NULL);
> +
> +	while (1)
> +		sleep(1);
> +
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_4.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_4.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_4.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_4.c	2009-08-31 01:15:54.000000000 -0400
> @@ -0,0 +1,62 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +
> +#define MEM_SIZE	(1024 * 1024 * 100)
> +
> +void sigusr_handler(int __attribute__((unused)) signo)
> +{
> +	char *p;
> +	int i;
> +	int pagesize = getpagesize();
> +
> +	p = mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE,
> +		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (p == MAP_FAILED) {
> +		fprintf(stderr, "failed to allocate memory!\n");
> +		exit(1);
> +	}
> +
> +	for (i = 0; i < MEM_SIZE; i += pagesize)
> +		p[i] = 'z';
> +}
> +
> +int main(void)
> +{
> +	struct sigaction sigusr_action;
> +
> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
> +	sigusr_action.sa_handler = &sigusr_handler;
> +	sigaction(SIGUSR1, &sigusr_action, NULL);
> +
> +	while (1)
> +		sleep(1);
> +
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh	2009-08-31 01:15:54.000000000 -0400
> @@ -0,0 +1,48 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> +##                                                                            ##
> +################################################################################
> +
> +# attach current task to memcg/0/
> +mkdir memcg/0
> +echo $$ > memcg/0/tasks
> +
> +./memcg_test_4 &
> +pid=$!
> +sleep 1
> +
> +# let $pid allocate 100M memory
> +/bin/kill -SIGUSR1 $pid
> +sleep 1
> +
> +# shrink memory, and then 80M will be swapped
> +echo 40M > memcg/0/memory.limit_in_bytes
> +
> +# turn off swap, and swapoff will be killed
> +swapoff -a
> +sleep 1
> +echo $pid > memcg/tasks 2> /dev/null
> +echo $$ > memcg/tasks 2> /dev/null
> +
> +# now remove the cgroup
> +rmdir memcg/0
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/Makefile ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/Makefile
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/Makefile	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/Makefile	2009-09-11 11:06:05.000000000 -0400
> @@ -0,0 +1,23 @@
> +CFLAGS += -Wall -O2 -g -Wextra
> +LDLIBS += -lm
> +
> +SRCS=$(wildcard *.c)
> +OBJECTS=$(patsubst %.c,%.o,$(SRCS))
> +TARGETS=$(patsubst %.c,%,$(SRCS))
> +
> +all: $(TARGETS)
> +
> +$(TARGETS): %: %.o
> +
> +install:
> +	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../../bin/$$i ; chmod +x $$i ; done
> +
> +test:
> +	@./memcgroup_stress_test.sh
> +
> +clean:
> +	rm -f $(TARGETS) $(OBJECTS)
> +
> +uninstall:
> +
> +.DEFAULT: ;
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c	2009-09-11 10:55:14.000000000 -0400
> @@ -0,0 +1,109 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <err.h>
> +#include <math.h>
> +#include <sys/mman.h>
> +
> +int flag_exit;
> +int flag_ready;
> +
> +int interval;
> +unsigned long memsize;
> +
> +char **pages;
> +int nr_page;
> +
> +void touch_memory()
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_page; i++)
> +		pages[i][0] = 0xef;
> +}
> +
> +void sigusr_handler(int __attribute__((unused)) signo)
> +{
> +	int i;
> +	int pagesize = getpagesize();
> +
> +	nr_page = ceil((double)memsize / pagesize);
> +
> +	pages = calloc(nr_page, sizeof(char *));
> +	if (pages == NULL)
> +		errx(1, "calloc() failed");
> +
> +	for (i = 0; i < nr_page; i++) {
> +		pages[i] = mmap(NULL, pagesize, PROT_WRITE | PROT_READ,
> +				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +		if (pages[i] == MAP_FAILED)
> +			err(1, "map() failed\n");
> +	}
> +
> +	flag_ready = 1;
> +}
> +
> +void sigint_handler(int __attribute__((unused)) signo)
> +{
> +	flag_exit = 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *end;
> +	struct sigaction sigint_action;
> +	struct sigaction sigusr_action;
> +
> +	if (argc != 3)
> +		errx(1, "Wrong argument num");
> +
> +	memsize = strtoul(argv[1], &end, 10);
> +	if (*end != '\0')
> +		errx(1, "wrong memsize");
> +	memsize = memsize * 1024 * 1024;
> +
> +	interval = atoi(argv[2]);
> +	if (interval <= 0)
> +		interval = 1;
> +
> +	memset(&sigint_action, 0, sizeof(sigint_action));
> +	sigint_action.sa_handler = &sigint_handler;
> +	sigaction(SIGINT, &sigint_action, NULL);
> +
> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
> +	sigusr_action.sa_handler = &sigusr_handler;
> +	sigaction(SIGUSR1, &sigusr_action, NULL);
> +
> +	while (!flag_exit) {
> +		sleep(interval);
> +
> +		if (flag_ready)
> +			touch_memory();
> +	};
> +
> +	return 0;
> +}
> +
> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090831.memcg/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2009-09-12 12:26:12.000000000 -0400
> @@ -0,0 +1,125 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
> +##                                                                            ##
> +################################################################################
> +
> +cd $LTPROOT/testcases/bin
> +export TCID="memcg_stress_test"
> +export TST_TOTAL=2
> +export TST_COUNT=0
> +
> +grep -w memory /proc/cgroups 2>&1 > /dev/null
> +if [ $? -ne 0 ]; then
> +	echo "WARNING:";
> +	echo "Kernel does not support for memory resource controller";
> +	echo "Skipping all memcgroup testcases....";
> +	exit 0
> +fi
> +
> +RUN_TIME=$(( 60 * 60 ))
> +
> +cleanup()
> +{
> +	if [ -e /dev/memcg ]; then
> +		umount /dev/memcg 2>/dev/null
> +		rmdir /dev/memcg 2>/dev/null
> +	fi
> +}
> +
> +
> +do_mount()
> +{
> +	cleanup;
> +
> +	mkdir /dev/memcg 2> /dev/null
> +	mount -t cgroup -omemory memcg /dev/memcg
> +}
> +
> +
> +# Run the stress test
> +#
> +# $1 - Number of cgroups
> +# $2 - Allocated how much memory in one process? in MB
> +# $3 - The interval to touch memory in a process
> +# $4 - How long does this test run ? in second
> +run_stress()
> +{
> +	do_mount;
> +
> +	for ((i = 0; i < $1; i++))
> +	{
> +		mkdir /memcg/$i 2> /dev/null
> +		./memcg_process_stress $2 $3 &
> +		pid[$i]=$!
> +
> +		echo ${pid[$i]} > /memcg/$i/tasks
> +	}
> +
> +	for ((i = 0; i < $1; i++))
> +	{
> +		/bin/kill -s SIGUSR1 ${pid[$i]} 2> /dev/null
> +	}
> +
> +	sleep $4
> +
> +	for ((i = 0; i < $1; i++))
> +	{
> +		/bin/kill -s SIGINT ${pid[$i]} 2> /dev/null
> +		wait ${pid[$i]}
> +
> +		rmdir /memcg/$i 2> /dev/null
> +	}
> +
> +	cleanup;
> +}
> +
> +testcase_1()
> +{
> +	run_stress 150 $(( ($mem-150) / 150 )) 10 $RUN_TIME
> +
> +	tst_resm TPASS "stress test 1 passed"
> +}
> +
> +testcase_2()
> +{
> +	run_stress 1 $mem 10 $RUN_TIME
> +
> +	tst_resm TPASS "stress test 2 passed"
> +}
> +
> +echo 3 > /proc/sys/vm/drop_caches
> +sleep 2
> +mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
> +swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> +
> +mem=$(( $mem_free + $swap_free / 2 ))
> +mem=$(( mem / 1024 ))
> +
> +date
> +export TST_COUNT=$(( $TST_COUNT + 1 ))
> +testcase_1
> +export TST_COUNT=$(( $TST_COUNT + 1 ))
> +testcase_2
> +date
> +
> +exit 0


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
