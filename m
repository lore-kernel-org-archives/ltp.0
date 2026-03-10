Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A87DEFCD9F
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 09:50:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A53E3E52E8
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 10:50:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8805B3DE7E0
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 10:50:18 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5CAE51A00928
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 10:50:16 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9l15t1491572; Tue, 10 Mar 2026 09:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=bVH/UJUKpuIpHnynp8PW0hPF+J+Ba8xQrHddBBmDQ
 as=; b=U/myZ9lH1s9eg1LIXtCb2+RCVqfkzKC6wkR/fNocUSb93kTBqpqDCfOU+
 wwU6i/DQ6WLGLzd6Q2wINC8/DxCzc36iso3bEzmzBbmdZnF039siFsESPAeDc6kM
 j34J97/aCxGlvOR3Y8kNgrxxaErI+z8R5MpH/ZFEFuCiXVlATDdhfS+PcEJPD7+Q
 wPj8Ko0xaXW/xsQtt6aalphJxN2peGvPoNjMWehshalaE2HXY31eqCRY8AUoii4k
 As0g70P37VQmWwVBlhGfgs7D9JL/BP4N+Gk23RkdnqY89F3jrV7IuFDEduNPqM3f
 edvQaNklgicavInVOhUXGv2Cp/asA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuya9b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 09:50:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A5cFeu029850;
 Tue, 10 Mar 2026 09:50:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6un5qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 09:50:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62A9o8Il16712046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 09:50:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D488D2004B;
 Tue, 10 Mar 2026 09:50:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E64320043;
 Tue, 10 Mar 2026 09:50:06 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.32]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 09:50:05 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 10 Mar 2026 15:19:58 +0530
Message-ID: <20260310094958.95381-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69afe956 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=npRE8wLiAAAA:8
 a=V7HiF2tqQ_5XaP8Lp5YA:9 a=RAb4T5FLMvhYbp7Aw4eJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4MSBTYWx0ZWRfXyZ3uEShMlzpf
 cUDaTMcbXYrKmXl4Z6QG7aRDa2U/WMkM9OarR2K9kHjSlQD2ZzVnTj6/GcZNb2EIgNTV2MTWXz6
 sbtMuIxW63ppP5NL8c9J+CXwsxByQslYb2pnWsUFE0VLlq68z4dsxm34eV0qhlbkiiqocLnHkIO
 9xxgBeAf7HDt4idk+rJbnefYl/tV8UBG62vIuGkim9OJH0k/tpC+N1PoON49vrmnpOWF7StNtyD
 PzajRasyx0u30tXUVjR/8RKQUgqUR9R9fb+X8LUFtgcRUks3Jm0aH9sUSgGydSQXbRvlf9/ixcY
 3rH3XVpvFzJwOIS06rXiz1LiqSpYeY2g96z3jA8CN8aK8ROaU4Tvc62pABzPgNufKScEj58rlu4
 dyvwp3I/8PtmqloLhC5Xti+SrxejBiBTj7yKeZQ1ULzC3YBqvTvPBMM2z90zcDszSQEqVhv5CpR
 MgaDZeLcnyb4j2oeRBQ==
X-Proofpoint-GUID: jy4mYfDsxd87IaaqO1qV1CX90qknzBUp
X-Proofpoint-ORIG-GUID: jy4mYfDsxd87IaaqO1qV1CX90qknzBUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100081
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH] [PATCH v4] Migrating the
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes in v4:
- Fixed make check errors
- Used SAFE_MMAP instead on mmap64
- Used SAFE_FTRUNCATE instaed of ftruncate64
- Used only test_pass flag
- Removed check "truncate_point % hpage_size > 0"

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 153 ++++++++++++++++++
 3 files changed, 155 insertions(+)
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
index 000000000..848d5c128
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,153 @@
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
+		.sa_sigaction = sigbus_handler_fail,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	test_pass = 0;
+
+	buggy_offset = truncate_point / (hpage_size / page_size);
+	buggy_offset = (long long)PALIGN(buggy_offset, hpage_size);
+
+	/* First get arena of three hpages size, at file offset 4GB */
+	q = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_PRIVATE, fd, truncate_point);
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
+#if (defined(__powerpc__) && defined(PPC_NO_SEGMENTS)) || \
+	!defined(__powerpc__) && !defined(__powerpc64__) && \
+	!defined(__ia64__)
+	/* Replace middle hpage by tinypage mapping to trigger
+	 * nr_ptes BUG
+	 */
+	p = SAFE_MMAP(q + hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
+	pi = p;
+	/* Touch one page to allocate its page table */
+	*pi = 0;
+#endif
+
+	/* Replace top hpage by hpage mapping at confusing file offset */
+	p = SAFE_MMAP(q + 2*hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_FIXED|MAP_PRIVATE, fd, buggy_offset);
+	pi = p;
+	/* Touch the low page with something non-zero */
+	*pi = 1;
+
+	SAFE_FTRUNCATE(fd, truncate_point);
+
+	SAFE_SIGACTION(SIGBUS, &sa_fail, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		if (*pi != 1) {
+			tst_res(TFAIL, "Data 1 has changed!");
+			goto cleanup;
+		}
+
+	SAFE_SIGACTION(SIGBUS, &sa_pass, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0) {
+		*qi;
+		tst_res(TFAIL, "Didn't SIGBUS on truncated page.");
+	}
+
+	if (test_pass)
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
