From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Jul 2020 16:08:09 +0200
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
References: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
Message-ID: <20200703140809.GB11556@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Validate the timespec returned by sched_rr_get_interval() against the
> value read from /proc/sys/kernel/sched_rr_timeslice_ms.

Looking at centos 6, the older distribution we support, the kernel there
is based on 4.15 so we do not have to bother with check if the file is
present. But we should really add a tag for the kernel commit that fixed
the issue.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index 31d7b5d56a52..f358c91ac505 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -62,6 +62,7 @@ static void run(void)
>  		        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
>  	}
>  
> +	TST_ASSERT_INT("/proc/sys/kernel/sched_rr_timeslice_ms", tst_ts_to_ms(tp));
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

-- 
Cyril Hrubis
chrubis@suse.cz
