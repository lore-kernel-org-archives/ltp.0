Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z32x4-0007wW-NK
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 13:55:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z32x2-0002lM-5B
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 13:55:26 +0000
Message-ID: <55799344.5090100@redhat.com>
Date: Thu, 11 Jun 2015 15:55:16 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1433840491-21403-1-git-send-email-sunyuan3@huawei.com>
In-Reply-To: <1433840491-21403-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH V2] containers: new testcase userns03
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

On 06/09/2015 11:01 AM, Yuan Sun wrote:
>   ID-outside-ns is interpreted according to which process is opening the file.
> If the process opening the file is in the same user namespace as the process
> PID, then ID-outside-ns is defined with respect to the parent user namespace.
> If the process opening the file is in a different user namespace, then
> ID-outside-ns is defined with respect to the user namespace of the process
> opening the file.
>   If kernel version >= 3.19.0, the case will ignore the git check.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

> ---
>  testcases/kernel/containers/userns/userns03.c | 250 ++++++++++++++++++++++++++

please also add it to .gitignore and container runtest file.

>  1 file changed, 250 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/userns03.c
> 
> diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
> new file mode 100644
> index 0000000..01308f6
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns03.c
> @@ -0,0 +1,250 @@
> +/*
> +* Copyright (c) Huawei Technologies Co., Ltd., 2015
> +* This program is free software; you can redistribute it and/or modify it
> +* under the terms of the GNU General Public License as published by the Free
> +* Software Foundation; either version 2 of the License, or (at your option)
> +* any later version. This program is distributed in the hope that it will be
> +* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
> +* Public License for more details. You should have received a copy of the GNU
> +* General Public License along with this program.
> +*/
> +
> +/*
> +* Verify that:
> +* /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
> +* white space:
> +* ID-inside-ns   ID-outside-ns   length
> +*
> +*  ID-outside-ns is interpreted according to which process is opening the file.
> +* If the process opening the file is in the same user namespace as the process
> +* PID, then ID-outside-ns is defined with respect to the parent user namespace.
> +* If the process opening the file is in a different user namespace, then
> +* ID-outside-ns is defined with respect to the user namespace of the process
> +* opening the file.
> +*/
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
> +char *TCID = "user_namespace3";
> +int TST_TOTAL = 1;
> +static int cpid1, parentuid, parentgid;
> +static bool setgroups;

I'd suggest to use different name, since there already is setgroups(2) function.

