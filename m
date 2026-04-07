Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F4EF4ECD
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 11:43:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED143D2269
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 13:43:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D87D83C2F5B
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 13:42:42 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC0F060013D
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 13:42:41 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635NfDPh3866508; Mon, 6 Apr 2026 11:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iW2bXk0Z36vCO3+y1FHBYIgPjNifSvX6x+rZ4Eg90
 /k=; b=XebH4AdZ1IoX64nX1wtbvQKj+icr51WUui06VeDElij2e2w6VCpCqymB3
 rYFd+Y5en8NjuXAOdJ8ASUceKF/cjBA8V0WWeVcaVmvTi6CD66S0YXIikLKw1IF1
 3Hya+J42zBRSXw0TI4lM946vYMw4JumoS85LM74lVWyZI31713TqV0+zyWunYslp
 mECehFkMAx9CT9EEPUfGrqu/+vF7rKHR1iF9+PwHJySZYOR0TY9o/uEPSF5oup4z
 CqQcpPEe/uT7FRd1+ZktH84AHGAp5EYF+LpcYHY6I2l1BnhsH6m6a1UU+1wwuND3
 vtRnEYOvYylS1WyDw01gvIDrEpeSA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2pcd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 11:42:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636BdSFC020570;
 Mon, 6 Apr 2026 11:42:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdyncf48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 11:42:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 636BgY5c52691410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 11:42:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BEF2004B;
 Mon,  6 Apr 2026 11:42:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37EF720040;
 Mon,  6 Apr 2026 11:42:33 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 11:42:33 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  7 Apr 2026 10:36:34 +0530
Message-ID: <20260407050634.124265-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDExMSBTYWx0ZWRfX+2xCLz5UXNPC
 EP1cd+HJ/KOwGxqRrGsJobx6pC+FnYiH0wIxqCHfxVAHduMeXW6+dRa+nxxxhiso5jjmy2H0yiv
 nyFLlS7cbNT6zwfs+tHImjGpmhATXPwca8SFIOCHat9nwqvXm3TX39WwJyk0m3Eq2FDsds38Cuy
 eUt86J7l1O7Ou0jFTAYflmsQBkqnNeN4Nu5tt75vPnT2wUq9lxXSmDc4k/xG/f/PQt8R7tsLV4r
 BS0JktmiQlA5kTeXwcI5087iDV9vVPxJwOx31EaV+gFVdvXLyVWjt19J8LfzcYo8padcrW6vIbc
 ceT7LHo1IyIQMMsUgRcXak8M6dv/hLy9FX6+IItAM6zbCiX3M1AbCgc1opTBNHeMqx33TGaN+nX
 TmWnOfbGJlwRQvXcANkJTRgudVfp6ENBMXNfw8DCO3b5tsCPFzP25lGtzc0q3QpZr6UVc6//DgX
 Afm20Th2LwqJjyAmOKQ==
X-Proofpoint-GUID: pj3fAVar4CB0OiKEVCAMZIHJgtFhbdyA
X-Proofpoint-ORIG-GUID: pj3fAVar4CB0OiKEVCAMZIHJgtFhbdyA
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d39c2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VcyuwuPAi_hLocmJvkYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060111
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] hugemmap37: Migrate truncate_sigbus_versus_oom
 from libhugetlbfs
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
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some kernels have a bug in the positioning of the test against
i_size. This bug means that attempting to instantiate a page
beyond the end of a hugepage file can result in an OOM and SIGKILL
instead of the correct SIGBUS.

This test verifies that accessing memory beyond a truncated hugepage
file correctly triggers SIGBUS rather than causing an OOM condition.

Signed-off-by: Samir <samir@linux.ibm.com>
---
v6:
1. Fixed description: Removed dangling comma and improved clarity
2. Added 'static' keyword to setup() and cleanup() functions
3. Fixed signal handler initialization:
   - Zero-initialized struct sigaction with = {}
   - Added sigemptyset(&sa.sa_mask)
   - Removed SA_SIGINFO flag (using sa_handler, not sa_sigaction)
4. Removed dead code: Deleted unused totpages assignment from setup()
5. Fixed resource leaks in run_test():
   - Added SAFE_MUNMAP() for both mapped regions (p and q)
   - Added SAFE_CLOSE() for both file descriptors (fd and fdx)
   - Reset fd and fdx to -1 after closing
6. Fixed cleanup() checks: Changed 'if (fd > 0)' to 'if (fd != -1)'
7. Initialized file descriptors to -1 at declaration
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 106 ++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..8aaafeee3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap37 hugemmap37
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..38d428fe8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap37
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
new file mode 100644
index 000000000..06813b976
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * Some kernels have a bug in the positioning of the test against
+ * i_size. This bug means that attempting to instantiate a page
+ * beyond the end of a hugepage file can result in an OOM and SIGKILL
+ * instead of the correct SIGBUS.
+ *
+ * The test:
+ * - Creates a hugepage file and maps it
+ * - Truncates the file to 0 size
+ * - Allocates all available hugepages to create memory pressure
+ * - Attempts to access the mapped memory
+ * - Verifies SIGBUS is received (correct behavior)
+ */
+
+#include "hugetlb.h"
+#include <setjmp.h>
+#include <signal.h>
+
+#define MNTPOINT "hugetlbfs/"
+static int fd = -1, fdx = -1;
+
+static unsigned long long hpage_size;
+static unsigned long totpages;
+
+static sigjmp_buf sig_escape;
+static volatile int test_pass;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long i;
+
+	test_pass = 0;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+
+	fdx = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			fdx, 0);
+	/* Touch the pages to ensure they're removed from the pool */
+	for (i = 0; i < totpages; i++) {
+		volatile char *x = (volatile char *)q + i * hpage_size;
+		*x = 0;
+	}
+	/* SIGBUS is what *should* happen */
+	SAFE_FTRUNCATE(fdx, 0);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*((volatile unsigned int *)p);
+
+	if (test_pass)
+		tst_res(TPASS, "Expected SIGBUS triggered");
+	else
+		tst_res(TFAIL, "Didn't SIGBUS");
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, totpages * hpage_size);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fdx);
+	fd = -1;
+	fdx = -1;
+}
+
+static void setup(void)
+{
+	struct sigaction sa = {};
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+	if (fdx != -1)
+		SAFE_CLOSE(fdx);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]){{"linux-git", "ebed4bfc8da8"}, {}},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
