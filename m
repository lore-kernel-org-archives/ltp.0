From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jul 2021 14:02:53 +0200
Subject: [LTP] [PATCH 3/3] Add lockdown checks to init_module* and
 finit_module* tests
In-Reply-To: <20210720103941.9767-3-mdoucha@suse.cz>
References: <20210720103941.9767-1-mdoucha@suse.cz>
 <20210720103941.9767-3-mdoucha@suse.cz>
Message-ID: <YPa7bSB8pNPrBDn8@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void lockdown_setup(struct tcase *tc)
> +{
> +	if (kernel_lockdown)
> +		tc->exp_errno = EPERM;
> +}
> +
>  static struct tcase tcases[] = {
>  	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, bad_fd_setup},
>  	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
> -	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT, NULL},
> -	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
> +	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT,
> +		lockdown_setup},
> +	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0,
> +		EINVAL, lockdown_setup},
>  	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL, NULL},
>  	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, NULL},
>  	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, NULL},

I'm slightly afraid that the order of checks may change over the time
and we will get EPERM in all these cases, but maybe I'm just overly
cautious. Other than this the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
