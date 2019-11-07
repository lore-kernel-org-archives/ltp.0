From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 7 Nov 2019 09:56:12 +0100 (CET)
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
Message-ID: <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan,

The subsystem prefix for acct is surely not 'kernel.'. Try:

 git log --oneline kernel/acct.c

On Sat, 2 Nov 2019, Jan Stancek wrote:
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 81f9831a7859..991c898160cd 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -417,6 +417,7 @@ static void fill_ac(acct_t *ac)
>  	struct pacct_struct *pacct = &current->signal->pacct;
>  	u64 elapsed, run_time;
>  	struct tty_struct *tty;
> +	struct timespec64 ts;
>  
>  	/*
>  	 * Fill the accounting struct with the needed info as recorded
> @@ -448,7 +449,8 @@ static void fill_ac(acct_t *ac)
>  	}
>  #endif
>  	do_div(elapsed, AHZ);
> -	ac->ac_btime = get_seconds() - elapsed;
> +	ktime_get_real_ts64(&ts);
> +	ac->ac_btime = ts.tv_sec - elapsed;

So the calculation goes like this:

   runtime = ktime_get_ns() - current->...->start_time;

   elapsed = ns_to_ahz(runtime)
   
   elapsed /= AHZ	-> runtime in seconds
   
And then you retrieve the current wall time and just use the seconds
portion for building the delta. That still can fail in corner cases when
the runtime to seconds conversion does not have truncation in the
conversions and the timespec nanoseconds part is close to 1e9.

There is another issue related to suspend. If the system suspends then
runtime is accurate vs. clock MONOTONIC, but the offset between clock
MONOTONIC and clock REALTIME is not longer the same due to the
suspend/resume which has the same issue as what you are trying to solve
because

   runtime = totaltime - time_in_suspend

so your ac_btime will be off by time_in_suspend.

Something like this should work:

   runtime = ktime_get_ns() - current->...->start_time;
   ....
   runtime_boot = ktime_get_boot_ns() - current->...->real_start_time;
   start_ns = ktime_get_real_ns() - runtime_boot;
   start_s = startns / NSEC_PER_SEC;

current->...->real_start_time is clearly a misnomer as it suggests
CLOCK_REALTIME at first sight ...

But it would be way simpler just to store the CLOCK_REALTIME start time
along with BOOT and MONOTONIC and just get rid of all these horrible
calculations which are bound to be wrong.

Peter?

Thanks,

	tglx

   


