Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZMUd6-0002bA-Kk
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 05:19:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMUd4-0005bl-Ug
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 05:19:12 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id EAF1F8CF65
	for <ltp-list@lists.sourceforge.net>;
	Tue,  4 Aug 2015 05:19:04 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t745J02D004564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2015 01:19:03 -0400
From: Li Wang <liwang@redhat.com>
Date: Tue,  4 Aug 2015 13:18:56 +0800
Message-Id: <1438665536-24945-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] ipc/msgrcv: add new testcase msgrcv08
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

system call msgrcv() from 32-bit application shows error:
"msgrcv: No message of desired type"

This simple program is writen for the issue as an regression case.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/ltplite                                 |   1 +
 runtest/syscalls                                |   1 +
 runtest/syscalls-ipc                            |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c | 135 ++++++++++++++++++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 3bc681c..2b204e8 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -496,6 +496,7 @@ msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
+msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/syscalls b/runtest/syscalls
index 70d4945..abdb146 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -662,6 +662,7 @@ msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
+msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index bd9bf30..5592a00 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -24,6 +24,7 @@ msgrcv04 msgrcv04
 msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
+msgrcv08 msgrcv08
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 172aeec..3d38d86 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -400,6 +400,7 @@
 /ipc/msgrcv/msgrcv05
 /ipc/msgrcv/msgrcv06
 /ipc/msgrcv/msgrcv07
+/ipc/msgrcv/msgrcv08
 /ipc/msgsnd/msgsnd01
 /ipc/msgsnd/msgsnd02
 /ipc/msgsnd/msgsnd03
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
new file mode 100644
index 0000000..89bfe2c
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -0,0 +1,135 @@
+/*
+ * Copyright (c) 2015   Author: Gabriellla Schmidt <gsc@bruker.de>
+ *                      Modify: Li Wang <liwang@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * you should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Description:
+ *
+ * A regression test for:
+ *      commit e7ca2552369c1dfe0216c626baf82c3d83ec36bb
+ *      Author: Mateusz Guzik <mguzik@redhat.com>
+ *      Date:   Mon Jan 27 17:07:11 2014 -0800
+ *
+ *           ipc: fix compat msgrcv with negative msgtyp
+ *
+ * Reproduce:
+ *
+ *      32-bit application using the msgrcv() system call
+ *      gives the error message:
+ *
+ *           msgrcv: No message of desired type
+ *
+ *      If this progarm is compiled as 64-bit application it works.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include "test.h"
+
+const char *TCID = "msgrcv08";
+const int TST_TOTAL = 1;
+
+#if __WORDSIZE == 32
+
+struct msgbuf {
+	long mtype;     /* message type, must be > 0 */
+	char mtext[16]; /* message data */
+};
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+}
+
+static int msr(int msqid)
+{
+	struct msgbuf msbs;
+	struct msgbuf msbr;
+	ssize_t sret;
+	long   mtype = 121;
+
+	memset(&msbs, 0, sizeof(msbs));
+	msbs.mtype = mtype;
+
+	if (msgsnd(msqid, &msbs, sizeof(msbs.mtext), IPC_NOWAIT))
+		tst_brkm(TBROK, NULL, "msgsnd error");
+
+	sret = msgrcv(msqid, &msbr, sizeof(msbr.mtext), -mtype, IPC_NOWAIT | MSG_NOERROR);
+
+	if (sret < 0) {
+		tst_resm(TFAIL, "Bug: No message of desired type.");
+		return -1;
+	}
+
+	if (msbr.mtype != mtype)
+		tst_brkm(TBROK, NULL,
+			"found mtype %ld, expected %ld\n", msbr.mtype, mtype);
+
+	if ((size_t)sret != sizeof(msbs.mtext))
+		tst_brkm(TBROK, NULL, "received %lu, expected %lu\n",
+			(unsigned long)sret, (unsigned long)sizeof(msbs.mtext));
+
+	return 0;
+}
+
+static void msgrcv_test(void)
+{
+	int ret;
+	int msqid = msgget(IPC_PRIVATE, IPC_CREAT | IPC_EXCL | 0666);
+
+	if (msqid < 0)
+		tst_brkm(TBROK, NULL, "msgget error");
+
+	ret = msr(msqid);
+
+	if (msgctl(msqid, IPC_RMID, 0))
+		tst_brkm(TBROK, NULL, "msgctl error");
+
+	if (!ret)
+		tst_resm(TPASS, "Hi, no regression found!");
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++)
+		msgrcv_test();
+
+	cleanup();
+	tst_exit();
+}
+
+#else /* no 64-bit */
+int main(void)
+{
+		tst_brkm(TCONF, NULL, "not works when compiled as 64-bit application.");
+}
+#endif
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
