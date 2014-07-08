Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1X4Wbx-0003ZD-Gv
	for ltp-list@lists.sourceforge.net; Tue, 08 Jul 2014 14:43:13 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X4Wbv-0004Ar-73
	for ltp-list@lists.sourceforge.net; Tue, 08 Jul 2014 14:43:13 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Tue, 8 Jul 2014 10:43:05 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
	[9.57.198.23])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8B27138C803D
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Jul 2014 10:43:03 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s68Eh3sb63766580
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jul 2014 14:43:03 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s68Eh3KQ008344
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jul 2014 10:43:03 -0400
Received: from localhost.localdomain ([9.125.24.45])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s68Egxa2008123
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jul 2014 10:43:01 -0400
Date: Tue, 8 Jul 2014 22:42:54 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140708144254.GB3111@localhost.localdomain>
References: <20140704031641.GA20446@localhost.localdomain>
	<1152474476.5259307.1404735279247.JavaMail.zimbra@redhat.com>
	<20140708072308.GA3111@localhost.localdomain>
	<1472278017.5756231.1404815787899.JavaMail.zimbra@redhat.com>
	<1015853559.5800703.1404820547657.JavaMail.zimbra@redhat.com>
	<2026740901.5816308.1404822634671.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2026740901.5816308.1404822634671.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit
	sendfile	capped	at	2G
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

On Tue, Jul 08, 2014 at 08:30:34AM -0400, Jan Stancek wrote:
> I think the problem addressed in commit 5d73320a96fcc was using sendfile on large files,
> and not making large (count > 2GB) sendfile() calls.
> 
> Taking this into account, I can see the difference with/without commit 5d73320a96fcc.
> Second case here fails on unpatched kernel with:
> 
> sendfile(3, 4, [3221225472], 1073741824) = -1 EOVERFLOW (Value too large for defined data type)
> 
> 
Great! I have combined these patches, please have a look. Many Thanks!


From 1bd0231a240629b42dc83e151badb4f0a18b9d22 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 3 Jul 2014 15:29:35 +0800
Subject: [PATCH] regression test for 64bit sendfile capped at 2G

There is a bug on 64bit sendfile() with large file, please see
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
for details.

This sendfile09.c was copied from sendfile02.c and using plain
file as the out_file. The file size is 4G (4294967296 bytes).

The count cannot be large than 2G, but the offset can. So the second
case tests with 3G offset and 1G count. Many thanks to Jan Stancek's
help.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/.gitignore            |   2 +
 testcases/kernel/syscalls/sendfile/sendfile09.c | 226 ++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendfile/sendfile09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 66d6a65..fbed9cb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -937,6 +937,8 @@ sendfile07 sendfile07
 sendfile07_64 sendfile07_64
 sendfile08 sendfile08
 sendfile08_64 sendfile08_64
+sendfile09 sendfile09
+sendfile09_64 sendfile09_64
 
 
 sendmsg01 sendmsg01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 975c150..b9d49cf 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -750,6 +750,8 @@
 /sendfile/sendfile07_64
 /sendfile/sendfile08
 /sendfile/sendfile08_64
