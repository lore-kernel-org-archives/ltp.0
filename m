Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4191606A32D
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PaqzrpfV
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62B513CFC38
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 05:44:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 148743C2037
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 05:44:31 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E7C1200346
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 05:44:29 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7319oT263839; Sat, 7 Nov 2026 04:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vp49C/6s1GdlLDsGy0zGu/ppdlBZFJLUtATRRZJls
 40=; b=PaqzrpfVuVLbamirz5OJYc0ADrU0kh6DpDSoZx/YfUGtKY3fn4iRho/1k
 SYe8IpG8ccDaVkJaYjGEKfJJ44Mv7yL9lkniRXc4Cpy+FIVK+nM9VK0mnn4o47z1
 RKIyf4wX7qjHft7sMIQMf1ILW2GVEB6fDNKLmavBp/wD8QDLaJgsye5jIwuZMHHU
 jhm+MSLFLP2W4xNRYdQsw/UooYJq19icLi8XwW36KqNOrJ6WV0hYEcvlY+Bp2iaj
 vQ5fRa/Mzv4Js0ddlwstd9Pl2l1SGryAFTBEDbzbgZDOc3UCu5q06J/jy5JcDvYc
 oE01DqIRAFKXFs6uuhQgEjb0CcyDw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq68aut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 04:44:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A72KBiG3328378; Sat, 7 Nov 2026 04:44:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h19222-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Nov 2026 04:44:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A74iNuA28705034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Nov 2026 04:44:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 303382004B;
 Sat,  7 Nov 2026 04:44:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13FF320040;
 Sat,  7 Nov 2026 04:44:22 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.90.129]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Nov 2026 04:44:21 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  7 Nov 2026 10:14:15 +0530
Message-ID: <20261107044415.35996-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxOCBTYWx0ZWRfX0LJYsnlbx+xL
 9qcHphxO9DlG6NDqXC1X/xOEcqKQUHCCkne8Fp/kHR3xjC1HGW8+PkTaJ03u09BnMkdrhsGpKjt
 DBJa4GhyMkCNhpASUzH11jmwNUlnIvI=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6aeeacab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hbf9TXK99ZFYK83OPnMA:9
X-Proofpoint-ORIG-GUID: WsInxLUB9HugtVJ2kpIklyMrg_ZRVp6k
X-Proofpoint-GUID: WsInxLUB9HugtVJ2kpIklyMrg_ZRVp6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxOCBTYWx0ZWRfX7wxhqlDHo3EH
 uUvSTXvPNuOTlS+DtMoTTPahenjLaFKkKwjdaAvKxxZzND74/GhOkHnDewH7TdvY2sEP2MB5Wdo
 TjWVXchknEwfhRdlDU8ow/CkCiK+4anasQbDgsKu/ns9cCUvVdki6hUWD2CeyXvXE7b6iVSsva5
 JIi6gAClHMxL+JLM74+4Iob3TKFKImIL0uBIxwRT8Tq0FzyhT8VlzdqtIeJIwUoeA3mYLrf3ZXy
 8WZVQOWkcar9iytwvWiCkcC5nbTIlkygg4zpBsGCQK+fveBL5pByQeUUu4hMIdfOrIM87hORdzu
 QcUiDY+kdFC2/LV4t4cJd5W8tOreZB5VSHAowsI9n7+1ZD09QPQvG+pBLyEGMDZ5MI3eJq/Z0BH
 0lrgAGz9R6YGhAdTeGC1hsuQ7zrj4MfIqpS92HVCqPFXd/s+nHCQrjZcjAeUL47MnPpyrNTzfgc
 4EaTwGOne3jfk3ctXgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070018
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] hugetlb/hugeshmget: Add hugeshmget07 to test
 SHM_HUGETLB with /dev/zero read
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test that a hugepage-backed shared memory segment can be created,
attached, read into via /dev/zero, detached and removed without
errors.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v8 -> v9:
- zero_fd is now opened in setup() and closed in cleanup() behind an fd != -1 guard,
  so it is closed even if SAFE_SHMGET() or SAFE_SHMAT() aborts.
- Dropped the redundant shmid = -1 after SAFE_SHMCTL.
Link to v8: https://lore.kernel.org/ltp/20260923083300.54026-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget07.c     | 69 +++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index fd687a14e..131ac740f 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -64,3 +64,4 @@ hugeshmget02 hugeshmget02 -i 10
 hugeshmget03 hugeshmget03 -i 10
 hugeshmget05 hugeshmget05 -i 10
 hugeshmget06 hugeshmget06 -i 10
+hugeshmget07 hugeshmget07 -i 10
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 763f134dd..0924b7217 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -56,6 +56,7 @@
 /hugetlb/hugeshmget/hugeshmget03
 /hugetlb/hugeshmget/hugeshmget05
 /hugetlb/hugeshmget/hugeshmget06
+/hugetlb/hugeshmget/hugeshmget07
 /ksm/ksm01
 /ksm/ksm02
 /ksm/ksm03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c
new file mode 100644
index 000000000..d5f74ec8f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Test :manpage:`shmget(2)` shared memory segment with hugepages.
+ *
+ * A hugepage-backed shared memory segment is created and attached to
+ * the process address space. The test reads one hugepage at a time
+ * from ``/dev/zero`` directly into the shared memory region,
+ * verifying that each read delivers the full hugepage worth of data.
+ * The segment is then detached and removed.
+ *
+ * Requires root for :manpage:`shmget(2)` with ``SHM_HUGETLB``.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define NR_HUGEPAGES 2
+
+static int shmid = -1;
+static int zero_fd = -1;
+static long hpage_size;
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	zero_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+
+	if (zero_fd != -1)
+		SAFE_CLOSE(zero_fd);
+}
+
+static void run_test(void)
+{
+	size_t i;
+	size_t size = hpage_size * NR_HUGEPAGES;
+	char *shmaddr;
+
+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB | SHM_R | SHM_W);
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p", shmaddr);
+
+	for (i = 0; i < size; i += hpage_size) {
+		TST_EXP_VAL(read(zero_fd, shmaddr + i, hpage_size),
+			(ssize_t)hpage_size);
+	}
+
+	SAFE_SHMDT(shmaddr);
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
