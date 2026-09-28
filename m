Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BCC98328
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 05:20:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C1203C5885
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 07:20:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210073E590F
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 07:19:13 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29D8220074D
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 07:19:12 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RHoQKN029915; Mon, 28 Sep 2026 05:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6TzaDUetEZr5MeJFz
 3pPx08zS11t941M/opSu6Q5s8I=; b=kRzHfgMZrm+1EhVj2W2s0IJ+trWpnb+3l
 DTPA5SXTyNP/wdR1uO22vPZ+OJ5SY9EIYvpIOUB7NfZXB40d57zkJdcbzzFFH44p
 p+mGx3narM0MHd9vT5tXMq10HebYHZcavsqBcLc908EhtOce/ShPnUq92+fHa+tn
 4Rotx5lpGvw3uHKmBvxOz3fBWyHTGjp7plIM4SImNP8003a5+VvkvDUtljrCfmCr
 91cfL4dOE4fZ/GRbm3j6qsgbL1la8tvRuRPmvK7AXX8mZ++7BYQVhwdCtp2YPxmV
 9Uaw2UG03zy5HRttWCQ2a1fA41xiDbBQHF2UlWv+D+DpL6SoOu8Mw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fjye3k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 05:19:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S4V1pq879748; Mon, 28 Sep 2026 05:19:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg3kek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 05:19:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68S5J7u938535678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 05:19:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E004D2004D;
 Mon, 28 Sep 2026 05:19:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11E4B20040;
 Mon, 28 Sep 2026 05:19:06 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 05:19:05 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 07:17:35 +0200
Message-ID: <20260928051740.591819-3-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928051740.591819-1-samir@linux.ibm.com>
References: <20260928051740.591819-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vS9McJhYCxdqWoUR_wefbZoRX583IKJQ
X-Proofpoint-GUID: vS9McJhYCxdqWoUR_wefbZoRX583IKJQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX1uz3CRb8sjxV
 pLaIpqBQJWHZ39MLRw5cO97iDrLpzj2WqpNR3N5xa25PkPz/GqumJfAicsAdkg0reaIbN8/gg1e
 HHUZNOXGoW68FpYNvesFq9cTznse7B8=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6ab9f8cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=E2Uj_D3y4ugP-Tpr_icA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfXx1hkB8neJS0f
 Y6VKyDeJuezBKxPgEzPbNiMkdi+FO+9DQ2KJR88oyczj4ys2cHeorx5fFOgxcw0KoR3uH+t0/iW
 ks01EGYIomDNBPcq8m/V684aeLAqe8GSkvC0c387yfGizz0RWUg2XU5ngG05nJ5fMnK1Cou3tWk
 8/jS4iCTbKTXxs1Et2KbzT7MHDDZdCxnYksRVweipGRNW99+Siko3oTUMvSviDAA8WhCFve6Ng9
 UkF62R6D1hJsIk7IXiHBxlAXOlnTRh0/CUqpULLXz3mmpwNuTGC8gBJyOFVpaSxCT2TEK9w4TfS
 YVxewaNI3NuyQQDRYe9cTTLGU/ujm7dranbX2BUbaCzkAy5MGRdyLSPMLWtKI2jSkxUkUbeqTvF
 qk8QioO8bWaDzhgLJB5hIxp2Itb6sW841CwxJTNOi2P/VqwnqenJrcspTAlWW9+zCnY9VEiGAEA
 FE5p7wIW2+g0RQ9qyEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280020
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cgroup: Add invalid burst test
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I added cpu_max_burst_invalid01 to test that the cpu.max.burst
interface in cgroupv2 correctly rejects invalid input values. The
kernel's tg_set_bandwidth() in kernel/sched/core.c rejects bad burst
values with EINVAL and must not change the previously stored burst
value.

