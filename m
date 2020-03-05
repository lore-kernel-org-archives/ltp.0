From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Mar 2020 15:46:06 +0100
Subject: [LTP] [PATCH 1/2] Add TST_ASSERT_SYSCALL*() macros
In-Reply-To: <20200305143658.26584-1-mdoucha@suse.cz>
References: <20200305143658.26584-1-mdoucha@suse.cz>
Message-ID: <20200305144606.GC28363@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/* assert that syscall returned only 0 and nothing else */
> +#define TST_ASSERT_SYSCALL(SCALL) \
> +	TST_ASSERT_SYSCALL_IMPL(SCALL, __FILE__, __LINE__)
> +
> +#define TST_ASSERT_SYSCALL_IMPL(SCALL, FILENAME, LINENO) \
> +	({ \
> +		int _tst_ret; \
> +		errno = 0; \
> +		_tst_ret = SCALL; \
> +		if (_tst_ret == -1) { \
> +			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
> +			tst_brk(_tst_ttype | TERRNO, "%s:%d " # SCALL \
                                                              ^
				I do not think that is reasonable to
				simply stringify the syscall, we are
				adding pretty printers for the syscall
				parameters and this change is backward.

These two patches are actually removing the pretty printer for the clock
id for the timerfd_create(). I do not like that.

> +				" failed", FILENAME, LINENO); \
> +		} \
> +		if (_tst_ret != 0) { \
> +			tst_brk(TBROK | TERRNO, "%s:%d " # SCALL \
> +				" returned invalid value %d", FILENAME, \
> +				LINENO, _tst_ret); \
> +		} \
> +		_tst_ret; \
> +	})
> +
> +/*
> + * assert that syscall returned any non-negative value (e.g. valid file
> + * descriptor)
> + */
> +#define TST_ASSERT_SYSCALL_FD(SCALL) \
> +	TST_ASSERT_SYSCALL_FD_IMPL(SCALL, __FILE__, __LINE__)
> +
> +#define TST_ASSERT_SYSCALL_FD_IMPL(SCALL, FILENAME, LINENO) \
> +	({ \
> +		int _tst_ret; \
> +		errno = 0; \
> +		_tst_ret = SCALL; \
> +		if (_tst_ret == -1) { \
> +			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
> +			tst_brk(_tst_ttype | TERRNO, "%s:%d " # SCALL \
> +				" failed", FILENAME, LINENO); \
> +		} \
> +		if (_tst_ret < 0) { \
> +			tst_brk(TBROK | TERRNO, "%s:%d " # SCALL \
> +				" returned invalid value %d", FILENAME, \
> +				LINENO, _tst_ret); \
> +		} \
> +		_tst_ret; \
> +	})
> +
>  /*
>   * Functions to convert ERRNO to its name and SIGNAL to its name.
>   */
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
