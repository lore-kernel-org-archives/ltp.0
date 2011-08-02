Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QoBsr-00019F-NZ
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 10:07:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QoBsq-0002Yi-EY
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 10:07:33 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p72A7QVf005309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Aug 2011 06:07:26 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue,  2 Aug 2011 18:06:46 +0800
Message-Id: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH] mm/ksm05: new testcase
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


KSM - NULL pointer dereference in ksm_do_scan() (CVE-2011-2183)

This is a testcase from upstream commit:
2b472611a32a72f4a118c069c2d62a1a3f087afd.

an exiting task can race against ksmd::scan_get_next_rmap_item
(http://lkml.org/lkml/2011/6/1/742) easily triggering a NULL pointer
dereference in ksmd.
ksm_scan.mm_slot == &ksm_mm_head with only one registered mm

CPU 1 (__ksm_exit)          CPU 2 (scan_get_next_rmap_item)
                            list_empty() is false
lock                        slot == &ksm_mm_head
list_del(slot->mm_list)
(list now empty)
unlock
                             lock
                             slot = list_entry(slot->mm_list.next)
                             (list is empty, so slot is still ksm_mm_head)
                             unlock
                             slot->mm == NULL ... Oops

Close this race by revalidating that the new slot is not simply the list
head again.

Test Prerequisites:

*) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
   distrub the testing as they also change some ksm tunables depends
   on current workloads.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                       |    1 +
 testcases/kernel/mem/ksm/ksm05.c |  187 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm05.c


--------------1.7.6
Content-Type: text/x-patch; name="0001-mm-ksm05-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-ksm05-new-testcase.patch"

diff --git a/runtest/mm b/runtest/mm
index df7d0cb..d240336 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -69,6 +69,7 @@ ksm03 ksm03
 ksm03_1 ksm03 -u 128
 ksm04 ksm04
 ksm04_1 ksm04 -u 128
+ksm05 -I 10
 
 cpuset01 cpuset01 -I 3600
 
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
new file mode 100644
index 0000000..2f6a5f9
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -0,0 +1,187 @@
+/*
+ * KSM - NULL pointer dereference in ksm_do_scan() (CVE-2011-2183)
+ *
+ * This is a testcase from upstream commit:
+ * 2b472611a32a72f4a118c069c2d62a1a3f087afd.
+ *
+ * an exiting task can race against ksmd::scan_get_next_rmap_item
+ * (http://lkml.org/lkml/2011/6/1/742) easily triggering a NULL pointer
+ * dereference in ksmd.
+ * ksm_scan.mm_slot == &ksm_mm_head with only one registered mm
+ *
+ * CPU 1 (__ksm_exit)          CPU 2 (scan_get_next_rmap_item)
+ *                             list_empty() is false
+ * lock                        slot == &ksm_mm_head
+ * list_del(slot->mm_list)
+ * (list now empty)
+ * unlock
+ *                              lock
+ *                              slot = list_entry(slot->mm_list.next)
+ *                              (list is empty, so slot is still ksm_mm_head)
+ *                              unlock
+ *                              slot->mm == NULL ... Oops
+ *
+ * Close this race by revalidating that the new slot is not simply the list
+ * head again.
+ *
+ * Test Prerequisites:
+ *
+ * *) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
+ *    distrub the testing as they also change some ksm tunables depends
+ *    on current workloads.
+ *
+ * Copyright (C) 2011  Red Hat, Inc.
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
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "../include/mem.h"
+
+char *TCID = "ksm05";
+int TST_TOTAL = 1;
+
+#ifdef HAVE_MADV_MERGEABLE
+
+static int is_running;
+
+static void sighandler(int sig);
+
+int main(int argc, char *argv[])
+{
+	int lc, status;
+	long ps;
+	char *msg;
+	pid_t pid;
+	void *ptr;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	ps = sysconf(_SC_PAGESIZE);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			if (posix_memalign(&ptr, ps, ps) < 0)
+				tst_brkm(TBROK|TERRNO, cleanup,
+						"posix_memalign");
+			if (madvise(ptr, ps, MADV_MERGEABLE) < 0)
+				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+			*(char *)NULL = 0; /* SIGSEGV occurs, expected. */
+			exit(0);
+		default:
+			break;
+		}
+		if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	}
+
+	tst_resm(TPASS, "still alive.");
+	cleanup();
+	tst_exit();
+}
+
+static void sighandler(int sig)
+{
+	if (sig == SIGSEGV)
+		tst_exit();
+	else
+		tst_resm(TFAIL, "sighandler received invalid signal:%d", sig);
+}
+
+void setup(void)
+{
+	int fd;
+	char buf[BUFSIZ], s[BUFSIZ];
+
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(2, 6, 32) < 0)
+		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required.");
+
+	tst_sig(FORK, sighandler, cleanup);
+	TEST_PAUSE;
+
+	/* save original /sys/kernel/mm/ksm/run value */
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");
+	fd = open(buf, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (read(fd, s, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	close(fd);
+	is_running = atoi(s);
+
+	/* echo 1 > /sys/kernel/mm/ksm/run */
+	if (is_running != 1) {
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		close(fd);
+	}
+}
+
+void cleanup(void)
+{
+	int fd;
+	char buf[BUFSIZ], s[BUFSIZ];
+
+	/* restore /sys/kernel/mm/ksm/run value */
+	if (is_running != 1) {
+		snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");
+		snprintf(s, BUFSIZ, "%d", is_running);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, s, 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		close(fd);
+	}
+
+	TEST_CLEANUP;
+}
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no MADV_MERGEABLE found.");
+}
+#endif

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. 
Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



