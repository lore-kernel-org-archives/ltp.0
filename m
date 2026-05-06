Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C64CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:38:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4CB3E6A9B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 20:38:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A76DD3E2C53
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:58 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12F0A600938
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:57 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64695G3B2062528
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cbW1b4VnHD+bgd3Va
 ZJ5/Z8kJAtie4QMC5JGqVPtJaA=; b=jY+STmzKIZQPwe9OGI0FVvOH0VEvi0+Uo
 fcNvkUfWf8xUlgfF2r/tw+ZGm4GsWTDkuYAczdoTlWfh5OrheRCFvljxMtZdx12w
 dxp4IbVBNVWtxYAs5X96vHJlRtu8SJelMSOG4T15td4xk4hs2h/grjryzISIVO9y
 P4YfgW22kK2eNg8hh/68VlOYDhiygQOzsHEHb+DOXxd3T7PSOtgdZH6eCpFxxuQV
 +trn29nNO5ir2eMImlRqaccZtdVkvZ0lS52J7i/u6DtGDAMJFOmgioWgDBqWOZJC
 3f3+DOUG/aC5qZvbKVbDQ/Kuqlve72KgBPElOHjobgt4+bvWIeZmw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6hh24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646IOba8010850
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yf9v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646IbrXM52035972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD69220043
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FC7620040
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.100.23])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:53 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 00:07:49 +0530
Message-Id: <20260506183750.97191-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260506183750.97191-1-sachinp@linux.ibm.com>
References: <20260506183750.97191-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb8a84 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wvspJy92nNHCjQc44YQA:9
X-Proofpoint-ORIG-GUID: sRco6rQUCZO1_HlxhVTX2ihNnf7PsEVU
X-Proofpoint-GUID: sRco6rQUCZO1_HlxhVTX2ihNnf7PsEVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MiBTYWx0ZWRfX4JWBW3udwzqs
 xnsPLGRIYyzNNr+wv+k+wz6bfGeWrTsTDvcSq3RBkl1pkPp6G6yBnx9KQPPTWHAYwElSd6/Hm0Q
 Uk1g2SNdVaq4Hh1YGUIvGLImkp0IpoehdnJAKDDn7+ounoZNEalv2B8Stnxhl3rOaMpPCN/iUBB
 ZqIx1o2ytg8TBUnBkP8Z4x+ZXQFJyWJaUmmphfkYY95YK2jg3NGJ6q6e50KIOTuHvXaom8De9rn
 qK4mAFjZcc/Vyc2r0mFOjqbRB/Atr4GFxnL5gGMGcoM8TrRiPsE5dXlszOBeWFvLiFpeB3hE3FN
 ZOZ9TUTF2WpyY1rZinEA2VOg0jNH2EAroYzQICUa0VdbKaikULQUsuCe6XGViKIbHUTTy/N5KSJ
 aD0SASmaNcGX7KNaOipWMBvBrIqneJmF2dO46gIYiVfheAOesr/uNBoHrBCRjwHxrDMH+BTXoLJ
 p+rnZf4Dzztz5JMTsAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060182
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] io_uring: Add test for varying buffer sizes with
 zero-length buffer
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add io_uring06 test to validate vectored I/O operations (IORING_OP_READV
and IORING_OP_WRITEV) with non-uniform buffer sizes including a
zero-length buffer.

The test verifies:
- Writing data using iovec with varying sizes (512, 0, 1024, 256 bytes)
- Reading data back into buffers of the same varying sizes
- Data integrity verification with zero-length buffer handling
- Proper handling of iovec arrays with mixed buffer sizes

This test ensures the kernel correctly handles zero-length buffers in
vectored I/O operations, which is important for applications that may
dynamically construct iovec arrays.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/io_uring/.gitignore |  1 +
 .../kernel/syscalls/io_uring/io_uring06.c     | 97 +++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bab0e8f3b..fc4892221 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1906,6 +1906,7 @@ io_uring02 io_uring02
 io_uring03 io_uring03
 io_uring04 io_uring04
 io_uring05 io_uring05
+io_uring06 io_uring06
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
index bce7048cd..dfe7cca5a 100644
--- a/testcases/kernel/syscalls/io_uring/.gitignore
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -3,3 +3,4 @@
 /io_uring03
 /io_uring04
 /io_uring05
+/io_uring06
diff --git a/testcases/kernel/syscalls/io_uring/io_uring06.c b/testcases/kernel/syscalls/io_uring/io_uring06.c
new file mode 100644
index 000000000..82e47a4e4
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring06.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*\
+ *
+ * Test varying buffer sizes including zero-length buffers with
+ * IORING_OP_READV and IORING_OP_WRITEV.
+ *
+ * This test validates vectored I/O operations with non-uniform buffer
+ * sizes including a zero-length buffer. It tests:
+ * 1. IORING_OP_WRITEV - Writing data using buffers of varying sizes
+ *    (512, 0, 1024, 256 bytes)
+ * 2. IORING_OP_READV - Reading data into buffers of varying sizes
+ * 3. Data integrity verification with zero-length buffer handling
+ * 4. Proper handling of iovec arrays with mixed buffer sizes
+ */
+
+#include "io_uring_common.h"
+
+#define TEST_FILE "io_uring_test_file"
+#define QUEUE_DEPTH 2
+#define NUM_VECS 4
+#define VAR_BUF1_SIZE 512
+#define VAR_BUF2_SIZE 1024
+#define VAR_BUF3_SIZE 256
+
+static struct iovec *write_iovs, *read_iovs;
+static struct io_uring_submit s;
+static sigset_t sig;
+
+static void run(void)
+{
+	int fd = -1;
+	int expected_size = VAR_BUF1_SIZE + VAR_BUF2_SIZE + VAR_BUF3_SIZE;
+
+	tst_res(TINFO,
+		"Testing vectors with varying sizes including zero-length buffer");
+
+	io_uring_init_iovec_pattern(write_iovs, NUM_VECS, 'X', 0);
+	io_uring_clear_iovec(read_iovs, NUM_VECS);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO,
+		"Writing %d bytes using buffers of sizes: 512, 0, 1024, 256",
+		expected_size);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
+			      0, expected_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO,
+		"Reading %d bytes using buffers of sizes: 512, 0, 1024, 256",
+		expected_size);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS, 0,
+			      expected_size, &sig);
+
+	io_uring_verify_iovec(write_iovs, read_iovs, NUM_VECS);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	io_uring_setup_supported_by_kernel();
+	sigemptyset(&sig);
+	memset(&s, 0, sizeof(s));
+	io_uring_setup_queue(&s, QUEUE_DEPTH, 0);
+}
+
+static void cleanup(void)
+{
+	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&write_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0,
+						   VAR_BUF2_SIZE,
+						   VAR_BUF3_SIZE, -1}},
+		{&read_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0,
+						  VAR_BUF2_SIZE,
+						  VAR_BUF3_SIZE, -1}},
+		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
