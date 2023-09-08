Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2889BEE57FE
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:44:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40D8E3CC272
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 13:44:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94A53C89B6
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 13:06:24 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E808A1A0BC3B
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 13:06:20 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388B2Y2g009205 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 11:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=31nU28ihg4863nGK0qbBt00NTWCn2PMVY6Li5+ZQPd8=;
 b=AqKApifD4vv/Ywmd2X/3HJ0dDNJOtU0lIeL/006EyDKIq77zpPxyCD2v3XrdrLrf/3tE
 TCsi6VIWAs4XsIARMAeff8sizv/H/uyVqTzLTnNpaZR+E4JeafIZkO7kbbPEnR1OmUSW
 9PED4wJN/HqR13/TGn8xjwM5B9DBshrx0mL0p8QCEBCn3BoFXnDacWJk3kJuoapDbe4d
 Eqv4jXITUWdxHaS5VK8XUv/H2t0U1+6P/9PNbKIB1IKPWa3/gHLK8BetSSy6Uy02MMDH
 o79ejFd/IcXkwODoQ26NCQHiUkXkkeNt9/pPnHsdzd/XvLQF58vDglaK/C6N7AqqFIq8 og== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t02cvra34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 11:06:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388ABoUJ021433 for <ltp@lists.linux.it>; Fri, 8 Sep 2023 11:05:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfs03apq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 08 Sep 2023 11:05:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388B5Za952298204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 11:05:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6264220043;
 Fri,  8 Sep 2023 11:05:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A62120040;
 Fri,  8 Sep 2023 11:05:34 +0000 (GMT)
Received: from ltcever7x1-lp6.aus.stglabs.ibm.com (unknown [9.53.168.26])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 11:05:34 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 06:05:30 -0500
Message-Id: <20230908110530.14990-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LMMNjv2YDJxatOb0v2XMBjDcmHTCuNV5
X-Proofpoint-ORIG-GUID: LMMNjv2YDJxatOb0v2XMBjDcmHTCuNV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080102
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 08 Sep 2023 13:43:58 +0200
Subject: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Samir Mulani <samir@linux.vnet.ibm.com>, geetika@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:On PowerPC, the address space is divided into segments.
These segments can contain either huge pages or normal pages, but not
both.
All segments are initially set up to map normal pages. When a huge page
mapping is created within a set of empty segments, they are "enabled"
for huge pages at that time. Once enabled for huge pages, they can
not be used again for normal pages for the remaining lifetime of the
process.

If the segment immediately preceeding the segment containing the stack is
converted to huge pages and the stack is made to grow into the this
preceeding segment, some kernels may attempt to map normal pages into the
huge page-only segment -- resulting in bugs.

Signed-off-by: Samir Mulani <samir@linux.vnet.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 145 ++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..0c812c780 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap34 hugemmap34
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..41f547edf 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap34
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
new file mode 100644
index 000000000..36c7dfd7d
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Name: stack_grow_into_huge
+ *
+ * On PowerPC, the address space is divided into segments.  These segments can
+ * contain either huge pages or normal pages, but not both.  All segments are
+ * initially set up to map normal pages.  When a huge page mapping is created
+ * within a set of empty segments, they are "enabled" for huge pages at that
+ * time.  Once enabled for huge pages, they can not be used again for normal
+ * pages for the remaining lifetime of the process.
+ *
+ * If the segment immediately preceeding the segment containing the stack is
+ * converted to huge pages and the stack is made to grow into the this
+ * preceeding segment, some kernels may attempt to map normal pages into the
+ * huge page-only segment -- resulting in bugs.
+ */
+
+#include "hugetlb.h"
+
+#ifdef __LP64__
+#define STACK_ALLOCATION_SIZE	(256*1024*1024)
+#else
+#define STACK_ALLOCATION_SIZE	(16*1024*1024)
+#endif
+#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static unsigned long long hpage_size;
+static int page_size;
+
+
+void do_child(void *stop_address)
+{
+	struct rlimit r;
+	volatile int *x;
+
+	/* corefile from this process is not interesting and limiting
+	 * its size can save a lot of time. '1' is a special value,
+	 * that will also abort dumping via pipe, which by default
+	 * sets limit to RLIM_INFINITY. */
+	r.rlim_cur = 1;
+	r.rlim_max = 1;
+	SAFE_SETRLIMIT(RLIMIT_CORE, &r);
+
+	do {
+		x = alloca(STACK_ALLOCATION_SIZE);
+		*x = 1;
+	} while ((void *)x >= stop_address);
+}
+
+static void run_test(void)
+{
+	int pid, status, sig;
+    	char *b;
+	void *stack_address, *mmap_address, *heap_address;
+        stack_address = alloca(0);
+        heap_address = sbrk(0);
+        /*
+         * paranoia: start mapping two hugepages below the start of the stack,
+         * in case the alignment would cause us to map over something if we
+         * only used a gap of one hugepage.
+         */
+        mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
+        do {
+		b = SAFE_MMAP(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
+						MAP_FIXED|MAP_SHARED, fd, 0);
+		mmap_address -= hpage_size;
+		/*
+		 * if we get all the way down to the heap, stop trying
+		 */
+		if (mmap_address <= heap_address)
+			break;
+ 	   } while (b == MAP_FAILED);
+
+        if (b == MAP_FAILED)
+		tst_res(TFAIL, "mmap() at unexpected address %p instead of %p\n", b,
+	    		 mmap_address);
+    
+    	pid = SAFE_FORK();
+		if (pid == 0) {
+			do_child(mmap_address);
+			exit(0);
+		}
+   	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status)) {
+		sig = WTERMSIG(status);
+
+		if (sig == SIGSEGV) {
+			 tst_res(TPASS, "Test Passed");
+			 exit(0);
+		} else {
+			tst_res(TFAIL, "Got unexpected signal: %s", strsignal(sig));
+			exit(1);
+		}
+	}
+	tst_res(TFAIL, "Child not signalled");
+}
+
+void setup(void)
+{
+    	struct rlimit r;
+	page_size = getpagesize();
+	hpage_size = tst_get_hugepage_size();
+	/*
+	 * Setting the stack size to unlimited.
+	 */
+	r.rlim_cur = RLIM_INFINITY;
+        r.rlim_max = RLIM_INFINITY;
+        SAFE_SETRLIMIT(RLIMIT_STACK, &r);
+
+        SAFE_GETRLIMIT(RLIMIT_STACK, &r);
+        if (r.rlim_cur != RLIM_INFINITY)
+		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+    	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+                {"linux-git", "0d59a01bc461"},
+                {}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+	.forks_child = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
