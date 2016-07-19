From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 16:21:19 +0200
Subject: [LTP] [PATCH 3/3] syscalls/kcmp03.c: Add new testcase
In-Reply-To: <1467803450-11622-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1467803450-11622-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160719142119.GG6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef CLONE_SYSVSEM
> +#define CLONE_SYSVSEM	0x00040000
> +#endif
> +
> +#ifndef CLONE_IO
> +#define CLONE_IO	0x80000000
> +#endif

These should rather go to the lapi/namespaces_constants.h

> +#define STACK_SIZE	(1024*1024)
> +
> +static int pid1;
> +static int pid2;
> +
> +static struct tcase {
> +	int clone_type;
> +	int kcmp_type;
> +} tcases[] = {
> +	{CLONE_VM, KCMP_VM},
> +	{CLONE_FS, KCMP_FS},
> +	{CLONE_IO, KCMP_IO},
> +	{CLONE_SYSVSEM, KCMP_SYSVSEM}
> +};
> +
> +static int do_child(void *arg)
> +{
> +	pid2 = getpid();
> +
> +	TEST(kcmp(pid1, pid2, *(int *)arg, 0, 0));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
> +		return 1;
> +	}
> +
> +	if (TEST_RETURN == 0) {
> +		tst_res(TPASS, "kcmp() returned the expected value");
> +	} else {
> +		tst_res(TFAIL, "kcmp() returned the unexpected value");
> +		return 1;

Why do we do the return 1 here if the value is not used at all? Why
don't we just fall down to the return 0; below?

> +	}
> +
> +	return 0;
> +}
> +
> +static void verify_kcmp(unsigned int n)
> +{
> +	int res;
> +	void *stack;
> +
> +	struct tcase *tc = &tcases[n];
> +
> +	pid1 = getpid();
> +
> +	stack = SAFE_MALLOC(STACK_SIZE);

Well, the stack could be allocated once in the test setup and freed in
the test cleanup.

> +	res = ltp_clone(tc->clone_type | SIGCHLD, do_child, &tc->kcmp_type,
> +			STACK_SIZE, stack);
> +	if (res == -1)
> +		tst_res(TFAIL | TERRNO, "clone() Failed");
> +
> +	SAFE_WAIT(NULL);
> +
> +	free(stack);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "kcmp03",
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_kcmp,
> +	.min_kver = "3.5.0"
> +};

The rest is fine.

-- 
Cyril Hrubis
chrubis@suse.cz
