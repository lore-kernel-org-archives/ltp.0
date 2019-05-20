From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 May 2019 15:04:07 +0200
Subject: [LTP] [PATCH] syscalls/prctl04.c: New test for prctl() with
 PR_{SET, GET}_SECCOMP
In-Reply-To: <1557141265-2247-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557141265-2247-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190520130407.GB27675@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/configure.ac b/configure.ac
> index fad8f8396..c858aff42 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -46,6 +46,7 @@ AC_CHECK_HEADERS([ \
>      linux/mempolicy.h \
>      linux/module.h \
>      linux/netlink.h \
> +    linux/seccomp.h \
>      linux/userfaultfd.h \
>      mm.h \
>      netinet/sctp.h \
> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
> index 6db8a6480..c3612e643 100644
> --- a/include/lapi/prctl.h
> +++ b/include/lapi/prctl.h
> @@ -14,4 +14,9 @@
>  # define PR_GET_CHILD_SUBREAPER	37
>  #endif
>  
> +#ifndef PR_SET_SECCOMP
> +# define PR_GET_SECCOMP  21
> +# define PR_SET_SECCOMP  22
> +#endif
> +
>  #endif /* LAPI_PRCTL_H__ */
> diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h
> new file mode 100644
> index 000000000..1e5bc3933
> --- /dev/null
> +++ b/include/lapi/seccomp.h
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +#ifndef LAPI_SECCOMP_H__
> +# define _LAPI_SECCOMP_H
> +
> +#include <linux/types.h>
> +
> +/* Valid values for seccomp.mode and prctl(PR_SET_SECCOMP, <mode>) */
> +#define SECCOMP_MODE_DISABLED   0
> +#define SECCOMP_MODE_STRICT     1
> +#define SECCOMP_MODE_FILTER     2
> +
> +#define SECCOMP_RET_KILL_THREAD  0x00000000U /* kill the thread */
> +#define SECCOMP_RET_KILL         SECCOMP_RET_KILL_THREAD
> +#define SECCOMP_RET_ALLOW        0x7fff0000U /* allow */
> +
> +/**
> + * struct seccomp_data - the format the BPF program executes over.
> + * @nr: the system call number
> + * @arch: indicates system call convention as an AUDIT_ARCH_* value
> + *        as defined in <linux/audit.h>.
> + * @instruction_pointer: at the time of the system call.
> + * @args: up to 6 system call arguments always stored as 64-bit values
> + * regardless of the architecture.
> + */
> +struct seccomp_data {
> +	int nr;
> +	__u32 arch;
> +	__u64 instruction_pointer;
> +	__u64 args[6];
> +};
> +
> +#endif /* _LAPI_SECCOMP_H */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2b8ca719b..51bff2990 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -863,6 +863,7 @@ ppoll01 ppoll01
>  prctl01 prctl01
>  prctl02 prctl02
>  prctl03 prctl03
> +prctl04 prctl04
>  
>  pread01 pread01
>  pread01_64 pread01_64
> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
> index 2f46a9a12..1c3da3052 100644
> --- a/testcases/kernel/syscalls/prctl/.gitignore
> +++ b/testcases/kernel/syscalls/prctl/.gitignore
> @@ -1,3 +1,4 @@
>  /prctl01
>  /prctl02
>  /prctl03
> +/prctl04
> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> new file mode 100644
> index 000000000..e3ba69af3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * Test PR_GET_SECCOMP and PR_SET_SECCOMP of prctl(2).
> + * 1) If PR_SET_SECCOMP sets the SECCOMP_MODE_STRICT for the calling thread,
> + *    the only system call that the thread is permitted to make are read(2),
> + *    write(2),_exit(2)(but not exit_group(2)), and sigreturn(2).  Other
> + *    system calls result in the delivery of a SIGKILL signal. This operation
> + *    is available only if the kernel is configured with CONFIG_SECCOMP enabled.
> + * 2) If PR_SET_SECCOMP sets the SECCOMP_MODE_FILTER for the calling thread,
> + *    the system calls allowed are defined by a pointer to a Berkeley Packet
> + *    Filter. Other system calls result int the delivery of a SIGSYS signal
> + *    with SECCOMP_RET_KILL. The SECCOMP_SET_MODE_FILTER operation is available
> + *    only if the kernel is configured with CONFIG_SECCOMP_FILTER enabled.
> + * 3) If SECCOMP_MODE_FILTER filters permit fork(2), then the seccomp mode
> + *    is inherited by children created by fork(2).
> + */
> +
> +#include <errno.h>
> +#include <signal.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <sys/types.h>
> +#include <linux/filter.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stddef.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/prctl.h"
> +#include "config.h"
> +#ifdef HAVE_LINUX_SECCOMP_H
> +#include <linux/seccomp.h>
> +#else
> +#include <lapi/seccomp.h>
> +#endif

