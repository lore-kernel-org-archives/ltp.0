Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z06wd-0003j7-LR
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 11:34:51 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z06wV-0007vS-DF
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 11:34:51 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 3 Jun 2015 13:36:13 -0600
Message-ID: <1433360173-23164-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] containers: new testcase userns03
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

  ID-outside-ns is interpreted according to which process is opening the file.
If the process opening the file is in the same user namespace as the process
PID, then ID-outside-ns is defined with respect to the parent user namespace.
If the process opening the file is in a different user namespace, then
ID-outside-ns is defined with respect to the user namespace of the process
opening the file.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/userns03.c | 327 ++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)
 create mode 100644 testcases/kernel/containers/userns/userns03.c

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
new file mode 100644
index 0000000..d128b78
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -0,0 +1,327 @@
+/*
+* Copyright (c) Huawei Technologies Co., Ltd., 2015
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of the GNU General Public License as published by the Free
+* Software Foundation; either version 2 of the License, or (at your option)
+* any later version. This program is distributed in the hope that it will be
+* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+* Public License for more details. You should have received a copy of the GNU
+* General Public License along with this program.
+*/
+
+/*
+* Verify that:
+* /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
+* white space:
+* ID-inside-ns   ID-outside-ns   length
+*
+*  ID-outside-ns is interpreted according to which process is opening the file.
+* If the process opening the file is in the same user namespace as the process
+* PID, then ID-outside-ns is defined with respect to the parent user namespace.
+* If the process opening the file is in a different user namespace, then
+* ID-outside-ns is defined with respect to the user namespace of the process
+* opening the file.
+*/
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include "test.h"
+#include "libclone.h"
+#include "userns_helper.h"
+
+char *TCID = "user_namespace3";
+int TST_TOTAL = 1;
+
+static int p1[2];
+static int p2[2];
+
+#define CHILD1UID 0
+#define CHILD1GID 0
+#define CHILD2UID 200
+#define CHILD2GID 200
+
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void)
+{
+	int exit_val;
+	int uid, gid;
+	char buf[BUFSIZ];
+	pid_t cpid1, cpid2;
+	char cpid2uidpath[BUFSIZ];
+	char cpid2gidpath[BUFSIZ];
+	int idinsidens, idoutsidens, length;
+	int parentuid, parentgid;
+
+	close(p1[1]);
+
+	if (read(p1[0], buf, BUFSIZ) == -1) {
+		printf("Failed to read.\n");
+		return 1;
+	}
+	if (sscanf(buf, "%d %d %d", &cpid2, &parentuid, &parentgid) == -1) {
+		printf("Failed to run sscanf\n");
+		return 1;
+	}
+
+	cpid1 = getpid();
+	uid = geteuid();
+	gid = getegid();
+
+	printf("USERNS test is running in a new user namespace.\n");
+	if (uid == CHILD1UID && gid == CHILD1GID) {
+		printf("Got expected uid and gid.\n");
+		exit_val = 0;
+	} else {
+		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
+		exit_val = 1;
+	}
+
+	/*Get the uid parameters of the child_fn1 process.*/
+	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	/* map file format:ID-inside-ns   ID-outside-ns   length
+	If the process opening the file is in the same user namespace as
+	the process PID, then ID-outside-ns is defined with respect to the
+	 parent user namespace.*/
+	if (idinsidens != CHILD1UID || idoutsidens != parentuid) {
+		printf("child_fn1 checks /proc/cpid1/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	sprintf(cpid2uidpath, "/proc/%d/uid_map", cpid2);
+	SAFE_FILE_SCANF(NULL, cpid2uidpath, "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	/* If the process opening the file is in a different user namespace,
+	then ID-outside-ns is defined with respect to the user namespace
+	of the process opening the file.*/
+	if (idinsidens != CHILD2UID || idoutsidens != CHILD1UID) {
+		printf("child_fn1 checks /proc/cpid2/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	sprintf(cpid2gidpath, "/proc/%d/gid_map", cpid2);
+	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	if (idinsidens != CHILD1GID || idoutsidens != parentgid) {
+		printf("child_fn1 checks /proc/cpid1/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	SAFE_FILE_SCANF(NULL, cpid2gidpath, "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	if (idinsidens != CHILD2GID || idoutsidens != CHILD1GID) {
+		printf("child_fn1 checks /proc/cpid2/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	return exit_val;
+}
+
+
+/*
+ * child_fn2() - Inside a new user namespace
+ */
+static int child_fn2(void)
+{
+	int exit_val;
+	int uid, gid;
+	char buf[BUFSIZ];
+	pid_t cpid1, cpid2;
+	char cpid1uidpath[BUFSIZ];
+	char cpid1gidpath[BUFSIZ];
+	int idinsidens, idoutsidens, length;
+	int parentuid, parentgid;
+
+	close(p2[1]);
+
+	if (read(p2[0], buf, BUFSIZ) == -1) {
+		printf("Failed to read.\n");
+		return 1;
+	}
+	if (sscanf(buf, "%d %d %d", &cpid1, &parentuid, &parentgid) == -1) {
+		printf("Failed to run sscanf\n");
+		return 1;
+	}
+
+	cpid2 = getpid();
+	uid = geteuid();
+	gid = getegid();
+
+	printf("USERNS test is running in a new user namespace.\n");
+	if (uid == CHILD2UID && gid == CHILD2GID) {
+		printf("Got expected uid and gid.\n");
+		exit_val = 0;
+	} else {
+		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
+		exit_val = 1;
+	}
+
+	/*Get the uid parameters of the child_fn2 process.*/
+	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	/* map file format:ID-inside-ns   ID-outside-ns   length
+	If the process opening the file is in the same user namespace as
+	the process PID, then ID-outside-ns is defined with respect to the
+	 parent user namespace.*/
+	if (idinsidens != CHILD2UID || idoutsidens != parentuid) {
+		printf("child_fn2 checks /proc/cpid2/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	sprintf(cpid1uidpath, "/proc/%d/uid_map", cpid1);
+	SAFE_FILE_SCANF(NULL, cpid1uidpath, "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	/* If the process opening the file is in a different user namespace,
+	then ID-outside-ns is defined with respect to the user namespace
+	of the process opening the file.*/
+	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID) {
+		printf("child_fn2 checks /proc/cpid1/uid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
+	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
+		printf("child_fn2 checks /proc/cpid2/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+
+	SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
+		&idoutsidens, &length);
+
+	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
+		printf("child_fn1 checks /proc/cpid1/gid_map:Got unexpected result of idinsidens=%d idoutsidens=%d\n",
+			idinsidens, idoutsidens);
+		exit_val = 1;
+	}
+	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 1);
+	return exit_val;
+}
+
+
+static void setup(void)
+{
+	check_newuser();
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(NULL);
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t cpid1, cpid2;
+	int parentuid;
+	int parentgid;
+	char tmp[BUFSIZ];
+	char path[BUFSIZ];
+	char content[BUFSIZ];
+	int fd;
+	int cpid1status, cpid2status;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+	if (pipe(p1) == -1 || pipe(p2) == -1)
+		tst_brkm(TFAIL | TERRNO, cleanup, "pipe failed");
+
+
+	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+		(void *)child_fn1, NULL);
+	if (cpid1 < 0)
+		tst_brkm(TFAIL | TERRNO, cleanup, "cpid1 clone failed");
+
+	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+		(void *)child_fn2, NULL);
+	if (cpid2 < 0)
+		tst_brkm(TFAIL | TERRNO, NULL, "cpid2 clone failed");
+
+	close(p1[0]);
+	close(p2[0]);
+
+	parentuid = geteuid();
+	parentgid = getegid();
+
+	sprintf(path, "/proc/%d/uid_map", cpid1);
+	sprintf(content, "%d %d 1", CHILD1UID, parentuid);
+	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+
+	sprintf(path, "/proc/%d/gid_map", cpid1);
+	sprintf(content, "%d %d 1", CHILD1UID, parentgid);
+	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+
+	sprintf(path, "/proc/%d/uid_map", cpid2);
+	sprintf(content, "%d %d 1", CHILD2UID, parentuid);
+	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+
+	sprintf(path, "/proc/%d/gid_map", cpid2);
+	sprintf(content, "%d %d 1", CHILD2UID, parentgid);
+	fd = SAFE_OPEN(NULL, path, O_WRONLY, 0644);
+	SAFE_WRITE(NULL, 1, fd, content, strlen(content));
+
+	sprintf(tmp, "%d %d %d", cpid2, parentuid, parentgid);
+	if (write(p1[1], tmp, strlen(tmp)+1) == -1)
+		tst_resm(TFAIL, "Failed to write.");
+
+	sprintf(tmp, "%d %d %d", cpid1, parentuid, parentgid);
+	if (write(p2[1], tmp, strlen(tmp)+1) == -1)
+		tst_resm(TFAIL, "Failed to write.");
+
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
+	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_SAFE_CHECKPOINT_WAKE(NULL, 1);
+
+	if ((waitpid(cpid1, &cpid1status, 0) < 0) ||
+		(waitpid(cpid2, &cpid2status, 0) < 0))
+		tst_resm(TBROK | TERRNO, "parent: waitpid failed.");
+
+	if (WIFSIGNALED(cpid1status)) {
+		tst_resm(TBROK | TERRNO, "child1 was killed with signal = %d",
+			WTERMSIG(cpid1status));
+	} else if (WIFEXITED(cpid1status) && WEXITSTATUS(cpid1status) != 0) {
+		tst_resm(TBROK | TERRNO, "child1 exited abnormally");
+	}
+
+	if (WIFSIGNALED(cpid2status)) {
+		tst_resm(TBROK | TERRNO, "child2 was killed with signal = %d",
+			WTERMSIG(cpid2status));
+	} else if (WIFEXITED(cpid2status) && WEXITSTATUS(cpid2status) != 0) {
+		tst_resm(TBROK | TERRNO, "child2 exited abnormally");
+	}
+
+	tst_resm(TPASS, "the uid and the gid are right inside the container");
+
+	tst_exit();
+}
+
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
