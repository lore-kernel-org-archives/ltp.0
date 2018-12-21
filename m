From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 21 Dec 2018 16:43:33 +0100
Subject: [LTP] [PATCH] syscalls/ptrace07: handle potential SIGSEGV on
 older kernels
In-Reply-To: <b8db71df3a21f600e2a52064df6d2a21ed2195a9.1545400016.git.jstancek@redhat.com>
References: <b8db71df3a21f600e2a52064df6d2a21ed2195a9.1545400016.git.jstancek@redhat.com>
Message-ID: <20181221154333.GA14354@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/21, Jan Stancek wrote:
>
> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> @@ -153,12 +153,32 @@ static void do_test(void)
>  			"PTRACE_SETREGSET failed with unexpected error");
>  	}
>  
> -	TEST(ptrace(PTRACE_CONT, pid, 0, 0));
> +	/*
> +	 * It is possible for test child 'pid' to crash on AMD
> +	 * systems (e.g. AMD Opteron(TM) Processor 6234) with
> +	 * older kernels. This causes tracee to stop and sleep
> +	 * in ptrace_stop(). Without resuming the tracee, the
> +	 * test hangs at do_test()->tst_reap_children() called
> +	 * by the library. Use detach here, so we don't need to
> +	 * worry about potential stops after this point.
> +	 */
> +	TEST(ptrace(PTRACE_DETACH, pid, 0, 0));
>  	if (TST_RET != 0)
> -		tst_brk(TBROK | TTERRNO, "PTRACE_CONT failed");
> +		tst_brk(TBROK | TTERRNO, "PTRACE_DETACH failed");
> +
> +	/* If child 'pid' crashes, only report it as info. */
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WIFEXITED(status)) {
> +		tst_res(TINFO, "test child %d exited, retcode: %d",
> +			pid, WEXITSTATUS(status));
> +	}
> +	if (WIFSIGNALED(status)) {
> +		tst_res(TINFO, "test child %d exited, termsig: %d",
> +			pid, WTERMSIG(status));
> +	}
>  
>  	okay = true;
> -	for (i = 0; i < num_cpus + 1; i++) {
> +	for (i = 0; i < num_cpus; i++) {
>  		SAFE_WAIT(&status);
>  		okay &= (WIFEXITED(status) && WEXITSTATUS(status) == 0);

Thanks Jan!

I think this change is correct.

Oleg.

