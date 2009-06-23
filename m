Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Uf-0003O3-Mt
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:01:05 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Ub-0007zV-Jl
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:01:05 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NF3xQd019390
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:03:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF0x0G197696
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:00:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF0xOj014052
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:00:59 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220111.n5M1BaL6029377@e35.co.us.ibm.com>
References: <200906220111.n5M1BaL6029377@e35.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:18 +0530
Message-Id: <1245768558.4860.67.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix some bashisms, mainly in the controllers	tests
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Sat, 2009-06-06 at 23:25 +0200, Jiri Palecek > wrote: 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/containers/netns/initialize.sh    |    2 +-
>  .../cpuset_base_ops_testset.sh                     |   16 ++++++++--------
>  .../cpuset_exclusive_test/cpuset_exclusive_test.sh |    8 ++++----
>  .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |    8 ++++----
>  .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |   18 +++++++++---------
>  .../cpuset_inherit_test/cpuset_inherit_testset.sh  |    8 ++++----
>  .../controllers/cpuset/cpuset_lib/cpuset_funcs.sh  |   20 ++++++++++----------
>  .../cpuset_load_balance_test.sh                    |    6 +++---
>  .../cpuset_sched_domains_test.sh                   |    8 ++++----
>  .../cpuset_memory_pressure_testset.sh              |   20 ++++++++++----------
>  .../cpuset_memory_spread_testset.sh                |    4 ++--
>  .../cpuset_memory_test/cpuset_memory_testset.sh    |   10 +++++-----
>  .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    8 ++++----
>  .../controllers/memcg/memcg_regression_test.sh     |   10 ++++------
>  testcases/kernel/io/stress_floppy/generate.sh      |    6 +++---
>  15 files changed, 75 insertions(+), 77 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
> index 9d722b0..dafc923 100755
> --- a/testcases/kernel/containers/netns/initialize.sh
> +++ b/testcases/kernel/containers/netns/initialize.sh
> @@ -78,7 +78,7 @@ DEBUG=0
>      fi
>  cleanup()
>  {
> -   if [ $# == 2 ]; then
> +   if [ $# = 2 ]; then
>          pid=$1
>          netdev=$2
>      fi
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> index fef8d46..2b1016e 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset01"
>  export TST_TOTAL=97
>  export TST_COUNT=1
> @@ -53,7 +53,7 @@ base_op_write_and_test()
>  		tst_brkm TFAIL "Failed to mkdir -p $(basename $write_file)"
>  		return 1
>  	}
> -	[ "$write_string" == NULL ] && write_string=" "
> +	[ "$write_string" = NULL ] && write_string=" "
>  	
>  	/bin/echo "$write_string" > "$write_file" 2> $CPUSET_TMP/stderr
>  	ret=$?
> @@ -97,7 +97,7 @@ base_op_test()
>  			exit_status=1
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
>  test_cpus()
> @@ -212,7 +212,7 @@ attach_task_test()
>  	if [ $? -ne 0 ]; then
>  		exit_status=1
>  		cleanup
> -		((TST_COUNT++))
> +		: $((TST_COUNT++))
>  		return
>  	fi
> 
> @@ -221,7 +221,7 @@ attach_task_test()
>  	if [ $? -ne 0 ]; then
>  		exit_status=1
>  		cleanup
> -		((TST_COUNT++))
> +		: $((TST_COUNT++))
>  		return
>  	fi
> 
> @@ -244,12 +244,12 @@ attach_task_test()
>  		exit_status=1
>  	fi
> 
> -	/bin/kill $pid &> /dev/null
> +	/bin/kill $pid > /dev/null 2>&1
>  	cleanup
>  	if [ $? -ne 0 ]; then
>  		exit_status=1
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
> index 5ff3176..a80462b 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset03"
>  export TST_TOTAL=18
>  export TST_COUNT=1
> @@ -217,7 +217,7 @@ test18()
>  	test 0 = $(cat "$CPUSET/father/child/mem_exclusive") || return 1
>  }
> 
> -for ((i=1; i <=$TST_TOTAL; i++))
> +for i in $(seq 1 $TST_TOTAL)
>  do
>  	setup
>  	if [ $? -ne 0 ]; then
> @@ -238,7 +238,7 @@ do
>  			exit_status=1
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  done
> 
>  exit $exit_status
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
> index 3abf7e2..f0f50b2 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset04"
>  export TST_TOTAL=32
>  export TST_COUNT=1
> @@ -442,7 +442,7 @@ test32()
>  	test 0 = "$(cat "$CPUSET/father/child/mems")" || return 1
>  }
> 
> -for ((i=1; i <=$TST_TOTAL; i++))
> +for i in $(seq 1 $TST_TOTAL)
>  do
>  	setup
>  	if [ $? -ne 0 ]; then
> @@ -463,7 +463,7 @@ do
>  			exit_status=1
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  done
> 
>  exit $exit_status
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> index 6886874..0ea5af9 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset08"
>  export TST_TOTAL=13
>  export TST_COUNT=1
> @@ -76,7 +76,7 @@ root_cpu_hotplug_test()
>  		return 1
>  	fi
> 
> -	/bin/cat /dev/zero &> /dev/null &
> +	/bin/cat /dev/zero > /dev/null 2>&1 &
>  	tst_pid=$!
> 
>  	cpu_hotplug $HOTPLUG_CPU $cpuhotplug 2> $CPUSET_TMP/stderr
> @@ -104,7 +104,7 @@ root_cpu_hotplug_test()
>  		tst_resm TFAIL "root group's cpus isn't expected(Result: $root_cpus, Expect: $expect_cpus)."
>  	fi
> 
> -	/bin/kill -9 $tst_pid &> /dev/null
> +	/bin/kill -9 $tst_pid > /dev/null 2>&1
> 
>  	return $ret
>  }
> @@ -136,7 +136,7 @@ general_cpu_hotplug_test()
>  		return 1
>  	fi
> 
> -	/bin/cat /dev/zero &> /dev/null &
> +	/bin/cat /dev/zero > /dev/null 2>&1 &
>  	tst_pid=$!
> 
>  	echo $tst_pid > "$path/tasks" 2> $CPUSET_TMP/stderr
> @@ -160,7 +160,7 @@ general_cpu_hotplug_test()
>  	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
>  	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
> 
> -	if [ "$expect_cpus" == "EMPTY" ]; then
> +	if [ "$expect_cpus" = "EMPTY" ]; then
>  		local tasks=`cat $path/tasks | grep "\b$tst_pid\b"`
>  		check_result "$tasks" "EMPTY"
>  		if [ $? -ne 0 ]; then
> @@ -187,12 +187,12 @@ general_cpu_hotplug_test()
>  			tst_resm TFAIL "task's cpu allowed list isn't expected(Result: $task_cpus, Expect: $expect_task_cpus)."
>  		fi
>  	else
> -		if [ "$cpus" == "" ]; then
> +		if [ "$cpus" = "" ]; then
>  			cpus="EMPTY"
>  		fi
>  		tst_resm TFAIL "general group's cpus isn't expected(Result: $cpus, Expect: $expect_cpus)."
>  	fi
> -	/bin/kill -s SIGKILL $tst_pid &> /dev/null
> +	/bin/kill -s SIGKILL $tst_pid > /dev/null 2>&1
> 
>  	return $ret
>  }
> @@ -218,7 +218,7 @@ base_test()
> 
>  		cpu_hotplug_cleanup
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
>  # Test Case 1-2
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
> index 8dc1c13..ed5dcb4 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset02"
>  export TST_TOTAL=27
>  export TST_COUNT=1
> @@ -52,7 +52,7 @@ base_op_write_and_test()
>  		tst_brkm TFAIL "Failed to mkdir -p $(basename $write_file)"
>  		return 1
>  	}
> -	[ "$write_string" == NULL ] && write_string=" "
> +	[ "$write_string" = NULL ] && write_string=" "
> 
>  	/bin/echo "$write_string" > "$write_file" 2> $CPUSET_TMP/stderr
>  	mkdir $(dirname $write_file)/2 2> $CPUSET_TMP/stderr
> @@ -97,7 +97,7 @@ inherit_test()
>  			exit_status=1
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
>  test_cpus()
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuset_funcs.sh
> index e473c27..aca0aaf 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuset_funcs.sh
> @@ -31,7 +31,7 @@ else
>  	N_NODES="`cat /sys/devices/system/node/has_normal_memory`"
>  fi
>  N_NODES=${N_NODES#*-*}
> -((N_NODES++))
> +: $((N_NODES++))
> 
>  CPUSET="/dev/cpuset"
>  CPUSET_TMP="/tmp/cpuset_tmp"
> @@ -89,7 +89,7 @@ user_check()
> 
>  cpuset_check()
>  {
> -	grep cpuset /proc/cgroups &> /dev/null
> +	grep cpuset /proc/cgroups > /dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_brkm TCONF ignored "Cpuset is not supported"
>  		return 1
> @@ -152,8 +152,8 @@ setup()
>  # Write the cleanup function
>  cleanup()
>  {
> -	mount | grep "$CPUSET" &>/dev/null || {
> -		rm -rf "$CPUSET" &>/dev/null
> +	mount | grep "$CPUSET" >/dev/null 2>&1 || {
> +		rm -rf "$CPUSET" >/dev/null 2>&1
>  		return 0
>  	}
> 
> @@ -161,7 +161,7 @@ cleanup()
>  	do
>  		while read pid
>  		do
> -			/bin/kill $pid &> /dev/null
> +			/bin/kill $pid > /dev/null 2>&1
>  			if [ $? -ne 0 ]; then
>  				tst_brkm TFAIL ignored "Couldn't kill task - "\
>  							"$pid in the cpuset"
> @@ -182,8 +182,8 @@ cleanup()
>  					" cpuset on $CPUSET..Exiting test"
>  		return 1
>  	fi
> -	rmdir "$CPUSET" &> /dev/null
> -	rm -rf "$CPUSET_TMP" &> /dev/null
> +	rmdir "$CPUSET" > /dev/null 2>&1
> +	rm -rf "$CPUSET_TMP" > /dev/null 2>&1
>  }
> 
>  # set the cpuset's parameter
> @@ -223,12 +223,12 @@ cpuset_set()
>  # cpu_hotplug cpu_id offline/online
>  cpu_hotplug()
>  {
> -	if [ "$2" == "online" ]; then
> +	if [ "$2" = "online" ]; then
>  		/bin/echo 1 > "/sys/devices/system/cpu/cpu$1/online"
>  		if [ $? -ne 0 ]; then
>  			return 1
>  		fi
> -	elif [ "$2" == "offline" ]; then
> +	elif [ "$2" = "offline" ]; then
>  		/bin/echo 0 > "/sys/devices/system/cpu/cpu$1/online"
>  		if [ $? -ne 0 ]; then
>  			return 1
> @@ -241,7 +241,7 @@ cpu_hotplug()
>  #   offline - offline a CPU in testing, we needn't do anything
>  setup_test_environment()
>  {
> -	if [ "$1" == "online" ]; then
> +	if [ "$1" = "online" ]; then
>  		cpu_hotplug $HOTPLUG_CPU offline
>  		if [ $? -ne 0 ]; then
>  			return 1
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
> index 06ce676..61d1288 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset07"
>  export TST_TOTAL=13
>  export TST_COUNT=1
> @@ -307,7 +307,7 @@ base_test()
> 
>  		cpu_hotplug_cleanup
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
>  test_general_load_balance1()
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
> index 8fcf18a..97fe711 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset06"
>  export TST_TOTAL=19
>  export TST_COUNT=1
> @@ -222,7 +222,7 @@ base_test()
> 
>  		cpu_hotplug_cleanup
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  }
> 
>  # Casee 1-6
> @@ -236,7 +236,7 @@ test_root_load_balance()
>  	while read isbalance level hotplug
>  	do
>  		base_test $isbalance $hotplug
> -		((file_case_num++))
> +		: $((file_case_num++))
>  	done <<- EOF
>  		0	none
>  		1	none
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> index 3b8cdca..7a1a157 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset10"
>  export TST_TOTAL=6
>  export TST_COUNT=1
> @@ -51,7 +51,7 @@ test1()
>  	fi
> 
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
>  			tst_resm TFAIL "Memory_pressure had memory pressure rate."
> @@ -72,7 +72,7 @@ test2()
>  	./cpuset_memory_pressure $usemem
> 
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
>  			tst_resm TFAIL "Memory_pressure had memory pressure rate."
> @@ -98,7 +98,7 @@ test3()
>  	fi
> 
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
>  			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
> @@ -145,7 +145,7 @@ test4()
>  	fi
> 
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -ne 0 ]; then
>  			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
> @@ -176,7 +176,7 @@ test5()
> 
>  	./cpuset_memory_pressure $usemem
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -eq 0 ]; then
>  			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
> @@ -222,7 +222,7 @@ test6()
> 
>  	./cpuset_memory_pressure $usemem
>  	local i
> -	for ((i=0; i<10; i++))
> +	for i in $(seq 0 9)
>  	do
>  		if [ $(cat "$CPUSET/memory_pressure") -eq 0 ]; then
>  			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
> @@ -235,7 +235,7 @@ test6()
>  	done
>  }
> 
> -for ((c=1; c <=$TST_TOTAL; c++))
> +for c in $(seq 1 $TST_TOTAL)
>  do
>  	setup
>  	if [ $? -ne 0 ]; then
> @@ -254,7 +254,7 @@ do
>  			fi
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  done
> 
>  exit $exit_status
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> index 2423da5..097a9b5 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset11"
>  export TST_TOTAL=6
>  export TST_COUNT=1
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> index 5e0b187..70433da 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> @@ -22,7 +22,7 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> +. ./cpuset_funcs.sh
> 
>  cd $LTPROOT/testcases/bin
> 
> @@ -152,7 +152,7 @@ check_hugetlbfs()
>  {
>  	local fssupport="grep -w hugetlbfs /proc/filesystems 2>/dev/null | cut -f2"
> 
> -	if [ "$fssupport" == "hugetlbfs" ]; then
> +	if [ "$fssupport" = "hugetlbfs" ]; then
>  		return 1
>  	else
>  		return 0
> @@ -469,7 +469,7 @@ get_the_second()
>  	ls /proc/$1/task | (
>  		read tid1
>  		read tid2
> -		if (($1 == tid1))
> +		if [ "$1" -eq "$tid1" ]
>  		then
>  			echo $tid2
>  		else
> @@ -806,7 +806,7 @@ test18()
>  	fi
>  }
> 
> -for ((c=1; c <=$TST_TOTAL; c++))
> +for c in $(seq 1 $TST_TOTAL)
>  do
>  	setup
>  	if [ $? -ne 0 ]; then
> @@ -825,7 +825,7 @@ do
>  			fi
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  done
> 
>  exit $exit_status
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> index 8223bb0..3dc55d6 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> @@ -22,10 +22,10 @@
>  #                                                                              #
>  ################################################################################
> 
> -source ./cpuset_funcs.sh
> -
>  cd $LTPROOT/testcases/bin
> 
> +. ./cpuset_funcs.sh
> +
>  export TCID="cpuset05"
>  export TST_TOTAL=16
>  export TST_COUNT=1
> @@ -315,7 +315,7 @@ test16()
>  	return 0
>  }
> 
> -for ((c=1; c <=$TST_TOTAL; c++))
> +for c in $(seq 1 $TST_TOTAL)
>  do
>  	setup
>  	if [ $? -ne 0 ]; then
> @@ -334,7 +334,7 @@ do
>  			fi
>  		fi
>  	fi
> -	((TST_COUNT++))
> +	: $((TST_COUNT++))
>  done
> 
>  exit $exit_status
> diff --git a/testcases/kernel/controllers/memcg/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/memcg_regression_test.sh
> index bfe9f42..28423c1 100755
> --- a/testcases/kernel/controllers/memcg/memcg_regression_test.sh
> +++ b/testcases/kernel/controllers/memcg/memcg_regression_test.sh
> @@ -128,8 +128,7 @@ test_2()
>  	pid2=$!
> 
>  	# check if 'echo' will exit and exit with failure
> -	for ((tmp = 0; tmp < 5; tmp++))
> -	{
> +	for tmp in $(seq 0 4); do
>  		sleep 1
>  		ps -p $! > /dev/null
>  		if [ $? -ne 0 ]; then
> @@ -143,7 +142,7 @@ test_2()
>  			fi
>  			break
>  		fi
> -	}
> +	done
> 
>  	if [ $tmp -eq 5 ]; then
>  		tst_resm TFAIL "'echo' doesn't exit!"
> @@ -206,8 +205,7 @@ test_4()
> 
>  mkdir memcg/
> 
> -for ((cur = 1; cur <= $TST_TOTAL; cur++))
> -{
> +for cur in $(seq 1 $TST_TOTAL); do
>  	export TST_COUNT=$cur
> 
>  	mount -t cgroup -o memory xxx memcg/
> @@ -219,7 +217,7 @@ for ((cur = 1; cur <= $TST_TOTAL; cur++))
>  	test_$cur
> 
>  	umount memcg/
> -}
> +done
> 
>  rmdir memcg/
> 
> diff --git a/testcases/kernel/io/stress_floppy/generate.sh b/testcases/kernel/io/stress_floppy/generate.sh
> index 13482bd..1fce03f 100755
> --- a/testcases/kernel/io/stress_floppy/generate.sh
> +++ b/testcases/kernel/io/stress_floppy/generate.sh
> @@ -19,17 +19,17 @@ if [ ! -d dumpdir ]; then
>     mkdir dumpdir
>  fi
> 
> -`diff --brief 1K_file dumpdir/1K_file &> /dev/null`
> +`diff --brief 1K_file dumpdir/1K_file > /dev/null 2>&1`
>  if [ $? ]; then
>     cp 1K_file dumpdir
>  fi
> 
> -`diff --brief 10K_file dumpdir/10K_file &> /dev/null`
> +`diff --brief 10K_file dumpdir/10K_file > /dev/null 2>&1`
>  if [ $? ]; then
>     cp 10K_file dumpdir
>  fi
> 
> -`diff --brief 100K_file dumpdir/100K_file &> /dev/null`
> +`diff --brief 100K_file dumpdir/100K_file > /dev/null 2>&1`
>  if [ $? ]; then
>     cp 100K_file dumpdir
>  fi
> -- 
> 1.6.3.1
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Are you an open source citizen? Join us for the Open Source Bridge conference!
> Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
> Need another reason to go? 24-hour hacker lounge. Register today!
> http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
