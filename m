From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 6 Jul 2020 12:41:22 +0800
Subject: [LTP] [PATCH V2] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <81a952af30185d5c72cda19d322d7abbbf7bd8fe.1594006171.git.viresh.kumar@linaro.org>
References: <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
 <81a952af30185d5c72cda19d322d7abbbf7bd8fe.1594006171.git.viresh.kumar@linaro.org>
Message-ID: <c3ffe29c-580d-5c7d-feb9-071c4dee98e0@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh

Acked-by.

> Validate the timespec returned by sched_rr_get_interval() against the
> value read from /proc/sys/kernel/sched_rr_timeslice_ms.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Add .tags entry
> - check if file is present or not.
> 
>   .../sched_rr_get_interval01.c                     | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index 31d7b5d56a52..0466be36bec0 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -5,11 +5,18 @@
>    *
>    * Gets round-robin time quantum by calling sched_rr_get_interval() and
>    * checks that the value is sane.
> + *
> + * It is also a regression test for kernel
> + * commit 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR
> + * timeslice tuning knob in milliseconds").
>    */
>   
>   #include <sched.h>
>   #include "tst_timer.h"
>   
> +#define PROC_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
> +static int proc_flag;
> +
>   struct tst_ts tp;
>   
>   static struct test_variants {
> @@ -39,6 +46,8 @@ static void setup(void)
>   
>   	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
>   		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
> +
> +	proc_flag = !access(PROC_SCHED_RR_TIMESLICE_MS, F_OK);
>   }
>   
>   static void run(void)
> @@ -62,6 +71,8 @@ static void run(void)
>   		        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
>   	}
>   
> +	if (proc_flag)
> +		TST_ASSERT_INT("/proc/sys/kernel/sched_rr_timeslice_ms", tst_ts_to_ms(tp));
>   }
>   
>   static struct tst_test test = {
> @@ -69,4 +80,8 @@ static struct tst_test test = {
>   	.test_variants = ARRAY_SIZE(variants),
>   	.setup = setup,
>   	.needs_root = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "975e155ed873"},
> +		{}
> +	}
>   };
> 