+/sendfile/sendfile09
+/sendfile/sendfile09_64
 /sendmsg/sendmsg01
 /sendmsg/sendmsg02
 /sendto/sendto01
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
new file mode 100644
index 0000000..2fac1f6
--- /dev/null
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -0,0 +1,226 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2014
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ * NAME
+ *	sendfile09.c
+ *
+ * DESCRIPTION
+ *	Testcase copied from sendfile02.c to test the basic functionality of
+ *	the sendfile(2) system call on large file. There is a kernel bug which
+ *	introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
+ *
+ * ALGORITHM
+ *	1. call sendfile(2) with offset = 0
+ *	2. call sendfile(2) with offset in the middle of the file
+ *
+ * USAGE:  <for command-line>
+ *  sendfile09 [-c n] [-i n] [-I x] [-P x] [-t]
+ *     where,
+ *             -i n : Execute test n times.
+ *             -I x : Execute test for x seconds.
+ *             -P x : Pause for x seconds between iterations.
+ *             -t   : Turn on syscall timing.
+ *
+ *
+ * RESTRICTIONS
+ *	Only supports 64bit systems and kernel 2.6.33 or above
+ */
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/sendfile.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+
+#ifndef OFF_T
+#define OFF_T off_t
+#endif /* Not def: OFF_T */
+
+TCID_DEFINE(sendfile09);
+
+static char *in_file = "in";
+static char *out_file = "out";
+static int fd;
+static int in_fd;
+static int out_fd;
+
+static void cleanup(void);
+static void setup(void);
+
+#define ONE_GB (INT64_C(1) << 30)
+
+static struct test_case_t {
+	char *desc;
+	OFF_T offset;
+	int64_t count;
+	int64_t exp_retval;
+	int64_t exp_updated_offset;
+} testcases[] = {
+	{ "Test sendfile(2) with offset = 0",
+	    0, ONE_GB, ONE_GB, ONE_GB},
+	{ "Test sendfile(2) with offset in the middle of file",
+	    3*ONE_GB, ONE_GB, ONE_GB, 4*ONE_GB}
+};
+
+int TST_TOTAL = ARRAY_SIZE(testcases);
+
+void do_sendfile(struct test_case_t *t)
+{
+	off_t before_pos, after_pos;
+
+	out_fd = SAFE_OPEN(cleanup, out_file, O_WRONLY);
+
+	in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);
+
+	before_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
+
+	TEST(sendfile(out_fd, in_fd, &t->offset, t->count));
+
+	if (TEST_RETURN == -1)
+		tst_brkm(TBROK | TTERRNO, cleanup, "sendfile(2) failed");
+
+	after_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
+
+	if (TEST_RETURN != t->exp_retval) {
+		tst_resm(TFAIL, "sendfile(2) failed to return "
+			 "expected value, expected: %" PRId64 ", "
+			 "got: %ld", t->exp_retval,
+			 TEST_RETURN);
+	} else if (t->offset != t->exp_updated_offset) {
+		tst_resm(TFAIL, "sendfile(2) failed to update "
+			 "OFFSET parameter to expected value, "
+			 "expected: %" PRId64 ", got: %" PRId64,
+			 t->exp_updated_offset,
+			 (int64_t) t->offset);
+	} else if (before_pos != after_pos) {
+		tst_resm(TFAIL, "sendfile(2) updated the file position "
+			 " of in_fd unexpectedly, expected file position: %"
+			 PRId64 ", " " actual file position %" PRId64,
+			 (int64_t) before_pos, (int64_t) after_pos);
+	} else {
+		tst_resm(TPASS, "functionality of sendfile() is "
+			 "correct");
+	}
+
+	close(in_fd);
+	close(out_fd);
+}
+
+/*
+ * setup() - performs all ONE TIME setup for this test.
+ */
+void setup(void)
+{
+	int i;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	/* make a temporary directory and cd to it */
+	tst_tmpdir();
+
+	if (!tst_fs_has_free(NULL, ".", 8, TST_GB))
+		tst_brkm(TCONF, cleanup, "sendfile(2) on large file"
+			" needs 8G free space.");
+
+	fd = SAFE_CREAT(cleanup, in_file, 00700);
+
+	/* create a 4G file */
+	for (i = 1; i <= (4 * 1024); i++) {
+		SAFE_LSEEK(cleanup, fd, 1024 * 1024 - 1, SEEK_CUR);
+
+		SAFE_WRITE(cleanup, 1, fd, "C", 1);
+	}
+
+	close(fd);
+
+	fd = SAFE_CREAT(cleanup, out_file, 00700);
+
+	close(fd);
+}
+
+/*
+ * cleanup() - performs all ONE TIME cleanup for this test at
+ *	       completion or premature exit.
+ */
+void cleanup(void)
+{
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	if (fd > 0)
+		close(fd);
+
+	if (in_fd > 0)
+		close(in_fd);
+
+	if (out_fd > 0)
+		close(out_fd);
+
+	/* delete the test directory created in setup() */
+	tst_rmdir();
+
+}
+
+int main(int ac, char **av)
+{
+	int i;
+	int lc;
+	const char *msg;		/* parse_opts() return message */
+
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit");
+#endif
+
+	if (tst_kvercmp(2, 6, 33) < 0) {
+		tst_resm(TINFO, "sendfile(2) on large file "
+			"skipped for kernels < 2.6.33");
+		return 0;
+	}
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	/*
+	 * The following loop checks looping state if -c option given
+	 */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; ++i)
+			do_sendfile(&testcases[i]);
+	}
+
+	cleanup();
+
+	tst_exit();
+}
-- 
1.9.3


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
