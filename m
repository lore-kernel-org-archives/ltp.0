Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z7hd1-0005n6-BQ
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 10:09:59 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z7hcz-0001hK-Sw
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 10:09:59 +0000
Date: Wed, 24 Jun 2015 06:09:44 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <272406532.7018175.1435140584383.JavaMail.zimbra@redhat.com>
In-Reply-To: <1434547032-7000-1-git-send-email-sunyuan3@huawei.com>
References: <1434547032-7000-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V4] containers: new testcase userns04
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
> Cc: ltp-list@lists.sourceforge.net, "weijg fnst" <weijg.fnst@cn.fujitsu.com>
> Sent: Wednesday, 17 June, 2015 3:17:12 PM
> Subject: [PATCH V4] containers: new testcase userns04

Hi,

I posted v5 with some small changes, please have a look.
Changes are commented inline:

> 
> If a namespace isn't aother namespace's ancestor, the first namespace

fixed typo, changed to "process in first namespace"

> does not have the CAP_SYS_ADMIN capability in the second namespace
> and the setns() call fails.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/containers/userns/userns04.c | 135

added .gitignore and runtest file

>  ++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/userns04.c
> 
> diff --git a/testcases/kernel/containers/userns/userns04.c
> b/testcases/kernel/containers/userns/userns04.c
> new file mode 100644
> index 0000000..286a46c
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns04.c
> @@ -0,0 +1,135 @@
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
> + *  If a namespace isn't another namespace's ancestor, the first namespace
> + *  does not have the CAP_SYS_ADMIN capability in the second namespace
> + *  and the setns() call fails.
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
> +char *TCID = "user_namespace4";
> +int TST_TOTAL = 1;
> +
> +static void setup(void)
> +{
> +	check_newuser();
> +	tst_tmpdir();
> +	TST_CHECKPOINT_INIT(NULL);
> +}
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

ltp_clone_quick expects "int (*fn)(void *arg)"
changed accordingly

> +{
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	return 0;
> +}
> +
> +static int child_fn2(int *arg)
> +{
> +	int exit_val;
> +
> +	if (setns(*arg, CLONE_NEWUSER) == -1) {
> +		printf("child2 setns() failure is expected\n");

removed printf for good case, added check of EPERM and output
of errno if it's different

> +		exit_val = 0;
> +	} else {
> +		printf("chile2 setns() success isn't expected\n");
> +		exit_val = 1;
> +	}
> +
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
> +	return exit_val;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int cpid1status, cpid2status;
> +	int cpid1, cpid2;
> +	char path[BUFSIZ];
> +	int fd;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();
> +/*
> +TEST_LOOPING isn't used because the parent pid can't reset to the
> +previous namespace after it joins another namespace by setns.
> +*/

added test looping
the parent forks throw-away process, which makes the same check

> +	tst_count = 0;
> +	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +		(void *)child_fn1, NULL);
> +
> +	if (cpid1 < 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
> +
> +	sprintf(path, "/proc/%d/ns/user", cpid1);
> +	fd = SAFE_OPEN(cleanup, path, O_RDONLY, 0644);
> +
> +	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
> +		(void *)child_fn2, &fd);
> +
> +	if (cpid2 < 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
> +
> +	if (setns(fd, CLONE_NEWUSER) == -1)
> +		tst_brkm(TFAIL, cleanup, "parent pid setns failure");
> +	else
> +		tst_resm(TINFO, "parent pid setns success");
> +
> +	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +	TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
> +
> +	if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
> +		(waitpid(cpid2, &cpid2status, 0) < 0))
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"parent: waitpid failed.");
> +
> +	if (WIFSIGNALED(cpid1status)) {
> +		tst_resm(TFAIL, "child1 was killed with signal = %d",
> +			WTERMSIG(cpid1status));
> +	} else if (WIFEXITED(cpid1status) &&
> +		WEXITSTATUS(cpid1status) != 0) {
> +		tst_resm(TFAIL, "child1 exited abnormally");
> +	}
> +
> +	if (WIFSIGNALED(cpid2status)) {
> +		tst_resm(TFAIL, "child2 was killed with signal = %d",
> +			WTERMSIG(cpid2status));
> +	} else if (WIFEXITED(cpid2status) &&
> +		WEXITSTATUS(cpid2status) != 0) {
> +		tst_resm(TFAIL, "child2 exited abnormally");
> +	} else
> +		tst_resm(TPASS, "The setns function works well.");

made a function for checking child ret code and used that for all 3 children

Regards,
Jan

> +
> +	SAFE_CLOSE(cleanup, fd);
> +	cleanup();
> +	tst_exit();
> +}
> +
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
