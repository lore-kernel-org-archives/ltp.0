Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZL6Ps-0000w8-4c
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 09:15:48 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZL6Po-0003PA-1G
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 09:15:48 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Fri, 31 Jul 2015 17:15:46 +0800
Message-ID: <1438334146-32590-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH V2] containers: new testcase userns06
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

When a process with non-zero user IDs performs an execve(), the
process's capability sets are cleared. When a process with zero
user IDs performs an execve(), the process's capability sets are
set.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 runtest/containers                                 |   1 +
 testcases/kernel/containers/.gitignore             |   2 +
 testcases/kernel/containers/userns/userns03.c      |  28 +---
 testcases/kernel/containers/userns/userns06.c      | 174 +++++++++++++++++++++
 .../kernel/containers/userns/userns06_capcheck.c   |  74 +++++++++
 testcases/kernel/containers/userns/userns_helper.h |  25 +++
 6 files changed, 280 insertions(+), 24 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/userns06.c
 create mode 100644 testcases/kernel/containers/userns/userns06_capcheck.c

diff --git a/runtest/containers b/runtest/containers
index de4197e..a9eb4b3 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -72,3 +72,4 @@ userns01 userns01
 userns02 userns02
 userns03 userns03
 userns04 userns04
+userns06 userns06
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index 85ced78..46a7609 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -7,3 +7,5 @@ userns/userns01
 userns/userns02
 userns/userns03
 userns/userns04
+userns/userns06_capcheck
+userns/userns06
diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index 4e12ff1..9b8ede5 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -162,26 +162,6 @@ static void setup(void)
 		setgroupstag = false;
 }
 
-static int updatemap(int cpid, bool type, int idnum, int parentmappid)
-{
-	char path[BUFSIZ];
-	char content[BUFSIZ];
-	int fd;
-
-	if (type == UID_MAP)
-		sprintf(path, "/proc/%d/uid_map", cpid);
-	else if (type == GID_MAP)
-		sprintf(path, "/proc/%d/gid_map", cpid);
-	else
-		tst_brkm(TBROK, cleanup, "invalid type parameter");
-
-	sprintf(content, "%d %d 1", idnum, parentmappid);
-	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
-	SAFE_CLOSE(cleanup, fd);
-	return 0;
-}
-
 int main(int argc, char *argv[])
 {
 	pid_t cpid2;
@@ -223,11 +203,11 @@ int main(int argc, char *argv[])
 			SAFE_CLOSE(cleanup, fd);
 		}
 
-		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid);
-		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid);
+		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid, cleanup);
+		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid, cleanup);
 
