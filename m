Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1MmyiJ-0000go-9Q
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 23:42:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MmyiC-0000aC-Ji
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 23:42:35 +0000
Message-ID: <4AAD8329.7080402@cn.fujitsu.com>
Date: Mon, 14 Sep 2009 07:41:29 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AA72EC0.2000404@cn.fujitsu.com>	
	<1252483110.5006.25.camel@subratamodak.linux.ibm.com>
	<1252847816.5357.38.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1252847816.5357.38.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add new testcases for memcgroup
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Dhaval Giani <dhaval@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <balbir@in.ibm.com>

Subrata Modak wrote:
> Hi Shi,
> 
> On Wed, 2009-09-09 at 13:28 +0530, Subrata Modak wrote: 
>> Hi Shi,
>>
>> Thanks once again for contributing the Memcgroup functional and Stress
>> tests. Please find some of my comments below:
> 
> Would you like to resubmit the patch once again addressing the comments
> below ?

Yes. I am busy for other works, but will send you a new patch based on your 
comments in this week, maybe today or tomorrow.


--
Regards
Shi Weihua

> 
> Regards--
> Subrata
> 
>> On Wed, 2009-09-09 at 12:27 +0800, Shi Weihua wrote:
>>> My workmate Li Zefan (lizf@cn.fujitsu.com) has created some testcases for 
>>> cgroup's subsystem "memory" in the last year. And, He catched some kernel bugs 
>>> through these testcases. So we think you glad to push them into LTP.
>>>
>>> There are total 40 testcases that have been added. These testcases contain 
>>> the basis operation test, part functionality test and stress test of memcgroup.
>>>
>>> How to run this test:
>>> 	# runltp -f controllers
>>>
>>> Result:
>>> memcgroup_function_test    1  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test    2  TPASS  :  rss=0/0, cache=4096/4096
>>> memcgroup_function_test    3  TPASS  :  rss=0/0, cache=4096/4096
>>> memcgroup_function_test    4  TPASS  :  rss=4096/4096, cache=8192/8192
>>> memcgroup_function_test    5  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test    6  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test    6  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test    7  TPASS  :  rss=0/0, cache=4096/4096
>>> memcgroup_function_test    7  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test    8  TPASS  :  rss=0/0, cache=4096/4096
>>> memcgroup_function_test    8  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test    9  TPASS  :  rss=4096/4096, cache=8192/8192
>>> memcgroup_function_test    9  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test   10  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test   10  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test   11  TPASS  :  failcnt=6
>>> memcgroup_function_test   12  TPASS  :  failcnt=6
>>> memcgroup_function_test   13  TPASS  :  failcnt=6
>>> memcgroup_function_test   14  TPASS  :  process 5793 is killed
>>> memcgroup_function_test   15  TPASS  :  process 5803 is killed
>>> memcgroup_function_test   16  TPASS  :  process 5813 is killed
>>> memcgroup_function_test   17  TPASS  :  process 5824 is killed
>>> memcgroup_function_test   18  TPASS  :  process 5835 is killed
>>> memcgroup_function_test   19  TPASS  :  process 5845 is killed
>>> memcgroup_function_test   20  TPASS  :  process 5854 is killed
>>> memcgroup_function_test   21  TPASS  :  process 5863 is killed
>>> memcgroup_function_test   22  TPASS  :  input=4095, limit_in_bytes=4096
>>> memcgroup_function_test   23  TPASS  :  input=4097, limit_in_bytes=8192
>>> memcgroup_function_test   24  TPASS  :  input=1, limit_in_bytes=4096
>>> memcgroup_function_test   25  TPASS  :  return value is 0
>>> memcgroup_function_test   26  TPASS  :  return value is 1
>>> memcgroup_function_test   27  TPASS  :  return value is 1
>>> memcgroup_function_test   28  TPASS  :  return value is 1
>>> memcgroup_function_test   29  TPASS  :  force memory succeeded
>>> memcgroup_function_test   30  TPASS  :  force memory failed as expected
>>> memcgroup_function_test   31  TPASS  :  return value is 0
>>> memcgroup_function_test   32  TPASS  :  return value is 0
>>> memcgroup_function_test   33  TPASS  :  return value is 0
>>> memcgroup_function_test   34  TPASS  :  return value is 0
>>> memcgroup_function_test   35  TPASS  :  return value is 1
>>> memcgroup_function_test   36  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test   36  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test   37  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test   37  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_function_test   38  TPASS  :  rss=4096/4096, cache=0/0
>>> memcgroup_function_test   38  TPASS  :  rss=0/0, cache=0/0
>>> memcgroup_stress_test      1  TPASS  :  stress test 1 passed
>>> memcgroup_stress_test      2  TPASS  :  stress test 2 passed
>>> INFO: ltp-pan reported all tests PASS
>>>
>>> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>>> ---
>>> diff -urpN ltp-full-20090831.orig/runtest/controllers ltp-full-20090831.memcgroup/runtest/controllers
>>> --- ltp-full-20090831.orig/runtest/controllers	2009-08-31 01:15:37.000000000 -0400
>>> +++ ltp-full-20090831.memcgroup/runtest/controllers	2009-09-07 17:51:12.000000000 -0400
>>> @@ -2,4 +2,6 @@
>>>  cgroup		cgroup_regression_test.sh
>>>  memcg		memcg_regression_test.sh
>>>  cgroup_fj	run_cgroup_test_fj.sh
>>> +memcgroup_function	memcgroup_function_test.sh
>>> +memcgroup_stress	memcgroup_stress_test.sh
>>>  controllers	test_controllers.sh
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/Makefile ltp-full-20090831.memcgroup/testcases/kernel/controllers/Makefile
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/Makefile	2009-09-07 18:14:49.000000000 -0400
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/Makefile	2009-09-07 18:15:49.000000000 -0400
>>> @@ -17,6 +17,7 @@ SUBDIRS += cgroup_fj
>>>  SUBDIRS += cpuctl
>>>  SUBDIRS += cpuctl_fj
>>>  SUBDIRS += memctl
>>> +SUBDIRS += memcgroup
>> Is it necessary to create a separate sub-directory called 'memcgroup'
>> when 'memcg' already exists. Can you please merge your present tests
>> under some common directory like:
>>
>>      1. move "controllers/memcg" to "controllers/memcg/regression",
>>      2. Create "controllers/memcg/functional", and
>>      3. Create "controllers/memcg/stress", to put the new tests,
>>
>> There is one major anomaly. The tests seems to create something like:
>>
>> # ls /memcg/
>> 0    105  112  12   127  134  141  149  21  29  36  43  50  58  65  72
>> 8   87  94                  memory.limit_in_bytes
>> memory.usage_in_bytes
>> 1    106  113  120  128  135  142  15   22  3   37  44  51  59  66  73
>> 80  88  95                  memory.max_usage_in_bytes
>> memory.use_hierarchy
>> 10   107  114  121  129  136  143  16   23  30  38  45  52  6   67  74
>> 81  89  96                  memory.memsw.failcnt
>> notify_on_release
>> 100  108  115  122  13   137  144  17   24  31  39  46  53  60  68  75
>> 82  9   97                  memory.memsw.limit_in_bytes
>> release_agent
>> 101  109  116  123  130  138  145  18   25  32  4   47  54  61  69  76
>> 83  90  98                  memory.memsw.max_usage_in_bytes  tasks
>> 102  11   117  124  131  139  146  19   26  33  40  48  55  62  7   77
>> 84  91  99                  memory.memsw.usage_in_bytes
>> 103  110  118  125  132  14   147  2    27  34  41  49  56  63  70  78
>> 85  92  memory.failcnt      memory.stat
>> 104  111  119  126  133  140  148  20   28  35  42  5   57  64  71  79
>> 86  93  memory.force_empty  memory.swappiness
>>
>> which are not cleaned up even after the tests have completed execution.
>> This is making the tests fail when it is run again. So, please clean
>> this up:
>>
>>      1. After normal test run,
>>      2. Check before the actual test run if it exists (if the earlier
>>         tests was abruptly terminated leaving these directories dirty),
>>         and cleanup before the tests begin,
>>
>> Following is the test results for the new tests that you are proposing
>> to be added on my machine:
>>
>> # uname -a
>> Linux 2.6.30-gcov #1 SMP Tue Aug 25 20:49:10 IST 2009 i686 i686 i386
>> GNU/Linux,
>>
>> Please also find my comments inlined:
>> ==================================================================================================
>> <<<test_start>>>
>> tag=memcgroup_function stime=1252484293
>> cmdline="    memcgroup_function_test.sh"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> memcgroup_function_test    1  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test    2  TPASS  :  rss=0/0, cache=4096/4096
>> memcgroup_function_test    3  TPASS  :  rss=0/0, cache=4096/4096
>> memcgroup_function_test    4  TPASS  :  rss=4096/4096, cache=8192/8192
>> memcgroup_function_test    5  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test    6  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test    6  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test    7  TPASS  :  rss=0/0, cache=4096/4096
>> memcgroup_function_test    7  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test    8  TPASS  :  rss=0/0, cache=4096/4096
>> memcgroup_function_test    8  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test    9  TPASS  :  rss=4096/4096, cache=8192/8192
>> memcgroup_function_test    9  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test   10  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test   10  TPASS  :  rss=0/0, cache=0/0
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 104:  5676 Killed                  $TEST_PATH/memcgroup_process $1 -s $2
>> kill 5676: No such process
>> kill 5676: No such process
>> memcgroup_function_test   11  TPASS  :  failcnt=6
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 104:  5688 Killed                  $TEST_PATH/memcgroup_process $1 -s $2
>> kill 5688: No such process
>> kill 5688: No such process
>> memcgroup_function_test   12  TPASS  :  failcnt=6
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 104:  5700 Killed                  $TEST_PATH/memcgroup_process $1 -s $2
>> kill 5700: No such process
>> kill 5700: No such process
>> memcgroup_function_test   13  TPASS  :  failcnt=6
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5712 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   14  TPASS  :  process 5712 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5721 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   15  TPASS  :  process 5721 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5733 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   16  TPASS  :  process 5733 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5744 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   17  TPASS  :  process 5744 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5755 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   18  TPASS  :  process 5755 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5765 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   19  TPASS  :  process 5765 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5774 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>> memcgroup_function_test   20  TPASS  :  process 5774 is killed
>> /root/subrata/ltp/ltp-full-20090831/testcases/bin/memcgroup_function_test.sh: line 141:  5783 Killed                  $TEST_PATH/memcgroup_process $2 -s $3
>>
>> *** ....<Can the above messages be appropriately handled ??>....
>>
>> memcgroup_function_test   21  TPASS  :  process 5783 is killed
>> memcgroup_function_test   22  TPASS  :  input=4095, limit_in_bytes=4096
>> memcgroup_function_test   23  TPASS  :  input=4097, limit_in_bytes=8192
>> memcgroup_function_test   24  TPASS  :  input=1, limit_in_bytes=4096
>> memcgroup_function_test   25  TFAIL  :  return value is 1
>> memcgroup_function_test   26  TPASS  :  return value is 1
>> memcgroup_function_test   27  TPASS  :  return value is 1
>> memcgroup_function_test   28  TPASS  :  return value is 1
>> memcgroup_function_test   29  TPASS  :  force memory succeeded
>> memcgroup_function_test   30  TPASS  :  force memory failed as expected
>> memcgroup_function_test   31  TPASS  :  return value is 0
>> memcgroup_function_test   32  TPASS  :  return value is 0
>> memcgroup_function_test   33  TPASS  :  return value is 0
>> memcgroup_function_test   34  TPASS  :  return value is 0
>> memcgroup_function_test   35  TPASS  :  return value is 1
>> memcgroup_function_test   36  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test   36  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test   37  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test   37  TPASS  :  rss=0/0, cache=0/0
>> memcgroup_function_test   38  TPASS  :  rss=4096/4096, cache=0/0
>> memcgroup_function_test   38  TPASS  :  rss=0/0, cache=0/0
>>
>> *** ....<The numbering seems to be wrong here>....
>>
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=110 termination_type=exited termination_id=1 corefile=no
>> cutime=29 cstime=268
>> <<<test_end>>>
>> <<<test_start>>>
>> tag=memcgroup_stress stime=1252484403
>> cmdline="      memcgroup_stress_test.sh"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> Wed Sep  9 13:50:07 IST 2009
>> incrementing stop
>> incrementing stop
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=265 termination_type=driver_interrupt termination_id=15
>>
>> *** ....<The stress tests seems to be not executing at all. What can be
>> the reason behind the "driver_interrupt" ?? >....
>>
>> corefile=no
>> cutime=20 cstime=219
>> <<<test_end>>>
>> ==================================================================================================
>>
>> Regards--
>> Subrata
>>
>>>  SUBDIRS += io-throttle
>>>  SUBDIRS += freezer
>>>  SUBDIRS += cpuset
>>> @@ -46,6 +47,7 @@ $(info "Kernel is not compiled with cpu 
>>>  endif
>>>  ifeq ($(CHECK_MEMCTL),memory)
>>>  SUBDIRS += memctl
>>> +SUBDIRS += memcgroup
>>>  else
>>>  $(info "Kernel is not compiled with memory resource controller support")
>>>  endif
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/Makefile ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/Makefile
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/Makefile	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/Makefile	2009-09-01 09:27:24.000000000 -0400
>>> @@ -0,0 +1,24 @@
>>> +CFLAGS += -Wall -O2 -g -Wextra
>>> +LDLIBS += -lm
>>> +
>>> +SRCS=$(wildcard *.c)
>>> +OBJECTS=$(patsubst %.c,%.o,$(SRCS))
>>> +TARGETS=$(patsubst %.c,%,$(SRCS))
>>> +
>>> +all: $(TARGETS)
>>> +
>>> +$(TARGETS): %: %.o
>>> +
>>> +install:
>>> +	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
>>> +
>>> +test:
>>> +	@./memcgroup_function_test.sh
>>> +	@./memcgroup_stress_test.sh
>>> +
>>> +clean:
>>> +	rm -f $(TARGETS) $(OBJECTS)
>>> +
>>> +uninstall:
>>> +
>>> +.DEFAULT: ;
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_function_test.sh ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_function_test.sh
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_function_test.sh	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_function_test.sh	2009-09-07 17:47:27.000000000 -0400
>>> @@ -0,0 +1,546 @@
>>> +#! /bin/sh
>>> +
>>> +################################################################################
>>> +##                                                                            ##
>>> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
>>> +##                                                                            ##
>>> +## This program is free software;  you can redistribute it and#or modify      ##
>>> +## it under the terms of the GNU General Public License as published by       ##
>>> +## the Free Software Foundation; either version 2 of the License, or          ##
>>> +## (at your option) any later version.                                        ##
>>> +##                                                                            ##
>>> +## This program is distributed in the hope that it will be useful, but        ##
>>> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
>>> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>>> +## for more details.                                                          ##
>>> +##                                                                            ##
>>> +## You should have received a copy of the GNU General Public License          ##
>>> +## along with this program;  if not, write to the Free Software               ##
>>> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
>>> +##                                                                            ##
>>> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
>>> +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
>>> +##                                                                            ##
>>> +################################################################################
>>> +
>>> +cd $LTPROOT/testcases/bin
>>> +export TCID="memcgroup_function_test"
>>> +export TST_TOTAL=38
>>> +export TST_COUNT=0
>>> +
>>> +grep -w memory /proc/cgroups 2>&1 > /dev/null
>>> +if [ $? -ne 0 ]; then
>>> +	echo "WARNING:";
>>> +	echo "Kernel does not support for memory resource controller";
>>> +	echo "Skipping all memcgroup testcases....";
>>> +	exit 0
>>> +fi
>>> +
>>> +TEST_PATH=$PWD
>>> +
>>> +PASS=0
>>> +FAIL=1
>>> +
>>> +PAGESIZE=`./memcgroup_getpagesize`
>>> +HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
>>> +HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
>>> +
>>> +cur_id=0
>>> +failed=0
>>> +
>>> +# Record the test result of a test case
>>> +#
>>> +# $1 - The result of the test case, $PASS or $FAIL
>>> +# $2 - The output information
>>> +result()
>>> +{
>>> +	pass=$1
>>> +	info="$2"
>>> +
>>> +	if [ $pass -eq $PASS ]; then
>>> +		tst_resm TPASS "$info"
>>> +	else
>>> +		tst_resm TFAIL "$info"
>>> +		failed=$(( $failed + 1 ))
>>> +	fi
>>> +}
>>> +
>>> +# Check rss size and cache size from memory.stat
>>> +#
>>> +# $1 - Expected rss size
>>> +# $2 - Expected cache size
>>> +check_mem_stat()
>>> +{
>>> +	case $cur_id in
>>> +	"11"|"12"|"13")
>>> +		# result() will be called in test_failcnt(),not here
>>> +		return
>>> +		;;
>>> +	*)
>>> +		;;
>>> +	esac
>>> +
>>> +	rss=`cat memory.stat | grep rss | head -n 1 | cut -d " " -f 2`
>>> +	cache=`cat memory.stat | grep cache | head -n 1 | cut -d " " -f 2`
>>> +
>>> +	if [ "$1" = "$rss" ] && [ "$2" = "$cache" ] ; then
>>> +		pass=$PASS
>>> +	else
>>> +		pass=$FAIL
>>> +	fi
>>> +
>>> +	result $pass "rss=$rss/$1, cache=$cache/$2"
>>> +}
>>> +
>>> +# Run test cases which checks memory.stat after make
>>> +# some memory allocation
>>> +#
>>> +# $1 - the parameters of 'process', such as --shm
>>> +# $2 - the -s parameter of 'process', such as 4096
>>> +# $3 - the expected rss size
>>> +# $4 - the expected pagecache size
>>> +# $5 - check after free ?
>>> +test_mem_stat()
>>> +{
>>> +	$TEST_PATH/memcgroup_process $1 -s $2 &
>>> +	sleep 1
>>> +	echo $! > tasks
>>> +	/bin/kill -s SIGUSR1 $!
>>> +	sleep 1
>>> +
>>> +	check_mem_stat $3 $4
>>> +
>>> +	/bin/kill -s SIGUSR1 $!
>>> +	sleep 1
>>> +	if [ $5 -eq 1 ]; then
>>> +		check_mem_stat 0 0
>>> +	fi
>>> +	/bin/kill -s SIGINT $!
>>> +}
>>> +
>>> +# Test if memory.failcnt > 0, which means page reclamation
>>> +# occured
>>> +test_failcnt()
>>> +{
>>> +	failcnt=`cat memory.failcnt`
>>> +	if [ $failcnt -gt 0 ]; then
>>> +		pass=$PASS
>>> +	else
>>> +		pass=$FAIL
>>> +	fi
>>> +
>>> +	result $pass "failcnt=$failcnt"
>>> +}
>>> +
>>> +# Test process will be killed due to exceed memory limit
>>> +#
>>> +# $1 - the value of memory.limit_in_bytes
>>> +# $2 - the parameters of 'process', such as --shm
>>> +# $3 - the -s parameter of 'process', such as 4096
>>> +test_proc_kill()
>>> +{
>>> +	echo $1 > memory.limit_in_bytes
>>> +	$TEST_PATH/memcgroup_process $2 -s $3 &
>>> +	pid=$!
>>> +	sleep 1
>>> +	echo $pid > tasks
>>> +
>>> +	/bin/kill -s SIGUSR1 $pid; sleep 1
>>> +	ps -p $pid > /dev/null 2> /dev/null
>>> +	if [ $? -ne 0 ]; then
>>> +		result $PASS "process $pid is killed"
>>> +	else
>>> +		/bin/kill -s SIGINT $pid
>>> +		result $FAIL "process $pid is not killed"
>>> +	fi
>>> +}
>>> +
>>> +# Test memory.limit_in_bytes will be aligned to PAGESIZE
>>> +#
>>> +# $1 - user input value
>>> +# $2 - expected value
>>> +test_limit_in_bytes()
>>> +{
>>> +	echo $1 > memory.limit_in_bytes
>>> +	limit=`cat memory.limit_in_bytes`
>>> +	if [ $limit -eq $2 ]; then
>>> +		result $PASS "input=$1, limit_in_bytes=$limit"
>>> +	else
>>> +		result $FAIL "input=$1, limit_in_bytes=$limit"
>>> +	fi
>>> +}
>>> +
>>> +# Test memory controller doesn't charge hugepage
>>> +#
>>> +# $1 - the value of /proc/sys/vm/nr_hugepages
>>> +# $2 - the parameters of 'process', --mmap-file or --shm
>>> +# $3 - the -s parameter of 'process', such as $HUGEPAGESIZE
>>> +# $4 - 0: expected failure, 1: expected success
>>> +test_hugepage()
>>> +{
>>> +	TMP_FILE=$TEST_PATH/tmp
>>> +	nr_hugepages=`cat /proc/sys/vm/nr_hugepages`
>>> +
>>> +	mkdir /hugetlb
>>> +	mount -t hugetlbfs none /hugetlb
>>> +
>>> +	echo $1 > /proc/sys/vm/nr_hugepages
>>> +
>>> +	$TEST_PATH/memcgroup_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
>>> +	sleep 1
>>> +
>>> +	/bin/kill -s SIGUSR1 $!
>>> +	sleep 1
>>> +
>>> +	check_mem_stat 0 0
>>> +
>>> +	echo "TMP_FILE:"
>>> +	cat $TMP_FILE
>>> +
>>> +	if [ $4 -eq 0 ]; then
>>> +		test -s $TMP_FILE
>>> +		if [ $? -eq 0 ]; then
>>> +			result $PASS "allocate hugepage failed as expected"
>>> +		else
>>> +			/bin/kill -s SIGUSR1 $!
>>> +			/bin/kill -s SIGINT $!
>>> +			result $FAIL "allocate hugepage shoud fail"
>>> +		fi
>>> +	else
>>> +		test ! -s $TMP_FILE
>>> +		if [ $? -eq 0 ]; then
>>> +			/bin/kill -s SIGUSR1 $!
>>> +			/bin/kill -s SIGINT $!
>>> +			result $PASS "allocate hugepage succeeded"
>>> +		else
>>> +			result $FAIL "allocate hugepage failed"
>>> +		fi
>>> +	fi
>>> +
>>> +	sleep 1
>>> +	rm -rf $TMP_FILE
>>> +	umount /hugetlb
>>> +	rmdir /hugetlb
>>> +	echo $nr_hugepages > /proc/sys/vm/nr_hugepages
>>> +}
>>> +
>>> +# Test the memory charge won't move to subgroup
>>> +#
>>> +# $1 - memory.limit_in_bytes in parent group
>>> +# $2 - memory.limit_in_bytes in sub group
>>> +test_subgroup()
>>> +{
>>> +	mkdir subgroup
>>> +	echo $1 > memory.limit_in_bytes
>>> +	echo $2 > subgroup/memory.limit_in_bytes
>>> +
>>> +	$TEST_PATH/memcgroup_process --mmap-anon -s $PAGESIZE &
>>> +	sleep 1
>>> +	echo $! > tasks
>>> +	/bin/kill -s SIGUSR1 $!
>>> +	sleep 1
>>> +	check_mem_stat $PAGESIZE 0
>>> +
>>> +	cd subgroup
>>> +	echo $! > tasks
>>> +	check_mem_stat 0 0
>>> +
>>> +	# cleanup
>>> +	cd ..
>>> +	echo $! > tasks
>>> +	/bin/kill -s SIGINT $!
>>> +	sleep 1
>>> +	rmdir subgroup
>>> +}
>>> +
>>> +# Case 1 - 10: Test the management and counting of memory
>>> +testcase_1()
>>> +{
>>> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE 0 0
>>> +}
>>> +
>>> +testcase_2()
>>> +{
>>> +	test_mem_stat "--mmap-file" $PAGESIZE 0 $PAGESIZE 0
>>> +}
>>> +
>>> +testcase_3()
>>> +{
>>> +	test_mem_stat "--shm -k 3" $PAGESIZE 0 $PAGESIZE 0
>>> +}
>>> +
>>> +testcase_4()
>>> +{
>>> +	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE \
>>> +		      $PAGESIZE $(($PAGESIZE*2)) 0
>>> +}
>>> +
>>> +testcase_5()
>>> +{
>>> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE 0 0
>>> +}
>>> +
>>> +testcase_6()
>>> +{
>>> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE 0 1
>>> +}
>>> +
>>> +testcase_7()
>>> +{
>>> +	test_mem_stat "--mmap-file" $PAGESIZE 0 $PAGESIZE 1
>>> +}
>>> +
>>> +testcase_8()
>>> +{
>>> +	test_mem_stat "--shm -k 8" $PAGESIZE 0 $PAGESIZE 1
>>> +}
>>> +
>>> +testcase_9()
>>> +{
>>> +	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE \
>>> +		      $PAGESIZE $(($PAGESIZE*2)) 1
>>> +}
>>> +
>>> +testcase_10()
>>> +{
>>> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE 0 1
>>> +}
>>> +
>>> +# Case 11 - 13: Test memory.failcnt
>>> +testcase_11()
>>> +{
>>> +	echo $PAGESIZE > memory.limit_in_bytes
>>> +	test_mem_stat "--mmap-anon" $(($PAGESIZE*2)) $PAGESIZE 0 0
>>> +	test_failcnt
>>> +}
>>> +
>>> +testcase_12()
>>> +{
>>> +	echo $PAGESIZE > memory.limit_in_bytes
>>> +	test_mem_stat "--mmap-file" $(($PAGESIZE*2)) 0 $PAGESIZE 0
>>> +	test_failcnt
>>> +}
>>> +
>>> +testcase_13()
>>> +{
>>> +	echo $PAGESIZE > memory.limit_in_bytes
>>> +	test_mem_stat "--shm" $(($PAGESIZE*2)) 0 $PAGESIZE 0
>>> +	test_failcnt
>>> +}
>>> +
>>> +# Case 14 - 15: Test mmap(locked) + alloc_mem > limit_in_bytes
>>> +testcase_14()
>>> +{
>>> +	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2))
>>> +}
>>> +
>>> +testcase_15()
>>> +{
>>> +	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2))
>>> +}
>>> +
>>> +# Case 16 - 18: Test swapoff + alloc_mem > limi_in_bytes
>>> +testcase_16()
>>> +{
>>> +	swapoff -a
>>> +	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE*2))
>>> +	swapon -a
>>> +}
>>> +
>>> +testcase_17()
>>> +{
>>> +	swapoff -a
>>> +	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE*2))
>>> +	swapon -a
>>> +}
>>> +
>>> +testcase_18()
>>> +{
>>> +	swapoff -a
>>> +	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE*2))
>>> +	swapon -a
>>> +}
>>> +
>>> +# Case 19 - 21: Test limit_in_bytes == 0
>>> +testcase_19()
>>> +{
>>> +	test_proc_kill 0 "--mmap-anon" $PAGESIZE
>>> +}
>>> +
>>> +testcase_20()
>>> +{
>>> +	test_proc_kill 0 "--mmap-file" $PAGESIZE
>>> +}
>>> +
>>> +testcase_21()
>>> +{
>>> +	test_proc_kill 0 "--shm -k 21" $PAGESIZE
>>> +}
>>> +
>>> +# Case 22 - 24: Test limit_in_bytes will be aligned to PAGESIZE
>>> +testcase_22()
>>> +{
>>> +	test_limit_in_bytes $((PAGESIZE-1)) $PAGESIZE
>>> +}
>>> +
>>> +testcase_23()
>>> +{
>>> +	test_limit_in_bytes $((PAGESIZE+1)) $((PAGESIZE*2))
>>> +}
>>> +
>>> +testcase_24()
>>> +{
>>> +	test_limit_in_bytes 1 $PAGESIZE
>>> +}
>>> +
>>> +# Case 25 - 28: Test invaild memory.limit_in_bytes
>>> +testcase_25()
>>> +{
>>> +	echo -1 > memory.limit_in_bytes 2> /dev/null
>>> +#	result $(( !($? != 0) ))  "return value is $?"  //lizf
>>> +	result $(( !($? == 0) ))  "return value is $?"
>>> +}
>>> +
>>> +testcase_26()
>>> +{
>>> +	echo 1.0 > memory.limit_in_bytes 2> /dev/null
>>> +	result $(( !($? != 0) )) "return value is $?"
>>> +}
>>> +
>>> +testcase_27()
>>> +{
>>> +	echo 1xx > memory.limit_in_bytes 2> /dev/null
>>> +	result $(( !($? != 0) )) "return value is $?"
>>> +}
>>> +
>>> +testcase_28()
>>> +{
>>> +	echo xx > memory.limit_in_bytes 2> /dev/null
>>> +	result $(( !($? != 0) )) "return value is $?"
>>> +}
>>> +
>>> +# Case 29 - 35: Test memory.force_empty
>>> +testcase_29()
>>> +{
>>> +	$TEST_PATH/memcgroup_process --mmap-anon -s $PAGESIZE &
>>> +	pid=$!
>>> +	sleep 1
>>> +	echo $pid > tasks
>>> +	/bin/kill -s SIGUSR1 $pid
>>> +	sleep 1
>>> +	echo $pid > ../tasks
>>> +
>>> +	echo 1 > memory.force_empty
>>> +	if [ $? -eq 0 ]; then
>>> +		result $PASS "force memory succeeded"
>>> +	else
>>> +		result $FAIL "force memory failed"
>>> +	fi
>>> +
>>> +	/bin/kill -s SIGINT $pid
>>> +}
>>> +
>>> +testcase_30()
>>> +{
>>> +	$TEST_PATH/memcgroup_process --mmap-anon -s $PAGESIZE &
>>> +	pid=$!
>>> +	sleep 1
>>> +	echo $pid > tasks
>>> +	/bin/kill -s SIGUSR1 $pid
>>> +	sleep 1
>>> +
>>> +	echo 1 > memory.force_empty 2> /dev/null
>>> +	if [ $? -ne 0 ]; then
>>> +		result $PASS "force memory failed as expected"
>>> +	else
>>> +		result $FAIL "force memory should fail"
>>> +	fi
>>> +
>>> +	/bin/kill -s SIGINT $pid
>>> +}
>>> +
>>> +testcase_31()
>>> +{
>>> +	echo 0 > memory.force_empty 2> /dev/null
>>> +	result $? "return value is $?"
>>> +}
>>> +
>>> +testcase_32()
>>> +{
>>> +	echo 1.0 > memory.force_empty 2> /dev/null
>>> +	result $? "return value is $?"
>>> +}
>>> +
>>> +testcase_33()
>>> +{
>>> +	echo 1xx > memory.force_empty 2> /dev/null
>>> +	result $? "return value is $?"
>>> +}
>>> +
>>> +testcase_34()
>>> +{
>>> +	echo xx > memory.force_empty 2> /dev/null
>>> +	result $? "return value is $?"
>>> +}
>>> +
>>> +testcase_35()
>>> +{
>>> +	# writing to non-empty top mem cgroup's force_empty
>>> +	# should return failure
>>> +	echo 1 > /memcg/memory.force_empty 2> /dev/null
>>> +	result $(( !$? )) "return value is $?"
>>> +}
>>> +
>>> +# Case 36 - 38: Test that group and subgroup have no relationship
>>> +testcase_36()
>>> +{
>>> +	test_subgroup $PAGESIZE $((2*PAGESIZE))
>>> +}
>>> +
>>> +testcase_37()
>>> +{
>>> +	test_subgroup $PAGESIZE $PAGESIZE
>>> +}
>>> +
>>> +testcase_38()
>>> +{
>>> +	test_subgroup $PAGESIZE 0
>>> +}
>>> +
>>> +shmmax=`cat /proc/sys/kernel/shmmax`
>>> +if [ $shmmax -lt $HUGEPAGESIZE ]; then
>>> +	echo $(($HUGEPAGESIZE)) > /proc/sys/kernel/shmmax
>>> +fi
>>> +
>>> +mkdir /memcg 2> /dev/null
>>> +mount -t cgroup -omemory memcg /memcg
>>> +
>>> +# Run all the test cases
>>> +for ((i = 1; i <= $TST_TOTAL; i++))
>>> +{
>>> +	export TST_COUNT=$(( $TST_COUNT + 1 ))
>>> +	cur_id=$i
>>> +
>>> +	# prepare
>>> +	mkdir /memcg/$i
>>> +	cd /memcg/$i
>>> +
>>> +	# run the case
>>> +	testcase_$i
>>> +
>>> +	# clean up
>>> +	sleep 1
>>> +	cd $TEST_PATH
>>> +	rmdir /memcg/$i
>>> +}
>>> +
>>> +umount /memcg
>>> +rmdir /memcg
>>> +
>>> +echo $shmmax > /proc/sys/kernel/shmmax
>>> +
>>> +if [ $failed -ne 0 ]; then
>>> +	exit 1
>>> +else
>>> +	exit 0
>>> +fi
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_getpagesize.c ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_getpagesize.c
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_getpagesize.c	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_getpagesize.c	2009-09-01 09:27:25.000000000 -0400
>>> @@ -0,0 +1,31 @@
>>> +/******************************************************************************/
>>> +/*                                                                            */
>>> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
>>> +/*                                                                            */
>>> +/* This program is free software;  you can redistribute it and/or modify      */
>>> +/* it under the terms of the GNU General Public License as published by       */
>>> +/* the Free Software Foundation; either version 2 of the License, or          */
>>> +/* (at your option) any later version.                                        */
>>> +/*                                                                            */
>>> +/* This program is distributed in the hope that it will be useful,            */
>>> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
>>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
>>> +/* the GNU General Public License for more details.                           */
>>> +/*                                                                            */
>>> +/* You should have received a copy of the GNU General Public License          */
>>> +/* along with this program;  if not, write to the Free Software               */
>>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
>>> +/*                                                                            */
>>> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
>>> +/*                                                                            */
>>> +/******************************************************************************/
>>> +
>>> +#include <unistd.h>
>>> +#include <stdio.h>
>>> +
>>> +int main(void)
>>> +{
>>> +	printf("%d\n", getpagesize());
>>> +	return 0;
>>> +}
>>> +
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_process.c ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_process.c
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_process.c	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_process.c	2009-09-01 09:27:26.000000000 -0400
>>> @@ -0,0 +1,319 @@
>>> +/******************************************************************************/
>>> +/*                                                                            */
>>> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
>>> +/*                                                                            */
>>> +/* This program is free software;  you can redistribute it and/or modify      */
>>> +/* it under the terms of the GNU General Public License as published by       */
>>> +/* the Free Software Foundation; either version 2 of the License, or          */
>>> +/* (at your option) any later version.                                        */
>>> +/*                                                                            */
>>> +/* This program is distributed in the hope that it will be useful,            */
>>> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
>>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
>>> +/* the GNU General Public License for more details.                           */
>>> +/*                                                                            */
>>> +/* You should have received a copy of the GNU General Public License          */
>>> +/* along with this program;  if not, write to the Free Software               */
>>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
>>> +/*                                                                            */
>>> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
>>> +/*                                                                            */
>>> +/******************************************************************************/
>>> +
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +#include <stdio.h>
>>> +#include <signal.h>
>>> +#include <err.h>
>>> +#include <limits.h>
>>> +#include <getopt.h>
>>> +#include <string.h>
>>> +#include <fcntl.h>
>>> +#include <sys/types.h>
>>> +#include <sys/stat.h>
>>> +#include <sys/mman.h>
>>> +#include <sys/shm.h>
>>> +
>>> +int fd;
>>> +
>>> +int flag_exit;
>>> +int flag_allocated;
>>> +
>>> +int opt_mmap_anon;
>>> +int opt_mmap_file;
>>> +int opt_mmap_lock1;
>>> +int opt_mmap_lock2;
>>> +int opt_shm;
>>> +int opt_hugepage;
>>> +
>>> +int key_id;		/* used with opt_shm */
>>> +unsigned long memsize;
>>> +
>>> +#define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
>>> +
>>> +#define MMAP_ANON	(SCHAR_MAX + 1)
>>> +#define MMAP_FILE	(SCHAR_MAX + 2)
>>> +#define MMAP_LOCK1	(SCHAR_MAX + 3)
>>> +#define MMAP_LOCK2	(SCHAR_MAX + 4)
>>> +#define SHM		(SCHAR_MAX + 5)
>>> +#define HUGEPAGE	(SCHAR_MAX + 6)
>>> +
>>> +const struct option long_opts[] = {
>>> +	{ "mmap-anon",	0, NULL, MMAP_ANON	},
>>> +	{ "mmap-file",	0, NULL, MMAP_FILE	},
>>> +	{ "mmap-lock1",	0, NULL, MMAP_LOCK1	},
>>> +	{ "mmap-lock2",	0, NULL, MMAP_LOCK2	},
>>> +	{ "shm",	0, NULL, SHM		},
>>> +	{ "hugepage",	0, NULL, HUGEPAGE	},
>>> +	{ "size",	1, NULL, 's'		},
>>> +	{ "key",	1, NULL, 'k'		},
>>> +	{ NULL,		0, NULL, 0		},
>>> +};
>>> +
>>> +/*
>>> + * process_options: read options from user input
>>> + */
>>> +void process_options(int argc, char *argv[])
>>> +{
>>> +	int c;
>>> +	char *end;
>>> +
>>> +	while (1) {
>>> +		c = getopt_long(argc, argv, "s:k:", long_opts, NULL);
>>> +		if (c == -1)
>>> +			break;
>>> +
>>> +		switch (c) {
>>> +		case 's':
>>> +			memsize = strtoul(optarg, &end, 10);
>>> +			if (*end != '\0')
>>> +				errx(1, "wrong -s argument!");
>>> +			break;
>>> +		case 'k':
>>> +			key_id = atoi(optarg);
>>> +			break;
>>> +		case MMAP_ANON:
>>> +			opt_mmap_anon = 1;
>>> +			break;
>>> +		case MMAP_FILE:
>>> +			opt_mmap_file = 1;
>>> +			break;
>>> +		case MMAP_LOCK1:
>>> +			opt_mmap_lock1 = 1;
>>> +			break;
>>> +		case MMAP_LOCK2:
>>> +			opt_mmap_lock2 = 1;
>>> +			break;
>>> +		case SHM:
>>> +			opt_shm = 1;
>>> +			break;
>>> +		case HUGEPAGE:
>>> +			opt_hugepage = 1;
>>> +			break;
>>> +		default:
>>> +			errx(1, "unknown option!\n");
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * touch_memory: force allocating phy memory
>>> + */
>>> +void touch_memory(char *p, int size)
>>> +{
>>> +	int i;
>>> +	int pagesize = getpagesize();
>>> +
>>> +	for (i = 0; i < size; i += pagesize)
>>> +		p[i] = 0xef;
>>> +}
>>> +
>>> +void mmap_anon()
>>> +{
>>> +	static char *p;
>>> +
>>> +	if (!flag_allocated) {
>>> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>>> +			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>>> +		if (p == MAP_FAILED)
>>> +			err(1, "mmap(anonymous) failed");
>>> +		touch_memory(p, memsize);
>>> +	} else {
>>> +		if (munmap(p, memsize) == -1)
>>> +			err(1, "munmap(anonymous) failed");
>>> +	}
>>> +}
>>> +
>>> +void mmap_file()
>>> +{
>>> +	static char *p;
>>> +	static int fd_hugepage;
>>> +	int fd_tmp;
>>> +
>>> +	if (!flag_allocated) {
>>> +		if (opt_hugepage) {
>>> +			fd_hugepage = open(FILE_HUGEPAGE,
>>> +					   O_CREAT | O_RDWR, 0755);
>>> +			if (fd_hugepage < 0)
>>> +				err(1, "open hugepage file failed");
>>> +			fd_tmp = fd_hugepage;
>>> +		} else
>>> +			fd_tmp = fd;
>>> +
>>> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>>> +			 MAP_SHARED, fd_tmp, 0);
>>> +		if (p == MAP_FAILED) {
>>> +			if (opt_hugepage)
>>> +				unlink(FILE_HUGEPAGE);
>>> +			err(1, "mmap(file) failed");
>>> +		}
>>> +		touch_memory(p, memsize);
>>> +	} else {
>>> +		if (!munmap(p, memsize) == -1)
>>> +			err(1, "munmap(file) failed");
>>> +
>>> +		if (opt_hugepage) {
>>> +			close(fd_hugepage);
>>> +			unlink(FILE_HUGEPAGE);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +void mmap_lock1()
>>> +{
>>> +	static char *p;
>>> +
>>> +	if (!flag_allocated) {
>>> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>>> +			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0, 0);
>>> +		if (p == MAP_FAILED)
>>> +			err(1, "mmap(lock) failed");
>>> +	} else {
>>> +		if (munmap(p, memsize) == -1)
>>> +			err(1, "munmap(lock) failed");
>>> +	}
>>> +}
>>> +
>>> +void mmap_lock2()
>>> +{
>>> +	static char *p;
>>> +
>>> +	if (!flag_allocated) {
>>> +		p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>>> +			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>>> +		if (p == MAP_FAILED)
>>> +			err(1, "mmap failed");
>>> +
>>> +		if (!mlock(p, memsize))
>>> +			err(1, "mlock failed");
>>> +	} else {
>>> +		if (!munmap(p, memsize) == -1)
>>> +			err(1, "munmap failed");
>>> +	}
>>> +}
>>> +
>>> +void shm()
>>> +{
>>> +	static char *p;
>>> +	static int shmid;
>>> +	unsigned long flag;
>>> +
>>> +	key_t key;
>>> +
>>> +	if (!flag_allocated) {
>>> +		flag = IPC_CREAT | SHM_R | SHM_W;
>>> +		if (opt_hugepage)
>>> +			flag |= SHM_HUGETLB;
>>> +
>>> +		key = ftok("/dev/null", key_id);
>>> +		if (key == -1)
>>> +			err(1, "ftok() failed\n");
>>> +
>>> +		shmid = shmget(key, memsize, flag);
>>> +		if (shmid == -1)
>>> +			err(1, "shmget() failed\n");
>>> +		shmctl(shmid, IPC_RMID, NULL);
>>> +
>>> +		shmid = shmget(key, memsize, flag);
>>> +		if (shmid == -1)
>>> +			err(1, "shmget() failed\n");
>>> +
>>> +		p = shmat(shmid, NULL, 0);
>>> +		if (p == (void *)-1) {
>>> +			shmctl(shmid, IPC_RMID, NULL);
>>> +			err(1, "shmat() failed\n");
>>> +		}
>>> +		touch_memory(p, memsize);
>>> +	} else {
>>> +		if (shmdt(p) == -1)
>>> +			err(1, "shmdt() failed\n");
>>> +		if (shmctl(shmid, IPC_RMID, NULL) == -1)
>>> +			err(1, "shmctl() failed\n");
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * sigint_handler: handle SIGINT by set the exit flag.
>>> + */
>>> +void sigint_handler(int __attribute__((unused)) signo)
>>> +{
>>> +	flag_exit = 1;
>>> +}
>>> +
>>> +/*
>>> + * sigusr_handler: handler SIGUSR
>>> + *
>>> + * When we receive SIGUSR, we allocate some memory according
>>> + * to the user input when the process started.
>>> + *
>>> + * When we receive SIGUSR again, we will free all the allocated
>>> + * memory.
>>> + */
>>> +void sigusr_handler(int __attribute__((unused)) signo)
>>> +{
>>> +	if (opt_mmap_anon)
>>> +		mmap_anon();
>>> +
>>> +	if (opt_mmap_file)
>>> +		mmap_file();
>>> +
>>> +	if (opt_mmap_lock1)
>>> +		mmap_lock1();
>>> +
>>> +	if (opt_mmap_lock2)
>>> +		mmap_lock2();
>>> +
>>> +	if (opt_shm)
>>> +		shm();
>>> +
>>> +	flag_allocated = !flag_allocated;
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	struct sigaction sigint_action;
>>> +	struct sigaction sigusr_action;
>>> +
>>> +	fd = open("/dev/zero", O_RDWR);
>>> +	if (fd < 0)
>>> +		err(1, "open /dev/zero failed");
>>> +
>>> +	memset(&sigint_action, 0, sizeof(sigint_action));
>>> +	sigint_action.sa_handler = &sigint_handler;
>>> +	sigaction(SIGINT, &sigint_action, NULL);
>>> +
>>> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
>>> +	sigusr_action.sa_handler = &sigusr_handler;
>>> +	sigaction(SIGUSR1, &sigusr_action, NULL);
>>> +
>>> +	process_options(argc, argv);
>>> +
>>> +	while (!flag_exit)
>>> +		sleep(1);
>>> +
>>> +	close(fd);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_process_stress.c ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_process_stress.c
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_process_stress.c	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_process_stress.c	2009-09-01 09:27:26.000000000 -0400
>>> @@ -0,0 +1,109 @@
>>> +/******************************************************************************/
>>> +/*                                                                            */
>>> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
>>> +/*                                                                            */
>>> +/* This program is free software;  you can redistribute it and/or modify      */
>>> +/* it under the terms of the GNU General Public License as published by       */
>>> +/* the Free Software Foundation; either version 2 of the License, or          */
>>> +/* (at your option) any later version.                                        */
>>> +/*                                                                            */
>>> +/* This program is distributed in the hope that it will be useful,            */
>>> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
>>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
>>> +/* the GNU General Public License for more details.                           */
>>> +/*                                                                            */
>>> +/* You should have received a copy of the GNU General Public License          */
>>> +/* along with this program;  if not, write to the Free Software               */
>>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
>>> +/*                                                                            */
>>> +/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
>>> +/*                                                                            */
>>> +/******************************************************************************/
>>> +
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +#include <signal.h>
>>> +#include <string.h>
>>> +#include <err.h>
>>> +#include <math.h>
>>> +#include <sys/mman.h>
>>> +
>>> +int flag_exit;
>>> +int flag_ready;
>>> +
>>> +int interval;
>>> +unsigned long memsize;
>>> +
>>> +char **pages;
>>> +int nr_page;
>>> +
>>> +void touch_memory()
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < nr_page; i++)
>>> +		pages[i][0] = 0xef;
>>> +}
>>> +
>>> +void sigusr_handler(int __attribute__((unused)) signo)
>>> +{
>>> +	int i;
>>> +	int pagesize = getpagesize();
>>> +
>>> +	nr_page = ceil((double)memsize / pagesize);
>>> +
>>> +	pages = calloc(nr_page, sizeof(char *));
>>> +	if (pages == NULL)
>>> +		errx(1, "calloc() failed");
>>> +
>>> +	for (i = 0; i < nr_page; i++) {
>>> +		pages[i] = mmap(NULL, pagesize, PROT_WRITE | PROT_READ,
>>> +				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>>> +		if (pages[i] == MAP_FAILED)
>>> +			err(1, "map() failed\n");
>>> +	}
>>> +
>>> +	flag_ready = 1;
>>> +}
>>> +
>>> +void sigint_handler(int __attribute__((unused)) signo)
>>> +{
>>> +	flag_exit = 1;
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	char *end;
>>> +	struct sigaction sigint_action;
>>> +	struct sigaction sigusr_action;
>>> +
>>> +	if (argc != 3)
>>> +		errx(1, "Wrong argument num");
>>> +
>>> +	memsize = strtoul(argv[1], &end, 10);
>>> +	if (*end != '\0')
>>> +		errx(1, "wrong memsize");
>>> +	memsize = memsize * 1024 * 1024;
>>> +
>>> +	interval = atoi(argv[2]);
>>> +	if (interval <= 0)
>>> +		interval = 1;
>>> +
>>> +	memset(&sigint_action, 0, sizeof(sigint_action));
>>> +	sigint_action.sa_handler = &sigint_handler;
>>> +	sigaction(SIGINT, &sigint_action, NULL);
>>> +
>>> +	memset(&sigusr_action, 0, sizeof(sigusr_action));
>>> +	sigusr_action.sa_handler = &sigusr_handler;
>>> +	sigaction(SIGUSR1, &sigusr_action, NULL);
>>> +
>>> +	while (!flag_exit) {
>>> +		sleep(interval);
>>> +
>>> +		if (flag_ready)
>>> +			touch_memory();
>>> +	};
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_stress_test.sh ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_stress_test.sh
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/memcgroup_stress_test.sh	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/memcgroup_stress_test.sh	2009-09-07 17:28:39.000000000 -0400
>>> @@ -0,0 +1,109 @@
>>> +#! /bin/sh
>>> +
>>> +################################################################################
>>> +##                                                                            ##
>>> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
>>> +##                                                                            ##
>>> +## This program is free software;  you can redistribute it and#or modify      ##
>>> +## it under the terms of the GNU General Public License as published by       ##
>>> +## the Free Software Foundation; either version 2 of the License, or          ##
>>> +## (at your option) any later version.                                        ##
>>> +##                                                                            ##
>>> +## This program is distributed in the hope that it will be useful, but        ##
>>> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
>>> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>>> +## for more details.                                                          ##
>>> +##                                                                            ##
>>> +## You should have received a copy of the GNU General Public License          ##
>>> +## along with this program;  if not, write to the Free Software               ##
>>> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
>>> +##                                                                            ##
>>> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
>>> +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
>>> +##                                                                            ##
>>> +################################################################################
>>> +
>>> +cd $LTPROOT/testcases/bin
>>> +export TCID="memcgroup_stress_test"
>>> +export TST_TOTAL=2
>>> +export TST_COUNT=0
>>> +
>>> +grep -w memory /proc/cgroups 2>&1 > /dev/null
>>> +if [ $? -ne 0 ]; then
>>> +	echo "WARNING:";
>>> +	echo "Kernel does not support for memory resource controller";
>>> +	echo "Skipping all memcgroup testcases....";
>>> +	exit 0
>>> +fi
>>> +
>>> +RUN_TIME=$(( 60 * 60 ))
>>> +
>>> +# Run the stress test
>>> +#
>>> +# $1 - Number of cgroups
>>> +# $2 - Allocated how much memory in one process? in MB
>>> +# $3 - The interval to touch memory in a process
>>> +# $4 - How long does this test run ? in second
>>> +run_stress()
>>> +{
>>> +	mkdir /memcg
>>> +	mount -t cgroup -omemory xxx /memcg
>>> +
>>> +	for ((i = 0; i < $1; i++))
>>> +	{
>>> +		mkdir /memcg/$i
>>> +		./memcgroup_process_stress $2 $3 &
>>> +		pid[$i]=$!
>>> +
>>> +		echo ${pid[$i]} > /memcg/$i/tasks
>>> +	}
>>> +
>>> +	for ((i = 0; i < $1; i++))
>>> +	{
>>> +		/bin/kill -s SIGUSR1 ${pid[$i]}
>>> +	}
>>> +
>>> +	sleep $4
>>> +
>>> +	for ((i = 0; i < $1; i++))
>>> +	{
>>> +		/bin/kill -s SIGINT ${pid[$i]}
>>> +		wait ${pid[$i]}
>>> +
>>> +		rmdir /memcg/$i
>>> +	}
>>> +
>>> +	umount /memcg
>>> +	rmdir /memcg
>>> +}
>>> +
>>> +testcase_1()
>>> +{
>>> +	run_stress 150 $(( ($mem-150) / 150 )) 10 $RUN_TIME
>>> +
>>> +	tst_resm TPASS "stress test 1 passed"
>>> +}
>>> +
>>> +testcase_2()
>>> +{
>>> +	run_stress 1 $mem 10 $RUN_TIME
>>> +
>>> +	tst_resm TPASS "stress test 2 passed"
>>> +}
>>> +
>>> +echo 3 > /proc/sys/vm/drop_caches
>>> +sleep 2
>>> +mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
>>> +swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
>>> +
>>> +mem=$(( $mem_free + $swap_free / 2 ))
>>> +mem=$(( mem / 1024 ))
>>> +
>>> +date
>>> +export TST_COUNT=$(( $TST_COUNT + 1 ))
>>> +testcase_1
>>> +export TST_COUNT=$(( $TST_COUNT + 1 ))
>>> +testcase_2
>>> +date
>>> +
>>> +exit 0
>>> diff -urpN ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/README ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/README
>>> --- ltp-full-20090831.orig/testcases/kernel/controllers/memcgroup/README	1969-12-31 19:00:00.000000000 -0500
>>> +++ ltp-full-20090831.memcgroup/testcases/kernel/controllers/memcgroup/README	2009-09-01 09:27:27.000000000 -0400
>>> @@ -0,0 +1,44 @@
>>> +
>>> +TEST SUITE:
>>> +
>>> +The directory memcgroup contains the tests related to the memory controller.
>>> +
>>> +There are total 40 testcases that have been added. These testcases 
>>> +contain the basis operation test and stress test of memctl.
>>> +
>>> +NOTE: the test can be run by root only.
>>> +
>>> +TESTS AIM:
>>> +
>>> +The aim of the tests is to test the functionality of memctl..
>>> +
>>> +FILES DESCRIPTION:
>>> +
>>> +memcgroup_function_test.sh
>>> +--------------------
>>> +This script runs all the 38 testcases of basis operation.
>>> +
>>> +memcgroup_tress_test.sh
>>> +--------------------
>>> +This script runs all the 2 testcases of stress test.
>>> +
>>> +memcgroup_getpagesize.c
>>> +--------------------
>>> +The program gets page size through getpagesize().
>>> +
>>> +memcgroup_process.c
>>> +--------------------
>>> +The program allocates some memory according to the user input when received SIGUSR.
>>> +And, it frees all the allocated when received SIGUSR again.
>>> +
>>> +memcgroup_process_stress.c
>>> +--------------------
>>> +The program allocates some memory in a specified time period when received SIGUSR. 
>>> +
>>> +Makefile
>>> +--------------------
>>> +The usual makefile for this directory
>>> +
>>> +README
>>> +------
>>> +The one you have gone through.
>>>
>>>
>>
>> ------------------------------------------------------------------------------
>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
>> trial. Simplify your report design, integration and deployment - and focus on 
>> what you do best, core application coding. Discover what's new with 
>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
