From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 08:02:17 +0200
Subject: [LTP] [PATCH v2 1/7] syscalls/clone01: Convert to new API
In-Reply-To: <20210902010814.32448-1-zhanglianjie@uniontech.com>
References: <20210902010814.32448-1-zhanglianjie@uniontech.com>
Message-ID: <YTBo6ZS2GKWb8edF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi zhanglianjie,

...
> +static void verify_clone(void)
>  {
> -	void *child_stack;
>  	int status, child_pid;

> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	TST_EXP_POSITIVE(ltp_clone(SIGCHLD, do_child, NULL,
Shouldn't be TST_EXP_PID_SILENT()
Because TST_EXP_POSITIVE() prints extra TPASS which is useless:

clone01.c:31: TPASS: clone() returned 11556
clone01.c:37: TPASS: clone returned 11556
clone01.c:43: TPASS: Child exited with 0

but with TST_EXP_PID_SILENT():
clone01.c:37: TPASS: clone returned 11986
clone01.c:43: TPASS: Child exited with 0

and on deliberate error (using -1 as flag):
clone01.c:31: TFAIL: clone() failed: EINVAL (22)
clone01.c:34: TBROK: wait(0x7ffed515f3ec) failed: ECHILD (10)

> +		CHILD_STACK_SIZE, child_stack), "clone()");

> -	child_stack = malloc(CHILD_STACK_SIZE);
> -	if (child_stack == NULL)
> -		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
> +	child_pid = SAFE_WAIT(&status);

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
	if (child_pid ==  TST_RET)

=> run `make check-clone01' to see this error (and run make check-* for other
tests).


Kind regards,
Petr
