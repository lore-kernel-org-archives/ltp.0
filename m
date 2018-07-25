From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Jul 2018 14:56:55 +0200
Subject: [LTP] [PATCH] syscalls/prctl03.c: New test for prctl() with
 PR_{SET, GET}_CHILD_SUBREAPER
In-Reply-To: <1532335907-9273-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1532335907-9273-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180725125655.GA23890@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * Test PR_SET_CHILD_SUBREAPER and PR_GET_CHILD_SUBREAPER of prctl(2).
> + * 1) If PR_SET_CHILD_SUBREAPER marks a process as a child subreaper, it
> + *    fulfills the role of init(1) for its descendant processes.   The
> + *    subreaper process can receive a SIGCHLD signal and wait(2) on its
> + *    descendant orphan process to discover corresponding termination status.
> + * 2) The setting of PR_SET_CHILD_SUBREAPER is not inherited by children
> + *    created by fork(2).
> + * 3) PR_GET_CHILD_SUBREAPER can get the setting of PR_SET_CHILD_SUBREAPER.
> + *
> + * These flags was added by kenrel commit ebec18a6d3aa:
> + * "prctl: add PR_{SET,GET}_CHILD_SUBREAPER to allow simple process supervision"
> + */
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/prctl.h>
> +
> +#include "tst_test.h"
> +
> +#ifndef PR_SET_CHILD_SUBREAPER
> +# define PR_SET_CHILD_SUBREAPER	36
> +# define PR_GET_CHILD_SUBREAPER	37
> +#endif

This should go to lapi/prctl.h.

> +static void check_get_subreaper(int exp_val)
> +{
> +	int get_val;
> +
> +	TEST(prctl(PR_GET_CHILD_SUBREAPER, &get_val));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_CHILD_SUBREAPER) failed");
> +		return;
> +	}
> +
> +	if (get_val == exp_val) {
> +		tst_res(TPASS, "prctl(PR_GET_CHILD_SUBREAPER) got expected %d",
> +			get_val);
> +	} else {
> +		tst_res(TFAIL, "prctl(PR_GET_CHILD_SUBREAPER) got %d, expected %d",
> +			get_val, exp_val);
> +	}
> +}
> +
> +static void verify_prctl(void)
> +{
> +	int status, ret;
> +	pid_t pid;
> +
> +	TEST(prctl(PR_SET_CHILD_SUBREAPER, 1));
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL) {
> +			tst_res(TCONF,
> +				"prctl() doesn't support PR_SET_CHILD_SUBREAPER");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"prctl(PR_SET_CHILD_SUBREAPER) failed");
> +		}
> +		return;
> +	}
> +
> +	tst_res(TPASS, "prctl(PR_SET_CHILD_SUBREAPER) succeeded");
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		pid_t cpid;
> +
> +		cpid = SAFE_FORK();
> +		if (!cpid) {
> +			TST_CHECKPOINT_WAIT(0);

We may as check the parent pid here, since we already waited the parent
it should have been reparented at this point.

> +			exit(0);
> +		}
> +
> +		check_get_subreaper(0);
> +		exit(1);

Why exit(1) when we don't use the value? I would expect exit(0) but that
is very minor.

> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +	TST_CHECKPOINT_WAKE(0);
> +	ret = wait(&status);
> +	if (ret > 0 && !WEXITSTATUS(status)) {
> +		tst_res(TPASS, "wait() got orphan process, pid %d status %d",
> +			ret, status);
> +	} else {
> +		tst_res(TFAIL | TERRNO, "wait() failed to get orphan process");
> +	}
> +	check_get_subreaper(1);
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.test_all = verify_prctl,
> +};

We may also set up a sigchild handler and check that we got sigchild
once the reparented process exitted.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
