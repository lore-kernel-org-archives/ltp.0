Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XS0eO-0002OO-AT
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 09:26:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS0eM-0000mE-IW
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 09:26:48 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8B9QdpF002034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 05:26:39 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s8B9Qbj5030334
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 05:26:38 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Sep 2014 11:26:36 +0200
Message-Id: <18212a6382077b1a49ca02422804fffb0189816b.1410427548.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] lib: implement TRERRNO
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

TRERRNO outputs errno information stored in TEST_RETURN.
For example, this can be used for pthread-style API,
where functions do not set errno on error, but return
error code directly.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .gitignore              |    1 +
 include/tst_res_flags.h |    2 +-
 lib/tests/trerrno.c     |   91 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_res.c           |   12 ++++++
 4 files changed, 105 insertions(+), 1 deletions(-)
 create mode 100644 lib/tests/trerrno.c

diff --git a/.gitignore b/.gitignore
index 352ca23..1256236 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,3 +67,4 @@ logfile.*
 /lib/tests/tst_fs_fill_hardlinks
 /lib/tests/tst_device
 /lib/tests/tst_record_childstatus
+/lib/tests/trerrno
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 1f3d06d..b79d69a 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -23,7 +23,7 @@
 
 #define TERRNO	0x100	/* Append errno information to output */
 #define TTERRNO	0x200	/* Append TEST_ERRNO information to output */
-#define TRERRNO	0x300	/* Capture errno information from TEST_RETURN to
+#define TRERRNO	0x400	/* Capture errno information from TEST_RETURN to
 			   output; useful for pthread-like APIs :). */
 
 #endif /* TST_RES_FLAGS_H */
diff --git a/lib/tests/trerrno.c b/lib/tests/trerrno.c
new file mode 100644
index 0000000..0c72328
--- /dev/null
+++ b/lib/tests/trerrno.c
@@ -0,0 +1,91 @@
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
+
+char *TCID = "trerrno";
+int TST_TOTAL = 1;
+
+static void setup(void)
+{
+	tst_tmpdir();
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+int main(void)
+{
+	int fd, stdout_fd;
+	char msg[4096], *pos;
+	FILE *f;
+
+	setup();
+
+	/* redirect stdout to file */
+	stdout_fd = dup(fileno(stdout));
+	fd = SAFE_OPEN(NULL, OUTPUT_FNAME, O_RDWR | O_CREAT, 0666);
+	TEST(dup2(fd, fileno(stdout)));
+	if (TEST_RETURN == -1)
+		tst_brkm(TBROK | TTERRNO, cleanup, "dup2");
+
+	errno = EPERM;
+	TEST_ERRNO = EPERM;
+	TEST_RETURN = EINVAL;
+	tst_resm(TINFO | TRERRNO, "test");
+	tst_flush();
+
+	/* restore stdout */
+	TEST(dup2(stdout_fd, fileno(stdout)));
+	if (TEST_RETURN == -1)
+		tst_brkm(TBROK | TTERRNO, cleanup, "dup2");
+
+	/* read file and verify that output is as expected */
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	f = fdopen(fd, "r");
+	if (!f)
+		tst_brkm(TBROK | TERRNO, cleanup, "fdopen");
+	if (!fgets(msg, sizeof(msg), f))
+		tst_brkm(TBROK, cleanup, "fgets");
+	fclose(f);
+
+	pos = strchr(msg, '\n');
+	if (pos != NULL)
+		*pos = '\0';
+
+	tst_resm(TINFO, "%s", msg);
+	if (strstr(msg, "EPERM"))
+		tst_resm(TFAIL, "EPERM shouldn't be in TRERRNO output");
+	if (strstr(msg, "EINVAL"))
+		tst_resm(TPASS, "EINVAL should be in TRERRNO output");
+	else
+		tst_resm(TFAIL, "EINVAL not found in TRERRNO output");
+
+	cleanup();
+	tst_exit();
+}
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 569bfe2..7619ea2 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -456,6 +456,18 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 				 strerror(TEST_ERRNO));
 	}
 
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	if (ttype & TRERRNO) {
+		size += snprintf(message + size, sizeof(message) - size,
+				 ": TEST_RETURN=%s(%i): %s",
+				 tst_strerrno(TEST_RETURN), (int)TEST_RETURN,
+				 strerror(TEST_RETURN));
+	}
+
 	if (size + 1 >= sizeof(message)) {
 		printf("%s: %i: line too long\n", __func__, __LINE__);
 		abort();
-- 
1.7.1


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
