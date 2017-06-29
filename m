From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Jun 2017 15:54:09 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/{mq_timedsend,
 mq_timedreceive}: Convert to new API + cleanup
In-Reply-To: <20170609191252.9870-2-pvorel@suse.cz>
References: <20170609191252.9870-1-pvorel@suse.cz>
 <20170609191252.9870-2-pvorel@suse.cz>
Message-ID: <20170629135408.GB3233@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static pid_t set_sig(void)
> +{
> +	clock_gettime(CLOCK_REALTIME, &eintr_ts);
> +	eintr_ts.tv_sec += 3;
> +
> +	return create_sig_proc(SIGINT, 40, 200000);
> +}
> +
> +static void set_timeout(void)
> +{
> +	clock_gettime(CLOCK_REALTIME, &timeout_ts);
> +	timeout_ts.tv_nsec += 50000000;
> +	timeout_ts.tv_sec += timeout_ts.tv_nsec / 1000000000;
> +	timeout_ts.tv_nsec %= 1000000000;
> +}

I went ahead and changed these two functions to get the timespec as a
parameter, which eliminated need for the two global timespec variables,
which made the code flow a bit easier to understand.

And pushed the patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
