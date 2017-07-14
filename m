From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 14 Jul 2017 14:45:33 +0200
Subject: [LTP] [PATCH] syscalls/setrlimit: add setrlimit04
In-Reply-To: <efe5be914c757f391b9f0eba0630548dea309f1b.1500030543.git.jstancek@redhat.com>
References: <efe5be914c757f391b9f0eba0630548dea309f1b.1500030543.git.jstancek@redhat.com>
Message-ID: <87h8yfi3v6.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Jan,

Jan Stancek writes:

> + *   DESCRIPTION
> + *     Attempt to run a trivial binary with stack < 1MB.
> + *
> + *     Early patches for stack guard gap caused that gap size was
> + *     contributing towards stack limit. This caused failures
> + *     for new processes (E2BIG) when ulimit was set to anything
> + *     lower than size of gap. commit 1be7107fbe18 "mm: larger
> + *     stack guard gap, between vmas" sets default gap size to 1M
> + *     (for systems with 4k pages), so let's set stack limit to 512kB
> + *     and confirm we can still run some trivial binary.
> + */

The first sentance is difficult to parse. I think you are saying that in
the early patches the stack gaurd gap was included in the stack
size. The stack size is then compared to the stack limit, so a process
would fail to start if

[initial process stack usage] + [stack gap] > [stack limit].

However the stack gap should not be included in this calculation.

> +
> +#define _GNU_SOURCE
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +
> +#define STACK_LIMIT (512 * 1024)
> +
> +static void test_setrlimit(void)
> +{
> +	int status;
> +	struct rlimit rlim;
> +	pid_t child;
> +
> +	rlim.rlim_cur = STACK_LIMIT;
> +	rlim.rlim_max = STACK_LIMIT;
> +
> +	SAFE_SETRLIMIT(RLIMIT_STACK, &rlim);
> +
> +	child = SAFE_FORK();
> +	if (child == 0)
> +		SAFE_EXECLP("/bin/true", "/bin/true", NULL);
> +	SAFE_WAITPID(child, &status, 0);
> +
> +	if (WIFEXITED(status)) {
> +		if ((WEXITSTATUS(status) == 0))
> +			tst_res(TPASS, "child process completed OK");
> +		else
> +			tst_res(TFAIL, "child process exited with %d",
> +				WEXITSTATUS(status));
> +	} else if (WIFSIGNALED(status)) {
> +		tst_res(TFAIL, "child exited with signal %s",
> +			tst_strsig(WTERMSIG(status)));
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all     = test_setrlimit,
> +	.forks_child  = 1,
> +	.needs_root = 1,
> +};
> --
> 1.8.3.1


--
Thank you,
Richard.
