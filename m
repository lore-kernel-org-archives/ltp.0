From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Feb 2021 13:51:36 +0100
Subject: [LTP] [PATCH 4/5] API: Add tst_clone
In-Reply-To: <20210211110317.31942-5-rpalethorpe@suse.com>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
 <20210211110317.31942-5-rpalethorpe@suse.com>
Message-ID: <YCUoWPHssRVkQ+vf@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	int flags;
> +	pid_t pid = -1;
> +
> +	tst_flush();
> +
> +	errno = ENOSYS;
> +	if (__NR_clone3 != __LTP__NR_INVALID_SYSCALL)
> +		pid = syscall(__NR_clone3, &args, sizeof(args));
> +
> +	if (pid == -1 && errno != ENOSYS)
> +		return -1;

As far as I can tell when kernel is too old we would get EINVAL because
the syscall number is not allocated. ENOSYS happens mostly when syscall
number is allocated and kernel does not implement the functionality,
e.g. it's disabled in .config.

I wonder if it's even menaningful to handle ENOSYS here, I doubt that
clone3() can be disabled, or do I miss something?

> +	if (pid != -1)
> +		return pid;
> +
> +	flags = args.exit_signal | args.flags;
> +
> +#ifdef __s390x__
> +	pid = syscall(__NR_clone, NULL, flags);
> +#else
> +	pid = syscall(__NR_clone, flags, NULL);
> +#endif
> +
> +	if (pid == -1)
> +		return -2;
> +
> +	return pid;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 0714f0a0e..6bbee030b 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -424,6 +424,31 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
>  	return pid;
>  }
>  
> +pid_t safe_clone(const char *file, const int lineno,
> +		 const struct tst_clone_args *args)
> +{
> +	pid_t pid;
> +
> +	if (!tst_test->forks_child)
> +		tst_brk(TBROK, "test.forks_child must be set!");
> +
> +	pid = tst_clone(args);
> +
> +	switch (pid) {
> +	case -1:
> +		tst_brk_(file, lineno, TBROK | TERRNO, "clone3 failed");
> +		break;
> +	case -2:
> +		tst_brk_(file, lineno, TBROK | TERRNO, "clone failed");
> +		return -1;
> +	}
> +
> +	if (!pid)
> +		atexit(tst_free_all);
> +
> +	return pid;
> +}
> +
>  static struct option {
>  	char *optstr;
>  	char *help;
> -- 
> 2.30.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
