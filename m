Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1X47Lc-0005fa-1H
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 11:44:40 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X47La-0000o4-8t
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 11:44:40 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 7 Jul 2014 07:44:32 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1BF0BC90026
	for <ltp-list@lists.sourceforge.net>;
	Mon,  7 Jul 2014 07:44:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s67BiVns65732730
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 11:44:31 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s67BiVAk012015
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 07:44:31 -0400
Received: from localhost.localdomain ([9.125.31.233])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s67BiUZ3011976
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 07:44:30 -0400
Date: Mon, 7 Jul 2014 19:44:25 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140707114425.GB4421@localhost.localdomain>
References: <20140704031641.GA20446@localhost.localdomain>
	<53BB90C6.9020101@cn.fujitsu.com>
	<20140707065140.GA4421@localhost.localdomain>
	<53BBA1BD.2050902@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BBA1BD.2050902@cn.fujitsu.com>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at
	2G
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
To: LTP <ltp-list@lists.sourceforge.net>

On Tue, Jul 08, 2014 at 03:46:05PM +0800, Xiaoguang Wang wrote:
> Hi,
> 
> On 07/07/2014 02:51 PM, Han Pingtian wrote:
> > On Tue, Jul 08, 2014 at 02:33:42PM +0800, Xiaoguang Wang wrote:
> >> Hi,
> >>
> >> On 07/04/2014 11:16 AM, Han Pingtian wrote:
> >>> Hi,
> >>>
> >>> Please review this patch. Thanks.
> >>>
> >>> There is a bug on 64bit sendfile() with large file, please see
> >>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
> >>> for details.
> >>
> >> I'd like to ask an irrelevant question about that where can we get such bug report or similar issues
> >> about syscalls from a stable place(url), or how did you found this issue, thanks.
> >>
> >> Give that currently there are 1039 test cases about syscalls in LTP(cat runtest/syscalls | grep -v "^#" | sed -e '/^$/d' | wc -l),
> >> we can tell that syscalls is a very big test suite in LTP, so I'd like to add all similar regression test about
> >> syscalls to LTP, which will expand ltp's test coverage, thanks. 
> >>
> >> Regards,
> >> Xiaoguang Wang
> >>
> > Thanks for your reply. I knew this problem just by accidental. It wasn't
> > found by me, but someone else. We are asked why we couldn't find it at
> > first time though we had run ltp to test the syscalls. So I think it
> > would be better to include a regession test for it to ltp. I think we
> > can find out all those regressions by mointoring bug report web site and
> > kernel's mailing list and something like these.
> 
> Yeah, kernel mail list would be the best place to find such issues, but usually
> it needs more time to figure them out :)
> 
> As for you patch, I don't know whether you have read the test-writing-guidelines.txt first, if not,
> please see https://github.com/linux-test-project/ltp/blob/master/doc/test-writing-guidelines.txt.
> For example, there are already many safe_* in ltp, you can use them, which will simplify your error checking, thanks.
> 
> Regards,
> Xiaoguang Wang 

I have modified the patch according to this guide. Please take a look.
Thanks.


From 15dbd7f21332cb7b08699be035c91bfdea31b6c0 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 3 Jul 2014 15:29:35 +0800
Subject: [PATCH] regression test for 64bit sendfile capped at 2G

There is a bug on 64bit sendfile() with large file, please see
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
for details.

This sendfile09.c was copied from sendfile02.c and using plain
file as the out_file. The file size is 4G (4294967296 bytes).
---
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/sendfile/sendfile09.c | 239 ++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
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
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
new file mode 100644
index 0000000..23a0b27
--- /dev/null
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -0,0 +1,239 @@
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
+ *	Testcase copied from sendfile02.c to test the basic functionality of the sendfile(2) system call on large file.
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
+#include <sys/wait.h>
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
+int TST_TOTAL = 4;
+
+char in_file[100];
+char out_file[100];
+int fd;
+int in_fd;
+int out_fd;
+
+void cleanup(void);
+void setup(void);
+
+struct test_case_t {
+	char *desc;
+	int offset;
+	int64_t exp_retval;
+	int64_t exp_updated_offset;
+} testcases[] = {
+	{
+	"Test sendfile(2) with offset = 0", 0, 4294967296, 4294967296}, {
+	"Test sendfile(2) with offset in the middle of file", 2, 4294967294, 4294967296}, {
+	"Test sendfile(2) with offset in the middle of file", 4, 4294967292, 4294967296}, {
+	"Test sendfile(2) with offset in the middle of file", 6, 4294967290, 4294967296}
+};
+
+#ifdef UCLINUX
+static char *argv0;
+#endif
+
+void do_sendfile(OFF_T offset, int i)
+{
+	struct stat sb;
+	off_t before_pos, after_pos;
+
+	out_fd = SAFE_OPEN(cleanup, out_file, O_WRONLY);
+
+	in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);
+
+	SAFE_STAT(cleanup, in_file, &sb);
+
+	before_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
+
+	TEST(sendfile(out_fd, in_fd, &offset, sb.st_size - offset));
+
+	if (TEST_RETURN == -1) {
+		tst_brkm(TBROK, cleanup, "sendfile(2) failed: %s",
+			strerror(TEST_RETURN));
+	}
+
+	after_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
+
+	if (TEST_RETURN != testcases[i].exp_retval) {
+		tst_resm(TFAIL, "sendfile(2) failed to return "
+			 "expected value, expected: %" PRId64 ", "
+			 "got: %" PRId64, testcases[i].exp_retval,
+			 TEST_RETURN);
+	} else if (offset != testcases[i].exp_updated_offset) {
+		tst_resm(TFAIL, "sendfile(2) failed to update "
+			 "OFFSET parameter to expected value, "
+			 "expected: %" PRId64 ", got: %" PRId64,
+			 testcases[i].exp_updated_offset,
+			 (int64_t) offset);
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
+	if (!tst_fs_has_free(NULL, ".", 8, TST_GB)) {
+		cleanup();
+		tst_brkm(TCONF, NULL, "sendfile(2) on large file needs 8G free space.");
+	}
+
+	sprintf(in_file, "in.%d", getpid());
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
+	sprintf(out_file, "out.%d", getpid());
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
+		tst_resm(TINFO, "sendfile(2) on large file skipped for kernels < 2.6.33");
+		return;
+	}
+
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	}
+#ifdef UCLINUX
+	argv0 = av[0];
+#endif
+
+	setup();
+
+	/*
+	 * The following loop checks looping state if -c option given
+	 */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; ++i) {
+			do_sendfile(testcases[i].offset, i);
+		}
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
