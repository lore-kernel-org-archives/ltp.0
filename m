Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XdeSw-0001g3-Mg
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 12:11:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XdeSu-0007i5-Gm
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 12:11:06 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9DCAvq5021664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Oct 2014 08:10:57 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s9DCAuKx002796
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Oct 2014 08:10:57 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Oct 2014 14:10:52 +0200
Message-Id: <091fa8ce5be96478cf31477561e2e90e9d5f7faa.1413201833.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2 v3] add LTP_DATAROOT and tst_dataroot()
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

LTP_DATAROOT (test.sh) and tst_dataroot (libltp) define directory
which holds test data files.

If LTPROOT is defined, it is $LTPROOT/testcases/data/$TCID
otherwise it's $CWD/datafiles (where CWD is current working
directory, before any call to tst_tmdir())

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .gitignore                      |    1 +
 doc/test-writing-guidelines.txt |   27 ++++++++++----
 include/tst_resource.h          |    3 ++
 lib/tests/tst_dataroot.c        |   76 +++++++++++++++++++++++++++++++++++++++
 lib/tst_resource.c              |   67 ++++++++++++++++++++++++++++++----
 testcases/lib/test.sh           |    3 ++
 6 files changed, 162 insertions(+), 15 deletions(-)
 create mode 100644 lib/tests/tst_dataroot.c

diff --git a/.gitignore b/.gitignore
index 1256236..bc63db7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,3 +68,4 @@ logfile.*
 /lib/tests/tst_device
 /lib/tests/tst_record_childstatus
 /lib/tests/trerrno
+/lib/tests/tst_dataroot
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a59fdd9..165551a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -180,13 +180,26 @@ IMPORTANT: The runtest files should have one entry per a test. Creating a
 2.1.2 Datafiles
 ^^^^^^^^^^^^^^^
 
-If your test needs datafiles to work, these should be generally put into a
-subdirectory named test name ('TCID' see below) and install it into the
-'testcases/data/' directory. The datafiles can be accessed as
-'$LTPROOT/testcases/data/TCID/...'. See
-'testcases/network/rpc/basic_tests/rpc01/' for example.
-
-NOTE: There may be some convenience interface added later.
+If your test needs datafiles to work, these should be put into a subdirectory
+named "datafiles" and installed into the 'testcases/data/$TCID' directory.
+
+You can obtain path to datafiles via $LTP_DATAROOT provided by test.sh
+  '$LTP_DATAROOT/...'
+or via C function tst_dataroot() provided by libltp
+  const char *dataroot = tst_dataroot();
+
+Datafiles can also be accessed as '$LTPROOT/testcases/data/$TCID/...',
+but $LTP_DATAROOT and tst_dataroot() are preffered as these can be used
+when running testcases directly in git tree as well as from install
+location.
+
+The path is constructed according to these rules:
+1. if $LTPROOT is set, return '$LTPROOT/testcases/data/$TCID'
+2. else if tst_tmpdir() was called return '$STARTWD/datafiles'
+   (where $STARTWD is initial working directory as recorded by tst_tmdir())
+3. else return '$CWD/datafiles'
+
+See 'testcases/commands/ade/ldd/ldd01' for example.
 
 2.1.3 Subexecutables
 ^^^^^^^^^^^^^^^^^^^^
diff --git a/include/tst_resource.h b/include/tst_resource.h
index a02a313..94c24b7 100644
--- a/include/tst_resource.h
+++ b/include/tst_resource.h
@@ -41,6 +41,9 @@
 
 #include "test.h"
 
+void tst_dataroot_init(void);
+const char *tst_dataroot(void);
+
 /*
  * Copy a file to the CWD. The destination is apended to CWD.
  */
