From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jun 2017 14:03:30 +0200
Subject: [LTP] [PATCH] ptrace/ptrace07: Add test for PTRACE_{G,
	S}ETSIGMASK
In-Reply-To: <20170629155034.11773-1-james.morse@arm.com>
References: <20170629155034.11773-1-james.morse@arm.com>
Message-ID: <20170630120330.GC18305@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
> @@ -0,0 +1,269 @@
> +/*
> + * Copyright (c) ARM Limited, 2017.
> + *
> + * Based on ptrace02.c:
> + * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + */
> +
> +/*
> + * Child masks SIGUSR1 then waits to receive this signal from its parent.
> + * Parent ptrace()s child to unmask SIGUSR1 then sends this signal.
> + */
> +
> +#include <sys/types.h>
> +
> +/*
> + * We need to know how big the kernel's sigset_t is:
> + */
> +#define sigset_t kernel_sigset_t
> +#define sigaltstack kernel_sigaltstack
> +#define sigaction kernel_sigaction
> +#define stack_t kernel_stack_t
> +#include <asm-generic/signal.h>
> +#undef sigset_t
> +#undef sigaltstack
> +#undef sigaction
> +#undef stack_t
> +
> +#include <errno.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <config.h>
> +#include "ptrace.h"
> +
> +#include "test.h"

First of all test.h is deprecated for quite some time, new testcases
should use the new test library aka "tst_test.h".

