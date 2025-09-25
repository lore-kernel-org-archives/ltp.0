Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25703CAC5A5
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 06:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA683CDD0A
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 08:07:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F9973CCF83
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:07:41 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70DC41000612
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:07:37 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P3ZuMd028034;
 Thu, 25 Sep 2025 06:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VldDdJ3684YJO8Blq81sS8doaueBTUgysmriEqZZG
 rQ=; b=XopYf/Lm/aTYO7H9YTjRkL1gNScgBd9P0jopk4z+o2IuTD/fHZn/QTgCm
 et1FBcQzpMz3OjaVA1Kj8oEpGNOSQ01IaPW8k24vMYf8JH6f5DVkGPJsS/+adnwF
 3v7ZPC0ihJ8oglftabPnB66P74Qlep0R07dKYTdy9mx0d4gx5TmYRZoSyFzSsh9b
 x3OWX2Ney4DdCDnAbWhigsZijeoFsTlosoiYAck9hsevSBtd/jVFy7lgtU6oV1/q
 E7zZa0z+2mF9ZqSv8dyU2vslfzGkUTo9JPj5Ffvo7NUwusUHa5m66piUm8ByF8hd
 YykrWLV/ETHiT0sZ8/EbZsVzDaxFw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyu0fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:07:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P2Hict030367;
 Thu, 25 Sep 2025 06:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1c3n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:07:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58P67Xko52953520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 06:07:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C87C620043;
 Thu, 25 Sep 2025 06:07:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC75220040;
 Thu, 25 Sep 2025 06:07:32 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.in.ibm.com (unknown
 [9.109.212.52]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 06:07:32 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Sep 2025 11:37:30 +0530
Message-ID: <20250925060730.1010196-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d4dc28 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=npRE8wLiAAAA:8 a=YGqHw-mjlB8INSgoCskA:9
 a=RAb4T5FLMvhYbp7Aw4eJ:22
X-Proofpoint-GUID: 97OZlCvqzETnA0URXu_6mhkne1wAHfSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX4aUDTBgDSIKK
 z3GDItUD2RP5eRvL5KhliV+a1nucAosE5vWOQyqlFS2Q03JkVvR3b9RvC/c/6k8fOM9umbYE+h4
 TRSXpHsS1TPs16rCLKUsfWF8RcLywnXynLWa2V0/F6aZVgVIVL5/SLojRlj6yVlNM0qN3bOP3JB
 JYCNQ5bcFpRIB2wx5of1M/77UDutz0F7IiTSmpak7B7LXNH6DMvofkjD3NPApkkM2JVti8/UbKp
 QaEYIF9Q0pRPcxiHJ7P4onzwcmxrpa05s5u+6qm4DhxGBESpDAmzycDlEktsC7ZYjURXmAGnlOA
 ELq6nSPAsvistmX7EyjFxkP9rrgA3Ctrp1MT0YR75odP+vNIL44Ms168BDY6eaqoDyMp6rID6zY
 N3R988IV
X-Proofpoint-ORIG-GUID: 97OZlCvqzETnA0URXu_6mhkne1wAHfSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH v3] Migrating the
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
Cc: pavrampu@linux.ibm.com, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Pavithra <pavrampu@linux.vnet.ibm.com>

Test Description:

A misconversion of hugetlb_vmtruncate_list to a prio_tree meant that
on 32-bit machines, truncates at or above 4GB could truncate lower pages,
resulting in BUG_ON()s. This kernel bug was fixed with
'commit 856fc2950555'.

The purpose of this test is to check whether huge pages are handled correctly
when a file is truncated above the 4GB boundary. It ensures that the memory is
not corrupted or lost during the truncation process, and that the expected data
is still present in the memory after truncation.

Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
---
Changes in v3:
- Fixed Warnings
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 170 ++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..bd40a7a30 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap36 hugemmap36
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..2ddef6bf1 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap36
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..a575d601e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,170 @@
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
+static void sigbus_handler_fail(void)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void sigbus_handler_pass(void)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	static long long buggy_offset, truncate_point;
+	void *p, *q;
+	volatile unsigned int *pi, *qi;
+
+	struct sigaction sa_pass = {
+		.sa_sigaction = sigbus_handler_pass,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	struct sigaction sa_fail = {
+    		.sa_sigaction = sigbus_handler_fail,
+    		.sa_flags = SA_SIGINFO,
+	};
+
+	sigbus_count = 0;
+	test_pass = 0;
+
+	buggy_offset = truncate_point / (hpage_size / page_size);
+	buggy_offset = (long long)PALIGN(buggy_offset, hpage_size);
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
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
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
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
