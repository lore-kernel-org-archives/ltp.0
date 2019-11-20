From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Nov 2019 13:33:39 +0100
Subject: [LTP] [PATCH 2/3] perf_event_open02: make do_work() run for
 specified time
In-Reply-To: <5b0f2a837117f3af1351d8b3da357cacecaa1463.1574087532.git.jstancek@redhat.com>
References: <cover.1574087532.git.jstancek@redhat.com>
 <5b0f2a837117f3af1351d8b3da357cacecaa1463.1574087532.git.jstancek@redhat.com>
Message-ID: <20191120123339.GE14963@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -static void do_work(void)
> +void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)

static void ?

> +{
> +	work_done = 1;
> +}
> +
> +static void do_work(int time_ms)
>  {
>  	int i;
> +	struct sigaction sa;
> +	struct itimerval val;
>  
> -	for (i = 0; i < LOOPS; ++i)
> -		asm volatile (""::"g" (i));
> -}
> +	work_done = 0;
> +	memset(&val, 0, sizeof(val));
> +	val.it_value.tv_sec = time_ms / 1000;
> +	val.it_value.tv_usec = (time_ms % 1000) * 1000;
>  
> +	sa.sa_handler = alarm_handler;
> +	sa.sa_flags = SA_RESETHAND;
> +	SAFE_SIGACTION(SIGALRM, &sa, NULL);

I would have set up the signal handler just once in the test setup.

> +	if (setitimer(ITIMER_REAL, &val, NULL))
> +		tst_brk(TBROK | TERRNO, "setitimer");
> +
> +	while (!work_done) {
> +		for (i = 0; i < 100000; ++i)
> +			asm volatile (""::"g" (i));
> +	}
> +}

Otherwise it looks great, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
