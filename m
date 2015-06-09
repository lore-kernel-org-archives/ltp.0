Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z27zV-0002Ir-Tz
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 01:06:09 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z27zN-0003oE-Un
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 01:06:09 +0000
Message-ID: <55763BE1.5050101@huawei.com>
Date: Tue, 9 Jun 2015 09:05:37 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1433360173-23164-1-git-send-email-sunyuan3@huawei.com>
	<55719C1A.6020502@redhat.com>
In-Reply-To: <55719C1A.6020502@redhat.com>
Subject: Re: [LTP] [PATCH] containers: new testcase userns03
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
     Thanks for your comment. I have sent a V2 patch review.
     If kernel version >= 3.19.0, the case will ignore the gid check. I 
don't add the gid check for
the kernel version(>=3.19.0) in userns03.c, because it would be 
different synchronized
strategy of processes between two kernel version.
     I plan to create a new case userns04 to cover gid check in kernel 
version(>=3.19.0).
     If you have different opinion, please let me know.
     Regards.
         Yuan



On 2015/6/5 20:54, Jan Stancek wrote:
> On 06/03/2015 09:36 PM, Yuan Sun wrote:
>>    ID-outside-ns is interpreted according to which process is opening the file.
>> If the process opening the file is in the same user namespace as the process
>> PID, then ID-outside-ns is defined with respect to the parent user namespace.
>> If the process opening the file is in a different user namespace, then
>> ID-outside-ns is defined with respect to the user namespace of the process
>> opening the file.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> Hi,
>
>> ---
>>   testcases/kernel/containers/userns/userns03.c | 327 ++++++++++++++++++++++++++
>>   1 file changed, 327 insertions(+)
>>   create mode 100644 testcases/kernel/containers/userns/userns03.c
>>
>> diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
>> new file mode 100644
>> index 0000000..d128b78
>> --- /dev/null
>> +++ b/testcases/kernel/containers/userns/userns03.c
>> @@ -0,0 +1,327 @@
>> +/*
>> +* Copyright (c) Huawei Technologies Co., Ltd., 2015
>> +* This program is free software; you can redistribute it and/or modify it
>> +* under the terms of the GNU General Public License as published by the Free
>> +* Software Foundation; either version 2 of the License, or (at your option)
>> +* any later version. This program is distributed in the hope that it will be
>> +* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
>> +* Public License for more details. You should have received a copy of the GNU
>> +* General Public License along with this program.
>> +*/
>> +
>> +/*
>> +* Verify that:
>> +* /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
>> +* white space:
>> +* ID-inside-ns   ID-outside-ns   length
>> +*
>> +*  ID-outside-ns is interpreted according to which process is opening the file.
>> +* If the process opening the file is in the same user namespace as the process
>> +* PID, then ID-outside-ns is defined with respect to the parent user namespace.
>> +* If the process opening the file is in a different user namespace, then
>> +* ID-outside-ns is defined with respect to the user namespace of the process
>> +* opening the file.
>> +*/
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
>> +#include "libclone.h"
>> +#include "userns_helper.h"
>> +
>> +char *TCID = "user_namespace3";
>> +int TST_TOTAL = 1;
>> +
>> +static int p1[2];
>> +static int p2[2];
>> +
>> +#define CHILD1UID 0
>> +#define CHILD1GID 0
>> +#define CHILD2UID 200
>> +#define CHILD2GID 200
>> +
>> +/*
>> + * child_fn1() - Inside a new user namespace
>> + */
>> +static int child_fn1(void)
>> +{
>> +	int exit_val;
>> +	int uid, gid;
>> +	char buf[BUFSIZ];
>> +	pid_t cpid1, cpid2;
> cpid1 is not used for anything
>
>> +	char cpid2uidpath[BUFSIZ];
>> +	char cpid2gidpath[BUFSIZ];
>> +	int idinsidens, idoutsidens, length;
>> +	int parentuid, parentgid;
> see comments in main() about passing these through pipe
>
>> +
>> +	close(p1[1]);
>> +
>> +	if (read(p1[0], buf, BUFSIZ) == -1) {
>> +		printf("Failed to read.\n");
>> +		return 1;
>> +	}
>> +	if (sscanf(buf, "%d %d %d", &cpid2, &parentuid, &parentgid) == -1) {
>> +		printf("Failed to run sscanf\n");
>> +		return 1;
>> +	}
>> +
>> +	cpid1 = getpid();
>> +	uid = geteuid();
>> +	gid = getegid();
>> +
>> +	printf("USERNS test is running in a new user namespace.\n");
> I'd remove this printf, I think it's quite obvious, and there's also same comment couple line above.
>
>> +	if (uid == CHILD1UID && gid == CHILD1GID) {
>> +		printf("Got expected uid and gid.\n");
>> +		exit_val = 0;
>> +	} else {
>> +		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
>> +		exit_val = 1;
>> +	}
>> +
>> +	/*Get the uid parameters of the child_fn1 process.*/
>> +	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	/* map file format:ID-inside-ns   ID-outside-ns   length
>> +	If the process opening the file is in the same user namespace as
>> +	the process PID, then ID-outside-ns is defined with respect to the
>> +	 parent user namespace.*/
>> +	if (idinsidens != CHILD1UID || idoutsidens != parentuid) {
>> +		printf("child_fn1 checks /proc/cpid1/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
> This line is too long.
>
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	sprintf(cpid2uidpath, "/proc/%d/uid_map", cpid2);
>> +	SAFE_FILE_SCANF(NULL, cpid2uidpath, "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	/* If the process opening the file is in a different user namespace,
>> +	then ID-outside-ns is defined with respect to the user namespace
>> +	of the process opening the file.*/
>> +	if (idinsidens != CHILD2UID || idoutsidens != CHILD1UID) {
>> +		printf("child_fn1 checks /proc/cpid2/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	sprintf(cpid2gidpath, "/proc/%d/gid_map", cpid2);
>> +	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	if (idinsidens != CHILD1GID || idoutsidens != parentgid) {
>> +		printf("child_fn1 checks /proc/cpid1/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	SAFE_FILE_SCANF(NULL, cpid2gidpath, "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	if (idinsidens != CHILD2GID || idoutsidens != CHILD1GID) {
>> +		printf("child_fn1 checks /proc/cpid2/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
>> +	return exit_val;
>> +}
>> +
>> +
>> +/*
>> + * child_fn2() - Inside a new user namespace
>> + */
>> +static int child_fn2(void)
> child_fn2 code is almost identical to child_fn1
>
> I'd suggest to change child_fn1 to just
> {
>    TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
>    return 0;
> }
>
> child_fn2 still verifies both cases of reading from same and other namespace
> and you can whole testcase simpler - removing same code and you don't need pipes anymore,
> as you can make all those 3 variables global and set them before you clone child2
>
>> +{
>> +	int exit_val;
>> +	int uid, gid;
>> +	char buf[BUFSIZ];
>> +	pid_t cpid1, cpid2;
>> +	char cpid1uidpath[BUFSIZ];
>> +	char cpid1gidpath[BUFSIZ];
>> +	int idinsidens, idoutsidens, length;
>> +	int parentuid, parentgid;
>> +
>> +	close(p2[1]);
>> +
>> +	if (read(p2[0], buf, BUFSIZ) == -1) {
>> +		printf("Failed to read.\n");
>> +		return 1;
>> +	}
>> +	if (sscanf(buf, "%d %d %d", &cpid1, &parentuid, &parentgid) == -1) {
>> +		printf("Failed to run sscanf\n");
>> +		return 1;
>> +	}
>> +
>> +	cpid2 = getpid();
>> +	uid = geteuid();
>> +	gid = getegid();
>> +
>> +	printf("USERNS test is running in a new user namespace.\n");
>> +	if (uid == CHILD2UID && gid == CHILD2GID) {
>> +		printf("Got expected uid and gid.\n");
>> +		exit_val = 0;
>> +	} else {
>> +		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
>> +		exit_val = 1;
>> +	}
>> +
>> +	/*Get the uid parameters of the child_fn2 process.*/
>> +	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	/* map file format:ID-inside-ns   ID-outside-ns   length
>> +	If the process opening the file is in the same user namespace as
>> +	the process PID, then ID-outside-ns is defined with respect to the
>> +	 parent user namespace.*/
>> +	if (idinsidens != CHILD2UID || idoutsidens != parentuid) {
>> +		printf("child_fn2 checks /proc/cpid2/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	sprintf(cpid1uidpath, "/proc/%d/uid_map", cpid1);
>> +	SAFE_FILE_SCANF(NULL, cpid1uidpath, "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	/* If the process opening the file is in a different user namespace,
>> +	then ID-outside-ns is defined with respect to the user namespace
>> +	of the process opening the file.*/
>> +	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID) {
>> +		printf("child_fn2 checks /proc/cpid1/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
>> +	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
>> +		printf("child_fn2 checks /proc/cpid2/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +
>> +	SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
>> +		&idoutsidens, &length);
>> +
>> +	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
>> +		printf("child_fn1 checks /proc/cpid1/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
>> +			idinsidens, idoutsidens);
>> +		exit_val = 1;
>> +	}
>> +	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 1);
>> +	return exit_val;
>> +}
>> +
>> +
>> +static void setup(void)
>> +{
>> +	check_newuser();
>> +	tst_tmpdir();
>> +	TST_CHECKPOINT_INIT(NULL);
> testcase fails for me on 4.0.4+ as unprivileged user, because
> write to gid_map gets EPERM. You may want to have a look at:
>    commit 66d2f338ee4c449396b6f99f5e75cd18eb6df272
>    Author: Eric W. Biederman <ebiederm@xmission.com>
>    Date:   Fri Dec 5 19:36:04 2014 -0600
>      userns: Allow setting gid_maps without privilege when setgroups is disabled
>
>
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	tst_rmdir();
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	pid_t cpid1, cpid2;
>> +	int parentuid;
>> +	int parentgid;
>> +	char tmp[BUFSIZ];
>> +	char path[BUFSIZ];
>> +	char content[BUFSIZ];
>> +	int fd;
>> +	int cpid1status, cpid2status;
>> +
>> +	tst_parse_opts(argc, argv, NULL, NULL);
>> +	setup();
>> +
> TESTLOOPING is missing
>
>> +	if (pipe(p1) == -1 || pipe(p2) == -1)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "pipe failed");
>> +
>> +
>> +	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
>> +		(void *)child_fn1, NULL);
>> +	if (cpid1 < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "cpid1 clone failed");
>> +
>> +	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
>> +		(void *)child_fn2, NULL);
>> +	if (cpid2 < 0)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "cpid2 clone failed");
>> +
>> +	close(p1[0]);
>> +	close(p2[0]);
>> +
>> +	parentuid = geteuid();
>> +	parentgid = getegid();
>> +
>> +	sprintf(path, "/proc/%d/uid_map", cpid1);
>> +	sprintf(content, "%d %d 1", CHILD1UID, parentuid);
>> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
>> +	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
> This calls for some kind of helper function, rather than copy-pasting
> almost same lines.
>
>> +
>> +	sprintf(path, "/proc/%d/gid_map", cpid1);
>> +	sprintf(content, "%d %d 1", CHILD1UID, parentgid);
>                                      ^^ This should be *GID
>
>> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
>> +	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
>> +
>> +	sprintf(path, "/proc/%d/uid_map", cpid2);
>> +	sprintf(content, "%d %d 1", CHILD2UID, parentuid);
>> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
>> +	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
>> +
>> +	sprintf(path, "/proc/%d/gid_map", cpid2);
>> +	sprintf(content, "%d %d 1", CHILD2UID, parentgid);
>                                      ^^ This should be *GID
>
>> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
>> +	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
>> +
>> +	sprintf(tmp, "%d %d %d", cpid2, parentuid, parentgid);
>> +	if (write(p1[1], tmp, strlen(tmp)+1) == -1)
>> +		tst_resm(TFAIL, "Failed to write.");
>> +
>> +	sprintf(tmp, "%d %d %d", cpid1, parentuid, parentgid);
>> +	if (write(p2[1], tmp, strlen(tmp)+1) == -1)
>> +		tst_resm(TFAIL, "Failed to write.");
> Converting these integers to string and then back seems pointless.
>
> If you make child_fn1 dummy, you don't need pipes at all.
> Just make cpid1, parentuid, parentgid static and global and set them
> before you clone child2.
>
>> +
>> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
>> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
>> +	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
>> +	TST_SAFE_CHECKPOINT_WAKE(NULL, 1);
>> +
>> +	if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
>> +		(waitpid(cpid2, &cpid2status, 0) < 0))
>> +		tst_resm(TBROK | TERRNO, "parent: waitpid failed.");
>> +
>> +	if (WIFSIGNALED(cpid1status)) {
>> +		tst_resm(TBROK | TERRNO, "child1 was killed with signal = %d",
> TERRNO here and in all calls below can be removed.
>
> Regards,
> Jan
>
>> +			WTERMSIG(cpid1status));
>> +	} else if (WIFEXITED(cpid1status) && WEXITSTATUS(cpid1status) != 0) {
>> +		tst_resm(TBROK | TERRNO, "child1 exited abnormally");
>> +	}
>> +
>> +	if (WIFSIGNALED(cpid2status)) {
>> +		tst_resm(TBROK | TERRNO, "child2 was killed with signal = %d",
>> +			WTERMSIG(cpid2status));
>> +	} else if (WIFEXITED(cpid2status) && WEXITSTATUS(cpid2status) != 0) {
>> +		tst_resm(TBROK | TERRNO, "child2 exited abnormally");
>> +	}
>> +
>> +	tst_resm(TPASS, "the uid and the gid are right inside the container");
>> +
>> +	tst_exit();
>> +}
>> +
>>
>
> .
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