> +
> +#define CHILD1UID 0
> +#define CHILD1GID 0
> +#define CHILD2UID 200
> +#define CHILD2GID 200
> +
> +/*
> + * child_fn1() - Inside a new user namespace
> + */
> +static int child_fn1(void)
> +{
> +	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
> +	return 0;
> +}
> +
> +
> +/*
> + * child_fn2() - Inside a new user namespace
> + */
> +static int child_fn2(void)
> +{
> +	int exit_val;
> +	int uid, gid;
> +	char cpid1uidpath[BUFSIZ];
> +	char cpid1gidpath[BUFSIZ];
> +	int idinsidens, idoutsidens, length;
> +
> +	uid = geteuid();
> +	gid = getegid();
> +
> +	if (uid == CHILD2UID) {
> +		printf("Got expected uid.\n");
> +		exit_val = 0;
> +	} else {
> +		printf("unexpected uid=%d\n", uid);
> +		exit_val = 1;
> +	}
> +
> +	if (setgroups == 0) {
> +		if (uid == CHILD2UID && gid == CHILD2GID) {

You are comparing uid twice, but that's just a minor.

> +			printf("Got expected uid and gid.\n");
> +			exit_val = 0;
> +		} else {
> +			printf("unexpected: uid=%d gid=%d\n", uid, gid);
> +			exit_val = 1;
> +		}
> +	}
> +	/*Get the uid parameters of the child_fn2 process.*/
> +	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
> +		&idoutsidens, &length);
> +
> +	/* map file format:ID-inside-ns   ID-outside-ns   length
> +	If the process opening the file is in the same user namespace as
> +	the process PID, then ID-outside-ns is defined with respect to the
> +	 parent user namespace.*/
> +	if (idinsidens != CHILD2UID || idoutsidens != parentuid) {
> +		printf("child_fn2 checks /proc/cpid2/uid_map:\n");
> +		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +			idinsidens, idoutsidens);
> +		exit_val = 1;
> +	}
> +
> +	sprintf(cpid1uidpath, "/proc/%d/uid_map", cpid1);
> +	SAFE_FILE_SCANF(NULL, cpid1uidpath, "%d %d %d", &idinsidens,
> +		&idoutsidens, &length);
> +
> +	/* If the process opening the file is in a different user namespace,
> +	then ID-outside-ns is defined with respect to the user namespace
> +	of the process opening the file.*/
> +	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID) {
> +		printf("child_fn2 checks /proc/cpid1/uid_map:\n");
> +		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +			idinsidens, idoutsidens);
> +		exit_val = 1;
> +	}
> +
> +	if (setgroups == 0) {
> +		sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
> +		SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d",
> +			 &idinsidens, &idoutsidens, &length);
> +
> +		if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
> +			printf("child_fn2 checks /proc/cpid2/gid_map:\n");
> +			printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +				idinsidens, idoutsidens);
> +			exit_val = 1;
> +		}
> +
> +		SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
> +			&idoutsidens, &length);
> +
> +		if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
> +			printf("child_fn1 checks /proc/cpid1/gid_map:\n");
> +			printf("unexpected: idinsidens=%d idoutsidens=%d\n",
> +				idinsidens, idoutsidens);
> +			exit_val = 1;
> +		}
> +	}
> +	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 1);
> +	return exit_val;
> +}
> +
> +
> +static void setup(void)
> +{
> +	char read_buf[BUFSIZ];
> +
> +	check_newuser();
> +	tst_tmpdir();
> +	TST_CHECKPOINT_INIT(NULL);
> +	if (tst_kvercmp(3, 19, 0) >= 0) {

I'm thinking if we shouldn't replace kernel version check with check that
"/proc/self/setgroups" exists. Then it would work on kernels that backport
those patches. What do you think?

> +		SAFE_FILE_SCANF(NULL, "/proc/self/setgroups", "%s", read_buf);
> +		if (strcmp(read_buf, "deny") == 0)
> +			setgroups = 0;
> +		else
> +			setgroups = 1;

You could drop one of these branches, static variable already defaults to 0.

> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +/*type: 0->uid; 1->git */

typo here, git -> gid

I'd suggest a define for these, it would be easier to read something like
UID_MAP, GID_MAP instead of 0 and 1.

> +static int updatemap(int cpid, bool type, int idnum, int parentmappid)
> +{
> +	char path[BUFSIZ];
> +	char content[BUFSIZ];
> +	int fd;
> +
> +	if (type == 0)
> +		sprintf(path, "/proc/%d/uid_map", cpid);
> +	else if (type == 1)
> +		sprintf(path, "/proc/%d/gid_map", cpid);
> +	else
> +		tst_brkm(TFAIL, NULL, "invalid type parameter");
> +
> +	sprintf(content, "%d %d 1", idnum, parentmappid);
> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
> +	SAFE_WRITE(NULL, 1, fd, content, strlen(content));

You should pass cleanup to SAFE_ functions above.

You are leaking fd here. Try to run it as ./netns03 -i 10000 and you get
  errno=EMFILE(24): Too many open files

> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pid_t cpid2;
> +	int cpid1status, cpid2status;
> +	int lc;
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
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				"cpid1 clone failed");
> +
> +		cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +			(void *)child_fn2, NULL);
> +		if (cpid2 < 0)
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				"cpid2 clone failed");
> +
> +		updatemap(cpid1, 0, CHILD1UID, parentuid);
> +		updatemap(cpid2, 0, CHILD2UID, parentuid);
> +
> +		if (setgroups == 0) {
> +			updatemap(cpid1, 1, CHILD1GID, parentuid);
> +			updatemap(cpid2, 1, CHILD2GID, parentuid);
> +		}
> +
> +		TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +		TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
> +		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +		TST_SAFE_CHECKPOINT_WAKE(NULL, 1);

cleanup here as well

> +
> +		if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
> +			(waitpid(cpid2, &cpid2status, 0) < 0))
> +				tst_resm(TBROK, "parent: waitpid failed.");

tst_brkm(TBROK | TERRNO, cleanup, ...


> +
> +		if (WIFSIGNALED(cpid1status)) {
> +			tst_resm(TBROK, "child1 was killed with signal = %d",

tst_resm(TFAIL

> +				WTERMSIG(cpid1status));
> +		} else if (WIFEXITED(cpid1status) &&
> +			WEXITSTATUS(cpid1status) != 0) {
> +			tst_resm(TBROK, "child1 exited abnormally");

tst_resm(TFAIL

> +		}
> +
> +		if (WIFSIGNALED(cpid2status)) {
> +			tst_resm(TBROK, "child2 was killed with signal = %d",
> +				WTERMSIG(cpid2status));

tst_resm(TFAIL

> +		} else if (WIFEXITED(cpid2status) &&
> +			WEXITSTATUS(cpid2status) != 0) {
> +			tst_resm(TBROK, "child2 exited abnormally");

tst_resm(TFAIL

Regards,
Jan


> +		} else
> +			tst_resm(TPASS, "Uid and the gid are right.");
> +	}
> +	tst_exit();
> +}
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
