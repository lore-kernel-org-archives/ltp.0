From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 15:05:36 +0200
Subject: [LTP] [PATCH 2/8] waitpid06: use the new API
In-Reply-To: <1468593589-30545-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1468593589-30545-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160718130536.GC18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#include <sys/types.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <sys/wait.h>
> -#include "test.h"
> -
> -static void setup_sigint(void);
> -static void do_child_1(void);
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "waitpid06";
> -int TST_TOTAL = 1;
> -volatile int intintr;
> -static void inthandlr();
> -static void do_exit(void);
> -static int flag;
> -
> -#define	FAILED	1
> -#define	MAXKIDS	8
> -
> -#ifdef UCLINUX
> -static char *argv0;
> -static void do_child_2_uclinux(void);
> -#endif
> -
> -int main(int argc, char **argv)
> -{
> -	int lc;
> -	int fail = 0;
> -	int pid;
> -	int status;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -#ifdef UCLINUX
> -	argv0 = argv[0];
> -
> -	maybe_run_child(&do_child_1, "n", 1);
> -	maybe_run_child(&do_child_2_uclinux, "n", 2);
> -#endif
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		pid = FORK_OR_VFORK();
> -		if (pid < 0) {
> -			tst_resm(TINFO, "Fork Failed, may be OK under stress");
> -			exit(pid);
> -		} else if (pid == 0) {
> -			/*
> -			 * Child:
> -			 * Set up to catch SIGINT.  The kids will wait till a
> -			 * SIGINT has been received before they proceed.
> -			 */
> -#ifdef UCLINUX
> -			if (self_exec(argv[0], "n", 1) < 0) {
> -				tst_resm(TINFO, "self_exec failed");
> -				exit(pid);
> -			}
> -#else
> -			do_child_1();
> -#endif
> -		} else {	/* parent */
> -			fail = 0;
> -			waitpid(pid, &status, 0);
> -			if (WEXITSTATUS(status) != 0) {
> -				tst_resm(TFAIL, "child returned bad status");
> -				fail = 1;
> -			}
> -			if (fail)
> -				tst_resm(TFAIL, "%s FAILED", TCID);
> -			else
> -				tst_resm(TPASS, "%s PASSED", TCID);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -/*
> - * setup_sigint()
> - *	Sets up a SIGINT handler
> - */
> -static void setup_sigint(void)
> -{
> -	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
> -		tst_resm(TFAIL, "signal SIGINT failed. " "errno = %d", errno);
> -		exit(-1);
> -	}
> -}
> +#include "waitpid_common.h"
>  
>  static void do_child_1(void)
>  {
> -	int kid_count, fork_kid_pid[MAXKIDS];
> -	int ret_val;
> +	int kid_count;
> +	pid_t ret_val;
>  	int i, j, k, found;
> -	int group1, group2;
> -	int wait_kid_pid[MAXKIDS], status;
> -
> -	setup_sigint();
> +	pid_t wait_kid_pid[MAXKIDS];
> +	int status;
> +	int flag = 0;
>  
> -	group1 = getpgrp();
>  	for (kid_count = 0; kid_count < MAXKIDS; kid_count++) {
>  		if (kid_count == (MAXKIDS / 2))
> -			group2 = setpgrp();
> +			SAFE_SETPGID(0, 0);
>  
> -		intintr = 0;
> -		ret_val = FORK_OR_VFORK();
> -		if (ret_val == 0) {	/* child */
> -#ifdef UCLINUX
> -			if (self_exec(argv0, "n", 2) < 0) {
> -				tst_resm(TFAIL, "Fork kid %d failed. "
> -					 "errno = %d", kid_count, errno);
> -				exit(ret_val);
> -			}
> -#else
> -			do_exit();
> -#endif
> -		} else if (ret_val < 0) {
> -			tst_resm(TFAIL, "Fork kid %d failed. "
> -				 "errno = %d", kid_count, errno);
> -			exit(ret_val);
> -		}
> +		ret_val = SAFE_FORK();
> +		if (ret_val == 0)
> +			do_exit(0);
>  
> -		/* parent */
>  		fork_kid_pid[kid_count] = ret_val;

>  	}
>  
> -#ifdef UCLINUX
> -	/* Give the kids a chance to setup SIGINT again, since this is
> -	 * cleared by exec().
> -	 */
> -	sleep(3);
> -#endif
> -
> -	/* Now send all the kids a SIGINT to tell them to
> -	 * proceed
> -	 */
> -	for (i = 0; i < MAXKIDS; i++) {
> -		if (kill(fork_kid_pid[i], SIGINT) < 0) {
> -			tst_resm(TFAIL, "Kill of child %d "
> -				 "failed, errno = %d", i, errno);
> -			exit(-1);
> -		}
> -	}
> +	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
>  
>  	/*
>  	 * Wait till all kids have terminated.  Stash away their
> -	 * pid's in an array.
> +	 * pids in an array.
>  	 */
>  	kid_count = 0;
>  	errno = 0;
> @@ -207,16 +63,15 @@ static void do_child_1(void)
>  			continue;
>  
>  		if (!WIFEXITED(status)) {
> -			tst_resm(TFAIL, "Child %d did not exit "
> +			tst_res(TFAIL, "Child %d did not exit "
>  				 "normally", ret_val);
>  			flag = FAILED;
> -			printf("status: %d\n", status);
>  		} else {
>  			if (WEXITSTATUS(status) != 3) {
> -				tst_resm(TFAIL, "Child %d"
> +				tst_res(TFAIL, "Child %d "
>  					 "exited with wrong "
>  					 "status", ret_val);
> -				tst_resm(TFAIL, "Expected 3 "
> +				tst_res(TFAIL, "Expected 3 "
>  					 "got %d ", WEXITSTATUS(status));
>  				flag = FAILED;
>  			}
> @@ -239,16 +94,16 @@ static void do_child_1(void)
>  		}
>  
>  		if (!found) {
> -			tst_resm(TFAIL, "Did not find a "
> +			tst_res(TFAIL, "Did not find a "
>  				 "wait_kid_pid for the "
>  				 "fork_kid_pid of %d", wait_kid_pid[i]);
>  			for (k = 0; k < MAXKIDS; k++) {
> -				tst_resm(TFAIL,
> +				tst_res(TFAIL,
>  					 "fork_kid_pid[%d] = "
>  					 "%d", k, fork_kid_pid[k]);
>  			}
>  			for (k = 0; k < kid_count; k++) {
> -				tst_resm(TFAIL,
> +				tst_res(TFAIL,
>  					 "wait_kid_pid[%d] = "
>  					 "%d", k, wait_kid_pid[k]);

This should probably be TINFO rather than TFAIL.

> +	exit(flag);
>  }

The TFAIL should be propagated automatically (the test results are
stored in shared memory in newlib), we can drop the whole logic around
the flag and exit value.

> -static void do_exit(void)
> -{
> -	wait_for_parent();
> -	exit(3);
> -}
> +static struct tst_test test = {
> +	.tid = "waitpid06",
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.cleanup = cleanup,
> +	.test_all = waitpid_test,
> +};
> diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
> new file mode 100644
> index 0000000..909468a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * Licensed under the GNU GPLv2 or later.
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +#ifndef WAITPID_COMMON_H__
> +#define WAITPID_COMMON_H__
> +
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define	FAILED	1
> +#define	MAXKIDS	8
> +
> +static pid_t *fork_kid_pid;
> +
> +static void do_child_1(void);
> +
> +static void cleanup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAXKIDS; i++) {
> +		if (fork_kid_pid[i] > 0) {
> +			kill(fork_kid_pid[i], SIGKILL);
> +			waitpid(fork_kid_pid[i], NULL, 0);
> +		}
> +	}

We should kill the pid of the do_child_1() here as well.

And possibly unmap the shared memory.

> +}
> +
> +static void waitpid_test(void)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	fork_kid_pid = SAFE_MMAP(NULL, sizeof(*fork_kid_pid) * MAXKIDS,
> +				 PROT_READ | PROT_WRITE,
> +				 MAP_SHARED | MAP_ANONYMOUS, -1, 0);

So we allocate shared memory here so that we can kill all the children
from the main test process. That's fine, but this should be done in the
setup() rather than in the test() function. Since otherwise this will
allocate the memory on each iteration of the test.

Also there is a race condition since we wait() on the pid, then do
various checks, then finally clear the array. We should rather clear the
pid from the shared array right after we return from the wait() and keep
a copy of the array for the checks.

Or we can zero the pid from the array the moment we get it from
waitpid() and also produce failure if particular pid couldn't be found.

Something as:

	for (;;) {
		pid = waitpid(-1, &status, 0);

		if (pid < 0) {
			if (errno == EINTR)
				continue;

			break;
		}

		for (i = 0; i < MAXKIDS; i++) {
			if (pid == pids[i]) {
				pids[i] = 0;
				break;
			}
		}

		if (i == MAXKIDS)
			tst_res(TFAIL, "Pid %i not found...", pid);

		if (!WIFEXITED(status))
			tst_res(TFAIL, "Pid %i returned with %i", pid, status);
	}

	for (i = 0; i < MAXKIDS; i++) {
		if (pids[i])
			tst_res(TFAIL, "Pid %i not reaped", pids[i]);
	}

> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_child_1();
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WEXITSTATUS(status) != 0)
> +			tst_res(TFAIL, "Child returned bad status");
> +		else
> +			tst_res(TPASS, "Child returned good status");
> +	}

Here as well, the test result is already in the shared memory.

We should check here if the child wasn't killed at this point though.
Something as:

	if (!WIFEXITED(status))
		tst_brk(TBROK, "Child exited abnormally");

> +}
> +
> +static void do_exit(int stop)
> +{
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	if (stop)
> +		kill(getpid(), SIGSTOP);
> +
> +	exit(3);
> +}
> +
> +#endif /* WAITPID_COMMON_H__ */
> -- 
> 1.7.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
