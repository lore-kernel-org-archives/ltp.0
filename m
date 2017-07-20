From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 14:08:07 +0200
Subject: [LTP] [PATCH v3 9/9] Test for CVE-2017-2671 on ping sockets
In-Reply-To: <20170623122211.29575-10-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-10-rpalethorpe@suse.com>
Message-ID: <20170720120807.GE32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	pthread_t thrd;
> +	int i;
> +
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
> +	tst_res(TINFO, "Created ping socket, attempting to race...");
> +
> +	for (i = 0; i < ATTEMPTS; i++) {
> +		SAFE_CONNECT(sockfd,
> +			     (struct sockaddr *)&iaddr, sizeof(iaddr));
> +		SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
> +
> +		tst_fzsync_delay_a(&fzsync_pair);
> +		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
> +		tst_fzsync_time_a(&fzsync_pair);
> +
> +		SAFE_PTHREAD_JOIN(thrd, 0);
> +		tst_fzsync_pair_update(i, &fzsync_pair);
> +
> +		if (!(i & 0x7FFF))
> +			tst_fzsync_pair_info(&fzsync_pair);
> +	}
> +
> +	tst_res(TPASS, "We didn't crash");

Hmm, shouldn't we close the sockfd here?

Or even better cannot we create the socket in the test setup and destroy
it in the test cleanup. That way everything should work fine even with
the -i option.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +};
> -- 
> 2.12.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
