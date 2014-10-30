Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XjpP6-00089h-6T
	for ltp-list@lists.sourceforge.net; Thu, 30 Oct 2014 13:04:40 +0000
Date: Thu, 30 Oct 2014 14:04:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141030130407.GB14847@rei.suse.de>
References: <1413451847-10433-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1413451847-10433-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] device-drivers/ltp_acpi_cpufreq: use simple
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
>  #define _GNU_SOURCE
> @@ -30,9 +33,11 @@
>  #include <stdlib.h>
>  #include <sched.h>
>  #include <sys/time.h>
> +#include <sys/resource.h>
>  #include <pthread.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <unistd.h>
>  #include <fcntl.h>
>  
>  #include "test.h"
> @@ -54,6 +59,8 @@ const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
>  const char curspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/cpuinfo_cur_freq";
>  const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
>  
> +const int units = 1000000; /* Mhz */
> +
>  static void cleanup(void)
>  {
>  	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
> @@ -110,26 +117,34 @@ void *thread_fn(void *val)
>  {
>  	struct timeval tv_start;
>  	struct timeval tv_end;
> -	int i, res = 0;
> -	intptr_t timeout = (intptr_t) val;
> +	int i;
> +	unsigned long long res = 0;

The res should be marked as volatile to avoid misoptimizations.

> +	intptr_t timeout = (intptr_t) val, ret;
> +
> +	struct sched_param params;
> +	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
> +	if (pthread_setschedparam(pthread_self(), SCHED_FIFO, &params)) {
> +		tst_resm(TWARN | TERRNO,
> +			"failed to set FIFO sched with max priority");
> +	}
>  
>  	gettimeofday(&tv_start, NULL);

We should use CLOCK_MONOTONIC_RAW for measuring the time here to avoid
failures when ntp daemon changes the system time, etc.

>  	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
>  
>  	do {
> -		for (i = 1; i < 10000; ++i)
> -			res += i * i;
> +		for (i = 0; i < units; ++i)
> +			++res;

Hmm, are you sure that the number stored in res divided by units and
timeout really yields the CPU speed?

I guess that it may, but that would also depend on what compiler does
with the code and how microcode is implemented in the target CPU, etc.
Or are you 100% sure that res/units/timeout will yield cpu speed in Mhz
in all cases?

If I'm reading the patch right, what it now does it two measurements to
see if things are faster with boost, that is fine but we should rather
stop calling the number speed and stop pretending that it's cpu speed in
Mhz.

>  		gettimeofday(&tv_end, NULL);
> -		sched_yield();
>  	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
>  
> -	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
> +	ret = res / units / timeout;
>  
> -	return NULL;
> +	return ((void *)ret);
>  }
>  
>  static int load_cpu(intptr_t timeout)
>  {
> +	void *ret;
>  	pthread_t thread_id;
>  
>  	if (pthread_create(&thread_id, 0, thread_fn,
> @@ -139,37 +154,37 @@ static int load_cpu(intptr_t timeout)
>  			__FILE__, __LINE__);
>  	}
>  
> -	sleep(2 * timeout / 3);
> -
> -	int cur_freq;
> -	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
> -	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
> -
> -	pthread_join(thread_id, NULL);
> +	pthread_join(thread_id, &ret);
>  
> -	return cur_freq;
> +	return (intptr_t)ret;
>  }
>  
>  static void test_run(void)
>  {
> -	int cur_freq, max_freq;
> +	int boost_freq, boost_off_freq, max_freq;
>  	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq);
>  	set_speed(max_freq);
>  
> +	/* make sure the process gets to run with the highest priority */
> +	load_cpu(5);
> +
>  	/* Enable boost */
>  	if (boost_value == 0)
>  		SAFE_FILE_PRINTF(cleanup, boost, "1");
> -	cur_freq = load_cpu(30);
> -	tst_resm((cur_freq >= max_freq) ? TPASS : TFAIL,
> -		"compare current speed %d and max speed %d",
> -		cur_freq, max_freq);
> +	boost_freq = load_cpu(12);
> +	tst_resm(TINFO, "avg counter freq with boost enabled: %d MHz", boost_freq);
>  
>  	/* Disable boost */
>  	SAFE_FILE_PRINTF(cleanup, boost, "0");
> -	cur_freq = load_cpu(30);
> -	tst_resm((cur_freq < max_freq) ? TPASS : TFAIL,
> -		"compare current speed %d and max speed %d",
> -		cur_freq, max_freq);
> +	boost_off_freq = load_cpu(12);
> +
> +	tst_resm(TINFO, "avg counter freq with boost disabled: %d MHz", boost_off_freq);
> +
> +	boost_off_freq *= 1.01;
> +
> +	tst_resm((boost_freq > boost_off_freq) ? TPASS : TFAIL,
> +		"compare boost speed %d and speed without boost + 1%% %d",
> +		boost_freq, boost_off_freq);
>  }
>  
>  int main(int argc, char *argv[])
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://p.sf.net/sfu/Zoho
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
