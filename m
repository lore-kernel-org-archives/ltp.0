From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 23 May 2019 10:49:34 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl04.c: New test for prctl() with
	PR_{SET, GET}_SECCOMP
In-Reply-To: <20190522123657.GB7912@rei.lan>
References: <20190520130407.GB27675@rei.lan>
 <1558520056-2257-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190522123657.GB7912@rei.lan>
Message-ID: <5CE60A3E.10102@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi cyril
   I will send a v3 patch for this.  Thanks for your review.

Kind Regards
Yang Xu

> Hi!
>> diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h
>> new file mode 100644
>> index 000000000..eead53c48
>> --- /dev/null
>> +++ b/include/lapi/seccomp.h
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + */
>> +#ifndef LAPI_SECCOMP_H__
>> +# define _LAPI_SECCOMP_H
>> +
>> +#include<linux/types.h>
>> +
>> +#ifdef HAVE_LINUX_SECCOMP_H
>> +#include<linux/seccomp.h>
>> +#else
>> +/* Valid values for seccomp.mode and prctl(PR_SET_SECCOMP,<mode>) */
>> +#define SECCOMP_MODE_DISABLED   0
>> +#define SECCOMP_MODE_STRICT     1
>> +#define SECCOMP_MODE_FILTER     2
>> +
>> +#define SECCOMP_RET_KILL_THREAD  0x00000000U /* kill the thread */
>> +#define SECCOMP_RET_KILL         SECCOMP_RET_KILL_THREAD
>> +#define SECCOMP_RET_ALLOW        0x7fff0000U /* allow */
>> +
>> +/**
>> + * struct seccomp_data - the format the BPF program executes over.
>> + * @nr: the system call number
>> + * @arch: indicates system call convention as an AUDIT_ARCH_* value
>> + *        as defined in<linux/audit.h>.
>> + * @instruction_pointer: at the time of the system call.
>> + * @args: up to 6 system call arguments always stored as 64-bit values
>> + * regardless of the architecture.
>> + */
>> +struct seccomp_data {
>> +	int nr;
>> +	__u32 arch;
>> +	__u64 instruction_pointer;
>> +	__u64 args[6];
>> +};
>> +
>> +#endif /* HAVE_LINUX_SECCOMP_H*/
>> +#endif /* _LAPI_SECCOMP_H */
> The ifdefs could be made a bit more readable by proper indentation as:
>
> #ifndef FOO_H__
> #define FOO_H__
>
> # include<header.h>
>
> # ifdef HAVE_BAR
> #  include<bar.h>
> # else
> #  define BAR1
> #  define BAR2
>
> # endif
> #endif /* FOO_H__ */
>
> But that is very minor.
>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 2b8ca719b..51bff2990 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -863,6 +863,7 @@ ppoll01 ppoll01
>>   prctl01 prctl01
>>   prctl02 prctl02
>>   prctl03 prctl03
>> +prctl04 prctl04
>>
>>   pread01 pread01
>>   pread01_64 pread01_64
>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>> index 2f46a9a12..1c3da3052 100644
>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>> @@ -1,3 +1,4 @@
>>   /prctl01
>>   /prctl02
>>   /prctl03
>> +/prctl04
>> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
>> new file mode 100644
>> index 000000000..9acd2c6fb
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + *
>> + * Test PR_GET_SECCOMP and PR_SET_SECCOMP of prctl(2).
>> + * 1) If PR_SET_SECCOMP sets the SECCOMP_MODE_STRICT for the calling thread,
>> + *    the only system call that the thread is permitted to make are read(2),
>> + *    write(2),_exit(2)(but not exit_group(2)), and sigreturn(2).  Other
>> + *    system calls result in the delivery of a SIGKILL signal. This operation
>> + *    is available only if the kernel is configured with CONFIG_SECCOMP enabled.
>> + * 2) If PR_SET_SECCOMP sets the SECCOMP_MODE_FILTER for the calling thread,
>> + *    the system calls allowed are defined by a pointer to a Berkeley Packet
>> + *    Filter. Other system calls result int the delivery of a SIGSYS signal
>> + *    with SECCOMP_RET_KILL. The SECCOMP_SET_MODE_FILTER operation is available
>> + *    only if the kernel is configured with CONFIG_SECCOMP_FILTER enabled.
>> + * 3) If SECCOMP_MODE_FILTER filters permit fork(2), then the seccomp mode
>> + *    is inherited by children created by fork(2).
>> + */
>> +
>> +#include<errno.h>
>> +#include<signal.h>
>> +#include<sys/prctl.h>
>> +#include<sys/wait.h>
>> +#include<sys/types.h>
>> +#include<linux/filter.h>
>> +#include<unistd.h>
>> +#include<stdlib.h>
>> +#include<stddef.h>
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +#include "lapi/prctl.h"
>> +#include "config.h"
>> +#include "lapi/seccomp.h"
>> +
>> +#define FNAME "filename"
>> +
>> +static const struct sock_filter  strict_filter[] = {
>> +	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof (struct seccomp_data, nr))),
>> +
>> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
>> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),
>> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_wait4, 3, 0),
>> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_write, 2, 0),
>> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_clone, 1, 0),
>> +
>> +	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL),
>> +	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW)
>> +};
>> +
>> +static const struct sock_fprog  strict = {
>> +	.len = (unsigned short)ARRAY_SIZE(strict_filter),
>> +	.filter = (struct sock_filter *)strict_filter
>> +};
>> +
>> +static void check_strict_mode(int);
>> +static void check_filter_mode(int);
>> +
>> +static struct tcase {
>> +	void (*func_check)();
>> +	int pass_flag;
>> +	int val;
>> +	int exp_signal;
>> +	char *message;
>> +} tcases[] = {
>> +	{check_strict_mode, 1, 1, SIGKILL,
>> +	"SECCOMP_MODE_STRICT doesn't permit GET_SECCOMP call"},
>> +
>> +	{check_strict_mode, 0, 2, SIGKILL,
>> +	"SECCOMP_MODE_STRICT doesn't permit read(2) write(2) and _exit(2)"},
>> +
>> +	{check_strict_mode, 1, 3, SIGKILL,
>> +	"SECCOMP_MODE_STRICT doesn't permit close(2)"},
>> +
>> +	{check_filter_mode, 1, 1, SIGSYS,
>> +	"SECCOMP_MODE_FILTER doestn't permit GET_SECCOMP call"},
>> +
>> +	{check_filter_mode, 0, 2, SIGSYS,
>> +	"SECCOMP_MODE_FILTER doesn't permit close(2)"},
>> +
>> +	{check_filter_mode, 1, 3, SIGSYS,
>> +	"SECCOMP_MODE_FILTER doesn't permit exit()"},
>> +
>> +	{check_filter_mode, 0, 4, SIGSYS,
>> +	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>> +};
>> +
>> +static void check_filter_mode_inherit(void)
>> +{
>> +	int childpid;
>> +	int childstatus;
>> +
>> +	childpid = fork();
>> +	if (childpid == 0) {
>> +		tst_res(TPASS, "SECCOMP_MODE_FILTER permits fork(2)");
>> +		exit(0);
>> +	}
>> +
>> +	wait4(childpid,&childstatus, 0, NULL);
>> +	if (WIFSIGNALED(childstatus)&&  WTERMSIG(childstatus) == SIGSYS)
>> +		tst_res(TPASS,
>> +			"SECCOMP_MODE_FILTER has been inherited by child");
>> +	else
>> +		tst_res(TFAIL,
>> +			"SECCOMP_MODE_FILTER isn't been inherited by child");
>> +}
>> +
>> +static void check_strict_mode(int val)
>> +{
>> +	int fd;
>> +	char buf[2];
>> +
>> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>> +
>> +	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT));
>> +	if (TST_RET == -1) {
>> +		tst_res(TFAIL | TTERRNO,
>> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT failed");
>> +		return;
>> +	}
>> +
>> +	switch (val) {
>> +	case 1:	{
>> +		tst_res(TPASS,
>> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT succeed");
>> +		prctl(PR_GET_SECCOMP);
>> +		tst_res(TFAIL, "prctl(PR_GET_SECCOMP) succeed unexpectedly");
>> +	break;
>> +	}
> There is no need to enclose the case switches between curly braces
> unless you need to declare variables there.
>
>> +	case 2: {
>> +		SAFE_WRITE(1, fd, "a", 1);
>> +		SAFE_READ(0, fd, buf, 1);
>> +		tst_res(TPASS,
>> +			"SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)");
>> +	break;
>> +	}
>> +	case 3: {
>> +		close(fd);
>> +		tst_res(TFAIL,
>> +			"SECCOMP_MODE_STRICT permits close(2) unexpectdly");
>> +	break;
>> +	}
>> +	}
>> +
>> +	tst_syscall(__NR_exit, 0);
>> +}
>> +
>> +static void check_filter_mode(int val)
>> +{
>> +	int fd;
>> +
>> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>> +
>> +	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER,&strict));
>> +	if (TST_RET == -1) {
>> +		if (TST_ERR == EINVAL)
>> +			tst_res(TCONF,
>> +				"kernel doesn't support SECCOMP_MODE_FILTER");
>> +		else
>> +			tst_res(TFAIL | TERRNO,
>> +				"prctl(PR_SET_SECCOMP) sets strict filter failed");
>> +		return;
>> +	}
>> +
>> +	switch (val) {
>> +	case 1: {
>> +		tst_res(TPASS,
>> +			"prctl(PR_SET_SECCOMP) sets strict filter succeed");
>> +		prctl(PR_GET_SECCOMP);
>> +		tst_res(TFAIL, "prctl(PR_GET_SECCOMP) succeed unexpectedly");
>> +	break;
>> +	}
>> +	case 2: {
>> +		close(fd);
>> +		tst_res(TPASS, "SECCOMP_MODE_FILTER permits close(2)");
>> +	break;
>> +	}
>> +	case 3:
>> +		exit(0);
>> +	break;
>> +	case 4:
>> +		check_filter_mode_inherit();
>> +	break;
>> +	}
>> +	tst_syscall(__NR_exit, 0);
>> +}
>> +
>> +static void verify_prctl(unsigned int n)
>> +{
>> +	int pid;
>> +	int status;
>> +	struct tcase *tc =&tcases[n];
>> +
>> +	pid = SAFE_FORK();
>> +	if (pid == 0) {
>> +		tc->func_check(tc->val);
>> +	} else {
>> +		SAFE_WAITPID(pid,&status, 0);
>> +		if (WIFSIGNALED(status)&&  WTERMSIG(status) == tc->exp_signal) {
>> +			if (tc->pass_flag)
>> +				tst_res(TPASS, "%s", tc->message);
>> +			else
>> +				tst_res(TFAIL, "%s", tc->message);
>> +			return;
>> +		}
>> +
>> +		if (n == 5)
>> +			tst_res(TFAIL,
>> +				"SECCOMP_MODE_FILTER permits exit() unexpectdly");
>                                                                              ^
> 									   Typo
>
> Depending on the value of n here is wrong, this code will unexpectedly
> fail to work if someone adds testcases to the tcases array.
>
> You can at least reuse the pass_flag and set it to 2 for this case, then
> you can do if (tc->pass_flag == 2) here instead.
>
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	TEST(prctl(PR_GET_SECCOMP));
>> +	if (TST_RET == 0)
>> +		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
>> +	if (TST_ERR == EINVAL)
>> +		tst_brk(TBROK, "kernel doesn't support PR_GET/SET_SECCOMP");
>                            ^
> 			  Shouldn't this be TCONF?
>
> Also we should handle other error cases, so maybe:
>
> 	if (TST_RET == 0) {
> 		tst_res(TINFO, ...);
> 		return;
> 	}
>
> 	if (TST_ERR == EINVAL)
> 		tst_brk(TCONF, ...);
>
> 	tst_brk(TBROK | TTERRNO, ...);
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test = verify_prctl,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.forks_child = 1,
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
>> +};
> Other than these minor nits the test looks good to me.
>



