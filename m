Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z4JED-0007wF-S8
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 01:30:21 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z4JE9-0006BV-IY
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 01:30:21 +0000
Message-ID: <557E2A9A.1050009@huawei.com>
Date: Mon, 15 Jun 2015 09:30:02 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1434052070-10537-1-git-send-email-sunyuan3@huawei.com>
	<1434073327.9061.4.camel@localhost>
In-Reply-To: <1434073327.9061.4.camel@localhost>
Subject: Re: [LTP] [PATCH] containers: new testcase userns04
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Jianggang,
     Thanks for your comment. I will update code according to
your suggestion.
     Yuan

On 2015/6/12 9:42, Wei, Jiangang wrote:
> On Thu, 2015-06-11 at 13:47 -0600, Yuan Sun wrote:
>>    If a namespace isn't aother namespace's ancestor, the first namespace
>> does not have the CAP_SYS_ADMIN capability in the second namespace
>> and the setns() call fails.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
>> ---
>>   testcases/kernel/containers/userns/userns04.c | 131 ++++++++++++++++++++++++++
>>   1 file changed, 131 insertions(+)
>>   create mode 100644 testcases/kernel/containers/userns/userns04.c
>>
>> diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
>> new file mode 100644
>> index 0000000..3e7249b
>> --- /dev/null
>> +++ b/testcases/kernel/containers/userns/userns04.c
>> @@ -0,0 +1,131 @@
>> +/*
>> + * Copyright (c) Huawei Technologies Co., Ltd., 2015
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> + * the GNU General Public License for more details.
>> + */
>> +
>> +/*
>> + * Verify that:
>> + *  If a namespace isn't aother namespace's ancestor, the first namespace
>> + *  does not have the CAP_SYS_ADMIN capability in the second namespace
>> + *  and the setns() call fails.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/wait.h>
>> +#include <assert.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include "test.h"
>> +#include "userns_helper.h"
>> +
>> +char *TCID = "user_namespace4";
>> +int TST_TOTAL = 1;
>> +
>> +/*
>> + * child_fn1() - Inside a new user namespace
>> + */
>> +static int child_fn1(void)
>> +{
>> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
>> +	return 0;
>> +}
>> +
>> +static int child_fn2(int *arg)
>> +{
>> +	int exit_val;
>> +
>> +	if (setns(*arg, CLONE_NEWUSER) == -1) {
>> +		printf("child2 setns() failure is expected\n");
>> +		exit_val = 0;
>> +	} else {
>> +		printf("chile2 setns() success isn't expected\n");
>> +		exit_val = 1;
>> +	}
>> +
>> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
>> +	return exit_val;
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	check_newuser();
>> +	tst_tmpdir();
>> +	TST_CHECKPOINT_INIT(NULL);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	tst_rmdir();
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int cpid1status, cpid2status;
>> +	int lc;
>> +	int cpid1, cpid2;
>> +	char path[BUFSIZ];
>> +	int fd;
>> +
>> +	tst_parse_opts(argc, argv, NULL, NULL);
>> +	setup();
>> +
>> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +		tst_count = 0;
>> +		cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
>> +			(void *)child_fn1, NULL);
>> +
>> +		if (cpid1 < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
>> +
>> +		sprintf(path, "/proc/%d/ns/user", cpid1);
>> +		fd = SAFE_OPEN(NULL, path, O_RDONLY, 0644);
>> +
>> +		cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
>> +			(void *)child_fn2, &fd);
>> +
>> +		if (cpid2 < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
>> +
>> +		if (setns(fd, CLONE_NEWUSER) == -1)
>> +			tst_brkm(TFAIL, cleanup, "parent pid setns failure");
>> +		else
>> +			tst_resm(TINFO, "parent pid setns success");
>> +
>> +		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
>> +		TST_SAFE_CHECKPOINT_WAKE(NULL, 1);
>> +
>> +		if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
>> +			(waitpid(cpid2, &cpid2status, 0) < 0))
>> +				tst_resm(TBROK, "parent: waitpid failed.");
>> +
>> +		if (WIFSIGNALED(cpid1status)) {
>> +			tst_resm(TBROK, "child1 was killed with signal = %d",
>> +				WTERMSIG(cpid1status));
>> +		} else if (WIFEXITED(cpid1status) &&
>> +			WEXITSTATUS(cpid1status) != 0) {
>> +			tst_resm(TBROK, "child1 exited abnormally");
>> +		}
>> +
>> +		if (WIFSIGNALED(cpid2status)) {
>> +			tst_resm(TBROK, "child2 was killed with signal = %d",
>> +				WTERMSIG(cpid2status));
>> +		} else if (WIFEXITED(cpid2status) &&
>> +			WEXITSTATUS(cpid2status) != 0) {
>> +			tst_resm(TBROK, "child2 exited abnormally");
>> +		} else
>> +			tst_resm(TPASS, "The setns function works well.");
>> +	}
> Hi,
> It should call cleanup() here.
>
> Regards,
> Wei
>> +	tst_exit();
>> +}
>> +


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
