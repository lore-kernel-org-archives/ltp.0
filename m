From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 10:59:55 +0200
Subject: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
In-Reply-To: <20210906060020.3219023-1-liwang@redhat.com>
References: <20210906060020.3219023-1-liwang@redhat.com>
Message-ID: <YTXYixG37nBTzhXk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	updated_timestamp = get_timestamp(fd_dest);
> +	timestamp2 = get_timestamp(fd_dest);
>  
> -	if (timestamp == updated_timestamp)
> +	diff = tst_timespec_diff(timestamp1, timestamp2);
> +
> +	if (!diff.tv_sec && !diff.tv_nsec)
>  		tst_brk(TFAIL, "copy_file_range did not update timestamp.");

So as we changed the code to sleep for 1.5 sec I guess that we can
expect the difference to be at least 1 second because:

- the minimal granularity is 1s in which case we will get exactly 1s in
  the diff

- if the granularity is greater, we will get a bit more than 1s

So I would go for something as:

	long long diff_us = tst_timespec_diff_us(timestamp2, timestamp1);

	if (diff_us >= 1000000 && diff_us <= 2000000)
		tst_res(TPASS, "...");

Which expects that the difference between timestamps is in a sane range
not that it just have been changed.

>  	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
