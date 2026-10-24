Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9E606A31E
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jm7xoqMA
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 331AA3E2BBC
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:45:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFF6F3E2553
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:54 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CDC44140123E
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:52 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAEaJX2616745; Fri, 23 Oct 2026 13:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/mlPCPcGhML9WNNnW
 nQOtNsU3Itg6qxOAogZc3Pwvug=; b=Jm7xoqMAMgEQPT55y6KKNJ185sceVMmwJ
 gEWMeAxJmps9SVVXzAdQHx9lCDTTl6h60LZ227Mnelw7Zpc971jqyYFb93PKIoTV
 uAacS/SRLsZUApZ37y2D/yoqF4c/1AxNTjuDsnp6zpSYNWjml8qkr6tmjH/0nUfA
 /3gK1vPuVQn9bOSu30LFRNsZVEChqFqil/WpzvqzA38JM8TcWTKuD3V4lIG5PLQp
 MHErRNcMErvfTwg8ivo83R4h0G9l3FBSiXn3XtY/bokJBlf7hySlLZLxP1CKMV1V
 iIvcEukuLM6GKfPwcIG8I89NHTp8mnZ34bVpGWeH5ysshh4WH/2zw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5acsvn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAYtxK1950362; Fri, 23 Oct 2026 13:44:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgm870-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NDilE026804508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 13:44:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E83C420043;
 Fri, 23 Oct 2026 13:44:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0FA20040;
 Fri, 23 Oct 2026 13:44:46 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 13:44:45 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 04:30:41 +0200
Message-ID: <20261024023044.80055-2-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024023044.80055-1-samir@linux.ibm.com>
References: <20261024023044.80055-1-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXyxOktWBLCj7z
 fFGq9/KA2Ts0LAZZeEEOHYhxvidl0Ne3facTP/sCNIgq+t4PjTmso8Y6pSvYU0UTkQVNH7xn1x5
 CnFfGP5IBxDbg2ckwaVNLqlJAUgv3Ta7qA8RUsCsAP2XF5NJznmlHp7KNCEJWMcpN8DAWNiz2lb
 2AuVjnVeEbtl14sTGxykz5XWBOxoGV6IBcv+68tgTAdgg2UD7If4C3men/Q63dU87xQxrUcNnPK
 FZItjT8X8IvSGzGBFZwSSRiWujileP4+0iRvsYQoIyIapVlasrS9d9ZoH7dO/JYcobC8TNn8AfD
 RmSYDAjcSRNjBZZVh3pKuFJCennLG6+e32/+j9NP274UZlqszLdErgkA3x2PvDAo7szMFf67/JG
 Nd3Bw/wtrW92FoOGqskxOxCCDaZHSwJ5hYPZkplV6vWOuNbnhNckjBDMP+l1I0SCHYDynNzM1QJ
 TNC4hm/DSV/0pKQBZbA==
X-Proofpoint-ORIG-GUID: 2rrVrEU3M_IrQEM55ezv0ofT0Z8pZEp2
X-Proofpoint-GUID: 2rrVrEU3M_IrQEM55ezv0ofT0Z8pZEp2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX9t9FgkvonJSo
 mx0xEirhhLDy8IpDwuhFrNwBeV3hP0EcQ8Qpz0dvj3fqsPN//SfypT4lkkmvi4EaeX+OqFdmsf9
 mee2C5sNYF75E1Osf/qMw8X9pzVg0p0=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6adb64d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CyAHCS5oa0t1xYPjFxQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230053
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/4] sched/psi: Add psi_invalid_trigger01 test
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

Add a test case to verify trigger input validation in /proc/pressure/memory.

In the kernel (kernel/sched/psi.c), the trigger parsing logic (psi_trigger_create)
is identical and shared across /proc/pressure/{cpu,memory,io}. Therefore,
testing /proc/pressure/memory validates the parser for all PSI interfaces.

The test checks that invalid trigger strings return -EINVAL:
- Invalid trigger state (not "some" or "full")
- Missing threshold or window values
- Non-numeric or negative numbers
- Zero threshold or zero window
- Threshold larger than window
- Window larger than the 10 second maximum

It also checks that valid boundary values succeed:
- Smallest threshold (1us)
- Threshold equal to window
- Valid windows of 500ms, 2s, and 10s
- Valid "full" state

Note: The kernel overwrites the last byte of the input buffer with '\0',
so we write strlen() + 1 bytes to prevent losing the last character.

Requires CAP_SYS_RESOURCE for custom window sizes. Reports TCONF if
CONFIG_PSI is not enabled or disabled with psi=0.

This patch also adds the testcases/kernel/sched/psi directory, Makefile,
and .gitignore.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 runtest/sched                                 |   2 +
 testcases/kernel/sched/psi/.gitignore         |   1 +
 testcases/kernel/sched/psi/Makefile           |   7 +
 .../kernel/sched/psi/psi_invalid_trigger01.c  | 135 ++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/sched/psi/.gitignore
 create mode 100644 testcases/kernel/sched/psi/Makefile
 create mode 100644 testcases/kernel/sched/psi/psi_invalid_trigger01.c

