Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38DFE743F1
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 07:55:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25B183CE110
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:55:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA94A3CB9EF
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:54:57 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B833F10011C8
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 09:54:55 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T7eqJ6009929
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 07:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cWqzIgahA0y23IIPfwzJjxYGnFer4RbthiPLdG4+7zQ=;
 b=kmHxxEjDVRdSMNiDw7s7P1uA+5x1m6bl6dJXRc2mDF8zVqa54jdAdLWz7nv+w0uoMfF/
 B68vDEITUGV8JcfL+qxrmbPpGeFGbE7jAccEtkERdzMe0Oh/qm2a6kwSFWGiQJpskDri
 5sgVCyR+9ezIPUvHHn3jD2x+xZa7Q8vn8HXNT+gCaafdfqeQ8dLmZnTxCNoCPUZ7ZE17
 CVywnHl+KxACzKe4MRfsFM3fy1ZmIdenYeKBQD21sk7fNUqpQkLK64l4J7K6UIaZjmFp
 wOWpsIiJIMcTntsAgmapmIUMZROS1IbgzEilb8it0WlfQBEOtwbR9F6J9p8JLJMlYQt2 Sw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tds73tdh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 07:54:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T59rjd011032
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 07:54:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabum2wx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 07:54:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38T7snmP45417002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Sep 2023 07:54:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086C520040;
 Fri, 29 Sep 2023 07:54:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BDAB20043;
 Fri, 29 Sep 2023 07:54:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.116.90])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 29 Sep 2023 07:54:48 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 29 Sep 2023 13:24:35 +0530
Message-Id: <20230929075435.72172-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OMBOvtbIg-TV2LaKqenRsHCAyqZict4R
X-Proofpoint-GUID: OMBOvtbIg-TV2LaKqenRsHCAyqZict4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=827
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290063
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:

A misconversion of hugetlb_vmtruncate_list to a prio_tree meant that
on 32-bit machines, truncates at or above 4GB could truncate lower pages,
resulting in BUG_ON()s. This kernel bug was fixed with
'commit 856fc2950555'.

The purpose of this test is to check whether huge pages are handled correctly
when a file is truncated above the 4GB boundary. It ensures that the memory is
not corrupted or lost during the truncation process, and that the expected data
is still present in the memory after truncation.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap39.c  | 171 ++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..7b7c44b77 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..7b923c8fd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c
new file mode 100644
index 000000000..be5cba69f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap39.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ */
+
+/*\
+ *[Descripiton]
+ *
+ * At one stage, a misconversion of hugetlb_vmtruncate_list to a
+ * prio_tree meant that on 32-bit machines, truncates at or above 4GB
+ * could truncate lower pages, resulting in BUG_ON()s.
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
+ * unless you *really* know what you're doing.
+ *
+ */
+
+#define _GNU_SOURCE
+#define _LARGEFILE64_SOURCE
+#define FOURGIG ((off64_t)0x100000000ULL)
+#define MNTPOINT "hugetlbfs/"
+
+#include <signal.h>
+#include <setjmp.h>
+#include "hugetlb.h"
+
+static int page_size;
+static long hpage_size;
+static int fd = -1;
+static volatile int test_pass;
+static int err;
+static int sigbus_count;
+static sigjmp_buf sig_escape;
+
+static void sigbus_handler_fail(int signum, siginfo_t *si, void *uc)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void sigbus_handler_pass(int signum, siginfo_t *si, void *uc)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	long long buggy_offset, truncate_point;
+	void *p, *q;
+	volatile unsigned int *pi, *qi;
+
+	struct sigaction sa_pass = {
+		.sa_sigaction = sigbus_handler_pass,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	struct sigaction sa_fail = {
+		.sa_sigaction = sigbus_handler_pass,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	sigbus_count = 0;
+	test_pass = 0;
+
+	buggy_offset = truncate_point / (hpage_size / page_size);
+	buggy_offset = PALIGN(buggy_offset, hpage_size);
+
+	/* First get arena of three hpages size, at file offset 4GB */
+	q = mmap64(NULL, 3*hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_PRIVATE, fd, truncate_point);
+	if (q == MAP_FAILED)
+		tst_brk(TBROK, "mmap() offset 4GB: %s", strerror(errno));
+	qi = q;
+	/* Touch the high page */
+	*qi = 0;
+
+	/* This part of the test makes the problem more obvious, but
+	 * is not essential.  It can't be done on segmented powerpc, where
+	 * segment restrictions prohibit us from performing such a
+	 * mapping, so skip it there. Similarly, ia64's address space
+	 * restrictions prevent this.
+	 */
+#if (defined(__powerpc__) && defined(PPC_NO_SEGMENTS)) \
+	|| !defined(__powerpc__) && !defined(__powerpc64__) \
+	&& !defined(__ia64__)
+	/* Replace middle hpage by tinypage mapping to trigger
+	 * nr_ptes BUG
+	 */
+	p = mmap64(q + hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		   MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (p != q + hpage_size)
+		tst_brk(TBROK, "mmap() offset 4GB: %s", strerror(errno));
+	pi = p;
+	/* Touch one page to allocate its page table */
+	*pi = 0;
+#endif
+
+	/* Replace top hpage by hpage mapping at confusing file offset */
+	p = mmap64(q + 2*hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_FIXED|MAP_PRIVATE, fd, buggy_offset);
+	if (p != q + 2*hpage_size)
+		tst_brk(TBROK, "mmap() buggy offset 0x%llx", buggy_offset);
+	pi = p;
+	/* Touch the low page with something non-zero */
+	*pi = 1;
+
+	err = ftruncate64(fd, truncate_point);
+	if (err) {
+		tst_res(TFAIL, "ftruncate failed");
+		goto cleanup;
+	}
+
+	SAFE_SIGACTION(SIGBUS, &sa_fail, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		if (*pi != 1) {
+			tst_res(TFAIL, "Data 1 has changed!");
+			goto cleanup;
+		}
+
+	SAFE_SIGACTION(SIGBUS, &sa_pass, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*qi;
+	else
+		sigbus_count++;
+	if (sigbus_count != 1)
+		/* Should have SIGBUSed above */
+		tst_res(TFAIL, "Didn't SIGBUS on truncated page.");
+	if (test_pass == 1)
+		tst_res(TPASS, "Expected SIGBUS");
+
+cleanup:
+	SAFE_MUNMAP(q, 3*hpage_size);
+	SAFE_MUNMAP(p, hpage_size);
+}
+
+static void setup(void)
+{
+	long long truncate_point;
+
+	page_size = getpagesize();
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	truncate_point = FOURGIG;
+	if (hpage_size > truncate_point)
+		tst_brk(TCONF, "Huge page size is too large!");
+	if (truncate_point % hpage_size > 0)
+		tst_brk(TCONF, "Truncation point is not aligned to huge page size!");
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "856fc2950555"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {4, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
+
-- 
2.39.2 (Apple Git-143)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
