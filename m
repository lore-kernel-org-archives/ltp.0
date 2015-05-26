Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YxEot-0008S0-DC
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 13:22:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YxEon-00020w-75
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 13:22:59 +0000
Message-ID: <556473A2.50407@redhat.com>
Date: Tue, 26 May 2015 15:22:42 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1432553084-9391-1-git-send-email-sunyuan3@huawei.com>
In-Reply-To: <1432553084-9391-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] containers: new testcase userns02 The user ID and
 group ID, which are inside a container,
 can be modified by its parent process.
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

Hi,

----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 25 May, 2015 1:24:44 PM
> Subject: [PATCH] containers: new testcase userns02 The user ID and group ID, which are inside a container, can be
> modified by its parent process.

This is quite long for single line, please add new line after "The user ID",

>
> ---
>  runtest/containers                            |  1 +
>  testcases/kernel/containers/.gitignore        |  1 +
>  testcases/kernel/containers/userns/userns02.c | 94 +++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/userns02.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index ca10372..bb1beb6 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -69,3 +69,4 @@ mountns03 mountns03
>  mountns04 mountns04
>  
>  userns01 userns01
> +userns02 userns02
> diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
> index 4478b53..e3c92c9 100644
> --- a/testcases/kernel/containers/.gitignore
> +++ b/testcases/kernel/containers/.gitignore
> @@ -4,3 +4,4 @@ mountns/mountns02
>  mountns/mountns03
>  mountns/mountns04
>  userns/userns01
> +userns/userns02
> diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
> new file mode 100644
> index 0000000..078439e
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns02.c
> @@ -0,0 +1,94 @@
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
> +*

If it's not too much trouble, could you please align those stars? :-)
Take a look at userns01.c

> +*
> +* Verify that:
> +*  The user ID and group ID, which are inside a container, can be modified by
> +* its parent process.
> +*/
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

I think you're not using libclone.h for anything in this test.

> +#include "userns_helper.h"
> +
> +char *TCID = "user_namespace2";
> +int TST_TOTAL = 1;
> +
> +char fullpath[BUFSIZ];

Seems unused.

> +pid_t childpid;
> +int parentuid;
> +int parentgid;
> +char cmd[BUFSIZ];
> +FILE *fp;

Why global? These are used only in main.


> +/*
> + * child_fn1() - Inside a new user namespace
> + */
> +static int child_fn1(void *arg)
> +{
> +	int exit_val;
> +	int uid, gid;
> +
> +	sleep(1);

No sleeps for synchronization please. You can use checkpoints, see include/tst_checkpoint.h.

> +	uid = geteuid();
> +	gid = getegid();
> +
> +	tst_resm(TINFO, "USERNS test is running in a new user namespace.");

Style guide discourages from using tst_* functions in child processes

> +	if (uid == 100 && gid == 100) {
> +		tst_resm(TINFO,  "Got expected uid and gid.");
> +		exit_val = 0;
> +	} else {
> +		tst_brkm(TFAIL | TTERRNO, NULL, "Got unexpected result of uid=%d gid=%d\n",
> +			uid, gid);

This line is too long
It's tst_* function in child process
It will end execution of child - making lines below irrelevant
TTERRNO doesn't make sense, since you haven't used TEST() macro
printf would suffice here

> +		exit_val = 1;
> +	}
> +
> +	return exit_val;
> +}
> +
> +static void setup(void)
> +{
> +	check_newuser();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int status;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +	setup();

This is something I missed in userns01 - TEST_LOOPING is missing.
Running "./userns02 -i 5" should run the case 5 times.

> +
> +	childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
> +
> +	if (childpid < 0)
> +		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");

TTERRNO will print errno from TEST_ERRNO, TERRNO from errno
You can either wrap call with TEST() and use TEST_RETURN instead of childpid
or you can change TTERRNO to TERRNO.

> +
> +	parentuid = geteuid();
> +	sprintf(cmd, "echo 100 %d 1 > /proc/%d/uid_map", parentuid, childpid);
> +	system(cmd);

There is SAFE_WRITE macro, which also checks that write succeeded.

> +	parentgid = getegid();
> +	sprintf(cmd, "echo 100 %d 1 > /proc/%d/gid_map", parentgid, childpid);
> +	system(cmd);
> +
> +	if (waitpid(childpid, &status, 0) < 0)
> +		tst_resm(TWARN, "parent: waitpid failed.");

TBROK | TERRNO would be better here - in case it fails, knowing errno
gives you more data.

You're missing a check that exit code was actually 0.

Regards,
Jan

> +
> +	tst_resm(TPASS, "the uid and the gid are right inside the container");
> +	tst_exit();
> +}
> +
> 


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