Test scenarios:
  TC1 - Writing burst = quota+1 (exceeds quota) and burst = "-1"
        (negative value) must both be rejected with EINVAL and the
        burst value must remain unchanged.
  TC2 - Writing a value where burst+quota exceeds the kernel MAX_BW
        and writing "abc" (garbage string) must both be rejected with
        EINVAL.
  TC3 - Writing a value that overflows the nanosecond conversion and
        writing "100xyz" (trailing garbage) must both be rejected with
        EINVAL.
  TC4 - After five consecutive rejected writes the burst value must
        remain unchanged.
  TC5 - With unlimited quota, burst > quota is accepted; after
        re-enabling a finite quota the same burst value must be
        rejected with EINVAL.

Requires CONFIG_CFS_BANDWIDTH=y and cgroupv2 cpu controller.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/.gitignore      |   1 +
 .../cgroup/cpu_max_burst_invalid01.c          | 417 ++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/cpu_max_burst_invalid01.c

diff --git a/runtest/controllers b/runtest/controllers
index aa93ea5af..b0c7ca3c4 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -4,6 +4,7 @@ cgroup_core02	cgroup_core02
 cgroup_core03	cgroup_core03
 cgroup		cgroup_regression_test.sh
 cpu_max_burst01  cpu_max_burst01
+cpu_max_burst_invalid01  cpu_max_burst_invalid01
 memcg_regression	memcg_regression_test.sh
 memcg_test_3	memcg_test_3
 memcg_failcnt memcg_failcnt.sh
diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index 2506388fd..0cc5ead44 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -4,3 +4,4 @@
 /cgroup_core02
 /cgroup_core03
 /cpu_max_burst01
