Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBC5C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 13:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09B053E5CA7
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:37:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2CC13E248E
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:37:34 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A4EA11400114
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:37:32 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CImuB2335976; Wed, 8 Jul 2026 13:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5A+z5LiRCW+2LTPSFFnATkdCBKQr+le+wMzSkHm2X
 TY=; b=LEhg2Cf0EiLxP83h99ksnmVH51yXUuUpcyLtKalU3tkQAG3mCeyHL16T4
 McoXsJSUYD/DexBiZgMzNJCVgZLVssKRbkZ9xCAJ4sHT/Lhw9z9tIpNPDqCrRJif
 hHNe8UyC2m++cTBFukEBaYXafJMPLFWBpehp5IDejgROL2VcBooCDkz8mBLghJ2V
 RvUMCznEvvcl5PPf9/XVpnyozqgu3IRrWPRNxDcLJAGk2L1YktiIoPEEdDN/XDji
 g3z3muao54+O5u5BEQmj/U2EyolZfQpoOJ+k+VbvqT/h8cHDLsp9KvGVdSclafMf
 Gc87IMeZZcXRUdBibLUHE3NsFhXcg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvyk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 13:37:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668DYdXj001701;
 Wed, 8 Jul 2026 13:37:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg802d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 13:37:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668DbS5M51642648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 13:37:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 827C020040;
 Wed,  8 Jul 2026 13:37:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44BCA2004B;
 Wed,  8 Jul 2026 13:37:28 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.64.77]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 13:37:28 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 15:37:26 +0200
Message-ID: <20260708133726.223095-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eAwRNpNpuHsjIShYf-SoP7fQG8oESWS6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfX+iyzbf+elQjR
 XPfnY+ftLP9vU2sCSbADFhrdb5kiPJaYKiaTZjzKah2T5jZCNG3iSkH1P7K98fM1ZEDanq+fbIR
 puD8dOT7bujdsFNBbNPVeLus6hTVCGg=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e529b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GMlbFEJKET5hatM3YXcA:9
X-Proofpoint-GUID: eAwRNpNpuHsjIShYf-SoP7fQG8oESWS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfXyXeaKP7HJevW
 +kwcOi1lVv1B+D6J9HjJPHAGAXEEjb9jnQ89FbEigykmkFKcZKVIaoQLJKY2Bq6YZRfey/WdqkR
 M1wtnrGteTX8B4y6CrulXjq9MjIp+n8QSkI0L5fZwe8PSwEQ1jFFaFKh57In8NpJ59IsfoFrnxV
 m3GIuA39ZN63cn1roU27bD7dh8VSftn6ar5sdurLSY5gNxMFRiwdlq3y+xljFuG7b/GJsyrIhVx
 s8j7zJgn2m0rXghgGIF3KTee4i/BJfr0nI4sRcadMW6uxkt9MZ2LGLLmaHvA+wi3smFcVWa+S5t
 f/OHu6A8t7/XM+/HAK1jDex74S1fBXh7+7uXzpQTDyAAGuHg1aPOYMAgpqtp7RAFdlCZAATzX7+
 zS550bkLf6X5viRRRlOT8WCV9YjvTPR0KsbBJ7xUO8VfVQQO0JWqRPe5epyhzX1U3aqxjqE3w+y
 IIQOalP36/fP5S5AGLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080130
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] kill11: Skip with pipe-based core dump handlers
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
Cc: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

kill11 verifies the signal and core dump bit reported to the waiting
parent.

When /proc/sys/kernel/core_pattern starts with '|', core dumps are
handled by a userspace helper such as systemd-coredump. In such setups
the test may hang waiting for children that are blocked in the core dump
path instead of testing the wait status itself.

Skip the test with TCONF for pipe-based core dump handlers. Direct
filesystem core dumps continue to work as expected.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/kill/kill11.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
index 3cf62feaed77..62b515a879a0 100644
--- a/testcases/kernel/syscalls/kill/kill11.c
+++ b/testcases/kernel/syscalls/kill/kill11.c
@@ -105,6 +105,7 @@ static void verify_kill(unsigned int n)
 static void setup(void)
 {
 	struct rlimit rlim;
+	char core_pattern[256];
 
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
 
@@ -121,6 +122,23 @@ static void setup(void)
 		rlim.rlim_cur = MIN_RLIMIT_CORE;
 		SAFE_SETRLIMIT(RLIMIT_CORE, &rlim);
 	}
+
+	/*
+	 * Check for pipe-based core dumps (e.g., systemd-coredump).
+	 * These can cause indefinite hangs in CI environments due to:
+	 * - I/O contention from parallel test runs
+	 * - Container restrictions on core dump handling
+	 * - cgroup limits on core dump rate/size
+	 * The test requires direct filesystem core dumps to complete reliably.
+	 */
+	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%255s", core_pattern);
+	if (core_pattern[0] == '|') {
+		tst_brk(TCONF,
+			"Pipe-based core dumps detected (e.g., systemd-coredump). "
+			"Test requires direct filesystem core dumps. "
+			"Set kernel.core_pattern to a file path (e.g., /tmp/core.%%p) "
+			"or disable systemd-coredump for proper testing.");
+	}
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
