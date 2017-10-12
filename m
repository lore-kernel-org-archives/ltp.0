From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 16:15:34 +0200
Subject: [LTP] [PATCH v4 1/2] syscalls/setrlimit05.c: Add a test for
	EFAULT
In-Reply-To: <1507724801-4974-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171011114615.GC19812@rei.lan>
 <1507724801-4974-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171012141534.GA25576@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Test for EFAULT when rlim points outside the accessible address space.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +
> +static void verify_setrlimit(void)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
> +		if (TEST_RETURN != -1) {
> +			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
> +			goto end;
                         ^
			 Why not just exit(0) here?

> +		}
> +
> +		/* Usually, setrlimit() should return EFAULT */
> +		if (TEST_ERRNO == EFAULT) {
> +			tst_res(TPASS | TTERRNO,
> +				"setrlimit() failed as expected");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"setrlimit() should fail with EFAULT, got");
> +		}
> +end:
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	/* If glibc has to convert between 32bit and 64bit struct rlimit
> +	 * in some cases, it is possible to get SegFault.
> +	 */
> +	if (!WIFEXITED(status)) {
> +		if (WIFSIGNALED(status) == SIGSEGV) {
                              ^
			      This is wrong, we have to use
			      WTERMSIG(status) == SIGSEGV
> +			tst_res(TPASS,
> +				"setrlimit() returned SIGSEGV as expected");
> +		} else {
> +			tst_res(TFAIL, "setrlimit() did not return SIGSEGV");
> +		}
> +	}

We should generally do something as:

	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
		tst_res(TPASS, "setrlimit() caused SIGSEGV");
		return;
	}

	tst_brk(TBROK, "Child ended with status %i", status);

But that prints the status as a number, which is hard to decipher. And
this is not the first time pattern like this emerges in test code. Maybe
we just need a library function to dissect the status as returned by
wait and print it content, then we can print the status in
human-readable format here and exit. I will try to sketch such function
and send a patch to ML as RFC.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_setrlimit,
> +	.forks_child = 1,
> +};
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
