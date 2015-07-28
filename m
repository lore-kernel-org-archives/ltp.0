Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZK4MY-0004GC-0u
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 12:52:06 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZK4MU-0003nC-N0
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 12:52:06 +0000
Date: Tue, 28 Jul 2015 08:51:51 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1614346991.1336747.1438087911912.JavaMail.zimbra@redhat.com>
In-Reply-To: <1437391482-6564-1-git-send-email-sunyuan3@huawei.com>
References: <1437391482-6564-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers: new testcase userns06
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 20 July, 2015 1:24:42 PM
> Subject: [PATCH] containers: new testcase userns06
> 
> When a process with non-zero user IDs performs an execve(), the
> process's capability sets are cleared. When a process with zero
> user IDs performs an execve(), the process's capability sets are
> set.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

> ---
>  runtest/containers                                 |   1 +
>  testcases/kernel/containers/.gitignore             |   1 +
>  .../kernel/containers/userns/execvpcapability.c    |  76 ++++++++
>  testcases/kernel/containers/userns/userns06.c      | 199
>  +++++++++++++++++++++
>  4 files changed, 277 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/execvpcapability.c
>  create mode 100644 testcases/kernel/containers/userns/userns06.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index de4197e..a9eb4b3 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -72,3 +72,4 @@ userns01 userns01
>  userns02 userns02
>  userns03 userns03
>  userns04 userns04
> +userns06 userns06
> diff --git a/testcases/kernel/containers/.gitignore
> b/testcases/kernel/containers/.gitignore
> index 85ced78..cf9e8a3 100644
> --- a/testcases/kernel/containers/.gitignore
> +++ b/testcases/kernel/containers/.gitignore
> @@ -7,3 +7,4 @@ userns/userns01
>  userns/userns02
>  userns/userns03
>  userns/userns04
> +userns/userns06

execvpcapability should also be in gitignore.

I'd suggest a different name for it, so we know it belongs to userns06,
for example "userns06_capcheck"

