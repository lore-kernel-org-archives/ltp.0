Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XoBmE-0001vV-V7
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 13:46:35 +0000
Date: Tue, 11 Nov 2014 14:45:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111134555.GA32196@rei>
References: <1415268497-8921-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415268497-8921-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] device-drivers/ltp_acpi_cpufreq: use simple
 counter instead of cur_freq
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> -void *thread_fn(void *val)
> +static int load_cpu(int max_freq_khz)
>  {
> -	struct timeval tv_start;
> -	struct timeval tv_end;
> -	int i, res = 0;
> -	intptr_t timeout = (intptr_t) val;
> -
> -	gettimeofday(&tv_start, NULL);
> -	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
> +	int sum = 0, i = 0, total_time_ms;
> +	struct timespec tv_start, tv_end;
>  
> -	do {
> -		for (i = 1; i < 10000; ++i)
> -			res += i * i;
> -		gettimeofday(&tv_end, NULL);
> -		sched_yield();
> -	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
> -
> -	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
> +	const int max_sum = max_freq_khz / 1000;
> +	const int units = 1000000; /* Mhz */
>  
> -	return NULL;
> -}
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_start);
>  
> -static int load_cpu(intptr_t timeout)
> -{
> -	pthread_t thread_id;
> +	do {
> +		for (i = 0; i < units; ++i)
> +			asm ("" : : : "memory");
> +	} while (++sum < max_sum);
>  
> -	if (pthread_create(&thread_id, 0, thread_fn,
> -		(void *) timeout) != 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			"pthread_create failed at %s:%d",
> -			__FILE__, __LINE__);
> -	}
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_end);
>  
> -	sleep(2 * timeout / 3);
> +	total_time_ms = (tv_end.tv_sec - tv_start.tv_sec) * 1000 +
> +		(tv_end.tv_nsec - tv_start.tv_nsec) / 1000000;
>  
> -	int cur_freq;
> -	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
> -	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
> +	if (!total_time_ms)
> +		tst_brkm(TBROK, cleanup, "can't calc freq, time period is 0");
>  
> -	pthread_join(thread_id, NULL);
> +	tst_resm(TINFO, "elapsed time is %d ms", total_time_ms);
>  
> -	return cur_freq;
> +	return sum * 1000 / total_time_ms;

Is this conversion really necessary? I guess that we can also return
the elapsed time here and test that the time is shorted by a few
percents with boost enabled in the test_run() function.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