diff --git a/lib/tests/tst_dataroot.c b/lib/tests/tst_dataroot.c
new file mode 100644
index 0000000..e40a992
--- /dev/null
+++ b/lib/tests/tst_dataroot.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2014 Linux Test Project, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include "test.h"
+#include "safe_macros.h"
+#include "usctest.h"
+
+#define OUTPUT_FNAME "output"
+#define LTPROOT "/opt/ltp"
+
+char *TCID = "dataroot";
+int TST_TOTAL = 1;
+
+static void cmp_paths(const char *p1, const char *p2, const char *s)
+{
+	if (strncmp(p1, p2, PATH_MAX) == 0)
+		tst_resm(TPASS, "%s", s);
+	else
+		tst_resm(TFAIL, "%s, %s != %s", s, p1, p2);
+}
+
+int main(void)
+{
+	const char *dataroot;
+	char curdir[PATH_MAX], tmp[PATH_MAX];
+
+	if (getcwd(curdir, PATH_MAX) == NULL)
+		tst_brkm(TBROK, NULL, "getcwd");
+
+	/* LTPROOT */
+	setenv("LTPROOT", LTPROOT, 1);
+	tst_dataroot_init();
+	dataroot = tst_dataroot();
+	snprintf(tmp, PATH_MAX, "%s/testcases/data/%s", LTPROOT, TCID);
+	cmp_paths(dataroot, tmp, "LTPROOT, no tmpdir, "
+		"dataroot == $LTPROOT/testcases/data/$TCID");
+
+	/* no LTPROOT, no tmpdir */
+	unsetenv("LTPROOT");
+	tst_dataroot_init();
+	dataroot = tst_dataroot();
+	snprintf(tmp, PATH_MAX, "%s/datafiles", curdir);
+	cmp_paths(dataroot, tmp, "no LTPROOT, no tmpdir, "
+		"dataroot == $CWD/datafiles");
+
+	/* no LTPROOT, tmpdir */
+	tst_tmpdir();
+	tst_dataroot_init();
+	dataroot = tst_dataroot();
+	snprintf(tmp, PATH_MAX, "%s/datafiles", curdir);
+	cmp_paths(dataroot, tmp, "no LTPROOT, tmpdir, "
+		"dataroot == $STARTWD/datafiles");
+
+	tst_rmdir();
+	tst_exit();
+}
+
diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index 54d4795..7c8deee 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -21,9 +21,61 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <pthread.h>
 #include "tst_resource.h"
 #include "ltp_priv.h"
 
+#ifndef PATH_MAX
+#ifdef MAXPATHLEN
+#define PATH_MAX	MAXPATHLEN
+#else
+#define PATH_MAX	1024
+#endif
+#endif
+
+static pthread_mutex_t tmutex = PTHREAD_MUTEX_INITIALIZER;
+static char dataroot[PATH_MAX];
+extern char *TCID;
+
+void tst_dataroot_init(void)
+{
+	const char *ltproot = getenv("LTPROOT");
+	char curdir[PATH_MAX];
+	const char *startdir;
+	int ret;
+
+	/* 1. if LTPROOT is set, use $LTPROOT/testcases/data/$TCID
+	 * 2. else if startwd is set by tst_tmdir(), use $STARWD/datafiles
+	 * 3. else use $CWD/datafiles */
+	if (ltproot) {
+		ret = snprintf(dataroot, PATH_MAX, "%s/testcases/data/%s",
+			ltproot, TCID);
+	} else {
+		startdir = tst_get_startwd();
+		if (startdir[0] == 0) {
+			if (getcwd(curdir, PATH_MAX) == NULL)
+				tst_brkm(TBROK | TERRNO, NULL,
+					"tst_dataroot getcwd");
+			startdir = curdir;
+		}
+		ret = snprintf(dataroot, PATH_MAX, "%s/datafiles", startdir);
+	}
+
+	if (ret < 0 || ret >= PATH_MAX)
+		tst_brkm(TBROK, NULL, "tst_dataroot snprintf: %d", ret);
+}
+
+const char *tst_dataroot(void)
+{
+	if (dataroot[0] == 0) {
+		pthread_mutex_lock(&tmutex);
+		if (dataroot[0] == 0)
+			tst_dataroot_init();
+		pthread_mutex_unlock(&tmutex);
+	}
+	return dataroot;
+}
+
 static int file_copy(const char *file, const int lineno,
                      void (*cleanup_fn)(void), const char *path,
 		     const char *filename, const char *dest)
@@ -56,15 +108,15 @@ void tst_resource_copy(const char *file, const int lineno,
 		dest = ".";
 
 	const char *ltproot = getenv("LTPROOT");
+	const char *dataroot = tst_dataroot();
+
+	/* look for data files in $LTP_DATAROOT, $LTPROOT/testcases/bin
+	 * and $CWD */
+	if (file_copy(file, lineno, cleanup_fn, dataroot, filename, dest))
+		return;
 
 	if (ltproot != NULL) {
-		/* the data are either in testcases/data or testcases/bin */
 		char buf[strlen(ltproot) + 64];
-
-		snprintf(buf, sizeof(buf), "%s/testcases/data", ltproot);
-
-		if (file_copy(file, lineno, cleanup_fn, buf, filename, dest))
-			return;
 		
 		snprintf(buf, sizeof(buf), "%s/testcases/bin", ltproot);
 		
@@ -72,9 +124,8 @@ void tst_resource_copy(const char *file, const int lineno,
 			return;
 	}
 
+	/* try directory test started in as last resort */
 	const char *startwd = tst_get_startwd();
-
-	/* try directory test started int first */
 	if (file_copy(file, lineno, cleanup_fn, startwd, filename, dest))
 		return;
 
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 10282f4..eecbfba 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -144,4 +144,7 @@ export TST_TOTAL="$TST_TOTAL"
 # Setup LTPROOT, default to current directory if not set
 if [ -z "$LTPROOT" ]; then
 	export LTPROOT="$PWD"
+	export LTP_DATAROOT="$LTPROOT/datafiles"
+else
+	export LTP_DATAROOT="$LTPROOT/testcases/data/$TCID"
 fi
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
