From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 16:28:47 +0200
Subject: [LTP] [PATCH 5/7] syscalls/clone05: Convert to new API
In-Reply-To: <20210813072657.21976-1-zhanglianjie@uniontech.com>
References: <20210813072657.21976-1-zhanglianjie@uniontech.com>
Message-ID: <YSZTn5KKmOgFINNX@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static int child_exited = 0;
               ^
	       This should be volatile to avoid compiler miscompilation,
	       also there is no point in setting it to 0 either, it's
	       global variable and these are initialized to zero
	       regardless.

> +static void *child_stack;
> 
> -int main(int ac, char **av)
> +static int child_fn(void *unused __attribute__((unused)))
>  {
> +	int i;
> 
> -	int lc, status;
> -	void *child_stack;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	child_stack = malloc(CHILD_STACK_SIZE);
> -	if (child_stack == NULL)
> -		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		TEST(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
> -		               CHILD_STACK_SIZE, child_stack));
> -
> -		if ((TEST_RETURN != -1) && (child_exited))
> -			tst_resm(TPASS, "Test Passed");
> -		else
> -			tst_resm(TFAIL, "Test Failed");
> +	for (i = 0; i < 100; i++) {
> +		sched_yield();
> +		usleep(1000);
> +	}
> 
> -		if ((wait(&status)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "wait failed, status: %d", status);
> +	child_exited = 1;
> +	_exit(0);
> +}
> 
> -		child_exited = 0;
> -	}
> +static void verify_clone(void)
> +{
> +	TST_EXP_POSITIVE(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
> +					CHILD_STACK_SIZE, child_stack), "clone with vfork");
> 
> -	free(child_stack);
> +	if (!TST_PASS)
> +		return;
> 
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_PASS(!child_exited);

This is misuse of the macro, since the macro checks for -1 on failure
and we will get 1 on failure here.

I guess that we should add TST_EXP_VAL() instead for cases like this and
we would do:

	TST_EXP_VAL(child_exited, 1);

Will you send a patch or should I add it?

-- 
Cyril Hrubis
chrubis@suse.cz
