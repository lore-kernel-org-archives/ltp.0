From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Mar 2020 18:42:05 +0100
Subject: [LTP] [PATCH v2 1/2] Add TST_ASSERT_SYSCALL*() macros
In-Reply-To: <20200305151459.30341-1-mdoucha@suse.cz>
References: <20200305151459.30341-1-mdoucha@suse.cz>
Message-ID: <20200305174205.GA29517@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> These macros take care of the standard return value checking boilerplate
> in cases where the test cannot continue after error.

> - TST_ASSERT_SYSCALL() calls tst_brk() if retval != 0
> - TST_ASSERT_SYSCALL_FD() calls tst_brk() if retval < 0
Reviewed-by: Petr Vorel <pvorel@suse.cz>

What I like on these macros (besides DRY) is that it really shows the test, not
the library, see
before:
tst_safe_timerfd.c:21: BROK: timerfd01.c:89 timerfd_create(CLOCK_MONOTONIC) failed: EINVAL (22)
after:
timerfd01.c:89: BROK: timerfd_create(CLOCK_MONOTONIC) failed: EINVAL (22)

> +/* assert that syscall returned only 0 and nothing else */
> +#define TST_ASSERT_SYSCALL(SCALL) \
> +	TST_ASSERT_SYSCALL_IMPL(SCALL, __FILE__, __LINE__, #SCALL)
> +
> +#define TST_ASSERT_SYSCALL_IMPL(SCALL, FILENAME, LINENO, CALLSTR, ...) \
> +	({ \
> +		int _tst_ret; \
> +		errno = 0; \
> +		_tst_ret = SCALL; \
> +		if (_tst_ret == -1) { \
> +			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
> +			tst_brk_(FILENAME, LINENO, _tst_ttype | TERRNO, \
> +				CALLSTR " failed", ##__VA_ARGS__); \
> +		} \
> +		if (_tst_ret != 0) { \
> +			tst_brk_(FILENAME, LINENO, TBROK | TERRNO, \
> +				CALLSTR " returned invalid value %d", \
> +				##__VA_ARGS__, _tst_ret); \
> +		} \
> +		_tst_ret; \
> +	})
> +
> +/*
> + * assert that syscall returned any non-negative value (e.g. valid file
> + * descriptor)
> + */
> +#define TST_ASSERT_SYSCALL_FD(SCALL) \
> +	TST_ASSERT_SYSCALL_FD_IMPL(SCALL, __FILE__, __LINE__, #SCALL)
> +
> +#define TST_ASSERT_SYSCALL_FD_IMPL(SCALL, FILENAME, LINENO, CALLSTR, ...) \
> +	({ \
> +		int _tst_ret; \
> +		errno = 0; \
> +		_tst_ret = SCALL; \
> +		if (_tst_ret == -1) { \
> +			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
> +			tst_brk_(FILENAME, LINENO, _tst_ttype | TERRNO, \
> +				CALLSTR " failed", ##__VA_ARGS__); \
> +		} \
> +		if (_tst_ret < 0) { \
> +			tst_brk_(FILENAME, LINENO, TBROK | TERRNO, \
> +				CALLSTR " returned invalid value %d", \
> +				##__VA_ARGS__, _tst_ret); \
> +		} \
> +		_tst_ret; \
> +	})

I'd consider to add single implementation, which would be influenced with flags
Something like
if ((flags & TST_ASSERT_LT_0) && _tst_ret < 0 || _tst_ret != 0) \

But maybe some people will not like degreased readability with macro,
and using flags would make it even a bit harder to read.

Kind regards,
Petr
