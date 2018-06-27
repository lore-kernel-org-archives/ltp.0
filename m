From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 Jun 2018 09:21:29 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_test: Fail the test subprocess cannot
 be	killed
In-Reply-To: <20180627123606.27726-1-chrubis@suse.cz>
References: <20180627123606.27726-1-chrubis@suse.cz>
Message-ID: <937810331.29259972.1530105689475.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> If there are any leftover children the main test process will likely be
> killed while sleeping in wait(). That is because all child processes are
> either waited explicitely by the test code or implicitly by the test
> library.
> 
> We also send SIGKILL to the whole process group, so if one of the
> children continues to live for long enough it very likely means that
> it has ended up stuck in the kernel.
> 
> So if there are any processes left with in the process group for the
> test processes once the process group leader i.e. main test process has
> been waited for we loop for a short while to give the init daemon chance
> to reap the process after it has been reparented and if that does not
> happen for a few seconds we declare the process to be stuck in the
> kernel.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Eric Biggers <ebiggers3@gmail.com>
> ---
>  lib/tst_test.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 80808854e..6316ac865 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1047,6 +1047,21 @@ static int fork_testrun(void)
>  	alarm(0);
>  	SAFE_SIGNAL(SIGINT, SIG_DFL);
>  
> +	unsigned int sleep = 100;
> +	unsigned int retries = 0;
> +
> +	while (kill(-test_pid, 0) == 0) {
> +
> +		usleep(sleep);
> +		sleep*=2;
> +
> +		if (retries++ <= 14)
> +			continue;
> +
> +		tst_res(TINFO, "Test process child stuck in the kernel!");
> +		tst_brk(TFAIL, "Congratulation, likely test hit a kernel bug.");
> +	}
> +

Looks good to me.

I'm thinking if we shouldn't also try to gather some data
that would help person looking at the logs. For example:
collect /proc/<pid>/stack output or trigger sysrq-t or sysrq-w.

Regards,
Jan

>  	if (WIFEXITED(status) && WEXITSTATUS(status))
>  		return WEXITSTATUS(status);
>  
> --
> 2.13.6
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
