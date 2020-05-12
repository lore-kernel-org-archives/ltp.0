From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 May 2020 17:44:09 +0200
Subject: [LTP] [PATCH 2/2] pty04: Retry reads when short
In-Reply-To: <20200512142824.13063-2-rpalethorpe@suse.com>
References: <20200512142824.13063-1-rpalethorpe@suse.com>
 <20200512142824.13063-2-rpalethorpe@suse.com>
Message-ID: <20200512154409.GA9960@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static ssize_t try_read(int fd, char *data, ssize_t size, ssize_t *n)
> +{
> +	ssize_t ret = read(fd, data, size);
> +
> +	if (ret < 0)
> +		return -(errno != EAGAIN);
> +
> +	return (*n += ret) >= size;
> +}

I had to read this piece twice, but I think it's correct.

>  static void read_netdev(const struct ldisc_info *ldisc)
>  {
> -	int rlen, plen = 0;
> +	int ret, rlen, plen = 0;
> +	ssize_t n;
>  	char *data;
>  
>  	switch (ldisc->n) {
> @@ -305,20 +316,27 @@ static void read_netdev(const struct ldisc_info *ldisc)
>  
>  	tst_res(TINFO, "Reading from socket %d", sk);
>  
> -	SAFE_READ(1, sk, data, plen);
> +	n = 0;
> +	ret = TST_RETRY_FUNC(try_read(sk, data, plen, &n), TST_RETVAL_NOTNULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "Read %zd of %d bytes", n, plen);

I wonder if a simple loop without exponential backoff would suffice
here. A least the code would probably be more readable.

>  	check_data(ldisc, data, plen);
>  	tst_res(TPASS, "Read netdev 1");
>  
> -	SAFE_READ(1, sk, data, plen);
> +	n = 0;
> +	ret = TST_RETRY_FUNC(try_read(sk, data, plen, &n), TST_RETVAL_NOTNULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "Read %zd of %d bytes", n, plen);
>  	check_data(ldisc, data, plen);
>  	tst_res(TPASS, "Read netdev 2");
>  
>  	TST_CHECKPOINT_WAKE(0);
> -	while((rlen = read(sk, data, plen)) > 0)
> +	while ((rlen = read(sk, data, plen)) > 0)
>  		check_data(ldisc, data, rlen);

This should have been part of the previous cleanup patch.

>  	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
>  
> +	close(sk);
>  	tst_free_all();
>  }
>  
> @@ -357,6 +375,7 @@ static void cleanup(void)
>  {
>  	ioctl(pts, TIOCVHANGUP);
>  	ioctl(ptmx, TIOCVHANGUP);
> +	close(sk);
>  
>  	tst_reap_children();
>  }
> -- 
> 2.26.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
