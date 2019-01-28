From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jan 2019 17:32:07 +0100
Subject: [LTP] [PATCH v3]  memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190104105407.48123-2-cristian.marussi@arm.com>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
Message-ID: <20190128163207.GA26834@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

thanks for your patch. I was thinking just to fix minor formatting issues, but
eval in run_stress() deserve to be rewritten.

> Ported to newlib framework and general cleanup.
> Moved an helper function out into cgroup_lib.sh.

..
> +	[ "x$val" = "x1" ] && return 0
drop x, it's portable enough like this::
[ "$val" = "1" ] && return 0

...
> +++ b/testcases/kernel/controllers/memcg/stress/Makefile
> @@ -1,24 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Author: Ngie Cooper, September 2009

>  #    kernel/controllers/memcg/stress testcase suite Makefile.
Delete this as well.

> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
...
> +	if ! is_cgroup_subsystem_available_and_enabled "memory";then
> +		tst_res TWARN "Either Kernel does not support MEMORY resource controller or feature not enabled"
> +		tst_brk TCONF ignored "Skipping all memory cgroup testcases...."
TWARN followed by TCONF does not make sense. Also skip is redundant. Please,
avoid using dots (even in comments).
This is enough:

    if ! is_cgroup_subsystem_available_and_enabled "memory"; then
        tst_res TCONF "Either Kernel does not support MEMORY resource controller or feature not enabled"
    fi

...
> +
> +	echo 3 > /proc/sys/vm/drop_caches
> +	sleep 2
> +	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
> +	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
Test started using awk, which might not be everywhere (even it's quite basic.
TST_NEEDS_CMDS="awk" would be good for tests.

And also TST_NEEDS_CMDS="$TST_NEEDS_CMDS awk" would be good for cgroup_lib.sh.

> +
> +	MEM=$(( $mem_free + $swap_free / 2 ))
> +	MEM=$(( $MEM / 1024 ))
> +	RUN_TIME=$(( 15 * 60 ))
> +
> +	tst_res TINFO "Calculated available memory $MEM MB"
>  }

> +do_cleanup()
> +{
> +	if [ -e /dev/memcg ]; then
> +		umount /dev/memcg 2> /dev/null
> +		rmdir /dev/memcg 2> /dev/null
> +	fi
> +}

>  do_mount()
>  {
> -	cleanup;
> +	do_cleanup

>  	mkdir /dev/memcg 2> /dev/null
>  	mount -t cgroup -omemory memcg /dev/memcg
> @@ -65,62 +65,53 @@ do_mount()
>  # $4 - How long does this test run ? in second
>  run_stress()
>  {
> -	do_mount;
> +	local i
> +
> +	do_mount

>  	for i in $(seq 0 $(($1-1)))
>  	do
Please keep do on the same line (in memcg_stress_test.sh on several times):
for i in $(seq 0 $(($1-1))); do

>  		mkdir /dev/memcg/$i 2> /dev/null
> -		./memcg_process_stress $2 $3 &
> -		eval pid$i=$!
Eval is evil. And eval with local is even more evil. Even if it works on dash,
using eval in whole function is just bad. Could you please rewrite it into
single variable?  You can just separate pids with space.
+ maybe describe variables instead of using positional variables, e.g.:
local cgroups="$1"
local mem="$2"
...

> +		memcg_process_stress $2 $3 &
> +		eval local pid$i=$!

>  		eval echo \$pid$i > /dev/memcg/$i/tasks
>  	done

>  	for i in $(seq 0 $(($1-1)))
>  	do
> -		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
> +		eval kill -USR1 \$pid$i 2> /dev/null
>  	done

>  	sleep $4

>  	for i in $(seq 0 $(($1-1)))
>  	do
> -		eval /bin/kill -s SIGKILL \$pid$i 2> /dev/null
> +		eval kill -KILL \$pid$i 2> /dev/null
>  		eval wait \$pid$i

>  		rmdir /dev/memcg/$i 2> /dev/null
>  	done

> -	cleanup;
> +	do_cleanup
>  }

>  testcase_1()
I'd rename it to test1.

>  {
> -	run_stress 150 $(( ($mem-150) / 150 )) 5 $RUN_TIME
> +	tst_res TINFO "testcase 1 started...it will run for $RUN_TIME secs"
Can you avoid dots, will?
Maybe describe it a bit.
I'd print test info in run_stress(), something like this:
tst_res TINFO "Testing $cgroups cgroups, using $mem, run for $RUN_TIME secs"

Kind regards,
Petr
