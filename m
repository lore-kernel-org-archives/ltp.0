From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 13:44:24 +0200
Subject: [LTP] [PATCH 2/2] perf_event_open02: make test more reliable on
 -rt kernels
In-Reply-To: <51dce875f4ad2c234031101cd5c7a85eace53caa.1571225074.git.jstancek@redhat.com>
References: <9c5134dc4b39f870f6e6cfab55c193f05b204b78.1571225074.git.jstancek@redhat.com>
 <51dce875f4ad2c234031101cd5c7a85eace53caa.1571225074.git.jstancek@redhat.com>
Message-ID: <20191016114424.GB27278@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../kernel/syscalls/perf_event_open/perf_event_open02.c   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> index 1cfe29bb3d8a..6fc6f4afa119 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> @@ -52,6 +52,7 @@ Usage is: ./performance_counter02  [-v]
>  The -v flag makes it print out the values of each counter.
>  */
>  
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> @@ -222,6 +223,20 @@ static void setup(void)
>  	int i;
>  	struct perf_event_attr tsk_event, hw_event;
>  
> +#ifdef HAVE_SCHED_GETCPU
> +	cpu_set_t mask;

Don't we have to allocate the mask dynamically so that we do not fail on
systems with more than CPU_SETSIZE (1024) CPUs?

We already have fallback macros for older libc in include/lapi/cpuset.h
so that we can use CPU_ALLOC() unconditionally.

> +	int cpu = sched_getcpu();
> +
> +	if (cpu == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "sched_getcpu() failed");
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(cpu, &mask);
> +
> +	if (sched_setaffinity(0, sizeof(cpu_set_t), &mask) == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "sched_setaffinity() failed");
> +#endif
> +
>  	/*
>  	 * According to perf_event_open's manpage, the official way of
>  	 * knowing if perf_event_open() support is enabled is checking for
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
