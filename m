Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cxie@redhat.com>) id 1T8oIj-0008U6-FS
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 08:16:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T8oIf-0005w1-DW
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 08:16:01 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q848FpFN007964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Sep 2012 04:15:51 -0400
From: Madper Xie <cxie@redhat.com>
Date: Tue,  4 Sep 2012 16:15:33 +0800
Message-Id: <1346746533-25458-1-git-send-email-cxie@redhat.com>
In-Reply-To: <n>
References: <n>
Subject: [LTP] [PATCH] new syscall test:fork14
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


Signed-off-by: Madper Xie <cxie@redhat.com>
---
 testcases/kernel/syscalls/fork/fork14.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fork/fork14.c

diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
new file mode 100644
index 0000000..5046e67
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -0,0 +1,102 @@
+/*********************************************************************
+ * Copyright (C) 2012  Red Hat, Inc.
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
+ * Description: This test is for kernel commit:
+ *              7edc8b0ac16cbaed7cb4ea4c6b95ce98d2997e84
+ *		Since vma length in dup_mmap is calculated and stored
+ *              in a unsigned int, it will overflow when length > 16
+ *              TB. The commit above fixed it. This case is to verify
+ *              whether that patch is added.
+ ********************************************************************/
+
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork14";
+
+#define GIG (1024 * 1024 * 1024L)
+#define EXTENT 16393
+
+/*
+ * If The vma length in dup_mmap is
+ * calculated and stored in a unsigned int,
+ * will overflow when length > 16TB.
+ */
+#define LARGE  16383
+
+static void setup();
+static void cleanup();
+
+int main(int argc, char *argv[])
+{
+	int i, r, lc;
+	void *m;
+
+/*
+ * I test this case on ppc64/x86_64/i386/s390x
+ * Only ppc64 x86_64 s390x can run it.
+ * So, I think it's only for 64bit system
+ * The fork will always successed on 32bit.
+ */
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
+#endif
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++){	
+		for (i = 0; i < EXTENT; i++) {
+			m = mmap(NULL, (size_t) 1 * GIG, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+			switch (fork()){
+			case -1:
+				break;
+			case 0 :
+				exit(0);
+			default:
+				if (waitpid(-1, NULL, 0) == -1)
+					tst_brkm(TBROK|TERRNO,
+						cleanup, "waitpid");
+				if (i >= LARGE) 
+					tst_brkm(TFAIL, NULL,
+						"Fork succeed unexpect:%d", i);
+			}
+		}
+	}
+	
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.7.12


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
