From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jul 2016 04:57:03 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/sched_setscheduler:
	add	sched_setscheduler03
In-Reply-To: <1468841008-14734-1-git-send-email-chuhu@redhat.com>
References: <1468841008-14734-1-git-send-email-chuhu@redhat.com>
Message-ID: <1720338582.6332657.1468918623876.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: ltp@lists.linux.it
> Sent: Monday, 18 July, 2016 1:23:28 PM
> Subject: [LTP] [PATCH v2] syscalls/sched_setscheduler: add	sched_setscheduler03
> 
> Test the scheduler behavior on fair processes without SYS_CAP_NICE
> capability, it should allow process do this syscall if it's not growing
> the priority.
> 
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
> 

Pushed with some tweaks, see comments below.

Regards,
Jan

> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <pwd.h>
> +#include <sched.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "linux_syscall_numbers.h"

This include was dropped, ltp_syscall has been removed in v2.

> +
> +#define RLIMIT_NICE_NORMAL 20
> +
> +static struct rlimit limit;
> +static uid_t nobody_uid;

Above 2 variables moved to setup(), they don't need to be global.

> +static pid_t zero_pid;
> +static struct sched_param param[1] = {{0}};

Whitespace added around "{}" to make checkpatch happy.

> +
> +static void verify_fn(unsigned int i)
> +{
> +
> +	tst_res(TINFO,
> +		"Verifying case[%d]: policy = %d, priority = %d",
> +		i + 1, cases[i].policy, cases[i].sched_param->sched_priority);
> +
> +	TEST(sched_setscheduler(*cases[i].pid, cases[i].policy,
> +					cases[i].sched_param));
> +	if (TEST_RETURN)
> +		tst_res(TFAIL, "case[%d] unexpected error - %d : %s - "
> +			 "expected %d", i + 1, TEST_ERRNO,
> +			 strerror(TEST_ERRNO), cases[i].error);

I turned this into tst_res(TFAIL | TTERRNO, ...)

> +	else
> +		tst_res(TPASS, "case[%d] succeeded", i + 1);
> +}
> +

> +
> +static void cleanup(void)
> +{
> +	tst_res(TINFO, "cleanup() executed by pid %i", getpid());
> +}

empty cleanup() removed.

> +
> +static void do_test(unsigned int i)
> +{
> +	int status = 0;
> +	pid_t f_pid = SAFE_FORK();
> +	if (f_pid == 0) {
> +		tst_res(TINFO, "forked pid is %d", getpid());
> +		verify_fn(i);
> +		exit(0);
> +	}
> +
> +	wait(&status);

wait -> SAFE_WAIT

Regards,
Jan
