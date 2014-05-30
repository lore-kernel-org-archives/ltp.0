Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WqD2V-0003C4-8d
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 02:59:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WqD2S-0002qo-16
	for ltp-list@lists.sourceforge.net; Fri, 30 May 2014 02:59:27 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4U2xCW8013216
	for <ltp-list@lists.sourceforge.net>; Fri, 30 May 2014 10:59:12 +0800
Message-ID: <1401418662.3225.16.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 30 May 2014 10:57:42 +0800
In-Reply-To: <1401418614.3225.15.camel@G08JYZSD130126>
References: <1401418614.3225.15.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] statvfs/statvfs02.c: add new errno testes
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Add new errno testes for statvfs(2)
  - EFAULT
  - ELOOP
  - ENAMETOOLONG
  - ENOENT
  - ENOTDIR

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/statvfs/statvfs02.c | 124 ++++++++++++++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statvfs/statvfs02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 11b6ffc..d71f137 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -867,6 +867,7 @@ statfs02 statfs02
 statfs03 statfs03
 
 statvfs01 statvfs01
+statvfs02 statvfs02
 
 # This syscall is obsoleted by settimeofday.
 #stime01 stime01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index ed877b0..bc71013 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -773,6 +773,7 @@ statfs02 statfs02
 statfs03 statfs03
 
 statvfs01 statvfs01
+statvfs02 statvfs02
 
 # This syscall is obsoleted by settimeofday.
 #stime01 stime01
diff --git a/runtest/syscalls b/runtest/syscalls
index 9207356..cb8ff4f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1176,6 +1176,7 @@ statfs03 statfs03
 statfs03_64 statfs03_64
 
 statvfs01 statvfs01
+statvfs02 statvfs02
 
 stime01 stime01
 stime02 stime02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 61c836c..d3939cd 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -918,6 +918,7 @@
 /statfs/statfs03
 /statfs/statfs03_64
 /statvfs/statvfs01
+/statvfs/statvfs02
 /stime/stime01
 /stime/stime02
 /string/string01
diff --git a/testcases/kernel/syscalls/statvfs/statvfs02.c b/testcases/kernel/syscalls/statvfs/statvfs02.c
new file mode 100644
index 0000000..adf08f3
--- /dev/null
+++ b/testcases/kernel/syscalls/statvfs/statvfs02.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. path is NULL, EFAULT would return.
+ *   2. Too many symbolic links were encountered in translating path,
+ *	ELOOP would return.
+ *   3. path is too long, ENAMETOOLONG would return.
+ *   4. The file referred to by path does not exist, ENOENT would return.
+ *   5. A component of the path prefix of path is not a directory,
+ *	ENOENT would return.
+ */
+
+#include <errno.h>
+#include <sys/statvfs.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define TEST_SYMLINK	"statvfs_symlink"
+#define TEST_FILE	"statvfs_file"
+
+char *TCID = "statvfs02";
+
+static struct statvfs buf;
+static char nametoolong[PATH_MAX+2];
+static void setup(void);
+static void cleanup(void);
+
+static struct test_case_t {
+	char *path;
+	struct statvfs *buf;
+	int exp_errno;
+} test_cases[] = {
+	{NULL, &buf, EFAULT},
+	{TEST_SYMLINK, &buf, ELOOP},
+	{nametoolong, &buf, ENAMETOOLONG},
+	{"filenoexist", &buf, ENOENT},
+	{"statvfs_file/test", &buf, ENOTDIR},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EFAULT, ELOOP, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
+static void statvfs_verify(const struct test_case_t *);
+
+int main(int argc, char **argv)
+{
+	int i, lc;
+	const char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			statvfs_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_SYMLINK(cleanup, TEST_SYMLINK, "statfs_symlink_2");
+	SAFE_SYMLINK(cleanup, "statfs_symlink_2", TEST_SYMLINK);
+
+	memset(nametoolong, 'a', PATH_MAX+1);
+
+	SAFE_TOUCH(cleanup, TEST_FILE, 0644, NULL);
+}
+
+static void statvfs_verify(const struct test_case_t *test)
+{
+	TEST(statvfs(test->path, test->buf));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "statvfs() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "statvfs() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "statvfs() failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