This ifdef should be in the lapi/seccomp.h instead.

I.e. the test should only include lapi/seccomp.h and should not care if
linux/seccomp.h is present or not.

> +#define FNAME "filename"
> +
> +static const struct sock_filter  strict_filter[] = {
> +	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof (struct seccomp_data, nr))),
> +
> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),
> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_wait4, 3, 0),
> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_write, 2, 0),
> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_clone, 1, 0),
> +
> +	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL),
> +	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW)
> +};
> +
> +static const struct sock_fprog  strict = {
> +	.len = (unsigned short)ARRAY_SIZE(strict_filter),
> +	.filter = (struct sock_filter *)strict_filter
> +};
> +
> +static void check_strict_mode(int val)
> +{
> +	int fd;
> +	char buf[2];
> +
> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
> +
> +	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINVAL) {
> +			tst_res(TCONF,
> +				"prctl(PR_SET_SECCOMP) doesn't support "
> +				"SECCOMP_MODE_STRICT");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"prctl(PR_SET_SECCOMP) sets "
> +				"SECCOMP_MODE_STRICT failed");
> +		}
> +		return;
> +	}
> +	if (val == 1) {
> +		tst_res(TPASS,
> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT "
> +			"succeed");
> +		prctl(PR_GET_SECCOMP);
> +		tst_res(TFAIL, "prctl(PR_GET_SECCOMP) succeed unexpectedly");
> +	}
> +	if (val == 2) {
> +		SAFE_WRITE(1, fd, "a", 1);
> +		SAFE_READ(0, fd, buf, 1);
> +		tst_res(TPASS,
> +			"SECCOMP_MODE_STRICT permits read(2) write(2) "
> +			"and _exit(2)");
> +	}
> +	if (val == 3) {
> +		close(fd);
> +		tst_res(TFAIL,
> +			"SECCOMP_MODE_STRICT permits close(2) unexpectdly");
> +	}

This is way too ugly, if nothing else we should use switch() here.


> +	tst_syscall(__NR_exit, 0);
> +}
> +
> +static void check_filter_mode(int val)
> +{
> +	int childpid;
> +	int childstatus;
> +	int fd;
> +
> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
> +
> +	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EFAULT)
> +			tst_res(TFAIL, "the strict prog is an invalid address");
> +		else
> +			tst_res(TFAIL | TERRNO,
> +				"prctl(PR_SET_SECCOMP) sets strict filter "
> +				"failed");
> +		return;
> +	}
> +	if (val == 1) {
> +		tst_res(TPASS,
> +			"prctl(PR_SET_SECCOMP) sets strict filter succeed");
> +		prctl(PR_GET_SECCOMP);
> +		tst_res(TFAIL, "prctl(PR_GET_SECCOMP) succeed unexpectedly");
> +	}
> +	if (val == 2) {
> +		close(fd);
> +		tst_res(TPASS, "SECCOMP_MODE_FILTER permits close(2)");
> +	}
> +	if (val == 3)
> +		exit(0);
> +	if (val == 4) {
> +		childpid = fork();
> +		if (childpid == 0) {
> +			tst_res(TPASS, "SECCOMP_MODE_FILTER permits fork(2)");
> +			exit(0);
> +		} else {
> +			wait4(childpid, &childstatus, 0, NULL);
> +			if (WIFSIGNALED(childstatus) &&
> +					WTERMSIG(childstatus) == SIGSYS)
> +				tst_res(TPASS,
> +					"SECCOMP_MODE_FILTER has been "
> +					"inherited by child");
> +			else
> +				tst_res(TFAIL,
> +					"SECCOMP_MODE_FILTER isn't been "
> +					"inherited by child");
> +		}
> +	}

