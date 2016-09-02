From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 2 Sep 2016 12:42:00 +0300
Subject: [LTP] [PATCH 3/4] memcg_lib.sh: Get rid of sleep 1 in
 signal_memcg_process
In-Reply-To: <1472750315-30848-3-git-send-email-chrubis@suse.cz>
References: <1472750315-30848-1-git-send-email-chrubis@suse.cz>
 <1472750315-30848-3-git-send-email-chrubis@suse.cz>
Message-ID: <57C94968.5070609@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 09/01/2016 08:18 PM, Cyril Hrubis wrote:
> The signal_memcg_process function, if passed a size paramter, now polls
                                                      ^^^^^^^^
typo

> the memory.usage_in_bytes file until it increases or decreases by a
> given amount (the amount the memcg_process is expected to allocate/free)
> or until the process is killed.
> 
> We now sleep only in the warmup and only after we send second signal to
> the memcg_process.
> 
> This further brings down the test runtime down by another minute, now
> the tests finish in about 30 second while we also assert that the
> usage_in_bytes gets incremented as process consumes memory.

50s vs 2m30s in my environment. Cool :)

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../memcg/functional/memcg_function_test.sh        |  28 +++---
>  .../controllers/memcg/functional/memcg_lib.sh      | 107 +++++++++++++--------
>  .../memcg_move_charge_at_immigrate_test.sh         |  13 +--
>  .../memcg/functional/memcg_stat_test.sh            |  11 ++-
>  .../memcg/functional/memcg_usage_in_bytes_test.sh  |   4 +-
>  5 files changed, 95 insertions(+), 68 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> index 1bb75d0..fadbcea 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> @@ -41,54 +41,54 @@ LOCAL_CLEANUP=shmmax_cleanup
>  # Case 1 - 10: Test the management and counting of memory
>  testcase_1()
>  {
> -	test_mem_stat "--mmap-anon" $PAGESIZE "rss" $PAGESIZE 0
> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
>  }
>  
>  testcase_2()
>  {
> -	test_mem_stat "--mmap-file" $PAGESIZE "rss" 0 0
> +	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 false
>  }
>  
>  testcase_3()
>  {
> -	test_mem_stat "--shm -k 3" $PAGESIZE "rss" 0 0
> +	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 false
>  }
>  
>  testcase_4()
>  {
> -	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE "rss" \
> -		$PAGESIZE 0
> +	test_mem_stat "--mmap-anon --mmap-file --shm" \
> +		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE false
>  }
>  
>  testcase_5()
>  {
> -	test_mem_stat "--mmap-lock1" $PAGESIZE "rss" $PAGESIZE 0
> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
>  }
>  
>  testcase_6()
>  {
> -	test_mem_stat "--mmap-anon" $PAGESIZE "rss" $PAGESIZE 1
> +	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
>  }
>  
>  testcase_7()
>  {
> -	test_mem_stat "--mmap-file" $PAGESIZE "rss" 0 1
> +	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 true
>  }
>  
>  testcase_8()
>  {
> -	test_mem_stat "--shm -k 8" $PAGESIZE "rss" 0 1
> +	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 true
>  }
>  
>  testcase_9()
>  {
> -	test_mem_stat "--mmap-anon --mmap-file --shm" $PAGESIZE "rss" \
> -		$PAGESIZE 1
> +	test_mem_stat "--mmap-anon --mmap-file --shm" \
> +		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE true
>  }
>  
>  testcase_10()
>  {
> -	test_mem_stat "--mmap-lock1" $PAGESIZE "rss" $PAGESIZE 1
> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
>  }
>  
>  # Case 11 - 13: Test memory.failcnt
> @@ -211,7 +211,7 @@ testcase_29()
>  	pid=$!
>  	TST_CHECKPOINT_WAIT 0
>  	echo $pid > tasks
> -	signal_memcg_process $pid
> +	signal_memcg_process $pid $PAGESIZE
>  	echo $pid > ../tasks
>  
>  	# This expects that there is swap configured
> @@ -226,7 +226,7 @@ testcase_30()
>  	pid=$!
>  	TST_CHECKPOINT_WAIT 0
>  	echo $pid > tasks
> -	signal_memcg_process $pid
> +	signal_memcg_process $pid $PAGESIZE
>  
>  	EXPECT_FAIL echo 1 \> memory.force_empty
>  
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 26d2783..d9272cd 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -89,25 +89,45 @@ check_mem_stat()
>  
>  signal_memcg_process()
>  {
> -	pid=$1
> +	local pid=$1
> +	local size=$2
> +	local path=$3
> +	local usage_start=$(cat ${path}memory.usage_in_bytes)

A side note.

In fact, in LTP we use 'local' in test cases written for '/bin/sh',
whereas 'local' is not in POSIX. Maybe document this fact in the test
writing guidelines?

> +
>  	kill -s USR1 $pid 2> /dev/null
> -	sleep 1
> +
> +	if [ -z "$size" ]; then
> +		return
> +	fi
> +
> +	while kill -0 $pid 2> /dev/null; do
> +		local usage=$(cat ${path}memory.usage_in_bytes)
> +		local diff_a=$((usage_start - usage))
> +		local diff_b=$((usage - usage_start))
> +
> +		if [ "$diff_a" -ge "$size" -o "$diff_b" -ge "$size" ]; then
> +			return
> +		fi
> +
> +		tst_sleep 100ms
> +	done

Maybe add some limit on the number of checks? In case the process
consumes less memory than in $size.

>  }
>  
>  stop_memcg_process()
>  {
> -	pid=$1
> +	local pid=$1
>  	kill -s INT $pid 2> /dev/null
>  	wait $pid
>  }
>  
>  warmup()
>  {
> -	pid=$1
> +	local pid=$1
>  
>  	tst_resm TINFO "Warming up pid: $pid"
>  	signal_memcg_process $pid
>  	signal_memcg_process $pid
> +	sleep 1
>  
>  	kill -0 $pid
>  	if [ $? -ne 0 ]; then
> @@ -123,15 +143,17 @@ warmup()
>  
>  # Run test cases which checks memory.stat after make
>  # some memory allocation
> -# $1 - the parameters of 'process', such as --shm
> -# $2 - the -s parameter of 'process', such as 4096
> -# $3 - item name in memory.stat
> -# $4 - the expected size
> -# $5 - check after free ?
>  test_mem_stat()
>  {
> -	tst_resm TINFO "Running memcg_process $1 -s $2"
> -	memcg_process $1 -s $2 &
> +	local memtypes="$1"
> +	local size=$2
> +	local total_size=$3
> +	local stat_name=$4
> +	local exp_stat_size=$5
> +	local check_after_free=$6
> +
> +	tst_resm TINFO "Running memcg_process $memtypes -s $size"
> +	memcg_process $memtypes -s $size &
>  	TST_CHECKPOINT_WAIT 0
>  
>  	warmup $!
> @@ -140,13 +162,13 @@ test_mem_stat()
>  	fi
>  
>  	echo $! > tasks
> -	signal_memcg_process $!
> +	signal_memcg_process $! $size
>  
> -	check_mem_stat $3 $4
> +	check_mem_stat $stat_name $exp_stat_size
>  
> -	signal_memcg_process $!
> -	if [ $5 -eq 1 ]; then
> -		check_mem_stat $3 0
> +	signal_memcg_process $! $size
> +	if $check_after_free; then
> +		check_mem_stat $stat_name 0
>  	fi
>  
>  	stop_memcg_process $!
> @@ -171,8 +193,8 @@ test_max_usage_in_bytes()
>  	fi
>  
>  	echo $! > tasks
> -	signal_memcg_process $!
> -	signal_memcg_process $!
> +	signal_memcg_process $! $2
> +	signal_memcg_process $! $2
>  
>  	check_mem_stat $3 $4
>  
> @@ -194,8 +216,8 @@ malloc_free_memory()
>  	TST_CHECKPOINT_WAIT 0
>  
>  	echo $! > tasks
> -	signal_memcg_process $!
> -	signal_memcg_process $!
> +	signal_memcg_process $! $2
> +	signal_memcg_process $! $2
>  
>  	stop_memcg_process $!
>  }
> @@ -234,7 +256,7 @@ test_proc_kill()
>  	TST_CHECKPOINT_WAIT 0
>  	echo $pid > tasks
>  
> -	signal_memcg_process $pid
> +	signal_memcg_process $pid $3
>  
>  	tpk_pid_exists=1
>  	for tpk_iter in $(seq 20); do
> @@ -311,7 +333,7 @@ test_hugepage()
>  	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
>  	TST_CHECKPOINT_WAIT 0
>  
> -	signal_memcg_process $!
> +	signal_memcg_process $! $3
>  
>  	check_mem_stat "rss" 0
>  
> @@ -323,14 +345,14 @@ test_hugepage()
>  		if [ $? -eq 0 ]; then
>  			tst_resm TPASS "allocate hugepage failed as expected"
>  		else
> -			signal_memcg_process $!
> +			signal_memcg_process $! $3
>  			stop_memcg_process $!
>  			tst_resm TFAIL "allocate hugepage should fail"
>  		fi
>  	else
>  		test ! -s $TMP_FILE
>  		if [ $? -eq 0 ]; then
> -			signal_memcg_process $!
> +			signal_memcg_process $! $3
>  			stop_memcg_process $!
>  			tst_resm TPASS "allocate hugepage succeeded"
>  		else
> @@ -358,13 +380,13 @@ test_subgroup()
>  	memcg_process --mmap-anon -s $PAGESIZE &
>  	TST_CHECKPOINT_WAIT 0
>  
> -	warmup $!
> +	warmup $! $PAGESIZE
>  	if [ $? -ne 0 ]; then
>  		return
>  	fi
>  
>  	echo $! > tasks
> -	signal_memcg_process $!
> +	signal_memcg_process $! $PAGESIZE
>  	check_mem_stat "rss" $PAGESIZE
>  
>  	cd subgroup
> @@ -379,17 +401,21 @@ test_subgroup()
>  }
>  
>  # Run test cases which test memory.move_charge_at_immigrate
> -# $1 - the parameters of 'process', such as --shm
> -# $2 - the -s parameter of 'process', such as 4096
> -# $3 - some positive value, such as 1
> -# $4 - the expected size
> -# $5 - the expected size
>  test_move_charge()
>  {
> +	local memtypes="$1"
> +	local size=$2
> +	local total_size=$3
> +	local move_charge_mask=$4
> +	local b_rss=$5
> +	local b_cache=$6
> +	local a_rss=$7
> +	local a_cache=$8
> +
>  	mkdir subgroup_a
>  
> -	tst_resm TINFO "Running memcg_process $1 -s $2"
> -	memcg_process $1 -s $2 &
> +	tst_resm TINFO "Running memcg_process $memtypes -s $size"
> +	memcg_process $memtypes -s $size &
>  	TST_CHECKPOINT_WAIT 0
>  	warmup $!
>  	if [ $? -ne 0 ]; then
> @@ -398,22 +424,19 @@ test_move_charge()
>  	fi
>  
>  	echo $! > subgroup_a/tasks
> -	signal_memcg_process $!
> +	signal_memcg_process $! $total_size "subgroup_a/"
>  
>  	mkdir subgroup_b
> -	echo $3 > subgroup_b/memory.move_charge_at_immigrate
> +	echo $move_charge_mask > subgroup_b/memory.move_charge_at_immigrate
>  	echo $! > subgroup_b/tasks
>  
>  	cd subgroup_b
> -	check_mem_stat "rss" $4
> -	check_mem_stat "cache" $5
> +	check_mem_stat "rss" $b_rss
> +	check_mem_stat "cache" $b_cache
>  	cd ../subgroup_a
> -	check_mem_stat "rss" $6
> -	check_mem_stat "cache" $7
> -
> +	check_mem_stat "rss" $a_rss
> +	check_mem_stat "cache" $a_cache
>  	cd ..
> -	echo $! > tasks
> -	signal_memcg_process $!
>  	stop_memcg_process $!
>  	rmdir subgroup_a subgroup_b
>  }
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> index aeb7d0f..6cdc7ed 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> @@ -34,27 +34,28 @@ TST_TOTAL=4
>  # Test disable moving charges
>  testcase_1()
>  {
> -	test_move_charge "--mmap-anon" $PAGESIZE  0 0 0 $PAGESIZE 0
> +	test_move_charge "--mmap-anon" $PAGESIZE $PAGESIZE 0 0 0 $PAGESIZE 0
>  }
>  
>  # Test move anon
>  testcase_2()
>  {
> -	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE 1 \
> -		$PAGESIZE 0 0 $((PAGESIZE*2))
> +	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE \
> +		$((PAGESIZE*3)) 1 $PAGESIZE 0 0 $((PAGESIZE*2))
>  }
>  
>  # Test move file
>  testcase_3()
>  {
> -	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE 2 \
> -		0 $((PAGESIZE*2)) $PAGESIZE 0
> +	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE \
> +		$((PAGESIZE*3)) 2 0 $((PAGESIZE*2)) $PAGESIZE 0
>  }
>  
>  # Test move anon and file
>  testcase_4()
>  {
> -	test_move_charge "--mmap-anon --shm" $PAGESIZE 3 $PAGESIZE $PAGESIZE 0 0
> +	test_move_charge "--mmap-anon --shm" $PAGESIZE \
> +		$((PAGESIZE*2)) 3 $PAGESIZE $PAGESIZE 0 0
>  }
>  
>  run_tests
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
> index 1f28aa4..2c47a92 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
> @@ -34,25 +34,28 @@ TST_TOTAL=8
>  # Test cache
>  testcase_1()
>  {
> -	test_mem_stat "--shm -k 3" $PAGESIZE "cache" $PAGESIZE 0
> +	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "cache" $PAGESIZE false
>  }
>  
>  # Test mapped_file
>  testcase_2()
>  {
> -	test_mem_stat "--mmap-file" $PAGESIZE "mapped_file" $PAGESIZE 0
> +	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE \
> +		"mapped_file" $PAGESIZE false
>  }
>  
>  # Test unevictable with MAP_LOCKED
>  testcase_3()
>  {
> -	test_mem_stat "--mmap-lock1" $PAGESIZE "unevictable" $PAGESIZE 0
> +	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE \
> +		"unevictable" $PAGESIZE false
>  }
>  
>  # Test unevictable with mlock
>  testcase_4()
>  {
> -	test_mem_stat "--mmap-lock2" $PAGESIZE "unevictable" $PAGESIZE 0
> +	test_mem_stat "--mmap-lock2" $PAGESIZE $PAGESIZE \
> +		"unevictable" $PAGESIZE false
>  }
>  
>  # Test hierarchical_memory_limit with enabling hierarchical accounting
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> index ab86318..69dc874 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
> @@ -34,7 +34,7 @@ TST_TOTAL=2
>  # Test memory.usage_in_bytes
>  testcase_1()
>  {
> -	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) \
> +	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
>  		"memory.usage_in_bytes" $((PAGESIZE*1024)) 0
>  }
>  
> @@ -48,7 +48,7 @@ testcase_2()
>  
>  	echo $((PAGESIZE*2048)) > memory.limit_in_bytes
>  	echo $((PAGESIZE*2048)) > memory.memsw.limit_in_bytes
> -	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) \
> +	test_mem_stat "--mmap-anon" $((PAGESIZE*1024)) $((PAGESIZE*1024)) \
>  		"memory.memsw.usage_in_bytes" $((PAGESIZE*1024)) 0
>  }

The above two calls need '0' substituted with 'false'.

Other than that, this patch looks good.
