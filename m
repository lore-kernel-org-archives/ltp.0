From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jul 2019 15:57:35 +0800
Subject: [LTP] [PATCH RESEND] syscalls/prctl06.c: New test for prctl()
 with PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <20190710105207.GC30934@rei.lan>
References: <20190709105303.GA4914@rei.lan>
 <1562366936-26456-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190710105207.GC30934@rei.lan>
Message-ID: <5D26EBEF.3090604@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/10 18:52, Cyril Hrubis wrote:

> Hi!
>>   pread01 pread01
>>   pread01_64 pread01_64
>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>> index 9ecaf9854..f52f6f665 100644
>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>> @@ -3,3 +3,4 @@
>>   /prctl03
>>   /prctl04
>>   /prctl05
>> +/prctl06
> Missing prctl06_execve
OK.

>> diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
>> new file mode 100644
>> index 000000000..9dd82a241
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl06.c
>> @@ -0,0 +1,173 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + *
>> + * Test PR_GET_NO_NEW_PRIVS and PR_SET_NO_NEW_PRIVS of prctl(2).
>> + *
>> + * 1)Return the value of the no_new_privs bit for the calling thread.
>> + *  A value of 0 indicates the regular execve(2) behavior.  A value of
>> + *  1 indicates execve(2) will operate in the privilege-restricting mode.
>> + * 2)With no_new_privs set to 1, diables privilege granting operations
>> + *  at execve-time. For example, a process will not be able to execute a
>> + *  setuid binary to change their uid or gid if this bit is set. The same
>> + *  is true for file capabilities.
>> + * 3)The setting of this bit is inherited by children created by fork(2).
>> + *  We also check NoNewPrivs field in /proc/[pid]/status if it supports.
>> + */
>> +
>> +#include<errno.h>
>> +#include<stdio.h>
>> +#include<stdlib.h>
>> +#include<sys/prctl.h>
>> +#include<pwd.h>
>> +#include<sys/types.h>
>> +#include<unistd.h>
>> +#include<sys/capability.h>
>> +#include<lapi/prctl.h>
>> +#include "tst_test.h"
>> +
>> +#define IPC_ENV_VAR        "LTP_IPC_PATH"
>> +#define MNTPOINT           "mntpoint"
>> +#define TESTBIN            "prctl06_execve"
>> +#define TEST_REL_BIN_DIR   MNTPOINT"/"
>> +#define SUID_MODE          (S_ISUID|S_ISGID|S_IXUSR|S_IXGRP|S_IXOTH)
>> +
>> +static int flag = 1;
>> +static char CapEff[20];
>> +
>> +static void check_proc_field(int val, char *name)
>> +{
>> +	char path[50];
>> +	pid_t pid;
>> +	int field = 0;
> Also it would be a bit cleaner if we do:
>
> 	if (flag)
> 		return;
>
> here and called the function unconditionaly down below.
>
Call check_proc_field()  when flag is 1 in check_no_new_privs(). So we have avoideded this situation.

>> +	pid = getpid();
>> +	sprintf(path, "/proc/%d/status", pid);
>                         ^
> 		       /proc/self/status ?
>
Yes.

>> +	TEST(FILE_LINES_SCANF(path, "NoNewPrivs:%d",&field));
>> +	if (TST_RET == 1) {
>> +		tst_res(TCONF,
>> +			"/proc/[pid]/status doesn't support NoNewPrivs field");
>> +		flag = 0;
>> +		return;
>> +	}
>> +	if (val == field)
>> +		tst_res(TPASS, "%s %s NoNewPrivs field expected %d got %d",
>> +			name, path, val, field);
>> +	else
>> +		tst_res(TFAIL, "%s %s NoNewPrivs field expected %d got %d",
>> +			name, path, val, field);
>> +
>> +	SAFE_FILE_LINES_SCANF(path, "CapEff:%s", CapEff);
>> +}
>> +
>> +static void check_no_new_privs(int val, char *name)
>> +{
>> +	TEST(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
>> +	if (TST_RET == val)
>> +		tst_res(TPASS,
>> +			"%s prctl(PR_GET_NO_NEW_PRIVS) expected %d got %d",
>> +			name, val, val);
>> +	else
>> +		tst_res(TFAIL,
>> +			"%s prctl(PR_GET_NO_NEW_PRIVS) expected %d got %ld",
>> +			name, val, TST_RET);
>> +	if (flag)
>> +		check_proc_field(val, name);
>> +}
>> +
>> +static void do_prctl(void)
>> +{
>> +	char ipc_env_var[1024];
>> +	char *const argv[] = {"prctl06_execve", "parent process", CapEff, NULL};
>> +	char *const childargv[] = {"prctl06_execve", "child process", CapEff, NULL};
>> +	char *const envp[] = {"LTP_TEST_ENV_VAR=test", ipc_env_var, NULL };
>                                  ^
> 				This is not really needed here. We use
> 				that only in the execve tests...
OK. I got it.
>> +	int childpid;
>> +	struct passwd *pw;
>> +	uid_t nobody_uid;
>> +	gid_t nobody_gid;
>> +
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	nobody_uid = pw->pw_uid;
>> +	nobody_gid = pw->pw_gid;
>            ^
> 	  This can be done once in test setup
>
>> +	check_no_new_privs(0, "parent");
>> +	tst_res(TINFO,
>> +		"parent process CapEff %s when no new privs was 0", CapEff);
>> +
>> +	TEST(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
>> +	if (TST_RET == -1) {
>> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NO_NEW_PRIVS) failed");
>> +		return;
>> +	}
>> +	tst_res(TPASS, "prctl(PR_SET_NO_NEW_PRIVS) succeeded");
>> +
>> +	SAFE_CHMOD("prctl06_execve", SUID_MODE);
>           ^
> 	 This can be done in setup() as well.
>
OK. I will move them into setup() .

>> +	SAFE_SETGID(nobody_gid);
>> +	SAFE_SETUID(nobody_uid);
>> +
>> +	sprintf(ipc_env_var, IPC_ENV_VAR "=%s", getenv(IPC_ENV_VAR));
>> +
>> +	childpid = SAFE_FORK();
>> +	if (childpid == 0) {
>> +		check_no_new_privs(1, "child");
>> +		execve("prctl06_execve", childargv, envp);
>> +		tst_brk(TFAIL | TTERRNO,
>> +			"child process failed to execute prctl_execve");
>> +
>> +	} else {
>> +		tst_reap_children();
>> +		check_no_new_privs(1, "parent");
>> +		tst_res(TINFO,
>> +			"parent process CapEff %s when no new privs was 1", CapEff);
>> +		execve("prctl06_execve", argv, envp);
>> +		tst_brk(TFAIL | TTERRNO,
>> +			"parent process failed to execute prctl_execve");
>> +	}
>> +}
>> +
>> +static void verify_prctl(void)
>> +{
>> +	int pid;
>> +
>> +	pid = SAFE_FORK();
>> +	if (pid == 0) {
>> +		do_prctl();
>> +		exit(0);
>> +	}
>> +	tst_reap_children();
> No need to reap children here if you do exit(0) the library will reap
> them for you.
Yes.

>> +}
>> +
>> +static void setup(void)
>> +{
>> +	TEST(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
>> +	if (TST_RET == 0) {
>> +		tst_res(TINFO, "kernel supports PR_GET/SET_NO_NEW_PRIVS");
>> +		SAFE_CP(TESTBIN, TEST_REL_BIN_DIR);
>> +		return;
>> +	}
>> +
>> +	if (TST_ERR == EINVAL)
>> +		tst_brk(TCONF,
>> +			"kernel doesn't support PR_GET/SET_NO_NEW_PRIVS");
>> +
>> +	tst_brk(TBROK | TTERRNO,
>> +		"current environment doesn't permit PR_GET/SET_NO_NEW_PRIVS");
>> +}
>> +
>> +static const char *const resfile[] = {
>> +	TESTBIN,
>> +	NULL,
>> +};
>> +
>> +static struct tst_test test = {
>> +	.resource_files = resfile,
>> +	.setup = setup,
>> +	.test_all = verify_prctl,
>> +	.forks_child = 1,
>> +	.needs_root = 1,
>> +	.mount_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +	.child_needs_reinit = 1,
>> +};
>> diff --git a/testcases/kernel/syscalls/prctl/prctl06_execve.c b/testcases/kernel/syscalls/prctl/prctl06_execve.c
>> new file mode 100644
>> index 000000000..6b256afae
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl06_execve.c
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> + *
>> + * dummy program which is used by prctl06 testcase
>> + */
>> +#define TST_NO_DEFAULT_MAIN
>> +#include<stdlib.h>
>> +#include<sys/types.h>
>> +#include<unistd.h>
>> +#include<errno.h>
>> +#include<pwd.h>
>> +#include<stdio.h>
>> +#include<string.h>
>> +#include "tst_test.h"
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	struct passwd *pw;
>> +	uid_t unknown_uid;
>> +	gid_t unknown_gid;
>> +	char path[50];
>> +	char CapEff[20];
>> +	pid_t pid;
>> +
>> +	tst_reinit();
>> +	if (argc != 3)
>> +		tst_brk(TFAIL, "argc is %d, expected 3", argc);
>> +
>> +	pid = getpid();
>> +	sprintf(path, "/proc/%d/status", pid);
>                          ^
> 			/proc/self/status
>
Yes.
>> +	SAFE_FILE_LINES_SCANF(path, "CapEff:%s", CapEff);
>> +
>> +	if (strncmp(CapEff, argv[2], sizeof(CapEff)))
>> +		tst_res(TFAIL,
>> +			"%s gains root privileges, current CapEff %s, expect %s",
>> +			argv[1], CapEff, argv[2]);
>> +	else
>> +		tst_res(TPASS,
>> +			"%s doesn't gain root privileges, CapEff %s",
>> +			argv[1], CapEff);
>> +
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	unknown_uid = pw->pw_uid + 1;
>> +	unknown_gid = pw->pw_gid + 1;
>> +
>> +	TEST(setgid(unknown_gid));
>> +	if (TST_RET == -1)
>> +		tst_res(TPASS,
>> +			"%s setgid(%d) isn't permmit", argv[1], unknown_gid);
>> +	else
>> +		tst_res(TFAIL, "%s setgid(%d) succeed expectedly",
>> +			argv[1], unknown_gid);
>> +
>> +	TEST(setuid(unknown_uid));
>> +	if (TST_RET == -1)
>> +		tst_res(TPASS,
>> +			"%s setuid(%d) isn't permmit", argv[1], unknown_uid);
>> +	else
>> +		tst_res(TFAIL, " %s setuid(%d) succeed unexpectedly",
>> +			argv[1], unknown_gid);
> We are executing setuid binary that was created by root here so
> shouldn't we just check that getuid() and getgid() returns 0?
>
I try it.  whether we set or not set new privs, the getuid() or getgid() return nobody in
prctl06_execve.  Or, I misunderstand your advise?

Also, my design is that
1. copy the prctl06_execve binary to a $PWD
2. chmod it with S_ISUID, S_ISGID ,prctl06_exeve can be excuted under nobody
3. prctl06 SETGID and SETUID as nobody, set no_new_privs to 1 and excute prctl06_execve
4. the prct06_execve itself would check if it gained root priviledges(check proc/self/status capeff
and excute setuid and setgid action )


> I guess that we can also chown the file to uid=0 and gid=0 once it has
> been copied to be 100% sure that the ids are correct in the test setup.
Yes.
>> +	return 0;
>> +}
> Otherwise the test looks very good.
>
>
> Also I guess that we need another test that would set the prctl value
> and check that it cannot be unset. If you are going to do that please do
> that in a separate file, this one is complex enough...
OK. I will add this in a separate file.




