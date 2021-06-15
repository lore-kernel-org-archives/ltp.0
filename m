From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Jun 2021 18:40:38 +0200
Subject: [LTP] [PATCH v2 1/2] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <20210614161413.82389-1-krzysztof.kozlowski@canonical.com>
References: <20210614161413.82389-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YMjYBoqTw9RSqYqH@yuki>
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
> +		test $? || return 0
> +
> +		memcached=`awk '/MemCached/ {print $2}' /proc/meminfo`
> +		test $? || return 0

I do not think that something as basic as awk on /proc/meminfo here will
fail...

> +		memfree=$((memfree + memcached))
> +	fi
> +
> +	# On x86_64, each 100 of processes were using ~16 MB of memory,
> +	# so try to estimate the needed free memory based on this.
> +	memneeded=$((max * nbprocess * 16384 / 100))
> +
> +	if [ $memfree -lt $memneeded ]; then

I would still add some memory margin to the memneeded here. At least
add a hundred of megabytes before we do the check.

> +		tst_brk TCONF "not enough of free memory on this system (approximate need $memneeded kB, free $memfree kB)"
> +	fi
> +	tst_res TINFO "memory requirements fulfilled (approximate need $memneeded kB, free $memfree kB)"
> +
> +	return 0
> +}
> +
> +check_limits()
> +{
> +	local realuid="$SUDO_UID"
> +	local tasksneeded=$((max * nbprocess + 100))
> +
> +	if [ "$realuid" = "" ]; then
> +		realuid=`id -u`
> +		test $? || return 0
> +	fi
> +
> +	local tasksmax=`systemctl show user-${real_uid}.slice | awk -F '=' '/TasksMax/ {print $2}'`
> +	test $? || return 0
> +
> +	if [ $tasksmax -le $tasksneeded ]; then
> +		tst_brk TCONF "limit of tasks is too low (approximate need $tasksneeded, limit $tasksmax)"
> +	fi
> +	tst_res TINFO "task limit fulfilled (approximate need $tasksneeded, limit $tasksmax)"

Huh, is this really needed? The test is supposed to run under root. The
user is supposed to login as a root or at least do 'su -' before
executing LTP anyways.

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

We should probably check if the $max * $mbprocess -ge 1000 or something
like that just in a case someone addds a test with large enough
$nbprocess.

> +		check_free_memory
> +	fi
> +
>  	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
>  	tst_res TINFO "cpuacct: $mount_point"
>  	if [ "$mount_point" = "" ]; then
> -- 
> 2.27.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
