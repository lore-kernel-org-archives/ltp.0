From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Sep 2021 15:17:59 +0200
Subject: [LTP] [PATCH v3 1/2] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <20210827092007.20889-1-krzysztof.kozlowski@canonical.com>
References: <20210827092007.20889-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YS99h3rPMLeSEFv5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +check_free_memory()
> +{
> +	local memneeded
> +	local memfree=`awk '/MemAvailable/ {print $2}' /proc/meminfo`
> +
> +	if [ $? -ne 0 ]; then
> +		local memcached
> +
> +		memfree=`awk '/MemFree/ {print $2}' /proc/meminfo`
> +		test $? -eq 0 || return 0
> +
> +		memcached=`awk '/MemCached/ {print $2}' /proc/meminfo`
> +		test $? -eq 0 || return 0
> +
> +		memfree=$((memfree + memcached))
> +	fi
> +
> +	# On x86_64, each 100 of processes were using ~16 MB of memory,
> +	# so try to estimate the needed free memory based on this.
> +	memneeded=$((max * nbprocess * 16384 / 100))
> +
> +	if [ $memfree -lt $memneeded ]; then
> +		tst_brk TCONF "not enough of free memory on this system (approximate need $memneeded kB, free $memfree kB)"
> +	fi
> +	tst_res TINFO "memory requirements fulfilled (approximate need $memneeded kB, free $memfree kB)"
> +
> +	return 0
> +}
> +
> +check_limits()
> +{
> +	local real_uid="$SUDO_UID"
> +	local tasksneeded=$((max * nbprocess + 100))
> +
> +	if [ "$real_uid" = "" ]; then
> +		real_uid=`id -u`
> +		test $? -eq 0 || return 0
> +	fi
> +
> +	local tasksmax=`systemctl show user-${real_uid}.slice | awk -F '=' '/TasksMax/ {print $2}'`
> +	test $? -eq 0 || return 0
> +
> +	# Check for number for cases like TasksMax=infinity
> +	[ -n "$tasksmax" ] && [ "$tasksmax" -eq "$tasksmax" ] 2>/dev/null
> +	test $? -eq 0 || return 0

Well we do have a C implementation of this now, it would be better to
have the logic in one place and just call the C function to collect the
number of pids.

If we add tst_get_free_pids.c to the testcases/lib/ directory with:

#define TST_NO_DEFAULT_MAIN
#include <stdio.h>
#include <tst_test.h>

extern struct tst_test *tst_test;

static struct tst_test test = {
};

int main(void)
{
	/* force messages to be printed from new library */
        tst_test = &test;

        printf("%i\n", tst_get_free_pids());

        return 0;
}

We can do FREE_PIDS=$(tst_get_free_pids) here and then just compare the numbers.

> +	if [ $tasksmax -le $tasksneeded ]; then
> +		tst_brk TCONF "limit of tasks is too low (approximate need $tasksneeded, limit $tasksmax)"
> +	fi
> +	tst_res TINFO "task limit fulfilled (approximate need $tasksneeded, limit $tasksmax)"
> +
> +	return 0
> +}
> +
>  setup()
>  {
>  	if ! grep -q -w cpuacct /proc/cgroups; then
>  		tst_brk TCONF "cpuacct not supported on this system"
>  	fi
>  
> +	check_limits
> +	# Don't bother with memory limit checks on smaller tests
> +	if [ $max -ge 100 ] && [ $nbprocess -ge 100 ]; then
> +		check_free_memory
> +	fi
> +
>  	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
>  	tst_res TINFO "cpuacct: $mount_point"
>  	if [ "$mount_point" = "" ]; then
> -- 
> 2.30.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
