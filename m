Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFDE606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rlGlrt1G
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A5183E9BE2
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:45:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DF983E9BE6
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9661602ADD
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:59 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAEa0s2720925; Fri, 23 Oct 2026 13:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Mwssc+3RqF6k0laFb
 koKDNmNBw6PG07fI3W2D4OLccM=; b=rlGlrt1GnErjH20y/XwDbDN649RP3QFS4
 MgkMN2Uu1y1OpoPcfjvmkB9e49xN4TuZvS8fQp7XiIjDBTLWTVduZyjYvrwKtJ1F
 Aw3bEPnvHV6e+pih46BfIpd8ih40qaOGzFyvObxldlVrvnTr0Ut8WPN76di0qahN
 riDWh/bIbgVVIiu7uonIjVZOwae8Ysr7ws04LYWN1EGZMVRBNLC6mjy84KrDOU+c
 ST6/DBczUIPh0JbHVm7dMR2iN0MCaZjVwvPAXhr8rSRXqBkLjjEzUuVL07KysMHK
 IpakvomzfUPmn6JFnCdL4beWVRzknPN15/pw6LLLML/gTYtyFaqXQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw595gqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAK6J81967202; Fri, 23 Oct 2026 13:44:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x5bu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NDiqtW51052926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 13:44:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD98F2004D;
 Fri, 23 Oct 2026 13:44:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11D9620043;
 Fri, 23 Oct 2026 13:44:52 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 13:44:51 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 04:30:43 +0200
Message-ID: <20261024023044.80055-4-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024023044.80055-1-samir@linux.ibm.com>
References: <20261024023044.80055-1-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T-w64pLbozgjQbYwe0nDn6WPD9Q7zHU-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX0gkKEOcRMBQc
 57N+462gr4K2ySth0uuU2S629rJRjBp8W1/5hwIJkg11bFw5sH3+ekgh6cjmXoM9/WnQ7vIB4BN
 7fp+0OnnxM68wNt6kHW9HM5/BIZT5g4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX1WxcsuH6J2BO
 S1H2hE+pFMkotGM6GZuLx52Jte7Z4hvDjMni3Or3duD+952oXNX/jsf3zsf2+tL5kyz+Ya62QOo
 lIx+4ysDdxZq/XlZvqq/4XpvNF5+eYbKZQVM/N5TXDmRnlEmXt7qbuqQXrsfnzhq+9E/mh7nXZz
 AMzutL89np5DBePqocqFGrIRqAoo8FaGRUWk1LVewRiRdsZywxfbu/oQzpKEBsLvDAPKiZiBF3T
 ogDU+p6h+263pzA7cVV1kA69DJkeWPqtS8ny6f2R6O/Ps4IRyVBr5/uXAES/+tHfQAiVlxalX4l
 pdk+7/Sm6W3Z0pmnUhqmR8oMJtqHFKsomJn9hIiDX4nvvmbGwGou9pVfcqEsciaowASJAxPO1uV
 YyTJ6ffSaNN1wqbpN+yGwJ1fjpbuWFz9+UVteDdbPPzfBc0dw0sqSpVm1zL69m6u0Dn/uxT8Mbb
 bd/VbAk3F+eA3gpSQrQ==
X-Proofpoint-ORIG-GUID: T-w64pLbozgjQbYwe0nDn6WPD9Q7zHU-
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb64d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ruHWQOf4x4ve5cAvcikA:9
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/4] sched/psi: Add psi_proc_format01 test
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

Add a test case to verify the format and values in /proc/pressure/{cpu,memory,io}.

The test checks that:
- Each file has valid "some" and "full" lines with avg10, avg60, avg300,
  and total fields.
- Averages are valid percentages between 0.00 and 100.00.
- Total stall times do not decrease over time.
- /proc/pressure/cpu reports "full" lines as 0.00 (per Linux 5.13+ behavior).

This test does not generate heavy system load and only validates interface
parsing. It reports TCONF if PSI is disabled.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 runtest/sched                                 |   1 +
 testcases/kernel/sched/psi/.gitignore         |   1 +
 .../kernel/sched/psi/psi_proc_format01.c      | 191 ++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 testcases/kernel/sched/psi/psi_proc_format01.c

diff --git a/runtest/sched b/runtest/sched
index b6dc478a0..0651fafd9 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -23,3 +23,4 @@ sched_football sched_football
 
 psi_invalid_trigger01 psi_invalid_trigger01
 psi_multiple_trigger01 psi_multiple_trigger01
+psi_proc_format01 psi_proc_format01
diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
index 23a5e6567..8d1083ff2 100644
--- a/testcases/kernel/sched/psi/.gitignore
+++ b/testcases/kernel/sched/psi/.gitignore
@@ -1,2 +1,3 @@
 /psi_invalid_trigger01
 /psi_multiple_trigger01
