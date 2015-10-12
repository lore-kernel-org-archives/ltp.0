From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Oct 2015 18:15:21 +0200
Subject: [LTP] [PATCH V2] syscall/kcmp: Add tests for kcmp
In-Reply-To: <1444315747-21818-1-git-send-email-chnyda@suse.com>
References: <1444315747-21818-1-git-send-email-chnyda@suse.com>
Message-ID: <20151012161521.GB22254@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes (explained below), thanks.

> +#if !defined(HAVE_ENUM_KCMP_TYPE)
> +
> +enum kcmp_type {
> +	KCMP_FILE,
> +	KCMP_VM,
> +	KCMP_FILES,
> +	KCMP_FS,
> +	KCMP_SIGHAND,
> +	KCMP_IO,
> +	KCMP_SYSVSEM,
> +	KCMP_TYPES,
> +};
> +
> +#endif
> +
> +#if !defined(HAVE_KCMP)
> +
> +int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
> +{
> +	return ltp_syscall(__NR_kcmp, pid1, pid2, type, fd1, fd2);
> +}
> +
> +#else
> +
> +#include <linux/kcmp.h>
> +
> +#endif

This was wrong #if to add the #else to, the kcmp.h defines the enum not
the syscall. I've fixed that.

> +static struct test_case {
> +	int *pid1;
> +	int *pid2;
> +	int type;
> +	int *fd1;
> +	int *fd2;
> +	int exp_different;
> +} test_cases[] = {
> +	{&pid1, &pid2, KCMP_FILE, &fd1, &fd2, 0},
> +	{&pid1, &pid2, KCMP_FILE, &fd1, &fd3, 1},
> +};

I've added a few more tests here. Case where pid1 == pid2, fd1 == fd2
and both at the same time.

> +	if (test->exp_errno && TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "kcmp() succeeded unexpectedly");
> +		return;
> +	}
> +

And I've removed the test->exp_errno from this condition, since we test
only failures in this test.

-- 
Cyril Hrubis
chrubis@suse.cz