> diff --git a/testcases/kernel/containers/userns/execvpcapability.c
> b/testcases/kernel/containers/userns/execvpcapability.c
> new file mode 100644
> index 0000000..c2ec7e5
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/execvpcapability.c
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd., 2015
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + */
> +
> +/*
> + * Verify that:
> + * When a process with non-zero user IDs performs an execve(), the
> + * process's capability sets are cleared. When a process with zero
> + * user IDs performs an execve(), the process's capability sets
> + * are set.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include "test.h"
> +#include "libclone.h"
> +#include "config.h"
> +#if HAVE_SYS_CAPABILITY_H
> +#include <sys/capability.h>
> +#endif
> +
> +char *TCID = "execvpcapability";
> +int TST_TOTAL = 1;
> +
> +int main(int argc, char *argv[])
> +{
> +#ifdef HAVE_LIBCAP
> +	cap_t caps;
> +	int i, last_cap;
> +	cap_flag_value_t flag_val;
> +	cap_flag_value_t expected_flag = 1;
> +
> +	if (argc != 2) {
> +		printf("Need 2 parameters, such as %s privilege\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	if (strcmp("privilege", argv[1]))
> +		expected_flag = 0;
> +
> +	caps = cap_get_proc();
> +	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
> +	for (i = 0; i <= last_cap; i++) {
> +		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
> +		if (flag_val != expected_flag)
> +			break;
> +		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
> +		if (flag_val != expected_flag)
> +			break;
> +	}
> +
> +	if (flag_val != expected_flag) {
> +		printf("unexpected effective/permitted caps at %d\n", i);
> +		exit(1);
> +	}
> +
> +#else
> +	printf("System is missing libcap.\n");
> +#endif
> +	tst_exit();
> +}
> diff --git a/testcases/kernel/containers/userns/userns06.c
> b/testcases/kernel/containers/userns/userns06.c
> new file mode 100644
> index 0000000..6828d5c
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns06.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd., 2015
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version. This program is distributed in the hope that it will
> be
> + * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
> + * Public License for more details. You should have received a copy of the
> GNU
> + * General Public License along with this program.
> + */
> +
> +/*
> + * Verify that:
> + * When a process with non-zero user IDs performs an execve(), the process's
> + * capability sets are cleared.
> + * When a process with zero user IDs performs an execve(), the process's
> + * capability sets are set.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/wait.h>
> +#include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include "test.h"
> +#include "libclone.h"
> +#include "userns_helper.h"
> +
> +#define CHILD1UID 0
> +#define CHILD1GID 0
> +#define CHILD2UID 200
> +#define CHILD2GID 200
> +#define UID_MAP 0
> +#define GID_MAP 1
> +
> +char *TCID = "user_namespace6";
> +int TST_TOTAL = 1;
> +static int cpid1, parentuid, parentgid;
> +
> +/*
> + * child_fn1() - Inside a new user namespace
> + */
> +static int child_fn1(void)
> +{
> +	int exit_val = 0;
> +	char *const args[] = { "execvpcapability", "privilege", NULL };

"privileged" / "unprivileged" sounds nicer, my dictionary says "nonprivilege"
isn't actually a word.

> +
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +
> +	if (execvp(args[0], args) == -1) {
> +		printf("execvp unexpected error: (%d) %s\n",
> +			errno, strerror(errno));
> +		exit_val = 1;
> +	}
> +
> +	return exit_val;
> +}
> +
> +/*
> + * child_fn2() - Inside a new user namespace
> + */
> +static int child_fn2(void)
> +{
> +	int exit_val = 0;
> +	int uid, gid;
> +	char *const args[] = { "execvpcapability", "nonprivilege", NULL };
> +
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
> +
> +	uid = geteuid();
> +	gid = getegid();
> +
> +	if (uid != CHILD2UID || gid != CHILD2GID) {
> +		printf("unexpected uid=%d gid=%d\n", uid, gid);
> +		exit_val = 1;
> +	}
> +
> +	if (execvp(args[0], args) == -1) {
> +		printf("execvp unexpected error: (%d) %s\n",
> +			errno, strerror(errno));
> +		exit_val = 1;
> +	}
> +
> +	return exit_val;
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +static void setup(void)
> +{
> +	check_newuser();
> +	tst_tmpdir();
> +	TST_CHECKPOINT_INIT(NULL);

If you use:
  TST_RESOURCE_COPY(cleanup, TESTAPP, NULL);
that will copy the child binary to tmp directory. If you also change
your exec* calls to look for it in current directory, then you can
conveniently run it from git tree as "./userns06"


> +}
> +
> +static int updatemap(int cpid, bool type, int idnum, int parentmappid)

Perhaps this should go into some helper header file now, so we don't keep
same copies in multiple tests.

> +{
> +	char path[BUFSIZ];
> +	char content[BUFSIZ];
> +	int fd;
> +
> +	if (type == UID_MAP)
> +		sprintf(path, "/proc/%d/uid_map", cpid);
> +	else if (type == GID_MAP)
> +		sprintf(path, "/proc/%d/gid_map", cpid);
> +	else
> +		tst_brkm(TBROK, cleanup, "invalid type parameter");
> +
> +	sprintf(content, "%d %d 1", idnum, parentmappid);
> +	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
> +	SAFE_CLOSE(cleanup, fd);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pid_t cpid2;
> +	char path[BUFSIZ];
> +	int cpid1status, cpid2status;
> +	int lc;
> +	int fd;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		parentuid = geteuid();
> +		parentgid = getegid();
> +
> +		cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +			(void *)child_fn1, NULL);
> +		if (cpid1 < 0)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				"cpid1 clone failed");
> +
> +		cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +			(void *)child_fn2, NULL);
> +		if (cpid2 < 0)
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				"cpid2 clone failed");
> +
> +		if (access("/proc/self/setgroups", F_OK) == 0) {
> +			sprintf(path, "/proc/%d/setgroups", cpid1);
> +			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
> +			SAFE_CLOSE(cleanup, fd);
> +
> +			sprintf(path, "/proc/%d/setgroups", cpid2);
> +			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
> +			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
> +			SAFE_CLOSE(cleanup, fd);
> +		}
> +
> +		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid);
> +		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid);
> +
> +		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid);
> +		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid);
> +
> +		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +		TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
> +
> +		if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
> +			(waitpid(cpid2, &cpid2status, 0) < 0))
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +				"parent: waitpid failed.");
> +
> +		if (WIFSIGNALED(cpid1status)) {
> +			tst_resm(TFAIL, "child1 was killed with signal = %d",
> +				WTERMSIG(cpid1status));
> +		} else if (WIFEXITED(cpid1status) &&
> +			WEXITSTATUS(cpid1status) != 0) {
> +			tst_resm(TFAIL, "child1 exited abnormally");
> +		}
> +
> +		if (WIFSIGNALED(cpid2status)) {
> +			tst_resm(TFAIL, "child2 was killed with signal = %d",
> +				WTERMSIG(cpid2status));
> +		} else if (WIFEXITED(cpid2status) &&
> +			WEXITSTATUS(cpid2status) != 0) {
> +			tst_resm(TFAIL, "child2 exited abnormally");
> +		} else
> +			tst_resm(TPASS, "test pass");

Can you replace waitpid/etc. with tst_record_childstatus()?

> +	}
> +	cleanup();
> +	tst_exit();
> +}

Main test, doesn't check for libcap presence, and it gives you TPASS
also in cases nothing has been checked. I'd expect TCONF in such case.

System is missing libcap.
System is missing libcap.
user_namespace6    1  TPASS  :  test pass
# echo $?
0

Regards,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
