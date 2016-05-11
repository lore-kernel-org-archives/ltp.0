From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 May 2016 17:01:08 +0200
Subject: [LTP] [PATCH 3/4] memcg_stress_test.sh: rewrite
In-Reply-To: <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160511150108.GI24701@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -cd $LTPROOT/testcases/bin
> -export TCID="memcg_stress_test"
> -export TST_TOTAL=2
> -export TST_COUNT=0
> +TCID=memcg_stress_test
> +TST_TOTAL=2
> +. test.sh
>  
>  if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
> -        echo "WARNING:";
> -        echo "Either Kernel does not support for memory resource controller or feature not enabled";
> -        echo "Skipping all memcgroup testcases....";
> -        exit 0
> +	tst_brkm TCONF "Kernel does not support the memory resource controller"
>  fi
>  
>  RUN_TIME=$(( 60 * 60 ))
>  
> +children=""
> +nr_children=0
> +memcg_path=/dev/memcg
> +memcg_created=0
> +
>  cleanup()
>  {
> -	if [ -e /dev/memcg ]; then
> -		umount /dev/memcg 2>/dev/null
> -		rmdir /dev/memcg 2>/dev/null
> +	for child in $children; do
> +		kill -s KILL $child 2> /dev/null
> +	done
> +	wait
> +
> +	if [ "$memcg_created" -ne 0 ]; then
> +		for i in $(seq 0 $(( $nr_children - 1 ))); do
> +			rmdir "$memcg_path/$i" 2> /dev/null
> +		done
> +		umount "$memcg_path"
> +		rmdir "$memcg_path"
>  	fi
>  }
> +TST_CLEANUP=cleanup
>  
> +do_unmount()
> +{
> +	ROD umount "$memcg_path"
> +	ROD rmdir "$memcg_path"
> +	memcg_created=0
> +}
>  
>  do_mount()
>  {
> -	cleanup;
> -
> -	mkdir /dev/memcg 2> /dev/null
> -	mount -t cgroup -omemory memcg /dev/memcg
> +	ROD mkdir "$memcg_path"
> +	memcg_created=1
> +	ROD mount -t cgroup -omemory memcg "$memcg_path"
>  }
>  
> +is_int()
> +{
> +	[ "$1" -eq "$1" ] 2> /dev/null
> +	return $?
> +}
>  
>  # Run the stress test
>  #
> @@ -65,33 +85,41 @@ do_mount()
>  # $4 - How long does this test run ? in second
>  run_stress()
>  {
> -	do_mount;
> +	nr_children=0
> +	children=""
> +
> +	do_mount
>  
> -	for i in $(seq 0 $(($1-1)))
> -	do
> -		mkdir /dev/memcg/$i 2> /dev/null
> +	for i in $(seq 0 $(( $1 - 1 ))); do
> +		ROD mkdir "$memcg_path/$i"
>  		./memcg_process_stress $2 $3 &

We should drop the ./ here since the binary is in $PATH

> -		eval pid$i=$!
> +		child=$!
>  
> -		eval echo \$pid$i > /dev/memcg/$i/tasks
> +		nr_children=$(( $nr_children + 1 ))
> +		children="$children $child"
> +
> +		ROD echo $child \> "$memcg_path/$i/tasks"
>  	done
>  
> -	for i in $(seq 0 $(($1-1)))
> -	do
> -		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
> +	for child in $children; do
> +		ROD /bin/kill -s SIGUSR1 $child

Here drop the /bin/ and remove the SIG from the signal name.

>  	done
>  
>  	sleep $4
>  
> -	for i in $(seq 0 $(($1-1)))
> -	do
> -		eval /bin/kill -s SIGKILL \$pid$i 2> /dev/null
> -		eval wait \$pid$i
> +	for child in $children; do
> +		ROD /bin/kill -s SIGINT $child

Here as well.

> +	done
> +
> +	for child in $children; do
> +		ROD wait $child
> +	done
>  
> -		rmdir /dev/memcg/$i 2> /dev/null
> +	for i in $(seq 0 $(( $nr_children - 1 ))); do
> +		ROD rmdir "$memcg_path/$i"
>  	done
>  
> -	cleanup;
> +	do_unmount
>  }
>  
>  testcase_1()
> @@ -108,19 +136,23 @@ testcase_2()
>  	tst_resm TPASS "stress test 2 passed"
>  }
>  
> -echo 3 > /proc/sys/vm/drop_caches
> +ROD echo 3 \> /proc/sys/vm/drop_caches
>  sleep 2
> +
>  mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`

mem_free=$(awk '/MemFree/ {print $2}' /proc/meminfo)

> +is_int "$mem_free" || tst_brkm TBROK "Unable to determine mem_free"
> +
>  swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`

Here as well.

> +is_int "$swap_free" || tst_brkm TBROK "Unable to determine swap_free"
>  
>  mem=$(( $mem_free + $swap_free / 2 ))
> -mem=$(( mem / 1024 ))
> +mem=$(( $mem / 1024 ))
> +[ "$mem" -gt 0 ] || tst_brkm TBROK "mem is negative: $mem"
>  
>  date
> -export TST_COUNT=$(( $TST_COUNT + 1 ))
>  testcase_1
> -export TST_COUNT=$(( $TST_COUNT + 1 ))
> +date
>  testcase_2
>  date
>  
> -exit 0
> +tst_exit

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
