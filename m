From: Cedric Hnyda <chnyda@suse.com>
Date: Wed, 11 Nov 2015 16:51:26 +0100
Subject: [LTP] [PATCH V4] plop
In-Reply-To: <1447256842-9226-1-git-send-email-chnyda@suse.com>
References: <1447256842-9226-1-git-send-email-chnyda@suse.com>
Message-ID: <564363FE.7060302@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry this is a mistake.
This message should not have been sent.

Please forget about this message.

Best,
Cedric

On 11/11/2015 04:47 PM, Cedric Hnyda wrote:
> Signed-off-by: Cedric Hnyda <chnyda@suse.com>
> ---
>   .../controllers/cgroup_fj/cgroup_fj_function2.sh   | 199 +++++----------------
>   1 file changed, 44 insertions(+), 155 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> index 68d290b..451fba3 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> @@ -23,14 +23,14 @@
>   ################################################################################
>   
>   caseno=$1
> +subsystem=$2
>   pid=0;
> -subsystem=1;
>   release_agent_para=1;
>   release_agent_echo=1;
> -subsystem_str="debug";
>   remount_use_str="";
>   noprefix_use_str="";
>   release_agent_para_str="";
> +mounted=1
>   
>   # not output debug info when stress test
>   no_debug=0
> @@ -38,7 +38,7 @@ no_debug=0
>   usage()
>   {
>   	echo "usage of cgroup_fj_function2.sh: "
> -	echo "  ./cgroup_fj_function2.sh -case number[1-13]"
> +	echo "  ./cgroup_fj_function2.sh -cgroup -case number[1-9]"
>   	echo "example: ./cgroup_fj_function2.sh 1"
>   	echo "  will test the 1st case"
>   }
> @@ -56,122 +56,74 @@ export TMPFILE=$TESTROOT/tmp_tasks
>   
>   case1()
>   {
> -	do_mkdir 1 1 /dev/cgroup/subgroup_2
> +	do_mkdir 1 1 $mount_point/ltp_subgroup_2
>   
> -	do_echo 1 0 $pid /dev/cgroup/subgroup_1/tasks
> +	do_echo 1 0 $pid $mount_point/ltp_subgroup_1/tasks
>   	sleep 1
> -	do_echo 1 0 $pid /dev/cgroup/subgroup_2/tasks
> +	do_echo 1 0 $pid $mount_point/ltp_subgroup_2/tasks
>   	sleep 1
> -	do_echo 1 1 $pid /dev/cgroup/tasks
> +	do_echo 1 1 $pid $mount_point/tasks
>   }
>   
>   case2()
>   {
> -	do_mkdir 1 1 /dev/cgroup/subgroup_2
> +	do_mkdir 1 1 $mount_point/ltp_subgroup_2
>   
>   	$TESTROOT/cgroup_fj_proc &
>   	pid2=$!
>   	sleep 1
>   
> -	cat /dev/cgroup/tasks > $TMPFILE
> +	cat $mount_point/tasks > $TMPFILE
>   	nlines=`cat $TMPFILE | wc -l`
>   	for i in `seq 1 $nlines`
>   	do
>   		cur_pid=`sed -n "$i""p" $TMPFILE`
>   		if [ -e /proc/$cur_pid/ ];then
> -			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_1/tasks
> +			do_echo 1 0 "$cur_pid" $mount_point/ltp_subgroup_1/tasks
>   		fi
>   	done
>   
>   	sleep 1
>   
> -	cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
> +	cat $mount_point/ltp_subgroup_1/tasks > $TMPFILE
>   	nlines=`cat $TMPFILE | wc -l`
>   	for i in `seq 1 $nlines`
>   	do
>   		cur_pid=`sed -n "$i""p" $TMPFILE`
>   		if [ -e /proc/$cur_pid/ ];then
> -			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_2/tasks
> +			do_echo 1 0 "$cur_pid" $mount_point/ltp_subgroup_2/tasks
>   		fi
>   	done
>   
>   	sleep 1
>   
> -	cat /dev/cgroup/subgroup_2/tasks > $TMPFILE
> +	cat $mount_point/ltp_subgroup_2/tasks > $TMPFILE
>   	nlines=`cat $TMPFILE | wc -l`
>   	for i in `seq 1 $nlines`
>   	do
>   		cur_pid=`sed -n "$i""p" $TMPFILE`
>   		if [ -e /proc/$cur_pid/ ];then
> -			do_echo 1 1 "$cur_pid" /dev/cgroup/tasks
> +			do_echo 1 1 "$cur_pid" $mount_point/tasks
>   		fi
>   	done
>   }
>   
>   case3()
>   {
> -	exist_subsystem "cpuset"
> -	exist_subsystem "ns"
> -	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
> +	do_mkdir 0 1 $mount_point/ltp_subgroup_2
>   
> -	mount_str="`mount -l | grep /dev/cgroup2`"
> -	if [ "$mount_str" != "" ]; then
> -		do_umount 0 1 /dev/cgroup2
> -	fi
> -
> -	if [ -e /dev/cgroup2 ]; then
> -		do_rmdir 1 1 /dev/cgroup2
> -	fi
> -
> -	do_mkdir 1 1 /dev/cgroup2
> -
> -	exist_subsystem "cpu"
> -	exist_subsystem "cpuacct"
> -	exist_subsystem "memory"
> -	do_mount 1 1 "-ocpu,cpuacct,memory" /dev/cgroup2 cgroup2
> -
> -	sleep 1
> -
> -	do_umount 0 1 /dev/cgroup
> -	do_rmdir 0 1 /dev/cgroup
> -	do_umount 0 1 /dev/cgroup2
> -	do_rmdir 0 1 /dev/cgroup2
> +	do_mv 0 1 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_3
>   }
>   
>   case4()
>   {
> -	exist_subsystem "cpuset"
> -	exist_subsystem "ns"
> -	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
> -
> -	mount_str="`mount -l | grep /dev/cgroup2`"
> -	if [ "$mount_str" != "" ]; then
> -		do_umount 1 1 /dev/cgroup2
> -	fi
> -
> -	if [ -e /dev/cgroup2 ]; then
> -		do_rmdir 0 1 /dev/cgroup2
> -	fi
> +	do_mkdir 0 1 $mount_point/ltp_subgroup_2
>   
> -	do_mkdir 0 1 /dev/cgroup2
> -
> -	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup2 cgroup2
> -
> -	sleep 1
> -
> -	do_umount 0 1 /dev/cgroup
> -	do_rmdir 0 1 /dev/cgroup
> -	do_umount 0 1 /dev/cgroup2
> -	do_rmdir 0 1 /dev/cgroup2
> +	do_mv 0 0 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_2
>   }
>   
>   case5()
>   {
> -	exist_subsystem "cpuset"
> -	exist_subsystem "ns"
> -	exist_subsystem "memory"
> -	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
> -
>   	mount_str="`mount -l | grep /dev/cgroup2`"
>   	if [ "$mount_str" != "" ]; then
>   		do_umount 1 1 /dev/cgroup2
> @@ -183,138 +135,75 @@ case5()
>   
>   	do_mkdir 0 1 /dev/cgroup2
>   
> -	do_mount 0 1 "-odebug,cpuset,memory" /dev/cgroup2 cgroup2
> +	do_mkdir 0 1 /dev/cgroup2/ltp_subgroup_2
> +
> +	do_mv 0 1 $mount_point/ltp_subgroup_1 $mount_point/ltp_subgroup_2
>   
>   	sleep 1
>   
> -	do_umount 0 1 /dev/cgroup
> -	do_rmdir 0 1 /dev/cgroup
> -	do_umount 0 1 /dev/cgroup2
> +	do_rmdir 0 1 /dev/cgroup2/ltp_subgroup_2
>   	do_rmdir 0 1 /dev/cgroup2
>   }
>   
>   case6()
>   {
> -	exist_subsystem "debug"
> -	exist_subsystem "cpuset"
> -	exist_subsystem "ns"
> -	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
> -
> -	mount_str="`mount -l | grep /dev/cgroup2`"
> -	if [ "$mount_str" != "" ]; then
> -		do_umount 1 1 /dev/cgroup2
> -	fi
> -
> -	if [ -e /dev/cgroup2 ]; then
> -		do_rmdir 0 1 /dev/cgroup2
> -	fi
> -
> -	do_mkdir 0 1 /dev/cgroup2
> -
> -	do_mount 0 1 "-oall" /dev/cgroup2 cgroup2
> -
> -	sleep 1
> +	do_mkdir 0 1 $mount_point/ltp_subgroup_2
>   
> -	do_umount 0 1 /dev/cgroup
> -	do_rmdir 0 1 /dev/cgroup
> -	do_umount 0 1 /dev/cgroup2
> -	do_rmdir 0 1 /dev/cgroup2
> +	do_mv 0 0 $mount_point/ltp_subgroup_1 $mount_point/tasks
>   }
>   
>   case7()
>   {
> -	do_mkdir 0 1 /dev/cgroup/subgroup_2
> -
> -	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_3
> -}
> -
> -case8()
> -{
> -	do_mkdir 0 1 /dev/cgroup/subgroup_2
> -
> -	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
> -}
> -
> -case9()
> -{
> -	mount_str="`mount -l | grep /dev/cgroup2`"
> -	if [ "$mount_str" != "" ]; then
> -		do_umount 1 1 /dev/cgroup2
> -	fi
> -
> -	if [ -e /dev/cgroup2 ]; then
> -		do_rmdir 0 1 /dev/cgroup2
> -	fi
> -
> -	do_mkdir 0 1 /dev/cgroup2
> -
> -	do_mkdir 0 1 /dev/cgroup2/subgroup_2
> -
> -	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
> -
> -	sleep 1
> -
> -	do_rmdir 0 1 /dev/cgroup2/subgroup_2
> -	do_rmdir 0 1 /dev/cgroup2
> -}
> -
> -case10()
> -{
> -	do_mkdir 0 1 /dev/cgroup/subgroup_2
> -
> -	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/tasks
> -}
> -
> -case11()
> -{
> -	do_echo 0 1 $pid /dev/cgroup/subgroup_1/tasks
> +	do_echo 0 1 $pid $mount_point/ltp_subgroup_1/tasks
>   
>   	sleep 1
>   
> -	do_rmdir 0 0 /dev/cgroup/subgroup_1
> +	do_rmdir 0 0 $mount_point/ltp_subgroup_1
>   
>   	sleep 1
>   
> -	do_echo 1 1 $pid /dev/cgroup/tasks
> +	do_echo 1 1 $pid $mount_point/tasks
>   }
>   
> -case12()
> +case8()
>   {
> -	do_mkdir 0 1 /dev/cgroup/subgroup_1/subgroup_1_1
> +	do_mkdir 0 1 $mount_point/ltp_subgroup_1/ltp_subgroup_1_1
>   
>   	sleep 1
>   
> -	do_rmdir 0 0 /dev/cgroup/subgroup_1
> +	do_rmdir 0 0 $mount_point/ltp_subgroup_1
>   
> -	do_rmdir 1 1 /dev/cgroup/subgroup_1/subgroup_1_1
> +	do_rmdir 1 1 $mount_point/ltp_subgroup_1/ltp_subgroup_1_1
>   }
>   
> -case13()
> +case9()
>   {
> -	do_rmdir 0 1 /dev/cgroup/subgroup_1
> +	do_rmdir 0 1 $mount_point/ltp_subgroup_1
>   }
>   
>   ##########################  main   #######################
> -if [ "$#" -ne "1" ] || [ $caseno -lt 1 ] || [ $caseno -gt 13 ]; then
> +if [ "$#" -ne "2" ] || [ $caseno -lt 1 ] || [ $caseno -gt 9 ]; then
>   	usage;
>   	exit_parameter;
>   fi
>   
> -exist_subsystem "debug"
> +exist_subsystem $subsystem
> +mount_point=$(get_mount_point)
> +
>   setup;
>   
> -if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
> +if [ $mounted -ne 1 ]; then
>   	mount_cgroup;
> -	$TESTROOT/cgroup_fj_proc &
> -	pid=$!
> -	mkdir_subgroup;
>   fi
>   
> +$TESTROOT/cgroup_fj_proc &
> +pid=$!
> +mkdir_subgroup;
> +
>   case$caseno
>   
>   cleanup;
> -if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
> -	do_kill 1 1 9 $pid
> -fi
> +do_kill 1 1 9 $pid
> +
>   sleep 1
>   exit 0;

-- 
Cedric Hnyda