diff --git a/runtest/sched b/runtest/sched
index ecedd1a92..cc6e703d7 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -20,3 +20,5 @@ sched_stress sched_stress.sh
 autogroup01 autogroup01
 
 sched_football sched_football
+
+psi_invalid_trigger01 psi_invalid_trigger01
diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
new file mode 100644
index 000000000..1d615553a
--- /dev/null
+++ b/testcases/kernel/sched/psi/.gitignore
@@ -0,0 +1 @@
+/psi_invalid_trigger01
diff --git a/testcases/kernel/sched/psi/Makefile b/testcases/kernel/sched/psi/Makefile
new file mode 100644
index 000000000..18896b6f2
--- /dev/null
+++ b/testcases/kernel/sched/psi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/psi/psi_invalid_trigger01.c b/testcases/kernel/sched/psi/psi_invalid_trigger01.c
new file mode 100644
index 000000000..c532d1ae4
--- /dev/null
+++ b/testcases/kernel/sched/psi/psi_invalid_trigger01.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corp.
+ * Author: Samir Mulani <samir@linux.ibm.com>
+ */
+
+/*\
+ * Verify that the PSI trigger parser rejects invalid trigger definitions
+ * written to /proc/pressure/memory with EINVAL and accepts valid ones.
+ *
+ * Each sub-case opens a fresh file descriptor, because only one trigger can
+ * be registered per open file description (a second write fails with EBUSY).
+ *
+ * Rejected with EINVAL:
+ *
+ * - Invalid state keyword: "invalid 100000 1000000"
+ * - Only state keyword: "some"
+ * - Missing window value: "some 100000"
+ * - Non-numeric threshold: "some abc 1000000"
+ * - Non-numeric window: "some 100000 abc"
+ * - Negative threshold: "some -1 1000000"
+ * - Zero threshold: "some 0 1000000"
+ * - Zero window: "some 100000 0"
+ * - Threshold greater than window: "some 1000001 1000000"
+ * - Window greater than the 10s maximum: "some 100000 10000001"
+ * - Window far above the maximum: "some 100000 4294967295"
+ *
+ * Accepted, the write returns the number of bytes written:
+ *
+ * - Smallest threshold: "some 1 1000000"
+ * - Documented minimum window of 500ms: "some 100000 500000"
+ * - Window of 2s: "some 100000 2000000"
+ * - Threshold equal to window: "some 1000000 1000000"
+ * - Window equal to the 10s maximum: "some 100000 10000000"
+ * - The "full" state: "full 100000 1000000"
+ *
+ * The documentation says that windows below 500ms are not accepted, but the
+ * kernel does not enforce a lower limit, so the test does not check for it.
+ */
+
+#include <string.h>
+
+#include "tst_test.h"
+
+#define PSI_MEM "/proc/pressure/memory"
+
+static struct tcase {
+	const char *desc;
+	const char *input;
+	int exp_errno;		/* 0 = expect success */
+} tcases[] = {
+	{"invalid state keyword", "invalid 100000 1000000", EINVAL},
+	{"only state keyword", "some", EINVAL},
+	{"missing window value", "some 100000", EINVAL},
+	{"non-numeric threshold", "some abc 1000000", EINVAL},
+	{"non-numeric window", "some 100000 abc", EINVAL},
+	{"negative threshold", "some -1 1000000", EINVAL},
+	{"zero threshold", "some 0 1000000", EINVAL},
+	{"zero window", "some 100000 0", EINVAL},
+	{"threshold greater than window", "some 1000001 1000000", EINVAL},
+	{"window greater than 10s maximum", "some 100000 10000001", EINVAL},
+	{"window far above 10s maximum", "some 100000 4294967295", EINVAL},
+	{"smallest threshold", "some 1 1000000", 0},
+	{"500ms window", "some 100000 500000", 0},
+	{"2s window", "some 100000 2000000", 0},
+	{"threshold equal to window", "some 1000000 1000000", 0},
+	{"window equal to 10s maximum", "some 100000 10000000", 0},
+	{"full state", "full 100000 1000000", 0},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	/*
+	 * The kernel overwrites the last byte of the written buffer with
+	 * a NUL, so the terminating '\0' has to be part of the write.
+	 */
+	size_t len = strlen(tc->input) + 1;
+	int fd;
+
+	fd = SAFE_OPEN(PSI_MEM, O_RDWR);
+
+	if (tc->exp_errno) {
+		TST_EXP_FAIL2(write(fd, tc->input, len), tc->exp_errno,
+			      "%s", tc->desc);
+	} else {
+		TEST(write(fd, tc->input, len));
+
+		if (TST_RET == (long)len)
+			tst_res(TPASS, "%s: trigger accepted", tc->desc);
+		else if (TST_RET == -1)
+			tst_res(TFAIL | TTERRNO, "%s: write failed", tc->desc);
+		else
+			tst_res(TFAIL, "%s: wrote %ld bytes, expected %zu",
+				tc->desc, TST_RET, len);
+	}
+
+	SAFE_CLOSE(fd);
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
+	.tcnt = ARRAY_SIZE(tcases),
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
