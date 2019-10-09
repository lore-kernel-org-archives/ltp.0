From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 15:56:56 +0200
Subject: [LTP] [PATCH] read_all: retry to queue work for any worker
In-Reply-To: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
References: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
Message-ID: <20191009135656.GD7561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void work_push_retry(int worker, const char *buf)
> +{
> +	int i, ret, worker_min, worker_max;
> +
> +	if (worker < 0) {
> +		/* pick any, try -worker first */
> +		worker_min = worker * (-1);
> +		worker_max = worker_count;
> +	} else {
> +		/* keep trying worker */
> +		worker_min = worker;
> +		worker_max = worker + 1;
> +	}
> +	i = worker_min;
> +
> +	for (;;) {
> +		ret = queue_push(workers[i].q, buf);
> +		if (ret == 1)
> +			break;
> +
> +		if (++i >= worker_max) {
> +			i = worker_min;
> +			usleep(100000);


My only concern is that we sleep for too long here. Maybe we should
start with smaller sleep here and increase it after a while.

Or have you checked that the tests runs as fast as if we had smaller
sleep here?

> +		}
> +	}
> +}
> +
>  static void stop_workers(void)
>  {
>  	const char stop_code[1] = { '\0' };
> @@ -292,7 +319,7 @@ static void stop_workers(void)
>  
>  	for (i = 0; i < worker_count; i++) {
>  		if (workers[i].q)
> -			TST_RETRY_FUNC(queue_push(workers[i].q, stop_code), 1);
> +			work_push_retry(i, stop_code);
>  	}
>  
>  	for (i = 0; i < worker_count; i++) {
> @@ -310,7 +337,7 @@ static void rep_sched_work(const char *path, int rep)
>  	for (i = j = 0; i < rep; i++, j++) {
>  		if (j >= worker_count)
>  			j = 0;
> -		TST_RETRY_FUNC(queue_push(workers[j].q, path), 1);
> +		work_push_retry(-j, path);
>  	}
>  }
>  
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
