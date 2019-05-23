From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 May 2019 13:52:36 +0200
Subject: [LTP] [PATCH] syscalls/prctl06.c: New test for prctl() with
 PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <1557404498-3879-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557404498-3879-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190523115236.GD30616@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define IPC_ENV_VAR "LTP_IPC_PATH"
> +
> +static void check_no_new_privs(int val)
> +{
> +	TEST(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> +	if (TST_RET == val)
> +		tst_res(TPASS,
> +			"prctl(PR_GET_NO_NEW_PRIVS) got %d "
> +			"when no_new_privs was %d", val, val);
> +	else
> +		tst_res(TFAIL | TTERRNO,
> +			"prctl(PR_GET_NO_NEW_PRIVS) expected %d got %ld",
> +			val, TST_RET);
> +	return;

This return is useless.

> +}
> +
> +static void do_prctl(void)
> +{
> +	char path[4096];
> +	char ipc_env_var[1024];
> +	char *const argv[] = {"prctl06_execve", "parent process", NULL};
> +	char *const childargv[] = {"prctl06_execve", "child process", NULL};
> +	char *const envp[] = {"LTP_TEST_ENV_VAR=test", ipc_env_var, NULL };
> +	cap_t caps = cap_init();
> +	cap_value_t capList = CAP_SETGID;
> +	unsigned int num_caps = 1;
> +	int childpid;
> +
> +	cap_set_flag(caps, CAP_EFFECTIVE, num_caps, &capList, CAP_SET);
> +	cap_set_flag(caps, CAP_INHERITABLE, num_caps, &capList, CAP_SET);
> +	cap_set_flag(caps, CAP_PERMITTED, num_caps, &capList, CAP_SET);
> +
> +	if (cap_set_proc(caps))
> +		tst_brk(TFAIL | TERRNO,
> +			"cap_set_flag(CAP_SETGID) failed");

You cannot use tst_brk with TFAIL, the best you can do here is to use
tst_ret(TFAIL ... ) then return; as you do below.

> +	tst_res(TINFO, "cap_set_flag(CAP_SETGID) succeeded");
> +
> +	check_no_new_privs(0);
> +
> +	TEST(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NO_NEW_PRIVS) failed");
> +		return;
> +	}
> +	tst_res(TPASS, "prctl(PR_SET_NO_NEW_PRIVS) succeeded");
> +
> +	check_no_new_privs(1);
> +
> +	if (tst_get_path("prctl06_execve", path, sizeof(path)))
> +		tst_brk(TCONF, "Couldn't find prctl_execve in $PATH");

If the path to the binary is in $PATH you don't have to execute the
binary by an absolute path, passing it's name to execve() should
suffice.

> +	sprintf(ipc_env_var, IPC_ENV_VAR "=%s", getenv(IPC_ENV_VAR));
> +	childpid = SAFE_FORK();
> +	if (childpid == 0) {
> +		check_no_new_privs(1);

		Maybe we can pass a "child" string here and "parent"
		string in the cases above so that we can print if the
		check was done in child/parent in the tst_res() inside
		of this function.

> +		execve(path, childargv, envp);
> +		tst_brk(TFAIL | TERRNO,
> +			"child process failed to execute prctl_execve");
> +
> +	} else {
> +		tst_reap_children();
> +		execve(path, argv, envp);
> +		tst_brk(TFAIL | TERRNO,
> +			"parent process failed to execute prctl_execve");
> +	}
> +	cap_free(caps);
> +	return;
> +}
> +
> +static void verify_prctl(void)
> +{
> +	int pid;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_prctl();
> +		exit(0);
> +	}
> +	tst_reap_children();
> +	return;
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_prctl,
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.child_needs_reinit = 1,
> +};
> diff --git a/testcases/kernel/syscalls/prctl/prctl06_execve.c b/testcases/kernel/syscalls/prctl/prctl06_execve.c
> new file mode 100644
> index 000000000..84c28551c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl06_execve.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * dummy program which is used by prctl06 testcase
> + */
> +#define TST_NO_DEFAULT_MAIN
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +
> +int main(int argc, char **argv)
> +{
> +	struct passwd *pw;
> +	uid_t nobody_uid;
> +	gid_t nobody_gid;
> +
> +	tst_reinit();
> +	if (argc != 2)
> +		tst_brk(TFAIL, "argc is %d, expected 2", argc);
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +	nobody_uid = pw->pw_uid;
> +	nobody_gid = pw->pw_gid;
> +	/*positive check*/
> +	TEST(setgid(nobody_gid));
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TTERRNO,
> +			"%s setgid(%d) isn't permmit", argv[1], nobody_gid);
> +	else
> +		tst_res(TPASS, "%s setgid(%d) succeed expectedly",
> +			argv[1], nobody_gid);
> +	/*negative check*/
> +	TEST(setuid(nobody_uid));
> +	if (TST_RET == -1)
> +		tst_res(TPASS | TTERRNO,
> +			"%s setuid(%d) isn't permmit", argv[1], nobody_uid);
> +	else
> +		tst_res(TFAIL, " %s setuid(%d) succeed unexpectedly",
> +			argv[1], nobody_gid);
> +	return 0;
> +}

I do not think that this is actually testing the prctl in question. Here
we actually check that capabilities were inherited over fork() + exec().

As far as I understand the PR_SET_NO_NEW_PRIVS it has been designed
expecially to avoid misuse of capabilities associated with a particular
file.

So the check would have to do:

1. copy the prctl06_execve binary to a $PWD
2. chmod it with S_ISUID, S_ISGID
3. the prct06_execve would be executed under user/group nobody
4. the prct06_execve itself would check if it gained root priviledges

And we can do the same for capablities as well.

I guess that we would have to format a device and mount it with support
for capabilities for the test, since as far as I can tell you cannot
usually do neither of set-usr-id or add capabilites to files in /tmp/.

-- 
Cyril Hrubis
chrubis@suse.cz
