Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OnrHS-000558-9s
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:03:02 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OnrHP-0004hB-Qs
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:03:02 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7OAtVSW016026
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 04:55:31 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7OB2rsH050066
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:02:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7OB2qRW021084
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:02:53 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C73452A.3020006@cn.fujitsu.com>
References: <4C73452A.3020006@cn.fujitsu.com>
Date: Tue, 24 Aug 2010 16:32:50 +0530
Message-Id: <1282647771.4833.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add ftrace-stress-test to LTP
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

Thanks. I need to test this on a suitable kernel. But doubtful if i can
add in the default run.

Regards--
Subrata

On Tue, 2010-08-24 at 12:06 +0800, Li Zefan wrote: 
> We test ftrace by forking processes to simultaneously and
> constantly read/write different tracing files in debugfs
> and procfs.
> 
> The test will be skipped if the kernel is older than 2.6.34,
> mainly because it can crash old kernels.
> 
> The test will run by default and will run for 90 seconds.
> 
> To run this test only:
> 
> 	# ./runltp -f tracing
> 
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> ---
>  runltp                                             |    3 +-
>  runtest/tracing                                    |    2 +
>  testcases/kernel/Makefile                          |    2 +-
>  testcases/kernel/tracing/Makefile                  |    5 +
>  .../kernel/tracing/ftrace_stress_test/Makefile     |    7 +
>  .../ftrace_stress_test/ftrace_get_page_size.c      |   10 +
>  .../tracing/ftrace_stress_test/ftrace_kvercmp.c    |   37 +++
>  .../ftrace_stress/ftrace_buffer_size.sh            |   43 ++++
>  .../ftrace_stress/ftrace_current_tracer.sh         |   34 +++
>  .../ftrace_stress/ftrace_ftrace_enabled.sh         |   39 ++++
>  .../ftrace_stress/ftrace_profile_enabled.sh        |   50 ++++
>  .../ftrace_stress/ftrace_set_event.sh              |   44 ++++
>  .../ftrace_stress/ftrace_set_ftrace_pid.sh         |   44 ++++
>  .../ftrace_stress/ftrace_stack_max_size.sh         |   39 ++++
>  .../ftrace_stress/ftrace_stack_trace.sh            |   46 ++++
>  .../ftrace_stress/ftrace_trace.sh                  |   27 +++
>  .../ftrace_stress/ftrace_trace_clock.sh            |   46 ++++
>  .../ftrace_stress/ftrace_trace_options.sh          |   42 ++++
>  .../ftrace_stress/ftrace_trace_pipe.sh             |   43 ++++
>  .../ftrace_stress/ftrace_trace_stat.sh             |   45 ++++
>  .../ftrace_stress/ftrace_tracing_enabled.sh        |   39 ++++
>  .../ftrace_stress/ftrace_tracing_max_latency.sh    |   38 +++
>  .../ftrace_stress/ftrace_tracing_on.sh             |   39 ++++
>  .../ftrace_stress_test/ftrace_stress_test.sh       |  237 ++++++++++++++++++++
>  24 files changed, 959 insertions(+), 2 deletions(-)
>  create mode 100644 runtest/tracing
>  create mode 100644 testcases/kernel/tracing/Makefile
>  create mode 100644 testcases/kernel/tracing/ftrace_stress_test/Makefile
>  create mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
>  create mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
>  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> 
> diff --git a/runltp b/runltp
> index b385984..89b1717 100755
> --- a/runltp
> +++ b/runltp
> @@ -593,7 +593,8 @@ main()
>                           ${LTPROOT}/runtest/numa                    \
>                           ${LTPROOT}/runtest/hugetlb                 \
>                           ${LTPROOT}/runtest/commands                \
> -                         ${LTPROOT}/runtest/hyperthreading
> +                         ${LTPROOT}/runtest/hyperthreading          \
> +                         ${LTPROOT}/runtest/tracing
>          do
>              [ -e "$SCENFILES" ] || \
>              {
> diff --git a/runtest/tracing b/runtest/tracing
> new file mode 100644
> index 0000000..ef3a048
> --- /dev/null
> +++ b/runtest/tracing
> @@ -0,0 +1,2 @@
> +#DESCRIPTION:Tracing testing
> +ftrace-stress-test	ftrace_stress_test.sh 90
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index e2a9d8e..8c50025 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -30,7 +30,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  ifneq ($(UCLINUX),1)
>  SUBDIRS		:= containers connectors controllers fs hotplug io ipc mem \
>  		   numa performance_counters power_management pty sched \
> -		   security syscalls timers
> +		   security syscalls timers tracing
>  else
>  SUBDIRS		:= syscalls
>  endif
> diff --git a/testcases/kernel/tracing/Makefile b/testcases/kernel/tracing/Makefile
> new file mode 100644
> index 0000000..e9f96c3
> --- /dev/null
> +++ b/testcases/kernel/tracing/Makefile
> @@ -0,0 +1,5 @@
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/Makefile b/testcases/kernel/tracing/ftrace_stress_test/Makefile
> new file mode 100644
> index 0000000..e4a913a
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/Makefile
> @@ -0,0 +1,7 @@
> +top_srcdir              ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS         := *.sh ftrace_stress/*
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> new file mode 100644
> index 0000000..b52a109
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> @@ -0,0 +1,10 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +int main(void)
> +{
> +	printf("%d\n", getpagesize());
> +
> +	return 0;
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c b/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
> new file mode 100644
> index 0000000..bd67b37
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
> @@ -0,0 +1,37 @@
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/utsname.h>
> +
> +int main(int argc, char **argv)
> +{
> +	struct utsname uval;
> +	int k1, k2, k3;
> +	int a1, a2, a3;
> +	unsigned long r1, r2;
> +
> +	if (argc != 4) {
> +		fprintf(stderr, "Wrong arguments!\n");
> +		return -1;
> +	}
> +
> +	a1 = strtol(argv[1], NULL, 10);
> +	a2 = strtol(argv[2], NULL, 10);
> +	a3 = strtol(argv[3], NULL, 10);
> +
> +	uname(&uval);
> +
> +	sscanf(uval.release, "%d.%d.%d", &k1, &k2, &k3);
> +
> +	r1 = (a1 << 16) + (a2 << 8) + a3;
> +	r2 = (k1 << 16) + (k2 << 8) + k3;
> +
> +	if (r1 > r2)
> +		return 0;
> +	else if (r1 == r2)
> +		return 1;
> +	else
> +		return 2;
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
> new file mode 100755
> index 0000000..af5a98e
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
> @@ -0,0 +1,43 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=200
> +
> +# Use up to 10% of free memory
> +free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
> +step=$(( $free_mem / 10 / $LOOP ))
> +if [ $step -eq 0 ]; then
> +	$step=1
> +	LOOP=50
> +fi
> +
> +for ((; ;))
> +{
> +	new_size=1
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		echo $new_size > "$TRACING_PATH"/buffer_size_kb
> +		new_size=$(( $new_size + $step ))
> +	}
> +
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		new_size=$(( $new_size - $step ))
> +		echo $new_size > "$TRACING_PATH"/buffer_size_kb
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
> new file mode 100755
> index 0000000..1baed96
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
> @@ -0,0 +1,34 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=200
> +
> +for ((; ;))
> +{
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		for tracer in `cat "$TRACING_PATH"/available_tracers`;
> +		do
> +			if [ "$tracer" == mmiotrace ]; then
> +				continue
> +			fi
> +
> +			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
> +		done
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
> new file mode 100755
> index 0000000..20bb234
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_LOOP=1500
> +count=0
> +
> +for ((; ;))
> +{
> +	count=$(( $count + 1 ))
> +
> +	for ((i = 0; i < $MAX_LOOP; i++))
> +	{
> +		echo 0 > /proc/sys/kernel/ftrace_enabled
> +		echo 1 > /proc/sys/kernel/ftrace_enabled
> +	}
> +
> +	enable=$(( $count % 3 ))
> +
> +	if [ $enable -eq 0 ]; then
> +		echo 1 > /proc/sys/kernel/ftrace_enabled
> +	else
> +		echo 0 > /proc/sys/kernel/ftrace_enabled
> +	fi
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
> new file mode 100755
> index 0000000..9c6162a
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
> @@ -0,0 +1,50 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_LOOP=1500
> +count=0
> +
> +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> +	should_skip=1
> +else
> +	should_skip=0
> +fi
> +
> +for ((; ;))
> +{
> +	if [ $should_skip -eq 1 ]; then
> +		sleep 2
> +		continue
> +	fi
> +
> +	count=$(( $count + 1 ))
> +
> +	for ((i = 0; i < $MAX_LOOP; i++))
> +	{
> +		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> +		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> +	}
> +
> +	enable=$(( $count % 3 ))
> +
> +	if [ $enable -eq 0 ]; then
> +		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> +	else
> +		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> +	fi
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
> new file mode 100755
> index 0000000..f876414
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
> @@ -0,0 +1,44 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +for ((; ;))
> +{
> +	for ((i = 0; i < 100; i++))
> +	{
> +		echo 1 > "$TRACING_PATH"/events/enable
> +		echo 0 > "$TRACING_PATH"/events/enable
> +	}
> +
> +	for dir in `ls $TRACING_PATH/events/`;
> +	do
> +		if [ ! -d $dir -o "$dir" == ftrace ]; then
> +			continue;
> +		fi
> +
> +		for ((i = 0; i < 20; i++))
> +		{
> +			echo 1 > "$TRACING_PATH"/events/$dir/enable
> +			echo 0 > "$TRACING_PATH"/events/$dir/enable
> +		}
> +	done
> +
> +	for event in `cat $TRACING_PATH/available_events`;
> +	do
> +		echo $event >> "$TRACING_PATH"/set_event
> +	done
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> new file mode 100755
> index 0000000..541215c
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> @@ -0,0 +1,44 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=300
> +
> +if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
> +	should_skip=1
> +else
> +	should_skip=0
> +fi
> +
> +for ((; ; ))
> +{
> +	if [ $should_skip -eq 1 ]; then
> +		sleep 2
> +		continue
> +	fi
> +
> +	for ((j = 0; j < $LOOP; j++))
> +	{
> +		for ((k = 1; k <= NR_PIDS; k++))
> +		{
> +			str="\$pid$k"
> +			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
> +		}
> +
> +		echo > "$TRACING_PATH"/set_ftrace_pid
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
> new file mode 100755
> index 0000000..682d05e
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_STACK_SIZE=8192
> +
> +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> +	should_skip=1
> +else
> +	should_skip=0
> +fi
> +
> +for ((; ;))
> +{
> +	if [ $should_skip -eq 1 ]; then
> +		sleep 2
> +		continue
> +	fi
> +
> +	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
> +	{
> +		echo $i > "$TRACING_PATH"/stack_max_size
> +		cat "$TRACING_PATH"/stack_max_size > /dev/null
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
> new file mode 100755
> index 0000000..a406c51
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=400
> +
> +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> +	should_skip=1
> +else
> +	should_skip=0
> +fi
> +
> +for ((; ;))
> +{
> +	if [ $should_skip -eq 1 ]; then
> +		sleep 2
> +		continue
> +	fi
> +
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		cat "$TRACING_PATH"/stack_trace > /dev/null
> +	}
> +
> +	sleep 1
> +
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		echo 0 > /proc/sys/kernel/stack_tracer_enabled
> +		echo 1 > /proc/sys/kernel/stack_tracer_enabled
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
> new file mode 100755
> index 0000000..e36712b
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
> @@ -0,0 +1,27 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=200
> +
> +for ((; ;))
> +{
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		cat "$TRACING_PATH"/trace > /dev/null
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
> new file mode 100755
> index 0000000..51f2507
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=400
> +
> +# In kernel which is older than 2.6.32, we set global clock
> +# via trace_options.
> +./ftrace_kvercmp 2 6 32
> +if [ $? -eq 0 ]; then
> +        old_kernel=1
> +else
> +        old_kernel=0
> +fi
> +
> +for ((; ;))
> +{
> +	if [ $old_kernel -eq 1 ];
> +	then
> +		for ((i = 0; i < $LOOP; i++))
> +		{
> +			echo 1 > "$TRACING_PATH"/options/global-clock
> +			echo 0 > "$TRACING_PATH"/options/global-clock
> +		}
> +	else
> +		for ((i = 0; i < $LOOP; i++))
> +		{
> +			echo local > "$TRACING_PATH"/trace_clock
> +			echo global > "$TRACING_PATH"/trace_clock
> +		}
> +	fi
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
> new file mode 100755
> index 0000000..47d2a62
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
> @@ -0,0 +1,42 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=200
> +
> +trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
> +
> +NR_TRACE_OPTIONS=19
> +
> +for ((; ; ))
> +{
> +	for ((j = 0; j < $LOOP; j++))
> +	{
> +		num=`date +%N`
> +		num=`printf 1%s $num`
> +
> +		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
> +		{
> +			n=$(( ( $num >> $i ) % 2 ))
> +			if [ $n -eq 0 ]; then
> +				echo 0 > "$TRACING_PATH"/options/${trace_options[$i]}
> +			else
> +				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
> +			fi
> +		}
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
> new file mode 100755
> index 0000000..cccb7ae
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
> @@ -0,0 +1,43 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +kill_this_pid()
> +{
> +	/bin/kill -SIGKILL $this_pid
> +	wait $this_pid
> +	exit 0
> +}
> +
> +trap kill_this_pid SIGUSR1
> +
> +LOOP=20
> +
> +for ((; ;))
> +{
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		cat "$TRACING_PATH"/trace_pipe > /dev/null &
> +
> +		this_pid=$!
> +		usleep 200000
> +		/bin/kill -SIGINT $this_pid
> +		wait $this_pid
> +		this_pid=0
> +		usleep 200000
> +	}
> +
> +	sleep 2
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
> new file mode 100755
> index 0000000..ad6859f
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
> @@ -0,0 +1,45 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +LOOP=200
> +
> +should_skip=0
> +
> +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> +        should_skip=1
> +fi
> +
> +# For kernels older than 2.6.36, this testcase can result in 
> +# divide-by-zero kernel bug
> +"$TPATH"/ftrace_kvercmp 2 6 36
> +if [ $? -eq 0 ]; then
> +	should_skip=1
> +fi
> +
> +for ((; ;))
> +{
> +	if [ $should_skip -eq 1 ]; then
> +		sleep 2
> +		continue
> +	fi
> +
> +	for ((i = 0; i < $LOOP; i++))
> +	{
> +		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
> new file mode 100755
> index 0000000..69f2ae6
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_LOOP=1500
> +count=0
> +
> +for ((; ;))
> +{
> +	count=$(( $count + 1 ))
> +
> +	for ((i = 0; i < $MAX_LOOP; i++))
> +	{
> +		echo 0 > "$TRACING_PATH"/tracing_enabled
> +		echo 1 > "$TRACING_PATH"/tracing_enabled
> +	}
> +
> +	enable=$(( $count % 3 ))
> +
> +	if [ $enable -eq 0 ]; then
> +		echo 0 > "$TRACING_PATH"/tracing_enabled
> +	else
> +		echo 1 > "$TRACING_PATH"/tracing_enabled
> +	fi
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
> new file mode 100755
> index 0000000..f19d734
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
> @@ -0,0 +1,38 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_LATENCY=100000
> +
> +if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
> +        should_skip=1
> +else
> +        should_skip=0
> +fi
> +
> +for ((; ;))
> +{
> +        if [ $should_skip -eq 1 ]; then
> +                sleep 2
> +                continue
> +        fi
> +
> +	for ((i = 0; i < $MAX_LATENCY; i += 400))
> +	{
> +		echo $i > "$TRACING_PATH"/tracing_max_latency
> +	}
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
> new file mode 100755
> index 0000000..672c223
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> +#                                                                             #
> +###############################################################################
> +
> +MAX_LOOP=1500
> +count=0
> +
> +for ((; ;))
> +{
> +	count=$(( $count + 1 ))
> +
> +	for ((i = 0; i < $MAX_LOOP; i++))
> +	{
> +		echo 0 > "$TRACING_PATH"/tracing_on
> +		echo 1 > "$TRACING_PATH"/tracing_on
> +	}
> +
> +	enable=$(( $count % 3 ))
> +
> +	if [ $enable -eq 0 ]; then
> +		echo 0 > "$TRACING_PATH"/tracing_on
> +	else
> +		echo 1 > "$TRACING_PATH"/tracing_on
> +	fi
> +
> +	sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> new file mode 100755
> index 0000000..3e6c4b7
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> @@ -0,0 +1,237 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2010 FUJITSU LIMITED                                         ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> +##                                                                            ##
> +################################################################################
> +
> +cd $LTPROOT/testcases/bin
> +
> +export TCID="ftrace-stress-test"
> +export TST_TOTAL=1
> +export TST_COUNT=1
> +
> +export TPATH="$PWD"
> +export DEBUGFS_PATH="$PWD/debugfs"
> +export TRACING_PATH="$PWD/debugfs/tracing"
> +export SPATH="$TPATH/ftrace_stress"
> +
> +test_interval=$1
> +
> +save_old_setting()
> +{
> +	cd $TRACING_PATH
> +
> +	old_trace_options=( `cat trace_options` )
> +	old_tracing_on=`cat tracing_on`
> +	old_tracing_enabled=`cat tracing_enabled`
> +	old_buffer_size=`cat buffer_size_kb`
> +
> +	if [ -e stack_max_size ]; then
> +		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
> +	fi
> +
> +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> +		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
> +	fi
> +
> +	if [ -e "function_profile_enabled" ]; then
> +		old_profile_enabled=`cat function_profile_enabled`
> +	fi
> +
> +	cd - > /dev/null
> +}
> +
> +restore_old_setting()
> +{
> +	cd $TRACING_PATH
> +
> +	echo nop > current_tracer
> +	echo 0 > events/enable
> +	echo 0 > tracing_max_latency 2> /dev/null
> +
> +	if [ -e trace_clock ]; then
> +		echo local > trace_clock
> +	fi
> +
> +	if [ -e "function_pofile_enabled" ]; then
> +		echo $old_profile_enabled > function_profile_enabled
> +	fi
> +
> +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> +		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
> +	fi
> +
> +	if [ -e stack_max_size ]; then
> +		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
> +		echo 0 > stack_max_size
> +	fi
> +
> +	echo $old_buffer_size > buffer_size_kb
> +	echo $old_tracing_on > tracing_on
> +	echo $old_tracing_enabled > tracing_enabled
> +
> +	for option in ${old_trace_options[*]};
> +	do
> +		echo $option > trace_options 2> /dev/null
> +	done
> +
> +	echo > trace
> +
> +	cd - > /dev/null
> +}
> +
> +clean_up()
> +{
> +	/bin/kill -SIGKILL $pid1
> +	/bin/kill -SIGKILL $pid2
> +	/bin/kill -SIGKILL $pid3
> +	/bin/kill -SIGKILL $pid4
> +	/bin/kill -SIGKILL $pid5
> +	/bin/kill -SIGKILL $pid6
> +	/bin/kill -SIGKILL $pid7
> +	/bin/kill -SIGKILL $pid8
> +	/bin/kill -SIGKILL $pid9
> +	/bin/kill -SIGKILL $pid10
> +	/bin/kill -SIGKILL $pid11
> +	/bin/kill -SIGUSR1 $pid12
> +	/bin/kill -SIGKILL $pid13
> +	/bin/kill -SIGKILL $pid14
> +	/bin/kill -SIGKILL $pid15
> +	/bin/kill -SIGKILL $pid16
> +
> +	sleep 2
> +	restore_old_setting
> +
> +	umount $DEBUGFS_PATH
> +	rmdir $DEBUGFS_PATH
> +}
> +
> +clean_up_exit()
> +{
> +	clean_up
> +	exit 1
> +}
> +
> +export_pids()
> +{
> +	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
> +		pid13 pid14 pid15 pid16
> +
> +	export NR_PIDS=16
> +}
> +
> +test_begin()
> +{
> +	start_time=`date +%s`
> +}
> +
> +test_wait()
> +{
> +	for ((; ;))
> +	{
> +		sleep 2
> +
> +		cur_time=`date +%s`
> +		elapsed=$(( $cur_time - $start_time ))
> +
> +		# run the stress test for $test_interval secs
> +		if [ $elapsed -ge $test_interval ]; then
> +			break
> +		fi
> +	}
> +}
> +
> +trap clean_up_exit SIGINT
> +
> +# Should be run by root user
> +if [ "`whoami`" != "root" ]; then
> +	tst_brkm TCONF ignored "The test should be run by root user. Skip the test..."
> +	exit 0
> +fi
> +
> +# Don't run the test on kernels older than 2.6.34, otherwise
> +# it can crash the system if the kernel is not latest-stable
> +./ftrace_kvercmp 2 6 34
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
> +	exit 0
> +fi
> +
> +mkdir $DEBUGFS_PATH
> +mount -t debugfs xxx $DEBUGFS_PATH
> +
> +# Check to see tracing feature is supported or not
> +if [ ! -d $TRACING_PATH ]; then
> +	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
> +	umount $DEBUGFS_PATH
> +	rmdir $DEBUGFS_PATH
> +	exit 0
> +fi
> +
> +echo "Ftrace Stress Test Begin"
> +
> +save_old_setting
> +
> +test_begin
> +
> +$SPATH/ftrace_trace_clock.sh &
> +pid1=$!
> +$SPATH/ftrace_current_tracer.sh &
> +pid2=$!
> +$SPATH/ftrace_trace_options.sh &
> +pid3=$!
> +$SPATH/ftrace_tracing_max_latency.sh &
> +pid4=$!
> +$SPATH/ftrace_stack_trace.sh &
> +pid5=$!
> +$SPATH/ftrace_stack_max_size.sh &
> +pid6=$!
> +$SPATH/ftrace_tracing_on.sh &
> +pid7=$!
> +$SPATH/ftrace_tracing_enabled.sh &
> +pid8=$!
> +$SPATH/ftrace_set_event.sh &
> +pid9=$!
> +$SPATH/ftrace_buffer_size.sh &
> +pid10=$!
> +$SPATH/ftrace_trace.sh &
> +pid11=$!
> +$SPATH/ftrace_trace_pipe.sh &
> +pid12=$!
> +$SPATH/ftrace_ftrace_enabled.sh &
> +pid13=$!
> +$SPATH/ftrace_set_ftrace_pid.sh &
> +pid14=$!
> +$SPATH/ftrace_profile_enabled.sh &
> +pid15=$!
> +$SPATH/ftrace_trace_stat.sh &
> +pid16=$!
> +
> +export_pids
> +
> +test_wait
> +
> +clean_up
> +
> +echo "Ftrace Stress Test End"
> +
> +tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
> +


------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
