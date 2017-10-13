From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Oct 2017 14:06:55 +0200
Subject: [LTP] [PATCH] syscalls/ptrace07: new test for ptrace FPU state
 corruption
In-Reply-To: <20171012223252.76241-1-ebiggers3@gmail.com>
References: <20171012223252.76241-1-ebiggers3@gmail.com>
Message-ID: <20171013120655.GC17900@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright (c) 2017 Google, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Regression test for commit 814fb7bb7db5 ("x86/fpu: Don't let userspace set
> + * bogus xcomp_bv").  This bug allowed ptrace(pid, PTRACE_SETREGSET,
> + * NT_X86_XSTATE, &iov) to assign a task an invalid FPU state --- specifically,
> + * by setting reserved bits in xstate_header.xcomp_bv.  This made restoring the
> + * FPU registers fail when switching to the task, causing the FPU registers to
> + * take on the values from other tasks.
> + *
> + * This test works firstly by checking whether PTRACE_SETREGSET fails with
> + * EINVAL when trying to set the invalid FPU state of a subprocess.
> + *
> + * In addition, this test has the subprocess run a loop checking its xmm0
> + * register for corruption.  This detects the case where the FPU state became
> + * invalid and the kernel is not restoring the process's registers.  Note that
> + * we have to set the expected value of xmm0 to all 0's since it is acceptable
> + * behavior for the kernel to simply reinitialize the FPU state upon seeing that
> + * it is invalid.  To increase the chance of detecting the problem, we also
> + * create additional processes that spin with different xmm0 contents.
> + *
> + * Thus bug affected the x86 architecture only.  Other architectures could have
> + * similar bugs as well, but this test has to be x86-specific because it has to
> + * know about the architecture-dependent FPU state.
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <sys/uio.h>
> +
> +#include "config.h"
> +#include "ptrace.h"
> +#include "tst_test.h"
> +
> +#ifndef PTRACE_GETREGSET
> +# define PTRACE_GETREGSET 0x4204
> +#endif
> +
> +#ifndef PTRACE_SETREGSET
> +# define PTRACE_SETREGSET 0x4205
> +#endif
> +
> +#ifndef NT_X86_XSTATE
> +# define NT_X86_XSTATE 0x202
> +#endif
> +
> +#ifdef __x86_64__
> +static void check_regs_loop(uint32_t initval)
> +{
> +	const unsigned long num_iters = 1000000000;
> +	uint32_t xmm0[4] = { initval, initval, initval, initval };
> +	int status = 1;
> +
> +	asm volatile("   movdqu %0, %%xmm0\n"
> +		     "   mov %0, %%rbx\n"
> +		     "1: dec %2\n"
> +		     "   jz 2f\n"
> +		     "   movdqu %%xmm0, %0\n"
> +		     "   mov %0, %%rax\n"
> +		     "   cmp %%rax, %%rbx\n"
> +		     "   je 1b\n"
> +		     "   jmp 3f\n"
> +		     "2: mov $0, %1\n"
> +		     "3:\n"
> +		     : "+m" (xmm0), "+r" (status)
> +		     : "r" (num_iters) : "rax", "rbx", "xmm0");
> +
> +	if (status) {
> +		tst_res(TFAIL,
> +			"xmm registers corrupted!  initval=%08X, xmm0=%08X%08X%08X%08X\n",
> +			initval, xmm0[0], xmm0[1], xmm0[2], xmm0[3]);
> +	}
> +	exit(status);
> +}
> +
> +static void do_test(void)
> +{
> +	int i;
> +	int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);

Please use the tst_ncpus() wrapper we have, since that one avoids
compilation failure on older distros where _SC_NPROCESSORS_ONLN is not
defined.

> +	pid_t pid;
> +	uint64_t xstate[512];
> +	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
> +	int status;
> +	bool okay = true;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		check_regs_loop(0x00000000);
> +	for (i = 0; i < num_cpus; i++) {
> +		if (SAFE_FORK() == 0)
> +			check_regs_loop(0xDEADBEEF);
> +	}
> +
> +	usleep(50000);

You are tryint to assert that the first child is executing the assembler
loop right? What about using the checkpoint interface we have.

If you do TST_CHECKPOINT_WAIT(0); here and TST_CHECKPOINT_WAKE(0) in the
child just before the asm loop is executed, then you will be sure that
the child is running and about to execute the loop. Then you can do very
short usleep() or sched_yield() here just before the ptrace().

> +	TEST(ptrace(PTRACE_ATTACH, pid, 0, 0));
> +	if (TEST_RETURN != 0)
> +		tst_brk(TBROK | TTERRNO, "PTRACE_ATTACH failed");
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +	TEST(ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov));
> +	if (TEST_RETURN != 0) {
> +		if (TEST_ERRNO == EIO)
> +			tst_brk(TCONF, "GETREGSET/SETREGSET is unsupported");
> +
> +		if (TEST_ERRNO == EINVAL)
> +			tst_brk(TCONF, "NT_X86_XSTATE is unsupported");
> +
> +		if (TEST_ERRNO == ENODEV)
> +			tst_brk(TCONF, "CPU doesn't support XSAVE instruction");
> +
> +		tst_brk(TBROK | TTERRNO,
> +			"PTRACE_GETREGSET failed with unexpected error");
> +	}
> +
> +	xstate[65] = -1; /* sets all bits in xstate_header.xcomp_bv */
> +	TEST(ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov));
> +	if (TEST_RETURN == 0) {
> +		tst_res(TFAIL, "PTRACE_SETREGSET unexpectedly succeeded");
> +		okay = false;
> +	} else if (TEST_ERRNO != EINVAL) {
> +		tst_brk(TBROK | TTERRNO,
> +			"PTRACE_SETREGSET failed with unexpected error");
> +	}
> +
> +	TEST(ptrace(PTRACE_CONT, pid, 0, 0));
> +	if (TEST_RETURN != 0)
> +		tst_brk(TBROK | TTERRNO, "PTRACE_CONT failed");
> +
> +	for (i = 0; i < num_cpus; i++) {
> +		SAFE_WAIT(&status);
> +		okay &= (WIFEXITED(status) && WEXITSTATUS(status) == 0);
> +	}
> +	if (okay)
> +		tst_res(TPASS, "wasn't able to set invalid FPU state");
> +}
> +#else /* !__x86_64__ */
> +static void do_test(void)
> +{
> +	tst_res(TCONF, "this test is only supported on x86_64");
> +}

Can you plase use the TST_TEST_TCONF() macro instead?

> +#endif /* __x86_64__ */
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.forks_child = 1,
> +};
> -- 
> 2.15.0.rc0.271.g36b669edcc-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