Here as well, use switch().

Also it would make sense to put the more complicated bodies, for
instance case val == 4 into a separate function.

> +	tst_syscall(__NR_exit, 0);
> +}
> +
> +static void verify_prctl(void)
> +{
> +	int pid;
> +	int status;
> +
> +	TEST(prctl(PR_GET_SECCOMP));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINVAL) {
> +			tst_res(TCONF,
> +				"prctl() doesn't support PR_GET_SECCOMP");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"prctl(PR_GET_SECCOMP) failed");
> +		}
> +		return;
> +	}
> +	tst_res(TPASS, "prctl(PR_GET_SECCOMP) succeed");
> +
> +	/*call get_seccomp when in stric mode ,it should be killed*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_strict_mode(1);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> +			tst_res(TPASS,
> +				"SECCOMP_MODE_STRICT doesn't permit "
> +				"GET_SECCOMP call");
> +	}
> +
> +	/*positive check in secure computing mode*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_strict_mode(2);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> +			tst_res(TFAIL,
> +				"SECCOMP_MODE_STRICT doesn't permit "
> +				"read(2) write(2) and _exit(2)");
> +	}
> +
> +	/*negative check in secure computing mode*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_strict_mode(3);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> +			tst_res(TPASS,
> +				"SECCOMP_MODE_STRICT doesn't permit close(2)");
> +	}
> +
> +	/*call get_seccomp in filter mode should be killed by SIGSYS signal*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_filter_mode(1);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSYS)
> +			tst_res(TPASS,
> +				"SECCOMP_MODE_FILTER doestn't permit "
> +				"GET_SECCOMP call");
> +	}
> +
> +	/*positive check in SECCOMP_MODE_FILTER*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_filter_mode(2);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSYS)
> +			tst_res(TFAIL,
> +				"SECCOMP_MODE_FILTER doesn't permit close(2)");
> +	}
> +
> +	/*negative check in SECCOMP_MODE_FILTER*/
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_filter_mode(3);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSYS)
> +			tst_res(TPASS,
> +				"SECCOMP_MODE_FILTER doesn't permit exit()");
> +		else
> +			tst_res(TFAIL,
> +				"SECCOMP_MODE_FILTER permits exit() "
> +				"unexpectdly");
> +	}
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_filter_mode(4);
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSYS)
> +			tst_res(TFAIL,
> +				"SECCOMP_MODE_FILTER fork failed "
> +				"unexpectdly");

This is a minor, but multiline statements should be enclosed in a curly
braces accodingly to LKML and also string constants shouldn't be split
into multiple lines, so this should be:

		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSYS) {
			tst_res(TFAIL,
			        "SECCOMP_MODE_FILTER fork failed unexpectdly");
		}

Also the else branch is useless since the function check_filter_mode()
calls exit.

So we can simply do:

	pid = SAFE_FORK();
	if (pid == 0)
		check_fitler_mode(4);

	SAFE_WAITPID(...);

> +	}
> +}

You are doing several different tests in this function, can we split
this and use .test and .tcnt instead of .test_all?

> +static struct tst_test test = {
> +	.test_all = verify_prctl,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
