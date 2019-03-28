From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 28 Mar 2019 07:52:53 +0100
Subject: [LTP] [PATCH] syscalls/stime: Use 3 variants via
	test_multiplex()
In-Reply-To: <1553668210-6141-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1553668210-6141-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190328065243.GB11011@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
...
> +static int do_stime(time_t *ntime)
> +{
> +	switch (tst_variant) {
> +	case 0:
> +#ifdef __ANDROID__
> +		tst_brk(TCONF, "libc stime() is not implemented for Android");
IMHO this is not optimal. 1) That might change in the future, 2) Why not to fix
it for other foo libc implementations, which might suffer the same problem.
Therefore IMHO autotools check should be used.

> +#else
> +		return stime(ntime);
> +#endif
> +	case 1:
> +		return tst_syscall(__NR_stime, ntime);
> +	case 2: {
> +		struct timeval tv;
> +
> +		tv.tv_sec = *ntime;
> +		tv.tv_usec = 0;
> +
> +		return tst_syscall(__NR_settimeofday, &tv, (struct timezone *) 0);
> +	}
> +	}

Kind regards,
Petr
