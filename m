From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 May 2020 10:48:37 +0200
Subject: [LTP] [PATCH V5] syscall: Add io_uring related tests
In-Reply-To: <20200526063555.25006-1-vikas.kumar2@arm.com>
References: <20200526063555.25006-1-vikas.kumar2@arm.com>
Message-ID: <20200526084837.GA10775@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vikas,

not a complete review, just a few notes.

...
> +/*
> + * Check whether the ioring related system calls are supported on
> + * the current kernel. These system calls are enabled by default
> + * on kernel version 5.1.0 or higher. But they also might have
> + * been backported as well.
> + */
IMHO the function name is obvious, so please shorten the comment :).
> +void io_uring_setup_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 1, 0)) < 0) {
> +		TEST(syscall(__NR_io_uring_setup, NULL, 0));
> +		if (TST_RET != -1)
> +			SAFE_CLOSE(TST_RET);
> +		else if (TST_ERR == ENOSYS)
> +			tst_brk(TCONF,
> +				"Test not supported on kernel version < v5.1");
> +	}
> +}
> +
> +void io_uring_register_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 1, 0)) < 0) {
> +		TEST(syscall(__NR_io_uring_register, NULL, 0));
> +		if (TST_RET != -1)
> +			SAFE_CLOSE(TST_RET);
> +		else if (TST_ERR == ENOSYS)
> +			tst_brk(TCONF,
> +				"Test not supported on kernel version < v5.1");
> +	}
> +}
> +
> +void io_uring_enter_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 1, 0)) < 0) {
> +		TEST(syscall(__NR_io_uring_enter, NULL, 0));
> +		if (TST_RET != -1)
> +			SAFE_CLOSE(TST_RET);
> +		else if (TST_ERR == ENOSYS)
> +			tst_brk(TCONF,
> +				"Test not supported on kernel version < v5.1");
> +	}
> +}
IMHO It's unlikely that somebody would backport just some syscalls, not all 3.
I'd be just for testing io_uring_setup().
Then no setup function is needed (use .setup =
io_uring_setup_supported_by_kernel in struct tst_test).

And according to man pages only io_uring_setup() returns a file descriptor. The
other two takes it as a parameter, so SAFE_CLOSE(TST_RET) is wrong.
https://www.mankier.com/2/io_uring_setup
https://www.mankier.com/2/io_uring_register
https://www.mankier.com/2/io_uring_enter
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int ret = 0;
> +
> +	s = SAFE_MALLOC(sizeof(*s));
> +	if (!s)
> +		return;
All SAFE_* macros (and safe_* functions which use them) are here to avoid these
checks in the code. They exit executing via tst_brk(TCONF, "..."), therefore use
just
s = SAFE_MALLOC(sizeof(*s));
(drop the check).

> +
> +	memset(s, 0, sizeof(*s));
> +	ret = setup_io_uring_test(s, tc);
> +	if (ret)
> +		tst_res(TFAIL | TTERRNO, "io_uring_setup error");
> +
> +	ret = submit_to_uring_sq(s, tc);
> +	if (ret)
> +		tst_res(TFAIL | TTERRNO, "io_uring_submit error");
> +	else
> +		tst_res(TPASS, "functionality of io_uring API is correct");

nit: we prefer return in if instead of else:

if (submit_to_uring_sq(s, tc)) {
	tst_res(TFAIL | TTERRNO, "io_uring_submit error");
	return;
}

tst_res(TPASS, "functionality of io_uring API is correct");

Kind regards,
Petr