+/psi_proc_format01
diff --git a/testcases/kernel/sched/psi/psi_proc_format01.c b/testcases/kernel/sched/psi/psi_proc_format01.c
new file mode 100644
index 000000000..7467e13d5
--- /dev/null
+++ b/testcases/kernel/sched/psi/psi_proc_format01.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corp.
+ * Author: Samir Mulani <samir@linux.ibm.com>
+ */
+
+/*\
+ * Verify the format of the PSI files in /proc/pressure/.
+ *
+ * - /proc/pressure/{cpu,memory,io} have two lines labelled "some" and "full",
+ *   each one carrying avg10, avg60, avg300 and total.
+ * - The averages are percentages, so they have to be between 0 and 100.
+ * - The totals never decrease between two consecutive reads.
+ * - The "full" line of /proc/pressure/cpu is always zero, the full stall
+ *   state is undefined at the system level and is reported as zero for
+ *   backward compatibility since Linux 5.13.
+ *
+ * The accounting of the counters under load is tested by psi_accounting01.
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define PSI_CPU "/proc/pressure/cpu"
+#define PSI_MEM "/proc/pressure/memory"
+#define PSI_IO "/proc/pressure/io"
+
+struct psi_line {
+	char label[8];
+	double avg10;
+	double avg60;
+	double avg300;
+	unsigned long long total;
+};
+
+struct psi_snap {
+	struct psi_line some;
+	struct psi_line full;
+};
+
+#define PSI_LINE "%7s avg10=%lf avg60=%lf avg300=%lf total=%llu"
+
+static const char *const paths[] = {PSI_CPU, PSI_MEM, PSI_IO};
+
+/* Returns 0 if both lines were parsed, -1 otherwise */
+static int read_psi(const char *path, struct psi_snap *snap)
+{
+	FILE *fp = SAFE_FOPEN(path, "r");
+	int ret;
+
+	ret = fscanf(fp, PSI_LINE " " PSI_LINE,
+		snap->some.label, &snap->some.avg10, &snap->some.avg60,
+		&snap->some.avg300, &snap->some.total,
+		snap->full.label, &snap->full.avg10, &snap->full.avg60,
+		&snap->full.avg300, &snap->full.total);
+
+	SAFE_FCLOSE(fp);
+
+	if (ret != 10) {
+		tst_res(TFAIL, "%s: parsed %d/10 values", path, ret);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int avg_valid(double avg)
+{
+	/* A NaN fails both comparisons */
+	return avg >= 0.0 && avg <= 100.0;
+}
+
+static int line_valid(const char *path, const struct psi_line *line,
+		      const char *label)
+{
+	if (strcmp(line->label, label)) {
+		tst_res(TFAIL, "%s: label is '%s', expected '%s'",
+			path, line->label, label);
+		return 0;
+	}
+
+	if (!avg_valid(line->avg10) || !avg_valid(line->avg60) ||
+	    !avg_valid(line->avg300)) {
+		tst_res(TFAIL, "%s: '%s' averages out of range: %.2f %.2f %.2f",
+			path, label, line->avg10, line->avg60, line->avg300);
+		return 0;
+	}
+
+	return 1;
+}
+
+static void verify_format(unsigned int n)
+{
+	struct psi_snap snap;
+
+	if (read_psi(paths[n], &snap))
+		return;
+
+	if (line_valid(paths[n], &snap.some, "some") &&
+	    line_valid(paths[n], &snap.full, "full"))
+		tst_res(TPASS, "%s has the expected format", paths[n]);
+}
+
+static void verify_monotonic(unsigned int n)
+{
+	struct psi_snap first, second;
+	int i;
+
+	if (read_psi(paths[n], &first))
+		return;
+
+	for (i = 0; i < 10; i++) {
+		usleep(10000);
+
+		if (read_psi(paths[n], &second))
+			return;
+
+		if (second.some.total < first.some.total ||
+		    second.full.total < first.full.total) {
+			tst_res(TFAIL,
+				"%s: a total decreased: some %llu -> %llu, full %llu -> %llu",
+				paths[n], first.some.total, second.some.total,
+				first.full.total, second.full.total);
+			return;
+		}
+
+		first = second;
+	}
+
+	tst_res(TPASS, "%s totals never decrease", paths[n]);
+}
+
+static void verify_cpu_full_zero(void)
+{
+	struct psi_snap snap;
+
+	if (read_psi(PSI_CPU, &snap))
+		return;
+
+	if (snap.full.total || snap.full.avg10 || snap.full.avg60 ||
+	    snap.full.avg300)
+		tst_res(TFAIL, "%s full line is not zero: avg10=%.2f total=%llu",
+			PSI_CPU, snap.full.avg10, snap.full.total);
+	else
+		tst_res(TPASS, "%s full line is zero", PSI_CPU);
+}
+
+static void run(unsigned int n)
+{
+	if (n < ARRAY_SIZE(paths))
+		verify_format(n);
+	else if (n < 2 * ARRAY_SIZE(paths))
+		verify_monotonic(n - ARRAY_SIZE(paths));
+	else
+		verify_cpu_full_zero();
+}
+
+static void setup(void)
+{
+	char buf[64];
+	int fd;
+
+	if (access(PSI_CPU, F_OK))
+		tst_brk(TCONF, "%s not available (CONFIG_PSI not set)", PSI_CPU);
+
+	fd = SAFE_OPEN(PSI_CPU, O_RDONLY);
+
+	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
+	if (read(fd, buf, sizeof(buf)) < 0) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
+
+		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_CPU);
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = 2 * ARRAY_SIZE(paths) + 1,
+	.test = run,
+	.setup = setup,
+	.min_kver = "5.13",
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_PSI=y",
+		NULL
+	},
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
