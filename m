Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PssUd-0006ap-D4
	for ltp-list@lists.sourceforge.net; Fri, 25 Feb 2011 07:53:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PssUb-0005Z7-47
	for ltp-list@lists.sourceforge.net; Fri, 25 Feb 2011 07:53:39 +0000
Date: Fri, 25 Feb 2011 15:57:28 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110225075728.GB2902@hpt.nay.redhat.com>
References: <20110224101921.GA30765@hpt.nay.redhat.com>
	<AANLkTimuSUtaPSL5x1N75_nF2OtXfjMzcvu5wK4b2FJ7@mail.gmail.com>
	<20110225025148.GA2902@hpt.nay.redhat.com>
	<AANLkTi=cqRqDH_JKyVTx0cnRRy74Yidd9T8Ww-cSJMs4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <AANLkTi=cqRqDH_JKyVTx0cnRRy74Yidd9T8Ww-cSJMs4@mail.gmail.com>
Subject: Re: [LTP] [PATCH] basic mlock() testcase from lkml
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 24, 2011 at 10:16:58PM -0800, Garrett Cooper wrote:
> On Thu, Feb 24, 2011 at 6:51 PM, Han Pingtian <phan@redhat.com> wrote:
> 
> ...
> 
> > Updated as required. Please review. Thanks.
> 
>     close should be under TEST_CLEANUP. Other than that it's fine.
Updated. Thanks.
> Thanks!
> -Garrett

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-basic-mlock-testcase-from-lkml.patch"

From 4c92e20058b0349910b309e891d92c60d1f15cad Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Thu, 24 Feb 2011 17:25:03 +0800
Subject: [PATCH] basic mlock() testcase from lkml

This is a reproducer copied from one of LKML patch submission,
which subject is

[PATCH] mlock: revert the optimization for dirtying pages and
triggering writeback.

"In 5ecfda0, we do some optimization in mlock, but it causes
a very basic test case(attached below) of mlock to fail. So
this patch revert it with some tiny modification so that it
apply successfully with the lastest 38-rc2 kernel."

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 runtest/mm                           |    1 +
 testcases/kernel/mem/mlock/Makefile  |   23 +++++++
 testcases/kernel/mem/mlock/mlock01.c |  105 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/mlock/Makefile
 create mode 100644 testcases/kernel/mem/mlock/mlock01.c

diff --git a/runtest/mm b/runtest/mm
index f097256..1296e59 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -76,6 +76,7 @@ hugemmap05_3 hugemmap05 -s -m
 
 cpuset01 cpuset01 -I 3600
 
+mlock01 mlock01
 mlock03 mlock03 -i 20
 
 mbind01 mbind01
diff --git a/testcases/kernel/mem/mlock/Makefile b/testcases/kernel/mem/mlock/Makefile
new file mode 100644
index 0000000..dbfbc1b
--- /dev/null
+++ b/testcases/kernel/mem/mlock/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/mlock/mlock01.c b/testcases/kernel/mem/mlock/mlock01.c
new file mode 100644
index 0000000..9218e0c
--- /dev/null
+++ b/testcases/kernel/mem/mlock/mlock01.c
@@ -0,0 +1,105 @@
+/*
+ * This is a reproducer copied from one of LKML patch submission,
+ * which subject is
+ *
+ * [PATCH] mlock: revert the optimization for dirtying pages and triggering writeback.
+ *
+ * "In 5ecfda0, we do some optimization in mlock, but it causes
+ * a very basic test case(attached below) of mlock to fail. So
+ * this patch revert it with some tiny modification so that it
+ * apply successfully with the lastest 38-rc2 kernel."
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
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "mlock01";
+int TST_TOTAL = 1;
+
+#include <sys/mman.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+int fd, file_len = 40960;
+char *testfile = "test_mmap";
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+	
+	close(fd);
+
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	tst_tmpdir();
+
+	fd = open(testfile, O_CREAT | O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	if (ftruncate(fd, file_len) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "ftruncate");
+
+	TEST_PAUSE;
+}
+
+int main(void)
+{
+	char *buf;
+	int lc;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		buf = mmap(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
+
+		if (buf == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+
+		if (mlock(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "mlock");
+
+		tst_resm(TINFO, "locked %d bytes from %p", file_len, buf);
+
+		if (munlock(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munlock");
+
+		if (munmap(buf, file_len) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+	}
+
+	tst_resm(TPASS, "mlock01 pass");
+
+	cleanup();
+
+	tst_exit();
+}
-- 
1.7.1


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--8P1HSweYDcXXzwPJ--

