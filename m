From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jul 2019 17:45:57 +0200
Subject: [LTP] [PATCH v2] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <1559922050-15221-1-git-send-email-ice_yangxiao@163.com>
References: <7ad6c506-e195-db0d-3b2b-a30b95c42f8a@oracle.com>
 <1559922050-15221-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <20190709154536.GA8195@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +rcutorture_setup()
> +{
> +	# do test by inserting and removing rcutorture module
> +	# so check if it is built-in, loaded or unbuilt
> +	modprobe -n --first-time rcutorture >/dev/null 2>&1 || \
> +		tst_brk TCONF "built-in, loaded or unbuilt rcutorture"

Wouldn't the --first-time disable the test on subsequent runs? Or do I
misunderstand how --first-time is supposed to work?

Also I guess that some modprobe implementations may not support
--first-time e.g. busybox.

> +}
>  
> -trap cleanup INT
> +rcutorture_test()
> +{
> +	local rcu_type=$1
>  
> -rcu_type="rcu rcu_bh srcu sched"
> +	tst_res TINFO "${rcu_type}-torture: running ${test_time} sec..."
>  
> -if tst_kvcmp -lt "3.12"; then
> -	rcu_type="$rcu_type rcu_sync rcu_expedited rcu_bh_sync rcu_bh_expedited \
> -	          srcu_sync srcu_expedited sched_sync sched_expedited"
> +	modprobe rcutorture nfakewriters=${num_writers} \
> +		torture_type=${rcu_type} >/dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		dmesg | grep -q "invalid torture type: \"${rcu_type}\"" && \
> +			tst_brk TCONF "invalid ${rcu_type} type"
>  
> -	if tst_kvcmp -lt "3.11"; then
> -		rcu_type="$rcu_type srcu_raw srcu_raw_sync"
> +		tst_brk TBROK "failed to load module"
>  	fi
> -fi
> -
> -TST_TOTAL=$(echo "$rcu_type" | wc -w)
> -
> -est_time=`echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc`
> -tst_resm TINFO "estimate time $est_time min"
> -
> -for type in $rcu_type; do
> -
> -	tst_resm TINFO "$type: running $test_time sec..."
> -
> -	modprobe rcutorture nfakewriters=$num_writers \
> -	         stat_interval=60 test_no_idle_hz=1 shuffle_interval=3 \
> -	         stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 \
> -	         fqs_stutter=3 test_boost=1 test_boost_interval=7 \
> -	         test_boost_duration=4 shutdown_secs=0 \
> -	         stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 \
> -	         onoff_interval=0 onoff_holdoff=0 torture_type=$type \
> -	         > /dev/null 2>&1 || tst_brkm TBROK "failed to load module"
>  
> -	sleep $test_time
> +	sleep ${test_time}
>  
> -	rmmod rcutorture > /dev/null 2>&1 || \
> -		tst_brkm TBROK "failed to unload module"
> +	rmmod rcutorture >/dev/null 2>&1 || \
> +		tst_brk TBROK "failed to unload module"

This should be modprobe -r, rmmod has been deprecated for quite some
time.

>  	# check module status in dmesg
> -	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
> -	if [ "$result_str" = "SUCCESS" ]; then
> -		tst_resm TPASS "$type: completed"
> +	local res=$(dmesg | sed -nE "s/.* ${rcu_type}-torture:.* End of test: (.*): .*/\1/p" | tail -n1)
> +	if [ "$res" = "SUCCESS" ]; then
> +		tst_res TPASS "${rcu_type}-torture: $res"
>  	else
> -		tst_resm TFAIL "$type: $result_str, see dmesg"
> +		tst_res TFAIL "${rcu_type}-torture: $res, see dmesg"
>  	fi
> -done
> +}
> +
> +do_test()
> +{
> +	case $1 in
> +	1) rcutorture_test rcu;;
> +	2) rcutorture_test srcu;;
> +	3) rcutorture_test srcud;;
> +	4) rcutorture_test tasks;;
> +	esac
> +}
>  
> -tst_exit
> +tst_run
> -- 
> 1.8.3.1
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
