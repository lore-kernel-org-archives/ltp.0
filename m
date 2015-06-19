Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z5wVM-0007R7-Af
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 13:38:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5wVK-0001Kx-6g
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 13:38:48 +0000
Message-ID: <55841B5D.5050608@redhat.com>
Date: Fri, 19 Jun 2015 15:38:37 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1434490094-20593-1-git-send-email-sunyuan3@huawei.com>
In-Reply-To: <1434490094-20593-1-git-send-email-sunyuan3@huawei.com>
Content-Type: multipart/mixed; boundary="------------090609000007020802030803"
Subject: Re: [LTP] [PATCH V3] containers: new testcase userns03
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090609000007020802030803
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 06/16/2015 11:28 PM, Yuan Sun wrote:
>   ID-outside-ns is interpreted according to which process is opening
> the file. If the process opening the file is in the same user namespace
> as the process PID, then ID-outside-ns is defined with respect to the
> parent user namespace. If the process opening the file is in a different
> user namespace, then ID-outside-ns is defined with respect to the user
> namespace of the process opening the file.
>   If kernel version >= 3.19.0, the case will ignore the git check.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Hi,

there is one problem in v3 with synchronization.
Problem is that child2 can start checking it's uid/gid sooner than
main sets the mapping.

I have attached my idea for possible fix, comments about changes I made are below.

> ---
>  runtest/containers                            |   1 +
>  testcases/kernel/containers/.gitignore        |   1 +
>  testcases/kernel/containers/userns/userns03.c | 254 ++++++++++++++++++++++++++
>  3 files changed, 256 insertions(+)
>  create mode 100644 testcases/kernel/containers/userns/userns03.c
> 
> diff --git a/runtest/containers b/runtest/containers
> index bb1beb6..720d0f2 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -70,3 +70,4 @@ mountns04 mountns04
>  
>  userns01 userns01
>  userns02 userns02
> +userns03 userns03
> diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
> index e3c92c9..bd3cb9d 100644
> --- a/testcases/kernel/containers/.gitignore
> +++ b/testcases/kernel/containers/.gitignore
> @@ -5,3 +5,4 @@ mountns/mountns03
>  mountns/mountns04
>  userns/userns01
>  userns/userns02
> +userns/userns03
> diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
> new file mode 100644
> index 0000000..b5596fc
> --- /dev/null
> +++ b/testcases/kernel/containers/userns/userns03.c
> @@ -0,0 +1,254 @@
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

I added comment here about when we set/test gid map.

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
> +static bool setgroupstag = true;
> +
> +#define CHILD1UID 0
> +#define CHILD1GID 0
> +#define CHILD2UID 200
> +#define CHILD2GID 200
> +#define UID_MAP 0
> +#define GID_MAP 1
> +#define UID_MAP 0
> +#define GID_MAP 1

UID_MAP, GID_MAP is defined twice, I deleted one.

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

I added WAIT here, so child doesn't start before main sets the mapping.

