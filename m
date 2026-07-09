Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3251C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 04:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D524E3E5CEC
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 06:13:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CC0F3C0EDD
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 06:13:31 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCDDF1A003D4
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 06:13:30 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668NJGAk1025446
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 04:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=yyo1d7kAcjWfLpYC0AO5/2yvfIDopQi2h3u/EsGao
 gM=; b=Dyvpv80+P4RrUgdF4lyOReTrAXDZBoXGgRbAtZV0q8nvy90Jatw5KjDrH
 dxM0m3FfMgwI69p/HRk05ZKbiBbvRGI9UirqvvE4cZp/bufkMcb7iSQvgsJt1agL
 7cdkc5/w88+hg2dhCLLRuTzKfHtp4Oc56crlVxXdElAaUh4SXfarWEH7Yzop4Z8U
 aqGLB7cTOfTAa4dVYXSfu1LwK9HCCBt1J8ZnYpwCPeh3E0xn4xmefcRWG8m0SJkr
 aZBM7Nq5AUX3Z8GU3q7nt6PjQ2Q88MBSZW0x2Wk/nvlB+ZbNn5jWzY2ErYS+oYPF
 r5tQkLkZtXTYM8UTx1VBuan4c6ZvQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqyn8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 04:13:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66944bgP003657
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 04:13:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yb632-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 04:13:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6694DPxV50856326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 9 Jul 2026 04:13:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62B7020040
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 04:13:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A37A52004B
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 04:13:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.72.98])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 04:13:24 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 09:43:23 +0530
Message-Id: <20260709041323.107-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfX0QCZGjAW8mZa
 GpZWWXsMcEw9PmFhzOWrnmQ5KmTXujicOWbzifZxioyPYnQmbJImBIxPjjrwF42J6Xaw3/nSVXr
 mrAZLm+jn4QBrWbP12CU9apS1CMTgf0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzMiBTYWx0ZWRfXyWvQmmzATUXR
 joMQak9zr4WmlHOsmuv+cIuwTKMFU21R4mmmVOQXMyUyzePPNUnJGWhLrqHCqK4xUsLM17JSBSg
 W8XLVqTkjge1EVPXAYwAIkBjtOjwxR5wg1RZ6fTXC5D8nmkkUgLH47kUuJ7v+a5OQ8NXRC18Jr7
 SWmAplgdi+cdqrjPTTOXAvE24dNl309E5kv9LB7AQcCsIQF1yXiY6iTvC/f6nrGARjklUCAnMLf
 jg5cKx/FoWoN73QnB7xQS6oW221Y7+lXkxxMdKTUTug+mzBnBxeweeaEqt09MG7i/atSnh2cZSp
 QFG0x2zzKxikM+eyx+n3ZxkXnMwLEf5Nh+/GgTc1R1cCE1VS1h08TmwmYSJty3rYlTAO/Wmn9tH
 rWO9MhFFbaGEhSnvFSc90PUuUVxHx5FZQTVmeMi6h1+xNu2hYNGLbe20L331DjyaOPdrwU8RFHx
 ppe+p/WiZbU0LbN06kQ==
X-Proofpoint-GUID: yrDoW8-LSlVnEUzV5-1RI4xMrbbPrgdA
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f1fe8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sbxu616zeFBjZv-u2-UA:9
X-Proofpoint-ORIG-GUID: yrDoW8-LSlVnEUzV5-1RI4xMrbbPrgdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090032
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mem/min_free_kbytes: Fix incorrect pass/fail
 accounting
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

When check_monitor() detected a violation (MemFree < min_free_kbytes) it
called tst_res(TFAIL, ...) from the child process, which atomically
incremented the shared results->failed counter, and then the child exited
with status 0. Back in the parent, min_free_kbytes_test() checked the
child exit status, found it was 0, and fell through to the unconditional
tst_res(TPASS, ...) at the end of the function.

This produced a misleading summary of 'passed 1 / failed 1' on violation:
the TFAIL from the monitor child was correctly counted, but the
unconditional TPASS that followed also added to the pass count regardless
of the violation.

Fix this by moving TPASS/TFAIL reporting into check_monitor() in the child
process. Emit tst_res(TFAIL, ...) immediately on each individual violation
so that the TINFO diagnostic and its corresponding TFAIL are always paired;
the 'violated' flag is kept to suppress the final TPASS when any breach was
seen. Emit tst_res(TPASS, ...) only when no violation was observed across
the entire monitoring run.
The parent's wait-result block is changed to guard against unexpected
termination (signal death or non-zero exit) only; it emits no result for
the monitor outcome since that is already reported by the child. The
original condition WIFEXITED && WEXITSTATUS != 0 missed signal death;
the corrected condition is !WIFEXITED || WEXITSTATUS != 0.

After the fix the summary correctly reflects the outcome:
- No violation:  passed 1 / failed 0
- Violation:     passed 0 / failed N  (one TFAIL per breached sample)

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
v1 -> v2:
- Addressed review comments by moving TPASS/TFAIL reporting
  into check_monitor() in the child process.

---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index bdc9126c2..132c8fe70 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -68,11 +68,9 @@ static void min_free_kbytes_test(void)
 	SAFE_KILL(pid, SIGUSR1);
 	SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_res(TFAIL, "check_monitor child exit with status: %s",
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_res(TFAIL, "check_monitor child failed: %s",
 			tst_strstatus(status));
-
-	tst_res(TPASS, "min_free_kbytes test pass");
 }
 
 static void test_tune(unsigned long overcommit_policy)
@@ -173,6 +171,7 @@ static int eatup_mem(unsigned long overcommit_policy)
 
 static void check_monitor(void)
 {
+	int violated = 0;
 	unsigned long tune;
 	unsigned long memfree;
 
@@ -182,12 +181,16 @@ static void check_monitor(void)
 
 		if (memfree < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
+				"min_free_kbytes is %lu kB", memfree, tune);
 			tst_res(TFAIL, "MemFree < min_free_kbytes");
+			violated = 1;
 		}
 
 		sleep(2);
 	}
+
+	if (!violated)
+		tst_res(TPASS, "min_free_kbytes test pass");
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
