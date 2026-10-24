Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC065606A31B
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RkrgkV+K
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15E863E9BF6
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:45:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0A313E9BEE
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 065D114060A0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:57 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAE6oD2718998; Fri, 23 Oct 2026 13:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=R+m/qCjGvS7hC9Ctr
 glXq5CwQeno2Bc6fC9Zalz3cJE=; b=RkrgkV+KoYiQHwLfR6xYI0JN3Hogm8tb9
 Yq8GSqpTURxgbU+fFO8U+hv1gvP9wGRb+4ky2envjFaAOw8y/AmS6ZQ3pwcIzxk8
 EDO1ySos6s5+BJItByyywy7Z1ZNUMS5y/Hu5O2m1SoUEaGDxYl9bfw2UjlQHK0+h
 6FPJolP8m3VtSlWZ0hOv+3SLw56rgE7gr1jGEyb928YEzHpf/JtQrSyWApD8tYGo
 yHPITodMgvl4DmpUzKc9UfaqzVk/7AYBGy4dvkFDfUWspabhHdmPrDnRWJS3ZnYD
 sLkVXbl1bR1X5q92rvW+JIVZMSBSWvsz20QwalM+NNtUJruLR4Zmg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw595gq6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAJsNt1912466; Fri, 23 Oct 2026 13:44:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg250bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NDiokO31851198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 13:44:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 147B020040;
 Fri, 23 Oct 2026 13:44:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CAE320043;
 Fri, 23 Oct 2026 13:44:49 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 13:44:49 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 04:30:42 +0200
Message-ID: <20261024023044.80055-3-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024023044.80055-1-samir@linux.ibm.com>
References: <20261024023044.80055-1-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oxJ4okLKNNUYx2SSby8Z3J0aa7SO45up
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX0Itzwwx8QcMb
 3DF9Y/t+IPIqJayqFzcokjAYMQX8PReZlaxkg0qI4MeisN/ed3ENt3Ua6c4msyJSIaYerqLbFNq
 snv59PJqQ08vsu0kiaYs/hWi9vrGL/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX/PQHfYT5jmVy
 Xk9lAaG0BUZfu8jGz8idOErOrfxMpxALP57cU5SaN0sk34UfEIuoKbwpGjYCd0bXkhi+2yml1+W
 3+rEFPa5Ue6sAUUYRz11iQWjzdbFgp+uu/sFDTQh8c756S9zm9wIZ1+QYgubKjPld/IL7yF2xET
 TWfS/CKPOsrdNnb/iKKjtqoh7tPGUNBjtMHuWVtUViqQzAM+Qgf1ZQSwhmNxh7jnDE8iXVE2z0w
 Qm5f7OqxqGvJmf05iK32gNF9KbzE4M1FYfkZBoxc8z0cyFOREgTFwZPRKyRdylIoW4iCiB9a9I6
 KpR0gsXmGvKRcIvQRbC0r+ik8G/Hn9cKG7VZOTos6YmM35FGHaLsR7wUvPPygNBTAQyAmbO0s2d
 OhVQAg0iT8/rzE8rQbr3BWXYBDOlbSBpZPKF5MZddL5/QaC3C8BpLlTpfogVYi0zWTChFekPhZM
 7mUmoPtNIlgLP5TQFkg==
X-Proofpoint-ORIG-GUID: oxJ4okLKNNUYx2SSby8Z3J0aa7SO45up
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb64d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HZIO0whCsIwEQ1cZDKkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230053
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/4] sched/psi: Add psi_multiple_trigger01 test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test case to check that only one PSI trigger can be registered
on a single open file description.

The test verifies that:
- Writing the first trigger to an open pressure file succeeds.
- Writing a second trigger to the same file descriptor fails with -EBUSY.
- Writing a second trigger through a dup() descriptor also fails with -EBUSY.
- Opening two separate file descriptors allows registering two independent
  triggers without conflict.

The test requires CAP_SYS_RESOURCE and reports TCONF if PSI is disabled.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 runtest/sched                                 |   1 +
 testcases/kernel/sched/psi/.gitignore         |   1 +
 .../kernel/sched/psi/psi_multiple_trigger01.c | 172 ++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 testcases/kernel/sched/psi/psi_multiple_trigger01.c

diff --git a/runtest/sched b/runtest/sched
index cc6e703d7..b6dc478a0 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -22,3 +22,4 @@ autogroup01 autogroup01
 sched_football sched_football
 
 psi_invalid_trigger01 psi_invalid_trigger01
+psi_multiple_trigger01 psi_multiple_trigger01
diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
index 1d615553a..23a5e6567 100644
--- a/testcases/kernel/sched/psi/.gitignore
+++ b/testcases/kernel/sched/psi/.gitignore
@@ -1 +1,2 @@
 /psi_invalid_trigger01
