Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PR7ae-0004FQ-SG
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:21:08 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PR7ad-0000wP-3e
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:21:08 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBAIL1Yn012926
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Dec 2010 13:21:01 -0500
Date: Fri, 10 Dec 2010 13:21:00 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1688222758.760511292005260897.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2141993321.760371292005215358.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44994_35238069.1292005260896"
Subject: [LTP] [PATCH 1/5] oom01: test OOM
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_44994_35238069.1292005260896
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The previous version of this can be dropped.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/Makefile |   22 +++++
 testcases/kernel/mem/oom/oom01.c  |  169 +++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
new file mode 100644
index 0000000..3634570
--- /dev/null
+++ b/testcases/kernel/mem/oom/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
new file mode 100644
index 0000000..1265faa
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,169 @@
+/*
+ * Out Of Memory (OOM)
+ *
+ * The program is designed to cope with unpredictable like amount and
+ * system physical memory, swap size and other VMM technology like KSM,
+ * memcg, memory hotplug and so on which may affect the OOM
+ * behaviours. It simply increase the memory consumption 3G each time
+ * until all the available memory is consumed and OOM is triggered.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom01";
+int TST_TOTAL = 3;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT	1
+#define NORMAL		2
+#define MLOCK		3
+#define KSM		4
+
+static char overcommit[BUFSIZ];
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "start testing overcommit_memory tunables.");
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "2", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT);
+
+		tst_resm(TINFO, "start normal OOM testing.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(NORMAL);
+
+		tst_resm(TINFO, "start OOM testing for mlocked pages.");
+		oom(MLOCK);
+
+		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		oom(KSM);
+	}
+	tst_exit();
+}
+
+void setup(void)
+{
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	fd = open(SYSFS_OVER, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (read(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void oom(int testcase)
+{
+	pid_t pid;
+	int status;
+	void *s; 
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = mmap(NULL, LENGTH, PROT_READ|PROT_WRITE,
+				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (s == MAP_FAILED) {
+				if (testcase == OVERCOMMIT && errno == ENOMEM)
+					break;
+				else
+					tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+			}
+			if (testcase == MLOCK && mlock(s, LENGTH) == -1)
+				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+			if (testcase == KSM
+				&& madvise(s, LENGTH, MADV_MERGEABLE) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (testcase == OVERCOMMIT) {
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	} else {
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	}
+}
-- 
1.7.3.2
------=_Part_44994_35238069.1292005260896
Content-Type: text/x-patch; name=0001-oom01-test-OOM.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-oom01-test-OOM.patch

From: CAI Qian <caiqian@redhat.com>
Date: Sat, 11 Dec 2010 02:06:59 +0800
Subject: [PATCH 1/5] oom01: test OOM

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/Makefile |   22 +++++
 testcases/kernel/mem/oom/oom01.c  |  169 +++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
new file mode 100644
index 0000000..3634570
--- /dev/null
+++ b/testcases/kernel/mem/oom/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
new file mode 100644
index 0000000..1265faa
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,169 @@
+/*
+ * Out Of Memory (OOM)
+ *
+ * The program is designed to cope with unpredictable like amount and
+ * system physical memory, swap size and other VMM technology like KSM,
+ * memcg, memory hotplug and so on which may affect the OOM
+ * behaviours. It simply increase the memory consumption 3G each time
+ * until all the available memory is consumed and OOM is triggered.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom01";
+int TST_TOTAL = 3;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT	1
+#define NORMAL		2
+#define MLOCK		3
+#define KSM		4
+
+static char overcommit[BUFSIZ];
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "start testing overcommit_memory tunables.");
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "2", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT);
+
+		tst_resm(TINFO, "start normal OOM testing.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(NORMAL);
+
+		tst_resm(TINFO, "start OOM testing for mlocked pages.");
+		oom(MLOCK);
+
+		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		oom(KSM);
+	}
+	tst_exit();
+}
+
+void setup(void)
+{
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	fd = open(SYSFS_OVER, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (read(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void oom(int testcase)
+{
+	pid_t pid;
+	int status;
+	void *s; 
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = mmap(NULL, LENGTH, PROT_READ|PROT_WRITE,
+				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (s == MAP_FAILED) {
+				if (testcase == OVERCOMMIT && errno == ENOMEM)
+					break;
+				else
+					tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+			}
+			if (testcase == MLOCK && mlock(s, LENGTH) == -1)
+				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+			if (testcase == KSM
+				&& madvise(s, LENGTH, MADV_MERGEABLE) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (testcase == OVERCOMMIT) {
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	} else {
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	}
+}
-- 
1.7.3.2


------=_Part_44994_35238069.1292005260896
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_44994_35238069.1292005260896
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_44994_35238069.1292005260896--

