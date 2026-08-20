Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC2C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C26A3CF094
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 20:27:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573493CE442
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:27:25 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17C50600453
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:27:23 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KGVd3F3088696; Thu, 20 Aug 2026 18:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fxF+TIYaDlZFmGnuQ543/D4F4u3TdbZD/OdsCnhB3
 fs=; b=UZglph0dlGaO3wFjxera6o14Aj7F6Ns7wY6eSlyxrNEofD/2G4q1bZctK
 ousUz+Fr0wSN9KgXlCsK/SDp2yifWIL0Z4JJ6alUqEYLdKns92o/d6D9G11vejhO
 sOAPqXqQSEDecmR7kG6xftSDhoeIQimtVi6zSRd+3Cu+3elomfNpLkjC3GV642zZ
 WxfBGGXyee0AiM93JT1x+282hEXY8kduQwtIc89KrR/rR5typcMEA6DohDEbaZ8Q
 cK21QLbH4za1dJw8+ahpQMo34XkfpgGcEZi10LLc+h4Ns+X15bSr2R6FloY9v8IR
 oDHIGmlWDgC72F7Zy8V2PrfA11ZVg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4c3kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 18:27:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KIQlec025982;
 Thu, 20 Aug 2026 18:27:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekg5yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 18:27:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KIRIrn37421330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 18:27:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4D920040;
 Thu, 20 Aug 2026 18:27:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 751F620043;
 Thu, 20 Aug 2026 18:27:17 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 18:27:17 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Aug 2026 18:25:51 +0530
Message-ID: <20260820125552.47435-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a874709 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3qUHwcN4j66NfFj6SEsA:9
X-Proofpoint-ORIG-GUID: 1LfD1N72uKHv979LTDdJzsi2yhSs6hOh
X-Proofpoint-GUID: 1LfD1N72uKHv979LTDdJzsi2yhSs6hOh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzNSBTYWx0ZWRfXzhI672miKnU+
 R/0tvhwYso+JTeC01FfsnCd+H1qgxNNyGlpd2o1JGnqtYWUmWamFmM8uAo8x6VoK5560tq85ttF
 GcLcnr77AVNHJD81PMxACbceXFjQu9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzNSBTYWx0ZWRfXz6A1Hg+at1vw
 TD45s5sKu2NnQse+KLIoKt76a6aiGpOLE7jXOpGWZyp+Ul/KG54ypzlfRoE2jo4SYCx4MkiFb5b
 zZvu10velWbnJeXARvs6M9PUi7WFHNlF160OD9TgP1+CCJpoU2Y02QfgOclFnEiM3lY9BfK8do7
 bBjGyjCg35qzyxBJBJhDvYc8ojBjiETgQpVcWqUdxWRFN96jsGSzi9CqVMFd9dizijVDKl6va3O
 ccYIec6df2mKwP5Xia3DNtd4GnAymBgVipe8fKVmOmdlf8kEtgv4fZaGamhtFG9Rc9qaSM+nVcD
 bf+zQosMx8XkCLwo0krCt3Ww9AGMkoEs59hGjTNkRF3/d8p8TIgoMgmrfgnfkMKNjeozqc/SYMj
 usARxEck5ok1VPwAtCq36Cuqz7VdNy/zEC8qtsiBFtzEQOOKozhpiD9ZdGDSLw0AcnNJJeLBBSt
 l0QAHRCl9XsD+JcCgAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200135
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] hugetlb/hugeshmat: Add hugeshmat06 migrated from
 libhugetlbfs shm-perms
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
Cc: liwang@redhat.com, Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test shared memory behavior when multiple processes attach to a
hugepage-backed segment with different permissions.

At one point, reservation accounting of free hugepages between the
parent and child processes may become inconsistent during memory
operations. The parent creates a shared memory segment backed by
4 hugepages (permission 0640), attaches it read-write, initialises
each hugepage with a pattern (0x55), then detaches. Child processes
are forked in a loop, each reattaching the segment read-only via
SHM_RDONLY, verifying the data pattern, detaching, and exiting.

