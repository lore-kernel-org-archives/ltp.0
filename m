Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WDUrR-0004RF-Hk
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 08:08:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDUrI-00004z-Lg
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 08:08:01 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1C87VrT004605
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Feb 2014 16:07:31 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 12 Feb 2014 16:06:10 +0800
Message-Id: <1392192370-9976-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <52FB25CE.7090704@cn.fujitsu.com>
References: <52FB25CE.7090704@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] msgrcv/msgrcv07.c: add MSG_EXCEPT,
	MSG_NOERROR flag test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

create a new case to test MSG_EXCEPT, MSG_NOERROR flag for msgrcv(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                                 |   1 +
 runtest/stress.part3                            |   1 +
 runtest/syscalls                                |   1 +
 runtest/syscalls-ipc                            |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c | 177 ++++++++++++++++++++++++
 6 files changed, 182 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 2f8f977..0fffa00 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -489,6 +489,7 @@ msgrcv03 msgrcv03
 msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
+msgrcv07 msgrcv07
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 5703d13..55e9b49 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -412,6 +412,7 @@ msgrcv03 msgrcv03
 msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
+msgrcv07 msgrcv07
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/syscalls b/runtest/syscalls
index 083c240..53bab14 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -642,6 +642,7 @@ msgrcv03 msgrcv03
 msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
+msgrcv07 msgrcv07
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 02b6e45..bd9bf30 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -23,6 +23,7 @@ msgrcv03 msgrcv03
 msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
+msgrcv07 msgrcv07
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index b622244..4fc27f8 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -386,6 +386,7 @@
 /ipc/msgrcv/msgrcv04
 /ipc/msgrcv/msgrcv05
 /ipc/msgrcv/msgrcv06
+/ipc/msgrcv/msgrcv07
 /ipc/msgsnd/msgsnd01
 /ipc/msgsnd/msgsnd02
 /ipc/msgsnd/msgsnd03
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
new file mode 100644
index 0000000..aac0b44
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Description:
+ *     Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
+ */
+
+#define  _GNU_SOURCE
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+#include "ipcmsg.h"
+
+
+#define MSGTYPE1	1
+#define MSGTYPE2	2
+#define MSG1	"message type1"
+#define MSG2	"message type2"
+
+static void wait4child(pid_t child, char *tst_flag);
+
+static void test_msg_except(void);
+static void test_msg_noerror(void);
+
+static void (*testfunc[])(void) = { test_msg_except, test_msg_noerror };
+
+char *TCID = "msgrcv07";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void test_msg_except(void)
+{
+	pid_t child_pid;
+	int msgq_id;
+	MSGBUF snd_buf1 = {.mtype = MSGTYPE1, .mtext = MSG1};
+	MSGBUF snd_buf2 = {.mtype = MSGTYPE2, .mtext = MSG2};
+	MSGBUF rcv_buf;
+
+	msgq_id = msgget(IPC_PRIVATE, MSG_RW);
+	if (msgq_id == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Can't create message queue");
+
+	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
+
+	if (msgsnd(msgq_id, &snd_buf2, MSGSIZE, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
+
+	child_pid = tst_fork();
+	if (child_pid == -1) {
+		tst_brkm(TBROK, cleanup, "fork failed");
+	} else if (child_pid > 0) {
+		wait4child(child_pid, "MSG_EXCEPT");
+	} else {
+		memset(&rcv_buf, 0, sizeof(rcv_buf));
+		TEST(msgrcv(msgq_id, &rcv_buf, MSGSIZE, MSGTYPE2, MSG_EXCEPT));
+		if (TEST_RETURN == -1) {
+			fprintf(stderr, "msgrcv(MSG_EXCEPT) failed\n");
+			exit(TBROK);
+		}
+		/* check the received message */
+		if (strcmp(rcv_buf.mtext, MSG1) == 0 &&
+		    rcv_buf.mtype == MSGTYPE1)
+			exit(TPASS);
+		else
+			exit(TFAIL);
+	}
+
+	rm_queue(msgq_id);
+}
+
+
+static void test_msg_noerror(void)
+{
+	pid_t child_pid;
+	int msg_len, msgq_id;
+	MSGBUF snd_buf1 = {.mtype = MSGTYPE1, .mtext = MSG1};
+	MSGBUF rcv_buf;
+
+	msgq_id = msgget(IPC_PRIVATE, MSG_RW);
+	if (msgq_id == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Can't create message queue");
+
+	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
+
+	child_pid = tst_fork();
+	if (child_pid == -1) {
+		tst_brkm(TBROK, cleanup, "fork failed");
+	} else if (child_pid > 0) {
+		wait4child(child_pid, "MSG_NOERROR");
+	} else {
+		msg_len = sizeof(MSG1) / 2;
+		memset(&rcv_buf, 0, sizeof(rcv_buf));
+
+		TEST(msgrcv(msgq_id, &rcv_buf, msg_len, MSGTYPE1, MSG_NOERROR));
+		if (TEST_RETURN == -1)
+			exit(TFAIL);
+
+		if (strncmp(rcv_buf.mtext, MSG1, msg_len) == 0 &&
+		    rcv_buf.mtype == MSGTYPE1)
+			exit(TPASS);
+		exit(TFAIL);
+	}
+
+	rm_queue(msgq_id);
+}
+
+static void wait4child(pid_t child, char *tst_flag)
+{
+	int status;
+	int ret;
+
+	if (waitpid(child, &status, 0) == -1)
+		tst_resm(TBROK | TERRNO, "waitpid");
+	if (WIFEXITED(status)) {
+		ret = WEXITSTATUS(status);
+		if (ret == 0)
+			tst_resm(TPASS, "test %s success", tst_flag);
+		else if (ret == 1)
+			tst_resm(TFAIL, "test %s failed", tst_flag);
+		else
+			tst_brkm(TBROK, cleanup, "msgrcv failed unexpectedly");
+	} else {
+		tst_brkm(TBROK, cleanup, "child process terminated "
+			 "abnormally. status: %d", status);
+	}
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
