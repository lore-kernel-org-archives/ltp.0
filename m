Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZNFXa-0007nI-8e
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 07:24:38 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZNFXU-0006PW-Cf
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 07:24:38 +0000
Message-ID: <55C30B95.9050107@huawei.com>
Date: Thu, 6 Aug 2015 15:24:05 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1437570025-3897-1-git-send-email-sunyuan3@huawei.com>
	<679430614.4320565.1438777516195.JavaMail.zimbra@redhat.com>
In-Reply-To: <679430614.4320565.1438777516195.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] container: new testcase pidns32
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
     The limitation is added by the following patch. In some old kernel
versions, no limitation is applied. I suggest that tst_kvercmp should be
used in this case.

commit f2302505775fd13ba93f034206f1e2a587017929
Author: Andrew Vagin <avagin@openvz.org>
Date:   Thu Oct 25 13:38:07 2012 -0700

     pidns: limit the nesting depth of pid namespaces

     'struct pid' is a "variable sized struct" - a header with an array of
     upids at the end.

     The size of the array depends on a level (depth) of pid 
namespaces.  Now a
     level of pidns is not limited, so 'struct pid' can be more than one 
page.

     Looks reasonable, that it should be less than a page. 
MAX_PIS_NS_LEVEL is
     not calculated from PAGE_SIZE, because in this case it depends on
     architectures, config options and it will be reduced, if someone adds a
     new fields in struct pid or struct upid.

     I suggest to set MAX_PIS_NS_LEVEL = 32, because it saves ability to 
expand
     "struct pid" and it's more than enough for all known for me use-cases.
     When someone finds a reasonable use case, we can add a config 
option or a
     sysctl parameter.

     In addition it will reduce the effect of another problem, when we have
     many nested namespaces and the oldest one starts dying.
     zap_pid_ns_processe will be called for each namespace and find_vpid 
will
     be called for each process in a namespace.  find_vpid will be called
     minimum max_level^2 / 2 times.  The reason of that is that when we 
found a
     bit in pidmap, we can't determine this pidns is top for this 
process or it
     isn't.

     vpid is a heavy operation, so a fork bomb, which create many nested
     namespace, can make a system inaccessible for a long time.  For 
example my
     system becomes inaccessible for a few minutes with 4000 processes.


Regards,
     Yuan

On 2015/8/5 20:25, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 22 July, 2015 3:00:25 PM
>> Subject: [PATCH] container: new testcase pidns32
>>
> Hi,
>
>> Kernel imposes a limit of 32 nested levels of pid namespaces.
> I have some concerns about this number. It looks more like
> implementation detail. Also it doesn't seem to apply for all
> kernels out there.
>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
>> ---
>>   testcases/kernel/containers/pidns/.gitignore |   1 +
>>   testcases/kernel/containers/pidns/pidns32.c  | 113
> You're missing runtest entry.
>
>>   +++++++++++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>   create mode 100644 testcases/kernel/containers/pidns/pidns32.c
>>
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
>> index 0000000..8a4459b
>> --- /dev/null
>> +++ b/testcases/kernel/containers/pidns/pidns32.c
>> @@ -0,0 +1,113 @@
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
>> + * The kernel imposes a limit of 32 nested levels of pid namespaces.
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
> This should probably include tst_require_root too, since CLONE_NEWPID requires CAP_SYS_ADMIN.
>
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
> You are relying on clone failing and you check level only after that.
> If I take sufficiently old kernel (which doesn't impose 32 levels as maximum),
> the testcase runs until it's killed by OOM.
>
>> +	if (cpid1 < 0) {
>> +		if (level == (MAXNEST))
>> +			return 0;
>> +		return 1;
>> +	}
>> +	if (waitpid(cpid1, NULL, 0) == -1)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static int wait4child(pid_t pid, const char *msg)
>> +{
>> +	int status;
>> +
>> +	if (waitpid(pid, &status, 0) == -1) {
>> +		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
>> +	} else if (WIFSIGNALED(status)) {
>> +		tst_resm(TFAIL, "%s: child was killed with signal = %d",
>> +			msg, WTERMSIG(status));
>> +		return WTERMSIG(status);
>> +	} else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
>> +		tst_resm(TFAIL, "%s: child returns %d", msg, status);
>> +		return WEXITSTATUS(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void test_max_nest(void)
>> +{
>> +	pid_t cpid1;
>> +	int status;
>> +
>> +	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
>> +		(void *)child_fn1, (void *)1);
>> +	if (cpid1 < 0)
>> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
>> +
>> +	status = 0;
>> +	status |= wait4child(cpid1, "child1");
>> +	if (status == 0)
>> +		tst_resm(TPASS, "The function works well.");
>> +	else
>> +		tst_resm(TFAIL, "Some child reported failure.");
> This can be replaced by using tst_record_childstatus().
>
> Regards,
> Jan
>
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
