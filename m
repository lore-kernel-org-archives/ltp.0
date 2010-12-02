Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PO366-0003eD-0X
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 06:56:54 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PO364-000694-E3
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 06:56:53 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB26ukEq002263
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Dec 2010 01:56:46 -0500
Date: Thu, 2 Dec 2010 01:56:46 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <511532576.1031811291273006660.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2056539924.1031781291272889252.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_57664_1077201717.1291273006659"
Subject: [LTP] [PATCH v2] Stack size mapping is decreased through
	mlock/munlock
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

------=_Part_57664_1077201717.1291273006659
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
v2: code cleanup


 runtest/mm                                |    1 +

 testcases/kernel/syscalls/mlock/mlock03.c |  106 +++++++++++++++++++++++++++++

 2 files changed, 107 insertions(+), 0 deletions(-)

 create mode 100644 testcases/kernel/syscalls/mlock/mlock03.c



diff --git a/runtest/mm b/runtest/mm

index 16e60d4..09a339d 100644

--- a/runtest/mm

+++ b/runtest/mm

@@ -70,3 +70,4 @@ hugemmap05_3 hugemmap05 -s -m

 cpuset01 cpuset01 -I 3600

 

 mbind01 mbind01

+mlock01 mlock01 -i 20

diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c

new file mode 100644

index 0000000..7e66053

--- /dev/null

+++ b/testcases/kernel/syscalls/mlock/mlock03.c

@@ -0,0 +1,106 @@

+/*

+ * Stack size mapping is decreased through mlock/munlock call.

+ *

+ * - mlock all lines on /proc/self/maps

+ * - show mapping

+ * - munlock all lines on /proc/self/maps

+ * - show again

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

+int main(int argc, char *argv[])

+{

+	int lc;

+	char *msg;

+	long from, to, first = -1, last = -1;

+	char b[KB], pid[BUFSIZ];

+	FILE *fp;

+

+	msg = parse_opts(argc, argv, NULL, NULL);

+	if (msg != NULL)

+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",

+			msg);

+	sprintf(pid, "cat /proc/%d/maps", getpid());

+

+	for (lc = 0; TEST_LOOPING(lc); lc++) {

+		fp = fopen("/proc/self/maps", "r");

+		if (fp == NULL)

+			tst_brkm(TBROK|TERRNO, tst_exit, "fopen");

+

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

+				if (mlock((const void*)from,

+						(to - from)) == -1)

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

+				(lc&1) ? "munlock" : "mlock  ",

+				from, to);

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

+

+	if (last < first)

+		tst_resm(TFAIL, "stack size is decreased.");

+	else

+		tst_resm(TPASS, "stack size is not decreased.");

+		

+	tst_exit();

+}

-- 

1.7.1

------=_Part_57664_1077201717.1291273006659
Content-Type: text/x-patch;
	name=0006-Stack-size-mapping-is-decreased-through-mlock-munloc.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0006-Stack-size-mapping-is-decreased-through-mlock-munloc.patch

From: CAI Qian <caiqian@redhat.com>
Date: Tue, 30 Nov 2010 17:58:08 +0800
Subject: [PATCH v2] Stack size mapping is decreased through mlock/munlock call

This is to test kernel if it has a problem with shortening [stack]
mapping through several loops of  mlock/munlock of /proc/self/maps. 

From:
munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]

To:
munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]

With more iterations - could drop to 0KiB.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup

 runtest/mm                                |    1 +
 testcases/kernel/syscalls/mlock/mlock03.c |  106 +++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/mlock/mlock03.c

diff --git a/runtest/mm b/runtest/mm
index 16e60d4..09a339d 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,3 +70,4 @@ hugemmap05_3 hugemmap05 -s -m
 cpuset01 cpuset01 -I 3600
 
 mbind01 mbind01
+mlock01 mlock01 -i 20
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
new file mode 100644
index 0000000..7e66053
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -0,0 +1,106 @@
+/*
+ * Stack size mapping is decreased through mlock/munlock call.
+ *
+ * - mlock all lines on /proc/self/maps
+ * - show mapping
+ * - munlock all lines on /proc/self/maps
+ * - show again
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
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	long from, to, first = -1, last = -1;
+	char b[KB], pid[BUFSIZ];
+	FILE *fp;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",
+			msg);
+	sprintf(pid, "cat /proc/%d/maps", getpid());
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		fp = fopen("/proc/self/maps", "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, tst_exit, "fopen");
+
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
+				if (mlock((const void*)from,
+						(to - from)) == -1)
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
+				(lc&1) ? "munlock" : "mlock  ",
+				from, to);
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
+
+	if (last < first)
+		tst_resm(TFAIL, "stack size is decreased.");
+	else
+		tst_resm(TPASS, "stack size is not decreased.");
+		
+	tst_exit();
+}
-- 
1.7.1


------=_Part_57664_1077201717.1291273006659
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_57664_1077201717.1291273006659
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_57664_1077201717.1291273006659--

