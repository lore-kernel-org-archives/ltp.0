Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZK3Mw-0002zr-Bh
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 11:48:26 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZK3Mu-0008Gb-JM
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 11:48:26 +0000
Date: Tue, 28 Jul 2015 07:48:12 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1067793714.1280389.1438084092950.JavaMail.zimbra@redhat.com>
In-Reply-To: <1436952165-23665-1-git-send-email-sunyuan3@huawei.com>
References: <1436952165-23665-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers: new testcase userns05
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
> Sent: Wednesday, 15 July, 2015 11:22:45 AM
> Subject: [PATCH] containers: new testcase userns05
> 
> A process created via fork(2) or clone(2) without the CLONE_NEWUSER
> flag is a member of the same user namespace as its parent.
>   When unshare an user namespace, the calling process is moved into a
> new user namespace which is not shared with any previously existing
> process.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

> ---
>  runtest/containers                            |   1 +
>  testcases/kernel/containers/.gitignore        |   1 +
>  testcases/kernel/containers/userns/userns05.c | 167
>  ++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/userns05.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index de4197e..cece80b 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -72,3 +72,4 @@ userns01 userns01
>  userns02 userns02
>  userns03 userns03
>  userns04 userns04
> +userns05 userns05
> diff --git a/testcases/kernel/containers/.gitignore
> b/testcases/kernel/containers/.gitignore
> index 85ced78..b433b03 100644
> --- a/testcases/kernel/containers/.gitignore
> +++ b/testcases/kernel/containers/.gitignore
> @@ -7,3 +7,4 @@ userns/userns01
>  userns/userns02
>  userns/userns03
>  userns/userns04
> +userns/userns05
> diff --git a/testcases/kernel/containers/userns/userns05.c
> b/testcases/kernel/containers/userns/userns05.c
> new file mode 100644
> index 0000000..8d25c56
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns05.c
> @@ -0,0 +1,167 @@
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
> + * A process created via fork(2) or clone(2) without the
> + * CLONE_NEWUSER flag is a member of the same user namespace as its
> + * parent.
> + * When unshare an user namespace, the calling process is moved into
> + * a new user namespace which is not shared with any previously
> + * existing process.
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
> +#include "userns_helper.h"
> +
> +char *TCID = "user_namespace5";
> +int TST_TOTAL = 1;
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +/*
> + * child_fn1() - Inside a new user namespace
> + */
> +static int child_fn1(void)
> +{
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	return 0;
> +}
> +
> +static int wait4child(pid_t pid, const char *msg)
> +{
> +	int status;
> +
> +	if (waitpid(pid, &status, 0) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> +	} else if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "%s: child was killed with signal = %d",
> +			msg, WTERMSIG(status));
> +		return WTERMSIG(status);
> +	} else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +		tst_resm(TFAIL, "%s: child returns %d", msg, status);
> +		return WEXITSTATUS(status);
> +	}
> +
> +	return 0;
> +}

As already pointed out by Cyril, we have "tst_record_childstatus()" in lib,
please use that.

> +
> +static long getusernsidbypid(int pid)
> +{
> +	char path[BUFSIZ];
> +	char userid[BUFSIZ];
> +	long id;

I'd recommend to initialize 'id', in case readlink/sscanf fails
to set the value.

> +
> +	sprintf(path, "/proc/%d/ns/user", pid);
> +
> +	if (readlink(path, userid, BUFSIZ) == -1)
> +		tst_resm(TFAIL, "readlink failure.");
> +
> +	if (sscanf(userid, "user:[%ld]", &id) != 1)
> +		tst_resm(TFAIL, "sscanf failure.");

Please add "| TERRNO" above, in case it fails it would be
good to know why.

> +	return id;
> +}
> +
> +static void test_userns_id(void)
> +{
> +	int status;

status is no longer needed

> +	int cpid1, cpid2, cpid3;
> +	long parentuserns, cpid1userns, cpid2userns, newparentuserns;
> +
> +	parentuserns = getusernsidbypid(getpid());
> +	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1,
> +		NULL);
> +	if (cpid1 < 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");

TBROK | TERRNO

> +	cpid1userns = getusernsidbypid(cpid1);
> +	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +
> +	/* A process created via fork(2) or clone(2) without the
> +	CLONE_NEWUSER flag is a member of the same user namespace as its
> +	parent.*/
> +	if (parentuserns != cpid1userns)
> +		tst_resm(TFAIL, "userns:parent should be equal to cpid1");
> +
> +	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +		(void *)child_fn1, NULL);
> +	if (cpid2 < 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");

TBROK | TERRNO

> +	cpid2userns = getusernsidbypid(cpid2);
> +	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +
> +	if (parentuserns == cpid2userns)
> +		tst_resm(TFAIL, "userns:parent should be not equal to cpid2");
> +
> +	switch (cpid3 = fork()) {
> +	case -1:
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +	case 0:
> +		if (unshare(CLONE_NEWUSER) == -1) {
> +			printf("parent pid unshare failure: (%d) %s",
> +				errno, strerror(errno));
> +			exit(1);
> +		}
> +		newparentuserns = getusernsidbypid(getpid());
> +
> +		/* When unshare an user namespace, the calling process
> +		is moved into a new user namespace which is not shared
> +		with any previously existing process.*/
> +		if (parentuserns == newparentuserns)
> +			exit(1);
> +		exit(0);
> +	}
> +
> +	status = 0;
> +	status |= wait4child(cpid1, "child1");
> +	status |= wait4child(cpid2, "child2");
> +	status |= wait4child(cpid3, "child3");
> +	if (status == 0)
> +		tst_resm(TPASS, "The usernsid function works well.");
> +	else
> +		tst_resm(TFAIL, "Some children reported failure.");

As mentioned above, please replace wait4child with tst_record_childstatus:
      tst_record_childstatus(cleanup, cpid1);
      tst_record_childstatus(cleanup, cpid2);
      tst_record_childstatus(cleanup, cpid3);

Regards,
Jan

> +}
> +
> +static void setup(void)
> +{
> +	check_newuser();
> +
> +	tst_tmpdir();
> +	TST_CHECKPOINT_INIT(NULL);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		test_userns_id();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
