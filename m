From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 14:43:36 +0200
Subject: [LTP] [PATCH 1/7] syscalls/clone01: Convert to new API
In-Reply-To: <20210813072505.20207-1-zhanglianjie@uniontech.com>
References: <20210813072505.20207-1-zhanglianjie@uniontech.com>
Message-ID: <YSY6+J/TXho4wTHF@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*\
> + * [Description]
> + * This is a test for the clone(2) system call.
> + * It is intended to provide a limited exposure of the system call.

We should write a better description than this, ideally outline what the
test really does with something as:

/*\
 * [Description]
 *
 * Basic clone() test.
 *
 * Starts a child with clone() syscalls, child does exit(0) and parent waits on it.
 */

>   */
> 
> -#if defined UCLINUX && !__THROW
> -/* workaround for libc bug */
> -#define __THROW
> -#endif
> -
> -#include <errno.h>
> -#include <sched.h>
> -#include <sys/wait.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdlib.h>
> +#include "tst_test.h"
>  #include "clone_platform.h"
> 
> -static void setup(void);
> -static void cleanup(void);
> -static int do_child();
> +static void *child_stack;
> 
> -char *TCID = "clone01";
> -int TST_TOTAL = 1;
> +static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	exit(0);
> +}
> 
> -int main(int ac, char **av)
> +static void verify_clone(void)
>  {
> -	void *child_stack;
>  	int status, child_pid;
> 
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	TST_EXP_POSITIVE(ltp_clone(SIGCHLD, do_child, NULL,
> +		CHILD_STACK_SIZE, child_stack), "clone()");
> 
> -	setup();
> +	child_pid = SAFE_WAIT(&status);
> 
> -	child_stack = malloc(CHILD_STACK_SIZE);
> -	if (child_stack == NULL)
> -		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
> -
> -	tst_count = 0;
> -
> -	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
> -	if (TEST_RETURN == -1)
> -		tst_resm(TFAIL | TTERRNO, "clone failed");
> -
> -	child_pid = SAFE_WAIT(cleanup, &status);
> -
> -	if (TEST_RETURN == child_pid)
> -		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
> +	if (TST_RET == child_pid)
> +		tst_res(TPASS, "clone returned %ld", TST_RET);
>  	else
> -		tst_resm(TFAIL, "clone returned %ld, wait returned %d",
> -			 TEST_RETURN, child_pid);
> -
> -	free(child_stack);
> -
> -	cleanup();
> -
> -	tst_exit();
> +		tst_res(TFAIL, "clone returned %ld, wait returned %d",
> +			 TST_RET, child_pid);


I guess that we should as well check that the test did exit with zero as
well with something as:

	if (WIFEXITTED(status) && WEXITSTATUS(status) == 0)
		tst_res(TPASS, "Child exitted with 0");
	else
		tst_res(TFAIL, "Child %s", tst_strstatus(status));

>  }
> 
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +static void setup(void) {
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
>  }
> 
> -static void cleanup(void)
> -{
> +static void cleanup(void) {
> +	free(child_stack);
>  }

These two functions violate LKML coding style, the opening brace have to
be on a seprate line.

You can easily check for these with the checkpatch.pl script as
described in:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#6-test-contribution-checklist

> -static int do_child(void)
> -{
> -	exit(0);
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_clone,
> +	.forks_child = 1,
> +//	.needs_tmpdir = 1,

If it's not needed just delete the line, no commented code please.

> +};
> \ No newline at end of file
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