+/cpu_max_burst_invalid01
diff --git a/testcases/kernel/controllers/cgroup/cpu_max_burst_invalid01.c b/testcases/kernel/controllers/cgroup/cpu_max_burst_invalid01.c
new file mode 100644
index 000000000..cca92e178
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cpu_max_burst_invalid01.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Samir Mulani, IBM Corporation
+ */
+
+/*\
+ * Negative / invalid-input tests for the cgroupv2 cpu.max.burst interface.
+ *
+ * The kernel's tg_set_bandwidth() (kernel/sched/core.c) imposes several
+ * hard constraints on the burst_us value written to cpu.max.burst.  Every
+ * invalid write must be rejected with EINVAL and must not modify the
+ * previously stored burst value.
+ *
+ * Kernel validation constraints from tg_set_bandwidth():
+ *   (A) burst_us > (U64_MAX / NSEC_PER_USEC)    -> EINVAL (nsec overflow)
+ *   (B) burst_us > quota_us                      -> EINVAL (exceeds quota)
+ *   (C) burst_us + quota_us > MAX_BW             -> EINVAL (sum overflow)
+ *   (D) Non-numeric / garbage string             -> EINVAL (parse error)
+ *   (E) Negative integer written as string       -> EINVAL (parse error)
+ *
+ * Test scenarios:
+ *   TC 1 - Boundary and sign violations: burst = quota+1 (B) and burst = "-1"
+ *          (E) must both be rejected with EINVAL, value unchanged.
+ *   TC 2 - Overflow and garbage: burst+quota > MAX_BW (C) and burst = "abc"
+ *          (D) must both be rejected with EINVAL, value unchanged.
+ *   TC 3 - Numeric overflow variants: burst overflows nsec translation (A)
+ *          and trailing garbage "100xyz" (D) must both be rejected.
+ *   TC 4 - Burst stable after a sequence of rejected writes.
+ *   TC 5 - Burst vs quota transition: unlimited -> finite quota.
+ *
+ * Requires: CONFIG_CFS_BANDWIDTH=y, cgroup v2 cpu controller.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+#define PERIOD_US	100000ULL
+#define QUOTA_US	 20000ULL
+#define BURST_US	 10000ULL
+
+/* MAX_BW_US: kernel max_bw_runtime_us = (1 << BW_SHIFT) * USEC_PER_SEC */
+#define MAX_BW_US	(((uint64_t)1 << 20) * 1000000ULL)
+
+static struct tst_cg_group *cg_child;
+
+static int cg_dirfd(const struct tst_cg_group *cg)
+{
+	int fd = tst_cg_group_unified_dir_fd(cg);
+
+	if (fd < 0)
+		tst_brk(TBROK, "tst_cg_group_unified_dir_fd returned %d", fd);
+	return fd;
+}
+
+static unsigned long long cg_read_ull(const struct tst_cg_group *cg,
+				      const char *fname)
+{
+	char buf[64];
+	char *endp;
+	unsigned long long val;
+
+	SAFE_FILE_READAT(cg_dirfd(cg), fname, buf, sizeof(buf) - 1);
+
+	val = strtoull(buf, &endp, 10);
+	if (endp == buf)
+		tst_brk(TBROK, "strtoull failed on '%s' from %s", buf, fname);
+	return val;
+}
+
+/*
+ * cg_write_str() - write @str to @fname; returns errno on failure.
+ * Uses raw write(2) so callers can inspect the error without aborting.
+ */
+static int cg_write_str(const struct tst_cg_group *cg,
+			const char *fname, const char *str)
+{
+	int fd, saved = 0;
+	ssize_t n;
+
+	fd = SAFE_OPENAT(cg_dirfd(cg), fname, O_WRONLY);
+	n  = write(fd, str, strlen(str));
+	if (n < 0)
+		saved = errno;
+	SAFE_CLOSE(fd);
+	return saved;
+}
+
+static void cg_write_str_safe(const struct tst_cg_group *cg,
+			      const char *fname, const char *str)
+{
+	SAFE_FILE_PRINTFAT(cg_dirfd(cg), fname, "%s", str);
+}
+
+static void set_cpu_max(const struct tst_cg_group *cg,
+			unsigned long long quota_us,
+			unsigned long long period_us)
+{
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "%llu %llu", quota_us, period_us);
+	cg_write_str_safe(cg, "cpu.max", buf);
+}
+
+static unsigned long long read_burst(const struct tst_cg_group *cg)
+{
+	return cg_read_ull(cg, "cpu.max.burst");
+}
+
+/* try_write_burst() - attempt a burst write; returns errno on failure. */
+static int try_write_burst(const struct tst_cg_group *cg,
+			   unsigned long long burst_us)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "%llu", burst_us);
+	return cg_write_str(cg, "cpu.max.burst", buf);
+}
+
+/* try_write_burst_str() - write a raw string; returns errno on failure. */
+static int try_write_burst_str(const struct tst_cg_group *cg, const char *str)
+{
+	return cg_write_str(cg, "cpu.max.burst", str);
+}
+
+/*
+ * check_rejected() - verify the write returned EINVAL and that the stored
+ * burst value is unchanged (rejected writes must not corrupt kernel state).
+ */
+static void check_rejected(const char *label, int err,
+			    unsigned long long expected_burst)
+{
+	unsigned long long actual_burst;
+
+	if (!err) {
+		tst_res(TFAIL, "%s: write succeeded unexpectedly (expected EINVAL)",
+			label);
+		return;
+	}
+
+	if (err != EINVAL) {
+		tst_res(TFAIL, "%s: got errno=%d (%s), expected EINVAL",
+			label, err, tst_strerrno(err));
+		return;
+	}
+
+	actual_burst = read_burst(cg_child);
+	if (actual_burst != expected_burst) {
+		tst_res(TFAIL, "%s: burst corrupted after rejected write (expected %llu us, got %llu us)",
+			label, expected_burst, actual_burst);
+		return;
+	}
+
+	tst_res(TPASS, "%s: write rejected (errno=EINVAL), burst unchanged (%llu us)",
+		label, actual_burst);
+}
+
+/*
+ * tc1_boundary_and_negative - burst > quota and negative integer rejected.
+ *
+ * quota+1 is the smallest violation; "-1" exercises the unsigned parser
+ * boundary.  Both writes must return EINVAL and leave burst unchanged.
+ */
+static void tc1_boundary_and_negative(void)
+{
+	int err;
+
+	cg_child = tst_cg_group_mk(tst_cg, "inv_tc1");
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+	cg_write_str_safe(cg_child, "cpu.max.burst", "10000");
+
+	err = try_write_burst(cg_child, QUOTA_US + 1);
+	check_rejected("burst=quota+1", err, BURST_US);
+
+	err = try_write_burst_str(cg_child, "-1");
+	check_rejected("burst=\"-1\"", err, BURST_US);
+
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+/*
+ * tc2_overflow_and_garbage - sum overflow and non-numeric string rejected.
+ *
+ * Uses burst <= quota so only the sum-overflow check fires; "abc" exercises
+ * the non-numeric parse path.  Both must return EINVAL.
+ */
+static void tc2_overflow_and_garbage(void)
+{
+	const unsigned long long quota_large = MAX_BW_US / 2 + 1;
+	const unsigned long long burst_large = MAX_BW_US / 2;
+	char buf[64];
+	int fd, err;
+	ssize_t n;
+
+	cg_child = tst_cg_group_mk(tst_cg, "inv_tc2");
+
+	snprintf(buf, sizeof(buf), "%llu %llu", quota_large, PERIOD_US);
+	fd = SAFE_OPENAT(cg_dirfd(cg_child), "cpu.max", O_WRONLY);
+	n  = write(fd, buf, strlen(buf));
+	SAFE_CLOSE(fd);
+	if (n < 0) {
+		tst_res(TCONF,
+			"%s: cannot set quota=%llu us (exceeds kernel MAX_BW), skipping",
+			__func__, quota_large);
+	} else {
+		err = try_write_burst(cg_child, burst_large);
+		if (!err) {
+			/*
+			 * burst_large <= quota_large so the burst>quota check
+			 * passed; the sum check did not fire.  This kernel's
+			 * MAX_BW is larger than our compile-time constant.
+			 */
+			tst_res(TCONF,
+				"%s: burst=%llu accepted (kernel MAX_BW exceeds compile-time estimate), skipping",
+				__func__, burst_large);
+			/* Clear burst before reducing quota to avoid EINVAL. */
+			cg_write_str_safe(cg_child, "cpu.max.burst", "0");
+		} else {
+			check_rejected("burst+quota>MAX_BW", err, 0ULL);
+		}
+	}
+
+	/* Reset to a small quota; burst must be 0 at this point. */
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+
+	err = try_write_burst_str(cg_child, "abc");
+	check_rejected("burst=\"abc\"", err, 0ULL);
+
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+/*
+ * tc3_nsec_overflow_and_trailing_garbage - nsec overflow and trailing
+ * garbage rejected.
+ *
+ * A value above U64_MAX/1000 overflows the internal ns conversion.
+ * "100xyz" must be rejected entirely, not silently truncated to 100.
+ */
+static void tc3_nsec_overflow_and_trailing_garbage(void)
+{
+	const unsigned long long overflow_val = (UINT64_MAX / 1000ULL) + 1ULL;
+	int err;
+
+	cg_child = tst_cg_group_mk(tst_cg, "inv_tc3");
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+
+	err = try_write_burst(cg_child, overflow_val);
+	check_rejected("burst>U64_MAX/NSEC_PER_USEC", err, 0ULL);
+
+	err = try_write_burst_str(cg_child, "100xyz");
+	check_rejected("burst=\"100xyz\"", err, 0ULL);
+
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+/*
+ * tc4_stable_after_rejections - burst value stable after repeated rejected
+ * writes.
+ *
+ * Repeated invalid writes must not partially corrupt the stored burst value.
+ */
+static void tc4_stable_after_rejections(void)
+{
+	struct {
+		unsigned long long val;
+		const char        *str;
+		const char        *label;
+	} bad[] = {
+		{ QUOTA_US + 1,  NULL,   "quota+1"    },
+		{ QUOTA_US * 5,  NULL,   "quota*5"    },
+		{ UINT64_MAX,    NULL,   "UINT64_MAX" },
+		{ 0,             "bad",  "\"bad\""    },
+		{ 0,             "-999", "\"-999\""   },
+	};
+	unsigned long long burst_after;
+	unsigned int i;
+	int err;
+
+	cg_child = tst_cg_group_mk(tst_cg, "inv_tc4");
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+	cg_write_str_safe(cg_child, "cpu.max.burst", "10000");
+
+	for (i = 0; i < ARRAY_SIZE(bad); i++) {
+		if (bad[i].str)
+			err = try_write_burst_str(cg_child, bad[i].str);
+		else
+			err = try_write_burst(cg_child, bad[i].val);
+
+		if (!err) {
+			tst_res(TFAIL,
+				"%s: bad write [%s] unexpectedly succeeded (expected EINVAL)",
+				__func__, bad[i].label);
+			continue;
+		}
+		if (err != EINVAL) {
+			tst_res(TFAIL,
+				"%s: bad write [%s] got errno=%d (%s), expected EINVAL",
+				__func__, bad[i].label, err, tst_strerrno(err));
+		}
+	}
+
+	burst_after = read_burst(cg_child);
+	if (burst_after == BURST_US)
+		tst_res(TPASS,
+			"%s: burst remains %llu us after %zu rejected writes",
+			__func__, BURST_US, ARRAY_SIZE(bad));
+	else
+		tst_res(TFAIL,
+			"%s: burst corrupted: expected %llu us, got %llu us",
+			__func__, BURST_US, burst_after);
+
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+/*
+ * tc5_quota_transition - burst > quota rejected after re-enabling finite quota.
+ *
+ * With unlimited quota the burst > quota check is skipped; re-enabling
+ * a finite quota must then cause the same burst value to be rejected.
+ */
+static void tc5_quota_transition(void)
+{
+	int err;
+	unsigned long long burst_after;
+
+	cg_child = tst_cg_group_mk(tst_cg, "inv_tc5");
+
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+	cg_write_str_safe(cg_child, "cpu.max", "max 100000");
+
+	err = try_write_burst(cg_child, QUOTA_US + 1);
+	burst_after = read_burst(cg_child);
+
+	if (err != 0) {
+		tst_res(TCONF,
+			"%s: burst=%llu rejected with unlimited quota (errno=%d) -- kernel enforces stricter check, skip",
+			__func__, QUOTA_US + 1, err);
+		cg_child = tst_cg_group_rm(cg_child);
+		return;
+	}
+
+	if (burst_after != QUOTA_US + 1) {
+		tst_res(TFAIL,
+			"%s: burst readback mismatch: expected %llu, got %llu",
+			__func__, QUOTA_US + 1, burst_after);
+		cg_child = tst_cg_group_rm(cg_child);
+		return;
+	}
+
+	tst_res(TPASS,
+		"%s: burst=%llu accepted with unlimited quota",
+		__func__, QUOTA_US + 1);
+
+	cg_write_str_safe(cg_child, "cpu.max.burst", "0");
+	set_cpu_max(cg_child, QUOTA_US, PERIOD_US);
+
+	err = try_write_burst(cg_child, QUOTA_US + 1);
+	check_rejected("burst>quota after re-enable", err, 0ULL);
+
+	cg_child = tst_cg_group_rm(cg_child);
+}
+
+static void (*const tc_funcs[])(void) = {
+	tc1_boundary_and_negative,
+	tc2_overflow_and_garbage,
+	tc3_nsec_overflow_and_trailing_garbage,
+	tc4_stable_after_rejections,
+	tc5_quota_transition,
+};
+
+static void run_test(unsigned int n)
+{
+	tc_funcs[n]();
+}
+
+static void setup(void)
+{
+	int dirfd;
+
+	dirfd = tst_cg_group_unified_dir_fd(tst_cg);
+	if (dirfd < 0)
+		tst_brk(TBROK, "tst_cg_group_unified_dir_fd failed");
+
+	if (faccessat(dirfd, "cpu.max.burst", F_OK, 0) != 0)
+		tst_brk(TCONF, "cpu.max.burst not present -- kernel requires CONFIG_CFS_BANDWIDTH=y");
+}
+
+static void cleanup(void)
+{
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
+}
+
+static struct tst_test test = {
+	.tcnt		= ARRAY_SIZE(tc_funcs),
+	.test		= run_test,
+	.setup		= setup,
+	.cleanup	= cleanup,
+	.needs_root	= 1,
+	.timeout	= 30,
+	.taint_check	= TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CFS_BANDWIDTH",
+		NULL
+	},
+	.needs_cgroup_ver    = TST_CG_V2,
+	.needs_cgroup_ctrls  = (const char *const []) { "cpu", NULL },
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
