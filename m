Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C286FD7072
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:23:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B33E73E1D3A
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 11:23:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B853C9C84
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:23:21 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E6B1200AFE
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:23:19 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H7G00O693890; Tue, 17 Mar 2026 10:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=R0rV7gpbBPxTeUNsxe8jyNOnFrGvnwEL0cTRY2wBy
 3g=; b=SFXE4YmiS5J+gX+hD4Q260RqEtUpD/eMlkI5MQCG5Kx8aWqoILzfA/Nd+
 7EJ909shkoqsqr7tkbDisfecVBQKbPuoiwjy1nnI6ppA3b5u0xlOaXfTTfkTRe+B
 pRzC+PY30/Gs5kuIWMEzv6RjuoUfnfUO7X8Ftn+bfot87xjw4MWisF/Bc66J4Nlt
 dhMcE1XiZozdFxtHN3DsLAKrYdc7s05rtVwhypwaWRNmuWZYxJF6mvwKg4KLOyxM
 Kn3R4h4akY5lWK3gQlTf2ohG0s5Ey1uT1fL6IylYfVJzHeHQ+4gTuUGSRr0iS208
 KjhKDKtZzDzUXaXFzfANeqckiH/cA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaubn17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 10:23:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7QsWK032346;
 Tue, 17 Mar 2026 10:23:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jrg1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 10:23:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HANC0544106176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 10:23:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAA562004F;
 Tue, 17 Mar 2026 10:23:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D879F2004E;
 Tue, 17 Mar 2026 10:23:11 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 10:23:11 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 17 Mar 2026 11:20:59 +0100
Message-ID: <20260317102059.6699-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA5MCBTYWx0ZWRfX4zw7jAQ2EvQc
 MY8OFX7LwD6JHQwoplzKZ+EP3XkBHMf+KlE52oQcDjARyimZBuVMgxdqtwMYo1jETf+oLnlOo1B
 mD5NYArYAN7/iqdClpqeV+Kycd5Kr6ihb4g3pteN0P7oJLNjmUlLTh73U/eSBOc9h+Xhz8Qobb1
 oF0E5OzxB9IRNKh3QQ/AciXqLyOwlSn1y/kRAaFE/Zg6hvgk7ZWfbTLQsuBYCEa4cWOw5PWwgZL
 kbconmfSTLDNVCqTyp0iDRHdVqCHSTpIQAaqhWDI8Xnba2tfRG02AExcaD7tkC3VFCCiwgMt/Iu
 uShStwGXEcSoBJHX32gKG1E1yViH2ww3voU0jKIId+wLiuex2WsiSSncfYq6x1PwseJq2yOgtM6
 wSWeoLazJO5BEo65k77SYI0hCaoGDd4YZ8jFJNzu0TSFupDDOdX1GVauMGOKTHKCRbrXcsZHdX/
 Xnp7iFF6JksUE+iEOrA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b92b96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pUv85iYMAo1k4DxLkLcA:9
X-Proofpoint-ORIG-GUID: BHS_0VWN5XHQ1J_brB3FVJq8mTR2arwC
X-Proofpoint-GUID: BHS_0VWN5XHQ1J_brB3FVJq8mTR2arwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170090
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In this test case, we are verifying the bug fix commit that is attached as a part of the test case structure,

Some kernel have a bug in the positioning of the test against
i_size.  This bug means that attempting to instantiate a page
beyond the end of a hugepage file can result in an OOM and SIGKILL
instead of the correct SIGBUS.

Signed-off-by: Samir <samir@linux.ibm.com>
---
v5:
1. Addressed typo issue from discription of the test.
2. Removed [Description] tag
3. Removed unused variable.
4. Moved struct sigaction sa this variable in to setup function.
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  | 92 +++++++++++++++++++
 3 files changed, 94 insertions(+)
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
index 000000000..300787a65
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * Some kernels have a bug in the positioning of the test against
+ * i_size.  This bug means that attempting to instantiate a page
+ * beyond the end of a hugepage file can result in an OOM and SIGKILL
+ * instead of the correct SIGBUS.
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
+}
+
+void setup(void)
+{
+	struct sigaction sa;
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_handler = sigbus_handler;
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	hpage_size = tst_get_hugepage_size();
+}
+
+void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (fdx > 0)
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
