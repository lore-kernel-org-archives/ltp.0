From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Mar 2020 18:50:31 +0100
Subject: [LTP] [PATCH v2 2/2] Reimplement TST_SAFE_TIMERFD_*() using
 TST_ASSERT_SYSCALL*()
In-Reply-To: <20200305151459.30341-2-mdoucha@suse.cz>
References: <20200305151459.30341-1-mdoucha@suse.cz>
 <20200305151459.30341-2-mdoucha@suse.cz>
Message-ID: <20200305175031.GB29517@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -	fd = timerfd_create(clockid, flags);
> -	if (fd < 0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
> -			file, lineno, tst_clock_name(clockid));
> -	}
> -
> -	return fd;
> +	return TST_ASSERT_SYSCALL_FD_IMPL(timerfd_create(clockid, flags), file,
> +		lineno, "timerfd_create(%s)", tst_clock_name(clockid));
>  }

>  int safe_timerfd_gettime(const char *file, const int lineno,
>  				int fd, struct itimerspec *curr_value)
>  {
> -	int rval;
> -
> -	rval = timerfd_gettime(fd, curr_value);
> -	if (rval != 0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
> -			file, lineno);
> -	}
> -
> -	return rval;
> +	return TST_ASSERT_SYSCALL_IMPL(timerfd_gettime(fd, curr_value), file,
> +		lineno, "timerfd_gettime()");
>  }

I like sprintf formatting (it's needed), but it'd be nice to have a way to avoid
it, when it's just foo() (using SCALL_FUN and SCALL_PARAMS).
But that's probably too much optimization, resulting in unreadable macros.

Kind regards,
Petr