> +static int do_child(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void parent_handler(int signo, siginfo_t *si, void *ctx);
> +static void child_handler(int signo, siginfo_t *si, void *ctx);
> +
> +char *TCID = "ptrace07";
> +int TST_TOTAL = 1;
> +
> +#define PIPE_READ  0
> +#define PIPE_WRITE 1
> +static int pipefd[2];
> +
> +int main(int ac, char **av)
> +{
> +	fd_set fds;
> +	sigset_t sigs;
> +	int rv, status;
> +	pid_t child_pid;
> +	struct timeval tv;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	if (pipe(pipefd) == -1) {
> +		tst_resm(TBROK, "pipe() failed");
> +		tst_exit();
> +	}
> +
> +	switch (child_pid = fork()) {
> +	case -1:
> +		/* fork() failed */
> +		tst_resm(TBROK, "fork() failed");
> +	case 0:		/* Child */
> +		close(pipefd[PIPE_READ]);
> +		do_child();
> +		abort();
> +	default:	/* Parent */
> +		close(pipefd[PIPE_WRITE]);
> +
> +		/* Wait for child to become ready */
> +		rv = read(pipefd[PIPE_READ], &rv, 1);
> +		if (rv != 1) {
> +			tst_resm(TBROK, "failed to read from pipe: %u", errno);
> +			break;
> +		}

We do have a futex() based synchronization primitives for this,
have a look at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#229-fork-and-parent-child-synchronization

> +		/* Attach to child */
> +		rv = ptrace(PTRACE_ATTACH, child_pid, NULL, NULL);
> +		if (rv) {
> +			tst_resm(TBROK, "ptrace() failed to attach: %u", errno);
> +			break;
> +		}
> +
> +		/* Wait for the child to stop */
> +		rv = waitpid(child_pid, &status, 0);
> +		if (rv == -1) {
> +			tst_resm(TBROK, "waitpid() failed: %u", errno);
> +			break;
> +		}

We also have SAFE_WAITPID() that includes error checking, see:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#224-safe-macros

> +		/* Inspect child signals: SIGUSR1 should be masked */
> +		rv = ptrace(PTRACE_GETSIGMASK, child_pid,
> +			    sizeof(kernel_sigset_t), &sigs);
> +		if (rv) {
> +			tst_resm(TBROK, "ptrace() failed: %u", errno);
> +			break;
> +		}
> +		if (!sigismember(&sigs, SIGUSR1)) {
> +			tst_resm(TFAIL, "Child SIGUSR1 not masked");
> +			break;
> +		}
> +
> +		/* Unmask child signals */
> +		rv = sigemptyset(&sigs);
> +		if (rv) {
> +			tst_resm(TBROK, "sigemptyset() failed: %u", errno);
> +			break;
> +		}
> +		rv = ptrace(PTRACE_SETSIGMASK, child_pid,
> +			    sizeof(kernel_sigset_t), &sigs);
> +		if (rv) {
> +			tst_resm(TBROK, "ptrace() failed: %u", errno);
> +			break;
> +		}
> +
> +		/* Restart child and deliver signal */
> +		rv = ptrace(PTRACE_CONT, child_pid, NULL, SIGUSR1);
> +		if (rv) {
> +			tst_resm(TBROK, "ptrace() failed: %u", errno);
> +			break;
> +		}
> +
> +		/* Wait for the child to signal receipt, or timeout */
> +		FD_ZERO(&fds);
> +		FD_SET(pipefd[PIPE_READ], &fds);
> +		tv.tv_sec = 1;
> +		tv.tv_usec = 0;
> +
> +		do {
> +			errno = 0;
> +			rv = select(pipefd[PIPE_READ]+1, &fds, NULL, NULL, &tv);
> +		} while (errno == EINTR);
> +
> +		if (rv == -1) {
> +			tst_resm(TBROK, "select() failed: %u", errno);
> +		} else if (rv == 0) {
> +			/* Timeout */
> +			tst_resm(TFAIL, "timeout: Signals not delivered");
> +		} else {
> +			/* Write from child indicates signal received */
> +			tst_resm(TPASS,
> +				 "ptrace() successfully unmasked signal");
> +		}
> +	}
> +
> +	if (child_pid != -1)
> +		kill(child_pid, SIGKILL);
> +
> +	/* cleanup and exit */
> +	cleanup();
> +	tst_exit();
> +
> +}
> +
> +static int do_child(void)
> +{
> +	long rv;
> +	sigset_t sigs;
> +	struct sigaction act = {0};
> +
> +	act.sa_sigaction = &child_handler;
> +	act.sa_flags = SA_SIGINFO;
> +	sigemptyset(&act.sa_mask);
> +
> +	rv = sigaction(SIGUSR1, &act, NULL);
> +	if (rv) {
> +		tst_resm(TBROK, "sigaction() failed in child");
> +		tst_exit();
> +	}
> +
> +	/* Mask SIGUSR1 */
> +	rv = sigemptyset(&sigs);
> +	if (rv) {
> +		tst_resm(TBROK, "sigemptyset() failed");
> +		tst_exit();
> +	}
> +	rv = sigaddset(&sigs, SIGUSR1);
> +	if (rv) {
> +		tst_resm(TBROK, "sigaddset() failed");
> +		tst_exit();
> +	}
> +	rv = sigprocmask(SIG_BLOCK, &sigs, NULL);
> +	if (rv) {
> +		tst_resm(TBROK, "sigprocmask() failed");
> +		tst_exit();
> +	}
> +
> +	/* Ready */
> +	rv = write(pipefd[PIPE_WRITE], &rv, 1);
> +	if (rv == -1) {
> +		tst_resm(TBROK, "Failed to write to parent: %u", errno);
> +		tst_exit();
> +	}
> +
> +	/* Receive signals from parent */
> +	while (1)
> +		sched_yield();
> +}
> +
> +void setup(void)
> +{
> +	int rv;
> +	struct sigaction act = {0};
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	act.sa_sigaction = &parent_handler;
> +	act.sa_flags = SA_SIGINFO;
> +	sigemptyset(&act.sa_mask);
> +
> +	rv = sigaction(SIGCHLD, &act, NULL);
> +	if (rv) {
> +		tst_resm(TFAIL, "sigaction() failed");
> +		tst_exit();
> +	}
> +
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +
> +}
> +
> +static void parent_handler(int signo, __attribute__((unused)) siginfo_t *si,
> +			   __attribute__((unused)) void *ctx)
> +{
> +	if (signo != SIGCHLD) {
> +		tst_resm(TBROK, "parent_handler() received unexpected signal.");
> +		tst_exit();

You cannot do this in the signal handler. Basically you can use only
async-signal-safe functions (man 7 signal). Otherwise you may cause
dead-locks and any kind of undefined behavior.

> +	}
> +}
> +
> +static void child_handler(int signo, __attribute__((unused)) siginfo_t *si,
> +			  __attribute__((unused)) void *ctx)
> +{
> +	int rv = 1;
> +
> +	if (signo == SIGUSR1) {
> +		rv = write(pipefd[PIPE_WRITE], &rv, 1);
> +		if (rv == -1)
> +			tst_resm(TBROK, "Failed to write to parent: %u", errno);
> +	}

Here as well.

The most safe course of action would be suspending the child in pause()
here instead of doing the bussy loop with sched_yield(), then just doing
exit(0) while the parent sleeps in SAFE_WAIT().

> +
> +	exit(rv);
> +}
> -- 
> 2.11.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
