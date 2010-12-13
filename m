Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PS1UK-0004SX-N1
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:02:20 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS1UI-0002fc-Sa
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:02:20 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBD62CZB032558
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Dec 2010 01:02:12 -0500
Date: Mon, 13 Dec 2010 01:02:09 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <576205689.821211292220129860.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1520798229.821161292220083283.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_47603_862758719.1292220129859"
Subject: [LTP] [PATCH v1] add a testcase to test /proc/sys/vm/nr_hugepages
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

------=_Part_47603_862758719.1292220129859
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

hi,I'd like to add several testcases to test vm tunable(/proc/sys/vm/*).
the patch is designed to test nr_hugepages vm tunable, and I will add 
more to test other vm tunables.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/vmtunabe/Makefile       |   31 +++++
 testcases/kernel/mem/vmtunabe/nr_hugepages.c |  166 ++++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunabe/Makefile
 create mode 100644 testcases/kernel/mem/vmtunabe/nr_hugepages.c

diff --git a/testcases/kernel/mem/vmtunabe/Makefile b/testcases/kernel/mem/vmtunabe/Makefile
new file mode 100644
index 0000000..3e7f888
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/Makefile
@@ -0,0 +1,31 @@
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
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/mem/vmtunabe/nr_hugepages.c b/testcases/kernel/mem/vmtunabe/nr_hugepages.c
new file mode 100644
index 0000000..3c139a6
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/nr_hugepages.c
@@ -0,0 +1,166 @@
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
+char *TCID="nr_hugepages"; 
+#define BUFFER_SIZE 256
+/* why I set HUGEPAGES 30, I think this value is appropriate,
+ * In general, all the systems can provide about 30 hugepages if they 
+ * support hugepage, if you make a much larger value, it will cause 
+ * shortage memory.
+ */
+#define HUGEPAGES 30 
+
+int TST_TOTAL=1;
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
+	/* if check_system() return zero, 
+ 	 * the system can't support this test. 
+ 	 */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such file");
+		tst_exit();
+	}
+	if ( (msg = parse_opts(argc, argv, NULL, NULL)) != NULL ) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
+	}
+	
+	
+	get_hugepages(&old_hugepages);
+	tst_resm(TINFO, "the old nr_hugepages is %d\n",old_hugepages);
+	
+	for ( lc = 0; TEST_LOOPING(lc); lc++ ) {
+		for ( counter = 0; counter < nr; counter++ ) {
+			set_hugepages(HUGEPAGES + counter);
+			tst_resm(TINFO, "set nr_hugepages %d",
+				HUGEPAGES + counter);
+			get_hugepages(&hugepages);
+			if ( hugepages != HUGEPAGES + counter ) {
+				set_hugepages(old_hugepages); /* recover the original value */
+				tst_brkm(TFAIL, cleanup, "nr_hugepages error");
+			}
+		}
+	}
+	
+	set_hugepages(old_hugepages); /* recover the primary value */
+	tst_resm(TPASS, "nr_hugepages");
+	cleanup();
+	return 0;
+}
+
+int get_hugepages(int *nr_hugepages) 
+{
+	FILE *f;
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+	f = fopen("/proc/meminfo", "r");
+	if (!f) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if((retcode = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
+			break;
+	}
+	fclose(f);
+	return 0;
+}
+
+int set_hugepages(int nr_hugepages)
+{
+	FILE *f ;
+	f = fopen("/proc/sys/vm/nr_hugepages","w");
+	if (!f) {
+		tst_brkm(TFAIL, NULL, "No permission, using root user.");
+		tst_exit();
+	}
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages */
+	fprintf(f, "%d", nr_hugepages);
+	
+	fclose(f);
+	return 0;
+}
+
+int check_system()
+{
+	int flag = -1;
+	flag = access("/proc/sys/vm/nr_hugepages",F_OK);
+	if (flag == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+void cleanup(void)
+{
+	set_hugepages(old_hugepages);
+	tst_exit();
+}
-- 
1.7.2.3

------=_Part_47603_862758719.1292220129859
Content-Type: text/x-patch;
	name=0001-add-a-testcase-nr_hugepages-for-vm-tunable.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-add-a-testcase-nr_hugepages-for-vm-tunable.patch

From 98708590d4822aa442cc3261fcb84dcd79967fa2 Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 13 Dec 2010 13:38:52 +0800
Subject: [PATCH 1/2] add a testcase nr_hugepages for vm tunable


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/vmtunabe/Makefile       |   31 +++++
 testcases/kernel/mem/vmtunabe/nr_hugepages.c |  166 ++++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunabe/Makefile
 create mode 100644 testcases/kernel/mem/vmtunabe/nr_hugepages.c

diff --git a/testcases/kernel/mem/vmtunabe/Makefile b/testcases/kernel/mem/vmtunabe/Makefile
new file mode 100644
index 0000000..3e7f888
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/Makefile
@@ -0,0 +1,31 @@
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
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/mem/vmtunabe/nr_hugepages.c b/testcases/kernel/mem/vmtunabe/nr_hugepages.c
new file mode 100644
index 0000000..3c139a6
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/nr_hugepages.c
@@ -0,0 +1,166 @@
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
+char *TCID="nr_hugepages"; 
+#define BUFFER_SIZE 256
+/* why I set HUGEPAGES 30, I think this value is appropriate,
+ * In general, all the systems can provide about 30 hugepages if they 
+ * support hugepage, if you make a much larger value, it will cause 
+ * shortage memory.
+ */
+#define HUGEPAGES 30 
+
+int TST_TOTAL=1;
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
+	/* if check_system() return zero, 
+ 	 * the system can't support this test. 
+ 	 */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such file");
+		tst_exit();
+	}
+	if ( (msg = parse_opts(argc, argv, NULL, NULL)) != NULL ) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
+	}
+	
+	
+	get_hugepages(&old_hugepages);
+	tst_resm(TINFO, "the old nr_hugepages is %d\n",old_hugepages);
+	
+	for ( lc = 0; TEST_LOOPING(lc); lc++ ) {
+		for ( counter = 0; counter < nr; counter++ ) {
+			set_hugepages(HUGEPAGES + counter);
+			tst_resm(TINFO, "set nr_hugepages %d",
+				HUGEPAGES + counter);
+			get_hugepages(&hugepages);
+			if ( hugepages != HUGEPAGES + counter ) {
+				set_hugepages(old_hugepages); /* recover the original value */
+				tst_brkm(TFAIL, cleanup, "nr_hugepages error");
+			}
+		}
+	}
+	
+	set_hugepages(old_hugepages); /* recover the primary value */
+	tst_resm(TPASS, "nr_hugepages");
+	cleanup();
+	return 0;
+}
+
+int get_hugepages(int *nr_hugepages) 
+{
+	FILE *f;
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+	f = fopen("/proc/meminfo", "r");
+	if (!f) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if((retcode = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
+			break;
+	}
+	fclose(f);
+	return 0;
+}
+
+int set_hugepages(int nr_hugepages)
+{
+	FILE *f ;
+	f = fopen("/proc/sys/vm/nr_hugepages","w");
+	if (!f) {
+		tst_brkm(TFAIL, NULL, "No permission, using root user.");
+		tst_exit();
+	}
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages */
+	fprintf(f, "%d", nr_hugepages);
+	
+	fclose(f);
+	return 0;
+}
+
+int check_system()
+{
+	int flag = -1;
+	flag = access("/proc/sys/vm/nr_hugepages",F_OK);
+	if (flag == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+void cleanup(void)
+{
+	set_hugepages(old_hugepages);
+	tst_exit();
+}
-- 
1.7.2.3


------=_Part_47603_862758719.1292220129859
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_47603_862758719.1292220129859
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_47603_862758719.1292220129859--