> +	uid = geteuid();
> +	gid = getegid();
> +
> +	if (uid == CHILD2UID) {
> +		printf("Got expected uid.\n");

I removed this printf.

> +		exit_val = 0;
> +	} else {
> +		printf("unexpected uid=%d\n", uid);
> +		exit_val = 1;
> +	}
> +
> +	if (setgroupstag == false) {
> +		if (gid == CHILD2GID) {
> +			printf("Got expected gid.\n");
> +			exit_val = 0;
> +		} else {
> +			printf("unexpected: gid=%d\n", gid);
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
> +	if (setgroupstag == false) {
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
> +	if (access("/proc/self/setgroups", F_OK) == 0) {
> +		SAFE_FILE_SCANF(NULL, "/proc/self/setgroups", "%s", read_buf);

added cleanup

> +		if (strcmp(read_buf, "deny") == 0)
> +			setgroupstag = false;
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +static int updatemap(int cpid, bool type, int idnum, int parentmappid)
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
> +		tst_brkm(TFAIL, cleanup, "invalid type parameter");
> +
> +	sprintf(content, "%d %d 1", idnum, parentmappid);
> +	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
> +	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
> +	SAFE_CLOSE(cleanup, fd);
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
> +		if (setgroupstag == false) {
> +			updatemap(cpid1, 1, CHILD1GID, parentuid);
> +			updatemap(cpid2, 1, CHILD2GID, parentuid);
> +		}

calls to updatemap changed to use defines rather than 0/1

Regards,
Jan



--------------090609000007020802030803
Content-Type: text/x-patch;
 name="1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="1.patch"

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index b5596fc..ce400a1 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -1,28 +1,41 @@
 /*
-* Copyright (c) Huawei Technologies Co., Ltd., 2015
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of the GNU General Public License as published by the Free
-* Software Foundation; either version 2 of the License, or (at your option)
-* any later version. This program is distributed in the hope that it will be
-* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-* Public License for more details. You should have received a copy of the GNU
-* General Public License along with this program.
-*/
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version. This program is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+ * Public License for more details. You should have received a copy of the GNU
+ * General Public License along with this program.
+ */
 
 /*
-* Verify that:
-* /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
-* white space:
-* ID-inside-ns   ID-outside-ns   length
-*
-*  ID-outside-ns is interpreted according to which process is opening the file.
-* If the process opening the file is in the same user namespace as the process
-* PID, then ID-outside-ns is defined with respect to the parent user namespace.
-* If the process opening the file is in a different user namespace, then
-* ID-outside-ns is defined with respect to the user namespace of the process
-* opening the file.
-*/
+ * Verify that:
+ * /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
+ * white space:
+ * ID-inside-ns   ID-outside-ns   length
+ *
+ * ID-outside-ns is interpreted according to which process is opening the file.
+ * If the process opening the file is in the same user namespace as the process
+ * PID, then ID-outside-ns is defined with respect to the parent user namespace.
+ * If the process opening the file is in a different user namespace, then
+ * ID-outside-ns is defined with respect to the user namespace of the process
+ * opening the file.
+ *
+ * GID check is skipped if setgroups is allowed, see kernel commits:
+ *
+ *   commit 9cc46516ddf497ea16e8d7cb986ae03a0f6b92f8
+ *   Author: Eric W. Biederman <ebiederm@xmission.com>
+ *   Date:   Tue Dec 2 12:27:26 2014 -0600
+ *     userns: Add a knob to disable setgroups on a per user namespace basis
+ *
+ *   commit 66d2f338ee4c449396b6f99f5e75cd18eb6df272
+ *   Author: Eric W. Biederman <ebiederm@xmission.com>
+ *   Date:   Fri Dec 5 19:36:04 2014 -0600
+ *     userns: Allow setting gid_maps without privilege when setgroups is disabled
+ *
+ */
 
 #define _GNU_SOURCE
 #include <sys/wait.h>
@@ -37,48 +50,44 @@
 #include "libclone.h"
 #include "userns_helper.h"
 
-char *TCID = "user_namespace3";
-int TST_TOTAL = 1;
-static int cpid1, parentuid, parentgid;
-static bool setgroupstag = true;
-
 #define CHILD1UID 0
 #define CHILD1GID 0
 #define CHILD2UID 200
 #define CHILD2GID 200
 #define UID_MAP 0
 #define GID_MAP 1
-#define UID_MAP 0
-#define GID_MAP 1
+
+char *TCID = "user_namespace3";
+int TST_TOTAL = 1;
+static int cpid1, parentuid, parentgid;
+static bool setgroupstag = true;
 
 /*
  * child_fn1() - Inside a new user namespace
  */
 static int child_fn1(void)
 {
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
 	return 0;
 }
 
-
 /*
  * child_fn2() - Inside a new user namespace
  */
 static int child_fn2(void)
 {
-	int exit_val;
+	int exit_val = 0;
 	int uid, gid;
 	char cpid1uidpath[BUFSIZ];
 	char cpid1gidpath[BUFSIZ];
 	int idinsidens, idoutsidens, length;
 
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
+
 	uid = geteuid();
 	gid = getegid();
 
-	if (uid == CHILD2UID) {
-		printf("Got expected uid.\n");
-		exit_val = 0;
-	} else {
+	if (uid != CHILD2UID) {
 		printf("unexpected uid=%d\n", uid);
 		exit_val = 1;
 	}
@@ -143,10 +152,16 @@ static int child_fn2(void)
 			exit_val = 1;
 		}
 	}
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 1);
+
+	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_SAFE_CHECKPOINT_WAKE(NULL, 1);
 	return exit_val;
 }
 
+static void cleanup(void)
+{
+	tst_rmdir();
+}
 
 static void setup(void)
 {
@@ -156,17 +171,13 @@ static void setup(void)
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(NULL);
 	if (access("/proc/self/setgroups", F_OK) == 0) {
-		SAFE_FILE_SCANF(NULL, "/proc/self/setgroups", "%s", read_buf);
+		SAFE_FILE_SCANF(cleanup, "/proc/self/setgroups", "%s",
+			read_buf);
 		if (strcmp(read_buf, "deny") == 0)
 			setgroupstag = false;
 	}
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
 static int updatemap(int cpid, bool type, int idnum, int parentmappid)
 {
 	char path[BUFSIZ];
@@ -181,7 +192,7 @@ static int updatemap(int cpid, bool type, int idnum, int parentmappid)
 		tst_brkm(TFAIL, cleanup, "invalid type parameter");
 
 	sprintf(content, "%d %d 1", idnum, parentmappid);
-	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
 	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
 	SAFE_CLOSE(cleanup, fd);
 	return 0;
@@ -214,18 +225,15 @@ int main(int argc, char *argv[])
 			tst_brkm(TFAIL | TERRNO, cleanup,
 				"cpid2 clone failed");
 
-		updatemap(cpid1, 0, CHILD1UID, parentuid);
-		updatemap(cpid2, 0, CHILD2UID, parentuid);
+		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid);
+		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid);
 
 		if (setgroupstag == false) {
-			updatemap(cpid1, 1, CHILD1GID, parentuid);
-			updatemap(cpid2, 1, CHILD2GID, parentuid);
+			updatemap(cpid1, GID_MAP, CHILD1GID, parentuid);
+			updatemap(cpid2, GID_MAP, CHILD2GID, parentuid);
 		}
 
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 1);
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
+		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
 
 		if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
 			(waitpid(cpid2, &cpid2status, 0) < 0))

--------------090609000007020802030803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------090609000007020802030803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090609000007020802030803--

