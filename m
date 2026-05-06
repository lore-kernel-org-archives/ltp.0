Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C275ECD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:38:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A2A93E6A99
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 20:38:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694B73E1FBC
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 811D62009EC
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:58 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646AwqHu2732371
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dnbBGf8oaw8fOjxnP
 Jo9jHpaUls709Qd5g00dqoBtow=; b=QndrB2cvXcdJ5kwU1AJQqtkiyNVspySXI
 vRMCNMOY30zKFFndRyrDFMm6FPLY0cut5GH6bk+V20qqM1hOjDGBtkpXDQSxcs46
 3dsowMUnhiX8rosMq4FpyPrvnkyQ31H2p9rQ3FGzz8gP3hBHhnMVfNS1yM5l13k3
 4fef8/ExwXlqHUNJauHrkiK7NC0REuwr3K09etE1/xseR96TYIaQSXw1g9ZyVJO8
 +tAD5rVQQXpO2oz50C+jPGE30c5m5K+3AxKgLwH4BR9QaV2GuKkzKYAonbAXMPfX
 uknWD6HR1rlyJVSai6bKD73Lx6+2W4/vbvsp/0rmLgHfNc4FAE9bg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7jbss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646IOTKc019580
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw7myk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646Ibr5J52035964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13BAC20043
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAF3E20040
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.100.23])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:52 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 00:07:48 +0530
Message-Id: <20260506183750.97191-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260506183750.97191-1-sachinp@linux.ibm.com>
References: <20260506183750.97191-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MiBTYWx0ZWRfX9bTmIN0bW15K
 mOAMIZVbUnxc/0RxgpODslotrDfOvB9fl5Gszibi4W+S1U7T+izPF+fpdA/J9AhjXicsChc5JGF
 lhXUFU/sgOUP/0WLUdeYj7ii1RwYyYOs5wpU+6xDjNwVQortZF4gS013cbgwHpGaZHKHfDuF0Mi
 fRqRZ+ZheMp+v5oneTY0hJqZJWsP/awQjeijx1UbePUack+jW5DF89XlGLiFtkEQ2lnbBQ9PG6s
 fjNzPG+w+QI4put8txHiOLd/vye/dbE12yONmRrExBYFPsZd8331Jr/tC7/fe3Soa79xs3CBjal
 jt5AtD2vokBnE1IhWCS1YqSrQBzbQr8XmZyel5LXoRdW/IpSLyrm3EluOMXW45C5/PE3fwujj0J
 MJXQKQl1t26Tbrd5zSr23J/9ImZYXmedQlmAhJlXKSZN9zHrb+DFyVQ8Wh0t7nJvcSciiGoH4cU
 iPmJb4UcOz38UK8qO9g==
X-Proofpoint-GUID: JtE4r-5mzfdHRP1IQWudymO6cWnPwsjf
X-Proofpoint-ORIG-GUID: JtE4r-5mzfdHRP1IQWudymO6cWnPwsjf
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fb8a84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wvspJy92nNHCjQc44YQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060182
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] syscalls/io_uring: Add test for partial vector
 operations
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

Add new test case io_uring05.c to validate vectored I/O operations
using partial vector sets with different file offsets.

The test performs:
- IORING_OP_WRITEV: Write first half using first 2 vectors at offset 0
- IORING_OP_WRITEV: Write second half using next 2 vectors at offset 2048
- IORING_OP_READV: Read entire file using all 4 vectors
- Data integrity verification across all vectors

This validates that io_uring correctly handles partial vector operations
and maintains data integrity when using different vector subsets with
specific file offsets.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/io_uring/.gitignore |  1 +
 .../kernel/syscalls/io_uring/io_uring05.c     | 94 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6b047b5fd..bab0e8f3b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1905,6 +1905,7 @@ io_uring01 io_uring01
 io_uring02 io_uring02
 io_uring03 io_uring03
 io_uring04 io_uring04
+io_uring05 io_uring05
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
index 36cd24662..bce7048cd 100644
--- a/testcases/kernel/syscalls/io_uring/.gitignore
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -2,3 +2,4 @@
 /io_uring02
 /io_uring03
 /io_uring04
+/io_uring05
diff --git a/testcases/kernel/syscalls/io_uring/io_uring05.c b/testcases/kernel/syscalls/io_uring/io_uring05.c
new file mode 100644
index 000000000..ded990c41
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring05.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*\
+ *
+ * Test partial vector operations with IORING_OP_READV and IORING_OP_WRITEV.
+ *
+ * This test validates vectored I/O operations using partial vector sets
+ * and different file offsets. It performs:
+ * 1. IORING_OP_WRITEV - Writing first half using first 2 vectors at offset 0
+ * 2. IORING_OP_WRITEV - Writing second half using next 2 vectors at offset
+ *    2048
+ * 3. IORING_OP_READV - Reading entire file using all 4 vectors
+ * 4. Data integrity verification across all vectors
+ */
+
+#include "io_uring_common.h"
+
+#define TEST_FILE "io_uring_test_file"
+#define QUEUE_DEPTH 2
+#define NUM_VECS 4
+#define VEC_SIZE 1024
+
+static struct iovec *write_iovs, *read_iovs;
+static struct io_uring_submit s;
+static sigset_t sig;
+
+static void run(void)
+{
+	int fd = -1;
+	int half_size = 2 * VEC_SIZE;
+
+	io_uring_init_iovec_pattern(write_iovs, NUM_VECS, 'A', 1);
+	io_uring_clear_iovec(read_iovs, NUM_VECS);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Writing first half using first 2 vectors at offset 0");
+	/* Write first half using first 2 vectors at offset 0 */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, 2, 0,
+			      half_size, &sig);
+
+	tst_res(TINFO,
+		"Writing second half using next 2 vectors at offset %d",
+		half_size);
+	/* Write second half using next 2 vectors at offset half_size */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, &write_iovs[2], 2,
+			      half_size, half_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Reading entire file using all 4 vectors");
+	/* Read back entire file using all 4 vectors */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS, 0,
+			      NUM_VECS * VEC_SIZE, &sig);
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
+		{&write_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE,
+						   VEC_SIZE, VEC_SIZE, -1}},
+		{&read_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE,
+						  VEC_SIZE, VEC_SIZE, -1}},
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