If the reservation accounting leaks, repeated read-only attaches
will exhaust the hugepage pool and shmat() will fail. The test
uses raw shmat() in each child and reports this failure as TFAIL.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
Changes in v5:
 1. Use raw shmat() instead of SAFE_SHMAT() and report pool
    exhaustion as TFAIL. HugetlbPages from /proc/<pid>/status
    only tracks mapped pages and can return zero after shmdt()
    even when resv_huge_pages is still leaked, so it is not a
    reliable oracle for this regression. [LTP AI Reviewer]
 2. Remove get_proc_hugetlb_kb() helper and the HugetlbPages
    check as they are no longer needed. [LTP AI Reviewer]
 3. Use IPC_PRIVATE instead of a fixed SEGMENT_KEY to avoid
    accidentally reusing or destroying a pre-existing segment.
    [LTP AI Reviewer]
 4. Drop the deprecated [Description] tag from the /*\ block.
    [LTP AI Reviewer]

Link: https://lore.kernel.org/ltp/49b1dbd9-4c51-414a-806c-1d5cc6b5e1c7@linux.ibm.com/ # v3 
Link: https://lore.kernel.org/ltp/20260820042516.46631-1-samir@linux.ibm.com/ # v4

 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 152 ++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6b35c1f42..1eb5c3339 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -49,6 +49,7 @@ hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
 hugeshmat04 hugeshmat04 -i 5
 hugeshmat05 hugeshmat05 -i 5
+hugeshmat06 hugeshmat06 -i 5
 
 hugeshmctl01 hugeshmctl01 -i 5
 hugeshmctl02 hugeshmctl02 -i 5
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e63a6dde7..704f89d5e 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -45,6 +45,7 @@
 /hugetlb/hugeshmat/hugeshmat03
 /hugetlb/hugeshmat/hugeshmat04
 /hugetlb/hugeshmat/hugeshmat05
+/hugetlb/hugeshmat/hugeshmat06
 /hugetlb/hugeshmctl/hugeshmctl01
 /hugetlb/hugeshmctl/hugeshmctl02
 /hugetlb/hugeshmctl/hugeshmctl03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
new file mode 100644
index 000000000..440d85672
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * Tests shared memory behavior when multiple processes attach to a
+ * hugepage-backed segment with different permissions.
+ *
+ * The parent creates a shared memory segment (permission 0640) backed by
+ * hugepages, attaches it read-write, initialises each hugepage with a
+ * pattern (0x55), then detaches.  A number of child processes are then
+ * forked; each child reattaches the segment read-only (SHM_RDONLY),
+ * verifies the expected pattern in every hugepage, detaches, and exits.
+ *
+ * The original libhugetlbfs shm-perms regression leaked resv_huge_pages
+ * on each read-only attach, eventually exhausting the hugepage reservation
+ * pool.  This is detected by using raw shmat() in each child so that a
+ * pool-exhaustion failure is reported as TFAIL rather than TBROK.
+ */
+
+#include "hugetlb.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define MNTPOINT	"hugetlbfs/"
+#define HPAGES_IN_SEG	4
+#define PATTERN		0x55
+#define MAX_CHILDREN	128
+
+static int global_shmid = -1;
+static long hpage_size;
+static long segment_size;
+
+static void setup(void)
+{
+	int shmid;
+	char *p;
+	int i;
+
+	hpage_size = tst_get_hugepage_size();
+	if (!hpage_size)
+		tst_brk(TCONF, "Hugepages are not supported");
+
+	segment_size = HPAGES_IN_SEG * hpage_size;
+
+	/* Create the hugepage SHM segment with 0640 permissions */
+	shmid = SAFE_SHMGET(IPC_PRIVATE, segment_size,
+			    IPC_CREAT | SHM_HUGETLB | 0640);
+	global_shmid = shmid;
+
+	/* Attach read-write, write a known pattern into each hugepage */
+	p = SAFE_SHMAT(shmid, NULL, 0);
+
+	for (i = 0; i < HPAGES_IN_SEG; i++)
+		memset(p + (i * hpage_size), PATTERN, hpage_size);
+
+	SAFE_SHMDT((const void *)p);
+}
+
+static void cleanup(void)
+{
+	if (global_shmid >= 0)
+		SAFE_SHMCTL(global_shmid, IPC_RMID, NULL);
+}
+
+static void run_test(void)
+{
+	int i, iterations;
+	pid_t pid;
+
+	/*
+	 * Number of attach/detach cycles to exercise reservation accounting.
+	 * Use tst_hugepages (reserved by the framework) but cap at
+	 * MAX_CHILDREN to avoid spawning an unreasonable number of children
+	 * on large-memory machines.
+	 */
+	iterations = MIN((long)tst_hugepages, (long)MAX_CHILDREN);
+
+	tst_res(TINFO, "Running %d child attach/detach iterations", iterations);
+
+	for (i = 0; i < iterations; i++) {
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			/* ---- child ---- */
+			char *shmaddr;
+			int j;
+
+			/*
+			 * Use raw shmat() instead of SAFE_SHMAT() so that a
+			 * failure caused by resv_huge_pages exhaustion is
+			 * reported as TFAIL, not TBROK.
+			 */
+			shmaddr = shmat(global_shmid, NULL, SHM_RDONLY);
+			if (shmaddr == (void *)-1) {
+				tst_res(TFAIL | TERRNO,
+					"Child %d: shmat() failed, hugepage reservation pool may be exhausted",
+					getpid());
+				exit(EXIT_FAILURE);
+			}
+
+			tst_res(TINFO, "Child %d attached segment successfully",
+				getpid());
+
+			/* Verify the pattern written by the parent */
+			for (j = 0; j < HPAGES_IN_SEG; j++) {
+				unsigned char val =
+					*((unsigned char *)shmaddr +
+					  (j * hpage_size));
+
+				if (val != PATTERN) {
+					tst_res(TFAIL,
+						"Child %d: hugepage[%d] data mismatch: got 0x%02x, expected 0x%02x",
+						getpid(), j, (unsigned int)val, PATTERN);
+					SAFE_SHMDT((const void *)shmaddr);
+					exit(EXIT_FAILURE);
+				}
+			}
+
+			SAFE_SHMDT((const void *)shmaddr);
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	/*
+	 * Wait for all children.  tst_reap_children() calls tst_brk(TBROK)
+	 * if any child exited non-zero, so a TFAIL inside a child is
+	 * automatically promoted to a test-level failure here.
+	 */
+	tst_reap_children();
+
+	tst_res(TPASS,
+		"All %d children attached read-only and verified reservation accounting",
+		iterations);
+}
+
+static struct tst_test test = {
+	.needs_root	 = 1,
+	.mntpoint	 = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir	 = 1,
+	.forks_child	 = 1,
+	.setup		 = setup,
+	.cleanup	 = cleanup,
+	.test_all	 = run_test,
+	/*
+	 * Request HPAGES_IN_SEG hugepages; that is all the test needs.
+	 * TST_NEEDS means the test is skipped if the kernel cannot
+	 * provide them.
+	 */
+	.hugepages	 = {HPAGES_IN_SEG, TST_NEEDS},
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
