Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PQNTs-0008Qz-Rr
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 17:07:04 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQNTq-0004ek-DE
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 17:07:04 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB8H6vNQ020799
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Dec 2010 12:06:57 -0500
Date: Wed, 8 Dec 2010 12:06:56 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <806083991.512621291828016991.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <581162850.512601291828009758.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33483_1405297271.1291828016990"
Subject: [LTP] oom01: Out Of Memory (OOM)
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

------=_Part_33483_1405297271.1291828016990
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Add a new test - Out Of Memory (OOM)

The program is designed to cope with unpredictable like amount and
system physical memory, swap size and other VMM technology like KSM,
memcg, memory hotplug and so on which may affect the OOM
behaviours. It simply increase the memory consumption 3G each time
until all the available memory is consumed and OOM is triggered.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/oom/Makefile |   22 +++++
 testcases/kernel/mem/oom/oom01.c  |  189 +++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/runtest/mm b/runtest/mm
index 8be3025..0afa3fb 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,5 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+oom01 oom01
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
index 0000000..7dfc9f9
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,189 @@
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
+
+static char overcommit;
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		oom();
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
+void oom(void)
+{
+	pid_t pid;
+	int status, fd;
+	char *s; 
+
+	tst_resm(TINFO, "start testing overcommit_memory tunables.");
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "2", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL) {
+				if (errno == ENOMEM)
+					break;
+				else
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"malloc");
+			}
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "the victim unxpectedly failred: %d", status);
+
+	tst_resm(TINFO, "start basic OOM testing.");
+	if (lseek(fd, SEEK_SET, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+			if (mlock(s, LENGTH) == -1)
+				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
+	close(fd);
+}
-- 
1.7.3.2
------=_Part_33483_1405297271.1291828016990
Content-Type: text/x-patch; name=0001-Add-a-new-test-Out-Of-Memory-OOM.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-Add-a-new-test-Out-Of-Memory-OOM.patch

Add a new test - Out Of Memory (OOM)

The program is designed to cope with unpredictable like amount and
system physical memory, swap size and other VMM technology like KSM,
memcg, memory hotplug and so on which may affect the OOM
behaviours. It simply increase the memory consumption 3G each time
until all the available memory is consumed and OOM is triggered.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm                        |    2 +
 testcases/kernel/mem/oom/Makefile |   22 +++++
 testcases/kernel/mem/oom/oom01.c  |  189 +++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/runtest/mm b/runtest/mm
index 8be3025..0afa3fb 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,5 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+oom01 oom01
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
index 0000000..7dfc9f9
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,189 @@
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
+
+static char overcommit;
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		oom();
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
+void oom(void)
+{
+	pid_t pid;
+	int status, fd;
+	char *s; 
+
+	tst_resm(TINFO, "start testing overcommit_memory tunables.");
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "2", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL) {
+				if (errno == ENOMEM)
+					break;
+				else
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"malloc");
+			}
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "the victim unxpectedly failred: %d", status);
+
+	tst_resm(TINFO, "start basic OOM testing.");
+	if (lseek(fd, SEEK_SET, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = malloc(LENGTH);
+			if (s == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+			if (mlock(s, LENGTH) == -1)
+				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
+	close(fd);
+}
-- 
1.7.3.2


------=_Part_33483_1405297271.1291828016990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF Dev2Dev email is sponsored by:

WikiLeaks The End of the Free Internet
http://p.sf.net/sfu/therealnews-com
------=_Part_33483_1405297271.1291828016990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_33483_1405297271.1291828016990--

