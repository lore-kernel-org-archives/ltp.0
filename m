Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PPs3w-0007W5-VN
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:34:12 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PPs3v-0008Jv-Ch
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:34:12 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB77Y6Wl029711
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 02:34:06 -0500
Date: Tue, 7 Dec 2010 02:34:05 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1066118806.253351291707245941.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <507792947.253331291707242881.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17388_1797519330.1291707245940"
Subject: [LTP] [PATCH v2] Stack size mapping is decreased through
 mlock/munlock call
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

------=_Part_17388_1797519330.1291707245940
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is to test kernel if it has a problem with shortening [stack]
mapping through several loops of  mlock/munlock of /proc/self/maps.

From:
munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]

To:
munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]

With more iterations - could drop to 0KiB.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: fix typos; code cleanup
---
 runtest/mm                                |    2 +
 testcases/kernel/syscalls/mlock/mlock03.c |  120 +++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mlock/mlock03.c

diff --git a/runtest/mm b/runtest/mm
index 16e60d4..fabfab1 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,3 +70,5 @@ hugemmap05_3 hugemmap05 -s -m
 cpuset01 cpuset01 -I 3600
 
 mbind01 mbind01
+
+mlock03 mlock03 -i 20
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
new file mode 100644
index 0000000..d11e42d
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -0,0 +1,120 @@
+/*
+ * Stack size mapping is decreased through mlock/munlock call.
+ *
+ * This is to test kernel if it has a problem with shortening [stack]
+ * mapping through several loops of mlock/munlock of /proc/self/maps.
+ *
+ * From:
+ * munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]
+ *
+ * To:
+ * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
+ *
+ * with more iterations - could drop to 0KiB.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
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
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include "test.h"
+#include "usctest.h"
+
+#define KB 1024
+
+char *TCID = "mlock03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	long from, to, first = -1, last = -1;
+	char b[KB];
+	FILE *fp;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		fp = fopen("/proc/self/maps", "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		while (!feof(fp)) {
+			if (!fgets(b, KB - 1, fp))
+				break;
+			b[strlen(b) - 1] = '\0';
+			sscanf(b, "%lx-%lx", &from, &to);
+
+			/* Record the initial stack size. */
+			if ((lc == 0) && (strstr(b, "[stack]") != NULL))
+				first = (to - from)/KB;
+
+			switch (lc & 1) {
+			case 0:
+				if (mlock((const void*)from, (to - from)) == -1)
+					tst_resm(TINFO|TERRNO, "mlock");
+				break;
+			case 1:
+				if (munlock((const void*)from,
+						(to - from)) == -1)
+					tst_resm(TINFO|TERRNO,
+						"munlock");
+				break;
+			default:
+				break;
+			}
+			tst_resm(TINFO, "%s from %lx to %0lx",
+				(lc&1) ? "munlock" : "mlock  ", from, to);
+
+			/* Record the final stack size. */
+			if (strstr(b, "[stack]") != NULL)
+				last = (to - from)/KB;
+		}
+		printf("\n");
+		fclose(fp);
+	}
+	tst_resm(TINFO, "starting stack size is %ld", first);
+	tst_resm(TINFO, "final stack size is %ld", last);
+	if (last < first)
+		tst_resm(TFAIL, "stack size is decreased.");
+	else
+		tst_resm(TPASS, "stack size is not decreased.");
+	cleanup();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
-- 
1.7.3.2
------=_Part_17388_1797519330.1291707245940
Content-Type: text/x-patch; name=stack-size-mapping-is-decreased.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=stack-size-mapping-is-decreased.patch

This is to test kernel if it has a problem with shortening [stack]
mapping through several loops of  mlock/munlock of /proc/self/maps.

From:
munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]

To:
munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]

With more iterations - could drop to 0KiB.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: fix typos; code cleanup
---
 runtest/mm                                |    2 +
 testcases/kernel/syscalls/mlock/mlock03.c |  120 +++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mlock/mlock03.c

diff --git a/runtest/mm b/runtest/mm
index 16e60d4..fabfab1 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,3 +70,5 @@ hugemmap05_3 hugemmap05 -s -m
 cpuset01 cpuset01 -I 3600
 
 mbind01 mbind01
+
+mlock03 mlock03 -i 20
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
new file mode 100644
index 0000000..d11e42d
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -0,0 +1,120 @@
+/*
+ * Stack size mapping is decreased through mlock/munlock call.
+ *
+ * This is to test kernel if it has a problem with shortening [stack]
+ * mapping through several loops of mlock/munlock of /proc/self/maps.
+ *
+ * From:
+ * munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]
+ *
+ * To:
+ * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
+ *
+ * with more iterations - could drop to 0KiB.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
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
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include "test.h"
+#include "usctest.h"
+
+#define KB 1024
+
+char *TCID = "mlock03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	long from, to, first = -1, last = -1;
+	char b[KB];
+	FILE *fp;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		fp = fopen("/proc/self/maps", "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		while (!feof(fp)) {
+			if (!fgets(b, KB - 1, fp))
+				break;
+			b[strlen(b) - 1] = '\0';
+			sscanf(b, "%lx-%lx", &from, &to);
+
+			/* Record the initial stack size. */
+			if ((lc == 0) && (strstr(b, "[stack]") != NULL))
+				first = (to - from)/KB;
+
+			switch (lc & 1) {
+			case 0:
+				if (mlock((const void*)from, (to - from)) == -1)
+					tst_resm(TINFO|TERRNO, "mlock");
+				break;
+			case 1:
+				if (munlock((const void*)from,
+						(to - from)) == -1)
+					tst_resm(TINFO|TERRNO,
+						"munlock");
+				break;
+			default:
+				break;
+			}
+			tst_resm(TINFO, "%s from %lx to %0lx",
+				(lc&1) ? "munlock" : "mlock  ", from, to);
+
+			/* Record the final stack size. */
+			if (strstr(b, "[stack]") != NULL)
+				last = (to - from)/KB;
+		}
+		printf("\n");
+		fclose(fp);
+	}
+	tst_resm(TINFO, "starting stack size is %ld", first);
+	tst_resm(TINFO, "final stack size is %ld", last);
+	if (last < first)
+		tst_resm(TFAIL, "stack size is decreased.");
+	else
+		tst_resm(TPASS, "stack size is not decreased.");
+	cleanup();
+}
+
+void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
-- 
1.7.3.2


------=_Part_17388_1797519330.1291707245940
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
------=_Part_17388_1797519330.1291707245940
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_17388_1797519330.1291707245940--

