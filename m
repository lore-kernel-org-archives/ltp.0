From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 May 2019 18:18:34 +0800
Subject: [LTP] [PATCH] syscalls/prctl06.c: New test for prctl() with
	PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <1557404498-3879-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557404498-3879-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5CE521FA.807@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
Ping.:-)
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/lapi/prctl.h                          |   5 +
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/prctl/.gitignore    |   1 +
>  testcases/kernel/syscalls/prctl/Makefile      |   2 +
>  testcases/kernel/syscalls/prctl/prctl06.c     | 117 ++++++++++++++++++
>  .../kernel/syscalls/prctl/prctl06_execve.c    |  46 +++++++
>  6 files changed, 172 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/prctl/prctl06.c
>  create mode 100644 testcases/kernel/syscalls/prctl/prctl06_execve.c
>
> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
> index 91da9c2d6..663ce19e9 100644
> --- a/include/lapi/prctl.h
> +++ b/include/lapi/prctl.h
> @@ -24,4 +24,9 @@
>  # define PR_SET_SECCOMP  22
>  #endif
>  
> +#ifndef PR_SET_NO_NEW_PRIVS
> +# define PR_SET_NO_NEW_PRIVS 38
> +# define PR_GET_NO_NEW_PRIVS 39
> +#endif
> +
>  #endif /* LAPI_PRCTL_H__ */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 950615bef..a43bf5e4d 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -865,6 +865,7 @@ prctl02 prctl02
>  prctl03 prctl03
>  prctl04 prctl04
>  prctl05 prctl05
> +prctl06 prctl06
>  
>  pread01 pread01
>  pread01_64 pread01_64
> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
> index 9ecaf9854..f52f6f665 100644
> --- a/testcases/kernel/syscalls/prctl/.gitignore
> +++ b/testcases/kernel/syscalls/prctl/.gitignore
> @@ -3,3 +3,4 @@
>  /prctl03
>  /prctl04
>  /prctl05
> +/prctl06
> diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
> index bd617d806..99a9d42e7 100644
> --- a/testcases/kernel/syscalls/prctl/Makefile
> +++ b/testcases/kernel/syscalls/prctl/Makefile
> @@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> +LDLIBS			+= $(CAP_LIBS)
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
> new file mode 100644
> index 000000000..ba5c2bcfb
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl06.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * Test PR_GET_NO_NEW_PRIVS and PR_SET_NO_NEW_PRIVS of prctl(2).
> + *
> + * 1)Return (as the function result) the value of the no_new_privs bit
> + *   for the calling thread. A value of 0 indicates the regular execve(2)
> + *   behavior.  A value of 1 indicates execve(2) will operate in the
> + *   privilege-restricting mode.
> + * 2)With no_new_privs set to 1, execve(2) promises not to grant privileges
> + *   to do anything that could not have been done without the execve(2)
> + *   call(for example, rendering the set-user-ID and set-group-ID mode bits)
> + * 3)The setting of this bit is inherited by children created by fork(2) and
> + *   clone(2), and preserved across execve(2).
> + */
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/prctl.h>
> +#include <pwd.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/capability.h>
> +#include <lapi/prctl.h>
> +#include "tst_test.h"
> +
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
> +
> +	sprintf(ipc_env_var, IPC_ENV_VAR "=%s", getenv(IPC_ENV_VAR));
> +	childpid = SAFE_FORK();
> +	if (childpid == 0) {
> +		check_no_new_privs(1);
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



