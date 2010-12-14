Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PSNSp-0001GQ-3F
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 05:30:15 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PSNSn-0003C5-JW
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 05:30:15 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBE5U70V023021
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Dec 2010 00:30:07 -0500
Date: Tue, 14 Dec 2010 00:30:07 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <84488521.961801292304607525.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] add a testcase to test /proc/sys/vm/nr_hugepages
 vm tunable
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
To: ltp-list@lists.sourceforge.net

hi,I'd like to add several testcases to test vm tunable(/proc/sys/vm/*).
the patch is designed to test nr_hugepages vm tunable, if you set nr_hugepages,
you can find this change through /proc/meminfo <HighTotal: > 
I will add more testcases for vm tunables in the few days.

v2: fixed the code style

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                                    |    3 +
 testcases/kernel/mem/vmtunable/Makefile       |   28 ++++
 testcases/kernel/mem/vmtunable/nr_hugepages.c |  184 +++++++++++++++++++++++++
 3 files changed, 215 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunable/Makefile
 create mode 100644 testcases/kernel/mem/vmtunable/nr_hugepages.c

diff --git a/runtest/mm b/runtest/mm
index 8be3025..3b5182f 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,6 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+# test for vm tunable
+nr_hugepages nr_hugepages -i 5
diff --git a/testcases/kernel/mem/vmtunable/Makefile b/testcases/kernel/mem/vmtunable/Makefile
new file mode 100644
index 0000000..fe4c248
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/Makefile
@@ -0,0 +1,28 @@
+#
+# Copyright (C) 2010  Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+#
+# Further, this software is distributed without any warranty that it
+# is free of the rightful claim of any third person regarding
+# infringement or the like.  Any license provided herein, whether
+# implied or otherwise, applies only to this software file.  Patent
+# licenses, if any, provided herein do not apply to combinations of
+# this program with other software, or any other product whatsoever.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+# 02110-1301, USA.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/vmtunable/nr_hugepages.c b/testcases/kernel/mem/vmtunable/nr_hugepages.c
new file mode 100644
index 0000000..a573630
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/nr_hugepages.c
@@ -0,0 +1,184 @@
+/* 
+ * vm tunable test
+ *
+ * ********************************************************************
+ * Copyright (C) 2010 Red Hat, Inc.
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
+ *
+ * ********************************************************************
+ *
+ * File Name: nr_hugepage.c
+ * Author: Zhouping Liu <zliu@redhat.com>
+ * Description:  
+ * The program is designed to test /proc/sys/vm/nr_hugepages.
+ * set the different values to nr_hugepages and watch this operations
+ * work normally. if you set nr_hugepages, you can see this change in
+ * /proc/meminfo: HugePages_Total
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "test.h"
+#include "usctest.h"
+#define BUFFER_SIZE 256
+
+/* the HUGEPAGES is the value that I will set /proc/sys/vm/nr_hugepages, 
+ * why I set HUGEPAGES 30, I think this value is appropriate.
+ * In general, all the systems can provide about 30 hugepages if they 
+ * support hugepage, if you make a much larger value, it will cause 
+ * shortage memory.
+ */
+#define HUGEPAGES 30 
+
+char *TCID ="nr_hugepages"; 
+int TST_TOTAL = 1;
+
+/* set hugepages */
+int set_hugepages(int nr_hugepages);
+/* get the total of hugepages and surplus hugepages */ 
+int get_hugepages(int *nr_hugepages);
+
+/* check whether the /proc/sys/vm/nr_hugepages file exist
+ * if not, then the test can't run continue.
+ * */
+int check_system();
+
+/* make some clean work. */
+void cleanup();
+
+int old_hugepages = 0; /* save the old nr_hugepages value */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg; /* message returned from parse_opts */
+	int counter = 0;
+	int nr = 10;
+	int hugepages = 0;
+
+	/* the test need to be run as root */
+	tst_require_root(tst_exit);
+
+	/* if check_system() return zero, 
+ 	 * the system can't support this test. 
+ 	 */
+	if (!check_system()) {
+		tst_brkm(TCONF|TERRNO,tst_exit, "Can't test %s, no such file", TCID);
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
+	}
+	
+	get_hugepages(&old_hugepages); /* save the original hugepages */
+	tst_resm(TINFO, "the original nr_hugepages is %d\n", old_hugepages);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* try to set nr_hugepages from 30 to 39 */
+		for ( counter = 0; counter < nr; counter++ ) {
+			set_hugepages(HUGEPAGES + counter);
+			tst_resm(TINFO, "set nr_hugepages %d", 
+				HUGEPAGES + counter);
+			get_hugepages(&hugepages);
+			if (hugepages != HUGEPAGES + counter) {
+				set_hugepages(old_hugepages); /* recover the original value */
+				tst_brkm(TFAIL, cleanup, "nr_hugepages error");
+			}
+		}
+	}
+	
+	tst_resm(TPASS, "nr_hugepages succeed.");
+	
+	set_hugepages(old_hugepages); /* recover the primary value */
+	cleanup();
+	return 0;
+}
+
+int get_hugepages(int *nr_hugepages) 
+{
+	FILE *f;
+	int flag = 0;
+	char buff[BUFFER_SIZE];
+
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
+		tst_brkm(TBROK, cleanup, "open /proc/meminfo error");
+	}
+
+	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if ((flag = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
+			break;
+	}
+
+	/* if flag = 1, that indicates the sscanf() have gotten the HugePages_Total */
+	if (flag != 1) {
+		fclose(f);
+		tst_brkm(TBROK, cleanup, "Failed reading Hugepages_Total.");
+	}
+
+	fclose(f);
+	return 0;
+}
+
+int set_hugepages(int nr_hugepages)
+{
+	FILE *f ;
+
+	f = fopen("/proc/sys/vm/nr_hugepages","w");
+	if (f == NULL) {
+		tst_brkm(TBROK, cleanup, "open /proc/sys/vm/nr_hugepages error");
+	}
+
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages */
+	if (fprintf(f, "%d", nr_hugepages) < 0) {
+		tst_brkm(TBROK, cleanup, "fprintf() error");
+	}
+	
+	fclose(f);
+	return 0;
+}
+
+int check_system()
+{
+	int flag = -1;
+	
+	flag = access("/proc/sys/vm/nr_hugepages", F_OK);
+	if (flag == 0) {  
+		return 1;  /* can access this file */
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	set_hugepages(old_hugepages); /* recover the original data */
+	tst_exit();
+}
-- 
1.7.2.3

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
