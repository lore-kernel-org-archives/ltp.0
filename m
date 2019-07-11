From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Jul 2019 08:03:57 +0200
Subject: [LTP] [PATCH v3] rcu/rcu_torture.sh: Rewrite test
In-Reply-To: <1562769310-4918-1-git-send-email-ice_yangxiao@163.com>
References: <1562769310-4918-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <20190711060357.GA28190@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> 1) Cleanup and convert to new API
> 2) Update valid rcutorture types(rcu, srcu, srcud, tasks)

> Note:
> Exclude valid busted* types(busted, busted_srcud) that check
> the test itself and expect failures, suggested by:
> https://www.spinics.net/lists/kernel/msg3045252.html

> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

Only few comments below (nits).

>  # default options
> -test_time=60
> +test_time=30
You shortened the test to half, good :).

...
> +rcutorture_setup()
> +{
> +	local module=1

> -	if tst_kvcmp -lt "3.11"; then
> -		rcu_type="$rcu_type srcu_raw srcu_raw_sync"
> -	fi
> -fi
> +	# check if rcutorture is built as a kernel module by inserting
> +	# and then removing it
> +	modprobe rcutorture >/dev/null 2>&1 ||  module=0
> +	modprobe -r rcutorture >/dev/null 2>&1 || module=0

This can be just module=1 or module= (none value).
(+ -q is enough instead of redirections). i.e.:

modprobe rcutorture -q || module=
modprobe -r rcutorture -q || module=
[ -n "$module" ] && \

(or even [ "$module" ] && \ )

We usually don't use 0 for shell scripts in LTP.
But that's a nit.

> -TST_TOTAL=$(echo "$rcu_type" | wc -w)
> +	[ $module -eq 0 ] && \
> +		tst_brk TCONF "rcutorture is built-in, non-existent or in use"
> +}

> -est_time=`echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc`
> -tst_resm TINFO "estimate time $est_time min"
> +rcutorture_test()
> +{
> +	local rcu_type=$1

> -for type in $rcu_type; do
> +	tst_res TINFO "${rcu_type}-torture: running ${test_time} sec..."
	tst_res TINFO "${rcu_type}-torture: running $test_time sec..."
(I prefer using brackets ${foo} only when needed - $foo is more readable).

> -	tst_resm TINFO "$type: running $test_time sec..."
> +	modprobe rcutorture nfakewriters=${num_writers} \
> +		torture_type=${rcu_type} >/dev/null 2>&1
Again, use -q:
modprobe -q rcutorture nfakewriters=$num_writers torture_type=$rcu_type

> +	if [ $? -ne 0 ]; then
> +		dmesg | grep -q "invalid torture type: \"${rcu_type}\"" && \
> +			tst_brk TCONF "invalid ${rcu_type} type"
and here ${foo} => $foo

> -	modprobe rcutorture nfakewriters=$num_writers \
> -	         stat_interval=60 test_no_idle_hz=1 shuffle_interval=3 \
> -	         stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 \
> -	         fqs_stutter=3 test_boost=1 test_boost_interval=7 \
> -	         test_boost_duration=4 shutdown_secs=0 \
> -	         stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 \
> -	         onoff_interval=0 onoff_holdoff=0 torture_type=$type \
> -	         > /dev/null 2>&1 || tst_brkm TBROK "failed to load module"
> +		tst_brk TBROK "failed to load module"
And here. But I'd prefer to keep stderr (in case of failure it's better
to see immediately what the problem was).
> +	fi

> -	sleep $test_time
> +	sleep ${test_time}
	sleep $test_time

> -	rmmod rcutorture > /dev/null 2>&1 || \
> -		tst_brkm TBROK "failed to unload module"
> +	modprobe -r rcutorture >/dev/null 2>&1 || \
> +		tst_brk TBROK "failed to unload module"
The same here (here I'd also keep stdout)

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
Maybe print dmesg (for automated tests, when you don't have direct access to
machine).

Kind regards,
Petr
