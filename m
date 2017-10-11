From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 13:46:15 +0200
Subject: [LTP] [PATCH v3 1/2] syscalls/setrlimit05.c: Add a test for
	EFAULT
In-Reply-To: <1507697036-30535-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171010125459.GD4970@rei.lan>
 <1507697036-30535-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171011114615.GC19812@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +		if (TEST_RETURN == -1 && TEST_ERRNO == EFAULT)
> +			exit(0);
> +
> +		exit(1);

Can we do the PASS/FAIL for the expected errno here?

Then we need to handle just the TPASS in the parent in case of SegFault.

> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	/* Usually, setrlimit() should return EFAULT */
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
> +		tst_res(TPASS, "setrlimit() returned EFAULT as expected");
> +		return;
> +	}
> +
> +	/* If glibc has to convert between 32bit and 64bit struct rlimit
> +	 * in some cases, it is possible to get SegFault.
> +	 */
> +	if (!WIFEXITED(status) && WIFSIGNALED(status) == SIGSEGV) {
> +		tst_res(TPASS, "setrlimit() returned SIGSEGV as expected");
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "setrlimit() did not return EFAULT or SIGSEGV");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_setrlimit,
> +	.forks_child = 1,
> +	.needs_root = 1,

Do we really need root?

> +};
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