-		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid);
-		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid);
+		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid, cleanup);
+		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid, cleanup);
 
 		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
 
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
new file mode 100644
index 0000000..07fb964
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -0,0 +1,174 @@
+/*
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
+
+/*
+ * Verify that:
+ * When a process with non-zero user IDs performs an execve(), the process's
+ * capability sets are cleared.
+ * When a process with zero user IDs performs an execve(), the process's
+ * capability sets are set.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include "libclone.h"
+#include "test.h"
+#include "config.h"
+
+#ifdef HAVE_SYS_CAPABILITY_H
+#include "userns_helper.h"
+#include <sys/capability.h>
+#endif
+
+#define CHILD1UID 0
+#define CHILD1GID 0
+#define CHILD2UID 200
+#define CHILD2GID 200
+
+char *TCID = "user_namespace6";
+int TST_TOTAL = 1;
+
+#ifdef HAVE_LIBCAP
+static int cpid1, parentuid, parentgid;
+
+/*
+ * child_fn1() - Inside a new user namespace
+ */
+static int child_fn1(void)
+{
+	int exit_val = 0;
+	char *const args[] = { "userns06_capcheck", "privileged" };
+
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+
+	if (execve(args[0], args, NULL) == -1) {
+		printf("execvp unexpected error: (%d) %s\n",
+			errno, strerror(errno));
+		exit_val = 1;
+	}
+
+	return exit_val;
+}
+
+/*
+ * child_fn2() - Inside a new user namespace
+ */
+static int child_fn2(void)
+{
+	int exit_val = 0;
+	int uid, gid;
+	char *const args[] = { "userns06_capcheck", "unprivileged" };
+
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
+
+	uid = geteuid();
+	gid = getegid();
+
+	if (uid != CHILD2UID || gid != CHILD2GID) {
+		printf("unexpected uid=%d gid=%d\n", uid, gid);
+		exit_val = 1;
+	}
+
+	if (execve(args[0], args, NULL) == -1) {
+		printf("execvp unexpected error: (%d) %s\n",
+			errno, strerror(errno));
+		exit_val = 1;
+	}
+
+	return exit_val;
+}
+#endif
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+#ifdef HAVE_LIBCAP
+	check_newuser();
+#endif
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(NULL);
+	TST_RESOURCE_COPY(cleanup, "userns06_capcheck", NULL);
+}
+
+int main(int argc, char *argv[])
+{
+#ifdef HAVE_LIBCAP
+	pid_t cpid2;
+	char path[BUFSIZ];
+	int lc;
+	int fd;
+#endif
+	tst_parse_opts(argc, argv, NULL, NULL);
+	setup();
+
+#ifdef HAVE_LIBCAP
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		parentuid = geteuid();
+		parentgid = getegid();
+
+		cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+			(void *)child_fn1, NULL);
+		if (cpid1 < 0)
+			tst_brkm(TBROK | TERRNO, cleanup,
+				"cpid1 clone failed");
+
+		cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
+			(void *)child_fn2, NULL);
+		if (cpid2 < 0)
+			tst_brkm(TBROK | TERRNO, cleanup,
+				"cpid2 clone failed");
+
+		if (access("/proc/self/setgroups", F_OK) == 0) {
+			sprintf(path, "/proc/%d/setgroups", cpid1);
+			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
+			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
+			SAFE_CLOSE(cleanup, fd);
+
+			sprintf(path, "/proc/%d/setgroups", cpid2);
+			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
+			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
+			SAFE_CLOSE(cleanup, fd);
+		}
+
+		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid, cleanup);
+		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid, cleanup);
+
+		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid, cleanup);
+		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid, cleanup);
+
+		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+		TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
+
+		tst_record_childstatus(cleanup, cpid1);
+		tst_record_childstatus(cleanup, cpid2);
+	}
+#else
+	tst_brkm(TCONF, cleanup, "HAVE_LIBCAP not supported");
+#endif
+	cleanup();
+	tst_exit();
+}
+
diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
new file mode 100644
index 0000000..1e62284
--- /dev/null
+++ b/testcases/kernel/containers/userns/userns06_capcheck.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
+/*
+ * Verify that:
+ * When a process with non-zero user IDs performs an execve(), the
+ * process's capability sets are cleared. When a process with zero
+ * user IDs performs an execve(), the process's capability sets
+ * are set.
+ */
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
+#include "config.h"
+#if HAVE_SYS_CAPABILITY_H
+#include <sys/capability.h>
+#endif
+
+char *TCID = "execvpcapability";
+int TST_TOTAL = 1;
+
+int main(int argc, char *argv[])
+{
+#ifdef HAVE_LIBCAP
+	cap_t caps;
+	int i, last_cap;
+	cap_flag_value_t flag_val;
+	cap_flag_value_t expected_flag = 1;
+#endif
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+#ifdef HAVE_LIBCAP
+	if (strcmp("privileged", argv[1]))
+		expected_flag = 0;
+
+	caps = cap_get_proc();
+	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+	for (i = 0; i <= last_cap; i++) {
+		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
+		if (flag_val != expected_flag)
+			break;
+		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
+		if (flag_val != expected_flag)
+			break;
+	}
+
+	if (flag_val != expected_flag) {
+		printf("unexpected effective/permitted caps at %d\n", i);
+		exit(1);
+	}
+
+#else
+	printf("System is missing libcap.\n");
+#endif
+	tst_exit();
+}
diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
index da03bae..c48c7ad 100644
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ b/testcases/kernel/containers/userns/userns_helper.h
@@ -14,6 +14,10 @@
 #include "../libclone/libclone.h"
 #include "test.h"
 #include "safe_macros.h"
+#include <stdbool.h>
+
+#define UID_MAP 0
+#define GID_MAP 1
 
 static int dummy_child(void *v)
 {
@@ -35,3 +39,24 @@ static int check_newuser(void)
 
 	return 0;
 }
+
+static int updatemap(int cpid, bool type, int idnum, int parentmappid,
+	void (*cleanup)(void))
+{
+	char path[BUFSIZ];
+	char content[BUFSIZ];
+	int fd;
+
+	if (type == UID_MAP)
+		sprintf(path, "/proc/%d/uid_map", cpid);
+	else if (type == GID_MAP)
+		sprintf(path, "/proc/%d/gid_map", cpid);
+	else
+		tst_brkm(TBROK, cleanup, "invalid type parameter");
+
+	sprintf(content, "%d %d 1", idnum, parentmappid);
+	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
+	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
+	SAFE_CLOSE(cleanup, fd);
+	return 0;
+}
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
