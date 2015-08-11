Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZP5Oc-0006G0-5Q
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 08:58:58 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZP5OX-0000rg-Ac
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 08:58:58 +0000
Message-ID: <55C9B596.7060802@huawei.com>
Date: Tue, 11 Aug 2015 16:43:02 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1438923308-5194-1-git-send-email-sunyuan3@huawei.com>
	<10491102.7385545.1439280346874.JavaMail.zimbra@redhat.com>
In-Reply-To: <10491102.7385545.1439280346874.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V2] container: new testcase pidns32
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi Jan,
     See in-line comments.
On 2015/8/11 16:05, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, 7 August, 2015 6:55:08 AM
>> Subject: [PATCH V2] container: new testcase pidns32
>>
>> Kernel imposes a limit of 32 nested levels of pid namespaces.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
>> ---
>>   runtest/containers                           |  1 +
>>   testcases/kernel/containers/pidns/.gitignore |  1 +
>>   testcases/kernel/containers/pidns/pidns32.c  | 96
>>   ++++++++++++++++++++++++++++
>>   3 files changed, 98 insertions(+)
>>   create mode 100644 testcases/kernel/containers/pidns/pidns32.c
>>
>> diff --git a/runtest/containers b/runtest/containers
>> index 9dc44bc..ac37ab2 100644
>> --- a/runtest/containers
>> +++ b/runtest/containers
>> @@ -13,6 +13,7 @@ pidns17 pidns17
>>   pidns20 pidns20
>>   pidns30 pidns30
>>   pidns31 pidns31
>> +pidns32 pidns32
>>   
>>   mqns_01 mqns_01
>>   mqns_01_clone mqns_01 -clone
>> diff --git a/testcases/kernel/containers/pidns/.gitignore
>> b/testcases/kernel/containers/pidns/.gitignore
>> index e56c1f9..488b045 100644
>> --- a/testcases/kernel/containers/pidns/.gitignore
>> +++ b/testcases/kernel/containers/pidns/.gitignore
>> @@ -12,3 +12,4 @@
>>   /pidns20
>>   /pidns30
>>   /pidns31
>> +/pidns32
>> diff --git a/testcases/kernel/containers/pidns/pidns32.c
>> b/testcases/kernel/containers/pidns/pidns32.c
>> new file mode 100644
>> index 0000000..d0d3e1e
>> --- /dev/null
>> +++ b/testcases/kernel/containers/pidns/pidns32.c
>> @@ -0,0 +1,96 @@
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
> Hi,
>
> I'm still not entirely convinced about this test.
>
>> + * Verify that:
>> + * The kernel imposes a limit of 32 nested levels of pid namespaces.
> If it doesn't, is that a bad thing? Are there some adverse effects, when
> such limitation is lacking?
It is a kernel feature. The following information is from
http://www.serverphorums.com/read.php?12,580615

'struct pid' is a "variable sized struct" - a header with an array
of upids at the end.

A size of the array depends on a level (depth) of pid namespaces. Now
a level of pidns is not limited, so 'struct pid' can be more than one
page.

Looks reasonable, that it should be less than a page. MAX_PIS_NS_LEVEL
is not calculated from PAGE_SIZE, because in this case it depends on
architectures, config options and it will be reduced, if someone adds a
new fields in struct pid or struct upid.

I suggest to set MAX_PID_NS_LEVEL = 32, because it saves ability to
expand "struct pid" and it's more than enough for all known for me
use-cases. When someone finds a reasonable use case, we can add a
config option or a sysctl parameter.

In addition it will reduce effect of another problem, when we have many
nested namespaces and the oldest one starts dying. zap_pid_ns_processe
will be called for each namespace and find_vpid will be called for each
process in a namespace. find_vpid will be called minimum max_level^2 / 2
times. The reason of that is that when we found a bit in pidmap, we
can't determine this pidns is top for this process or it isn't.

vpid is a heavy operation, so a fork bomb, which create many nested
namespace, can do a system inaccessible for a long time.
>
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
>> +#include "pidns_helper.h"
>> +
>> +#define MAXNEST 32
>> +
>> +char *TCID = "pidns32";
>> +int TST_TOTAL = 1;
>> +
>> +static void setup(void)
>> +{
>> +	if (tst_kvercmp(3, 7, 0) < 0)
>> +		tst_brkm(TCONF, NULL, "nest depth limitation not supported");
>> +	tst_require_root();
>> +	check_newpid();
>> +	tst_tmpdir();
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	tst_rmdir();
>> +}
>> +
>> +static int child_fn1(void *arg)
>> +{
>> +	pid_t cpid1;
>> +	long level = (long)arg;
>> +
>> +	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
>> +		(void *)child_fn1, (void *)(level + 1));
> You are relying on fact that clone will fail at MAXNEST levels.
> If it doesn't then this keeps making child processes presumably
> until you hit OOM.
>
> First action of new child should be to check current level. If it's
> over, test can end there.
Yes, you are right. I will update the code.
>
>> +	if (cpid1 < 0) {
>> +		if (level == MAXNEST)
>> +			return 0;
>> +		return 1;
>> +	}
>> +	if (waitpid(cpid1, NULL, 0) == -1)
>> +		return 1;
> If you ignore status in waitpid() call, how do you know that child at
> MAXNEXT level failed test condition?
  79 /* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
  80 #define MAX_PID_NS_LEVEL 32
  81
  82 static struct pid_namespace *create_pid_namespace(struct 
user_namespace *user_ns,
  83         struct pid_namespace *parent_pid_ns)
  84 {
  85         struct pid_namespace *ns;
  86         unsigned int level = parent_pid_ns->level + 1;
  87         int i;
  88         int err;
  89
  90         if (level > MAX_PID_NS_LEVEL) {
  91                 err = -EINVAL;
  92                 goto out;
  93         }
http://lxr.free-electrons.com/source/kernel/pid_namespace.c

I need to update the code to judge if the error is EINVAL.
>
> Regards,
> Jan
>
>> +	if (level > MAXNEST) {
>> +		printf("MAX_PIS_NS_LEVEL doestn't take effect\n");
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void test_max_nest(void)
>> +{
>> +	pid_t cpid1;
>> +
>> +	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
>> +		(void *)child_fn1, (void *)1);
>> +	if (cpid1 < 0)
>> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
>> +
>> +	tst_record_childstatus(cleanup, cpid1);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int lc;
>> +
>> +	setup();
>> +	tst_parse_opts(argc, argv, NULL, NULL);
>> +
>> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +		tst_count = 0;
>> +		test_max_nest();
>> +	}
>> +
>> +	cleanup();
>> +	tst_exit();
>> +}
>> --
>> 1.9.1
>>
>>
> .
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
