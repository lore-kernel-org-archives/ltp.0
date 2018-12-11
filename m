From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Dec 2018 09:57:45 +0100
Subject: [LTP] [PATCH] getrlimit03: Allow for missing getrlimit syscall
 at runtime
In-Reply-To: <20181210131952.27010-1-rpalethorpe@suse.com>
References: <20181210131952.27010-1-rpalethorpe@suse.com>
Message-ID: <20181211085745.GA2824@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> It appears that __NR_getrlimit can be missing or disabled in the kernel. For
> example this appears to be the case on the PPC64le platform. So this changes
> the test to return TCONF under these circumstances as this system call is
> redundant and libc can implement it in terms of other calls.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---

...
>  #if SIGNED_GETRLIMIT
> +	if (seen_getrlimit_nosys)
> +		goto EXIT;
> +
>  	errno = 0;
>  	ret_l = getrlimit_long(resource, &rlim_l);
>  	errno_l = errno;

> +	if (errno_l == ENOSYS) {
> +		tst_res(TCONF,
> +			"__NR_getrlimit(%d) is not present", __NR_getrlimit);
> +		seen_getrlimit_nosys = 1;
> +		return;
> +	}
> +
>  	if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno_l,
>  			   "__NR_getrlimit") ||
>  	    compare_u64_long(resource, rlim_u64.rlim_cur, rlim_l.rlim_cur,
> @@ -172,6 +184,7 @@ static void run(unsigned int resource)
>  		return;
>  #endif

> +EXIT:

Minor issue: EXIT should be before #endif (otherwise it issues warning on !SIGNED_GETRLIMIT.

>  	tst_res(TPASS, "getrlimit(%u) was consistent during all syscalls",
>  		resource);
>  }


Kind regards,
Petr
