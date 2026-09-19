Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69DDC982D7
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 15:16:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE8723E72AB
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 17:16:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D27E3E7189
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:16:14 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55EE110005C4
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 17:16:12 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JDZiB2064385
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 15:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=etmMXMnZpn7l3jtfRm6ERBePPi12hKxBIoa+QuML2
 pE=; b=By22TiiMk0yWZHqsE/LAiarB0shRwaxmrUegWbKaWbCSecA4L3wH8j8uY
 malOFUX0RSlyN1bTaDADJZ1r42tVoU3r+X5DfFk3Fk4lCRIbjsaHcI40KLr+5rWX
 P/mgsMTepkau1e7xeK9PTr6/hjyVgCM88DDP9zh+ip5TmEJ4o0AQIk+36d60wHBR
 tYVovzwV+Vu97mf7IUER8moZt3gNVbROvratLchQV7WK/czWMPeQF4FkwVT9S5/j
 u/TtXun9XvHxjKvyHQ1m8bIBDp+yFq4tl2GXNwlKteZXF3rO3Icc5gLYjaXdTuzD
 zI9SBODGk6SGdR9FEUFVmwOfeQfVw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgrsj9p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 15:16:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JDIICl2474330
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 15:16:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsk3q1keb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 15:16:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68JFG6tc30933600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2026 15:16:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A50D20043;
 Sat, 19 Sep 2026 15:16:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B42520040;
 Sat, 19 Sep 2026 15:16:05 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.97.187]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2026 15:16:05 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 20:46:02 +0530
Message-ID: <20260919151602.1039825-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6aaea73a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dKYrag7ThPpB7sSXuvwA:9
X-Proofpoint-ORIG-GUID: ocAKhHFh1ZRi4Z3Bq8lMQXS8dr92g7iR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDIxOSBTYWx0ZWRfX+Zo28WrogatR
 150tXgmerGzFtTDza5yDMMGO3B5YHfHkcvEOqKB8MhI0CdsP7T5cCzIDeoXwOgVqCMezovwPRRg
 JX+EPXM35CxeYhm7hrQLstcG5e9qoL98ucjsWh3BoQphMB78MVyyRVMj2iDx4GKk6fzlLEHg8ap
 6BuGyoQqBSStB0+iaVE8wdXBePXkCyo4auu90NSDPtmMMJSe7GPArBYsmcQZTyh6GtunwM9TW0/
 +PoKnixV5C8fLpREQxJ7ta6Z5A3TYJrauuIICYeGv1sfwUGnMhDB6cQ/cajn2oF9TEFaho4GlDB
 IxOh6kK1WDsnrVgqGwvhPwoZxZQFNJk0nekYsymoa6SoarO/8Vn8wTxLT5qPTkjCuBNDiOTzMV2
 FQBgDHgwvTudHNopK0xu+VoLLHhbQoGSuXb4TSEugjb04ED4j3epZfFlDmWIPfTl7s8td4pIXDm
 5PWvYI4Y+P65eSKKHPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDIxOSBTYWx0ZWRfX1P6QR5w6cOOa
 NLTi53cL1wZMlM53Etlzzjf3G3e5QyNztR0aiDlv1KTk1fjp+MZXd1G9K0HAa9UaEXsQnWv0+Rf
 Jk1OFFraz9PQ855IXgpep50sHGfA/G0=
X-Proofpoint-GUID: ocAKhHFh1ZRi4Z3Bq8lMQXS8dr92g7iR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190219
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] syscalls/shmget: Add shmget07 to test SHM_HUGETLB
 with raw device read
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

Test that a hugepage-backed shared memory segment can be created,
attached, written to via /dev/zero, detached and removed without
errors.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v6 -> v7:
- Fix read() destination not advancing per iteration (shmaddr ->
  shmaddr + i)
- Add SAFE_SHMCTL(IPC_RMID) and reset shmid = -1 at end of run_test()
  to fix hugepage pool leak between iterations (ENOMEM on -i 2)
- Add SAFE_CLOSE(raw_fd) to fix fd leak
- Use NR_HUGEPAGES in .hugepages struct instead of magic literal 2
Link to v6: https://lore.kernel.org/ltp/20260311070235.206921-1-pavrampu@linux.ibm.com/
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/shmget/.gitignore |  1 +
 testcases/kernel/syscalls/shmget/shmget07.c | 76 +++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/shmget/shmget07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index accdf2df9..e6b0f3f0b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1593,6 +1593,7 @@ shmget03 shmget03
 shmget04 shmget04
 shmget05 shmget05
 shmget06 shmget06
+shmget07 shmget07
 
 shutdown01 shutdown01
 shutdown02 shutdown02
diff --git a/testcases/kernel/syscalls/shmget/.gitignore b/testcases/kernel/syscalls/shmget/.gitignore
index 768d1c69d..23ba002b5 100644
--- a/testcases/kernel/syscalls/shmget/.gitignore
+++ b/testcases/kernel/syscalls/shmget/.gitignore
@@ -3,3 +3,4 @@
 /shmget04
 /shmget05
 /shmget06
+/shmget07
diff --git a/testcases/kernel/syscalls/shmget/shmget07.c b/testcases/kernel/syscalls/shmget/shmget07.c
new file mode 100644
index 000000000..f862f1dd5
--- /dev/null
+++ b/testcases/kernel/syscalls/shmget/shmget07.c
@@ -0,0 +1,76 @@
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
+ * from :file:`/dev/zero` directly into the shared memory region,
+ * verifying that each read delivers the full hugepage worth of data.
+ * The segment is then detached and removed.
+ *
+ * Requires root for :manpage:`shmget(2)` with ``SHM_HUGETLB``.
+ */
+
+#include "tst_test.h"
+#include "tst_hugepage.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define NR_HUGEPAGES 2
+
+static int shmid = -1;
+static long hpage_size;
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static void run_test(void)
+{
+	size_t i;
+	size_t size = hpage_size * NR_HUGEPAGES;
+	char *shmaddr;
+	int raw_fd;
+
+	raw_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+
+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB|SHM_R|SHM_W);
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p", shmaddr);
+
+	/* Read a page from device and write to shm segment */
+
+	for (i = 0; i < size; i += hpage_size) {
+		TEST(read(raw_fd, shmaddr + i, hpage_size));
+		if (TST_RET != hpage_size) {
+			tst_res(TFAIL | TERRNO, "Can't read full page from raw device!");
+			break;
+		}
+		tst_res(TPASS, "Read full page from raw device");
+	}
+
+	SAFE_CLOSE(raw_fd);
+	SAFE_SHMDT(shmaddr);
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+	shmid = -1;
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
