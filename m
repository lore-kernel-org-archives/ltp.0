Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209C2C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 10:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE643D21E3
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 12:33:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0663A3CB98F
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 12:33:40 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A4A5600147
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 12:33:38 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FNocZ3003639
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 10:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=0vEDHIKN70/jvhp4Uis3s1lxfm
 JpliJKCfX+KzhAUCM=; b=dMdX3M0VM2bZYq7OKAbYfftorWwQLlFtOr7PulGMWI
 CruFNpUSKhI6QNkyzSFuQr4TK8lXtP+ym73q0jZiqrsNYPtA0Kqxha9pTk0/l30q
 JOiJZOirosFPPKNirVARRHCD/3Oz77mJmm/SgtccrDO7v/wvVvo1xnDx+8c52ALm
 1VeDl26HgMETMVgm5/K6H7+0GvV75DZHCPunD8gJOVT5MGBw/woz2L/lEw7KNMak
 DuE922QNULdC7m1ucsAQMGYkfb0Qz1Jmf+oEcBIol+6YxuIRsYMh+vp6lQzjIfYL
 YUQt91qRMSXXLnXc4f22SJtT7I1BX7aApvxVMEr9IRLg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6quva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 10:33:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47GAKEFQ011508
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 10:33:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhukdrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 10:33:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47GAXUVn55902480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 10:33:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DDCB20040;
 Fri, 16 Aug 2024 10:33:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AA602004B;
 Fri, 16 Aug 2024 10:33:29 +0000 (GMT)
Received: from ltcden10-lp11.aus.stglabs.ibm.com (unknown [9.53.174.232])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Aug 2024 10:33:29 +0000 (GMT)
From: Samir Mulani <samir@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 16 Aug 2024 16:03:17 +0530
Message-ID: <20240816103317.127972-1-samir@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nZtpMj0xzcXh1FhElGW0tXrQiloP-GqX
X-Proofpoint-GUID: nZtpMj0xzcXh1FhElGW0tXrQiloP-GqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_02,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408160077
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Migrating the
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>
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
v4:
---Addressed the below requested changes
1. Added support for running architecture-specific test cases using the 
	supported_archs member of the tst_test structure.
2. Replaced the exit -1 condition with a simple return statement when 
	there is insufficient memory for the test.
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 138 ++++++++++++++++++
 3 files changed, 140 insertions(+)
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
index c96fe8bfc..828c62776 100644
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
index 000000000..1bc069148
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation
+ * Author: David Gibson & Adam Litke
+ */
+
+ /*\
+  * [Description]
+  *
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
+#include <errno.h>
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
+	 * sets limit to RLIM_INFINITY.
+	 */
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
+	int pid, status;
+	void *stack_address, *mmap_address, *heap_address, *map;
+
+	stack_address = alloca(0);
+	heap_address = sbrk(0);
+
+	/*
+	 * paranoia: start mapping two hugepages below the start of the stack,
+	 * in case the alignment would cause us to map over something if we
+	 * only used a gap of one hugepage.
+	 */
+	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
+	do {
+		map = mmap(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
+				MAP_SHARED | MAP_FIXED_NOREPLACE, fd, 0);
+		if (map == MAP_FAILED) {
+			if (errno == ENOMEM) {
+				tst_res(TCONF, "There is no enough memory in the system to do mmap");
+				return;
+			}
+		}
+		mmap_address -= hpage_size;
+		/*
+		 * if we get all the way down to the heap, stop trying
+		 */
+	} while (mmap_address <= heap_address);
+	pid = SAFE_FORK();
+	if (pid == 0)
+		do_child(mmap_address);
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
+}
+
+void setup(void)
+{
+	struct rlimit r;
+
+	page_size = getpagesize();
+	hpage_size = tst_get_hugepage_size();
+	/*
+	 * Setting the stack size to unlimited.
+	 */
+	r.rlim_cur = RLIM_INFINITY;
+	r.rlim_max = RLIM_INFINITY;
+	SAFE_SETRLIMIT(RLIMIT_STACK, &r);
+	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
+	if (r.rlim_cur != RLIM_INFINITY)
+		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "0d59a01bc461"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+	.forks_child = 1,
+	.supported_archs = (const char *const []){"ppc", "ppc64", NULL},
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
