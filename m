From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Mar 2018 13:42:42 +0100
Subject: [LTP] [PATCH] commands/sysctl: Add new regression test for
 invalid sched_time_avg
In-Reply-To: <1516695452-23224-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1516695452-23224-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180306124242.GC16934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +TST_TESTFUNC=sysctl_test
> +TST_NEEDS_CMDS="sysctl"
> +
> +. tst_test.sh
> +
> +get_value()
> +{
> +	local value=$(sysctl -n $1)
> +	[ -z "$value" ] && tst_brk TBROK \
> +		"Failed to get the value of sched_time_avg(_ms)"
> +
> +	echo $value
> +}
> +
> +sysctl_test()
> +{
> +	# With commit d00535d, sched_time_avg was renamed as sched_time_avg_ms
> +	local name=$(sysctl -a 2>&1 | egrep -o \
> +		'kernel.(sched_time_avg|sched_time_avg_ms)')
> +	[ -z "$name" ] && tst_brk TCONF \
> +		"sched_time_avg(_ms) was not supported"

Can't we just do?

if [ -e /proc/sys/kernel/sched_time_avg_ms ]; then
	name=...
fi

if [ -e /proc/sys/kernel/sched_time_avg ]; then
	name=...
fi

[ -z "$name" ] ...

> +	local orig_value=$(get_value $name)
> +
> +	sysctl -w $name=0 >/dev/null 2>&1
> +
> +	# Increase the chance of exposing the problem on RHEL6
> +	sleep 3

What is this sleep good for? Do we wait here for the kernel to crash?

> +	local curr_value=$(get_value $name)
> +
> +	if [ ${curr_value} -eq ${orig_value} ]; then
> +		tst_res TPASS "Setting sched_time_avg(_ms) failed"
> +	else
> +		tst_res TFAIL "Setting sched_time_avg(_ms) succeeded"
> +		sysctl -w $name=${orig_value} >/dev/null 2>&1
> +	fi
> +}
> +
> +tst_run
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