+/psi_multiple_trigger01
diff --git a/testcases/kernel/sched/psi/psi_multiple_trigger01.c b/testcases/kernel/sched/psi/psi_multiple_trigger01.c
new file mode 100644
index 000000000..5859bd580
--- /dev/null
+++ b/testcases/kernel/sched/psi/psi_multiple_trigger01.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corp.
+ * Author: Samir Mulani <samir@linux.ibm.com>
+ */
+
+/*\
+ * Verify that only one PSI trigger can be registered per open file
+ * description.
+ *
+ * Documentation/accounting/psi.rst states: "Write operations to a file
+ * descriptor with an already existing psi trigger will fail with EBUSY."
+ *
+ * - Writing a valid trigger to a freshly opened file succeeds.
+ * - Writing a second trigger through the same file descriptor fails with
+ *   EBUSY.
+ * - Writing a second trigger through a dup() of the file descriptor fails
+ *   with EBUSY, because both descriptors share one open file description.
+ * - Two separately opened files accept different triggers.
+ * - Two separately opened files accept the same trigger.
+ * - After the file holding a trigger is closed a new file accepts a trigger.
+ *
+ * The cases with separately opened files confirm that the limit is per open
+ * file description and not per trigger definition.
+ */
+
+#include <string.h>
+
+#include "tst_test.h"
+
+#define PSI_MEM "/proc/pressure/memory"
+#define TRIG_A "some 100000 1000000"
+#define TRIG_B "full 200000 2000000"
+
+/*
+ * The kernel overwrites the last byte of the written buffer with a NUL, so
+ * the terminating '\0' has to be part of the write.
+ */
+#define TRIG_LEN(trig) ((long)strlen(trig) + 1)
+#define WRITE_TRIG(fd, trig) write((fd), (trig), TRIG_LEN(trig))
+
+#define SET_TRIG(fd, trig) \
+	SAFE_WRITE(SAFE_WRITE_ALL, (fd), (trig), TRIG_LEN(trig))
+
+static void first_write_succeeds(void)
+{
+	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	TST_EXP_VAL(WRITE_TRIG(fd, TRIG_A), TRIG_LEN(TRIG_A),
+		    "first write to a fresh fd");
+
+	SAFE_CLOSE(fd);
+}
+
+static void second_write_ebusy(void)
+{
+	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	SET_TRIG(fd, TRIG_A);
+
+	TST_EXP_FAIL2(WRITE_TRIG(fd, TRIG_B), EBUSY,
+		      "second write to the same fd");
+
+	SAFE_CLOSE(fd);
+}
+
+static void dup_fd_shares_trigger(void)
+{
+	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+	int dup_fd = SAFE_DUP(fd);
+
+	SET_TRIG(fd, TRIG_A);
+
+	TST_EXP_FAIL2(WRITE_TRIG(dup_fd, TRIG_B), EBUSY,
+		      "write to a dup() of an fd that has a trigger");
+
+	SAFE_CLOSE(dup_fd);
+	SAFE_CLOSE(fd);
+}
+
+static void two_fds_different_triggers(void)
+{
+	int fd1 = SAFE_OPEN(PSI_MEM, O_RDWR);
+	int fd2 = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	TST_EXP_VAL(WRITE_TRIG(fd1, TRIG_A), TRIG_LEN(TRIG_A),
+		    "fd1 write trigger A");
+	TST_EXP_VAL(WRITE_TRIG(fd2, TRIG_B), TRIG_LEN(TRIG_B),
+		    "fd2 write trigger B");
+
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
+}
+
+static void two_fds_same_trigger(void)
+{
+	int fd1 = SAFE_OPEN(PSI_MEM, O_RDWR);
+	int fd2 = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	TST_EXP_VAL(WRITE_TRIG(fd1, TRIG_A), TRIG_LEN(TRIG_A),
+		    "fd1 write trigger A");
+	TST_EXP_VAL(WRITE_TRIG(fd2, TRIG_A), TRIG_LEN(TRIG_A),
+		    "fd2 write trigger A again");
+
+	SAFE_CLOSE(fd1);
+	SAFE_CLOSE(fd2);
+}
+
+static void trigger_after_close(void)
+{
+	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	SET_TRIG(fd, TRIG_A);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	TST_EXP_VAL(WRITE_TRIG(fd, TRIG_B), TRIG_LEN(TRIG_B),
+		    "write a trigger after closing the previous fd");
+
+	SAFE_CLOSE(fd);
+}
+
+static void (*const tests[])(void) = {
+	first_write_succeeds,
+	second_write_ebusy,
+	dup_fd_shares_trigger,
+	two_fds_different_triggers,
+	two_fds_same_trigger,
+	trigger_after_close,
+};
+
+static void run(unsigned int n)
+{
+	tests[n]();
+}
+
+static void setup(void)
+{
+	char buf[64];
+	int fd;
+
+	if (access(PSI_MEM, F_OK))
+		tst_brk(TCONF, "%s not available (CONFIG_PSI not set)", PSI_MEM);
+
+	fd = SAFE_OPEN(PSI_MEM, O_RDONLY);
+
+	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
+	if (read(fd, buf, sizeof(buf)) < 0) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
+
+		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_MEM);
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tests),
+	.test = run,
+	.setup = setup,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_RESOURCE),
+		{}
+	},
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_PSI=y",
+		NULL
+	},
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
