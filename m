Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2CBC44501
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:29:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8F893E5C6D
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 12:29:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FF5C3C5691
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:28:47 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1805D1A009B4
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:28:46 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6696Ii0s1155433; Thu, 9 Jul 2026 10:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QZx7bwtiaS3e39JLlqJ8+9cDOZO1Jv3gMlwy5f34Z
 eU=; b=ECzj/+M17MKWv/PA2z/Q5yeGJCq/wkfwb8OkoIWy5L7N8EXcFVYVxu8fF
 zk/q9lD+7oDA++gY1B1+fZTXW0Lke98cZSxA0fplskUSN4emO4wdgqdKZGZPdghy
 F9NyAjy1fZ9ZDydZ4Kmxcfil0boYi2ypnu5oBbBYPbkDhAG+NEpSojS+SeZtHfI3
 zfnmJNZKM6J1a5JytdEJsIyUBBiX+raH+DyDcoIcHmgHAHvDY9CTLWO4cENBazrj
 3Rh1+KZFWM2pjTQgUGXC9M1BNU9DVafbzqP6/5RH9OimncKykzorKhUgNax+R40N
 FZHn7oWOgIU3ZmrdWXwXdCjp3svfQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw51748-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 10:28:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669AJkic003799;
 Thu, 9 Jul 2026 10:28:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ycc1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 10:28:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669ASdcb38011358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 10:28:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2EBF2004D;
 Thu,  9 Jul 2026 10:28:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A5532004B;
 Thu,  9 Jul 2026 10:28:39 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2026 10:28:39 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 12:28:37 +0200
Message-ID: <20260709102837.54583-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RzJUfAojtBly7Cu2tkpRf5B0mvFdI_HW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfXxgsoQ6FzSRzg
 m4d1LeKXPkNmwcxaTq0Hd+FIhcJQYwpQmWInkFkb13vZEF9D9C8aGxqr6s3w01bxn3Qdpjx3ofa
 TrX/v0wvy4r9SCbsnwj4MpPyBxdCsjZeAIuQr7BtV9J4BgIlgP5j1G4jkEe4+C1gQXzVbxVFJ61
 zqnE+6cT7f4lI88CwoD9j1pdZU22nhvaO0FWA1pNah2MxOg+GgDmgwjYYbNmp6XdecM3svSDclA
 OOolFq1u5D+24RN49I8Bd0IIqgET+hIBp57xZ0ub+68RYIzzSEfBkgwfedq2W0UGauzVo8fe7qq
 wwR8y4NgBAy3aQoAxLLdsg6Hw3HbgQ4fUnpG0vZ1wBzFEbz56LvVGgCEaWP4q4a9K1syAr8/PE+
 uacS+8kdLQFjMRuzRGp6sDrLqujuconSdS4u4hGfHAJIfnbkgiGEcEohQcEFPxbo0i2rHXGNsNi
 c0aMxx+DPrQF+vD89eg==
X-Proofpoint-ORIG-GUID: RzJUfAojtBly7Cu2tkpRf5B0mvFdI_HW
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f77dc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=MeauYMBAq9GstPKRHFEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX+/J7vCj/BQNh
 XPfdMC3IOFsA6/Z3yrvbmToxGIYLfxctYfsa1iAfP+ZPLivpoaioreUDHKic6Q9keMNgAP7rO3o
 Ord0t+KlcaJPdUpxpp1cgJBTvxB2a7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090099
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per signal
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

kill11 verifies the signal and core dump bit reported to the waiting
parent.

When /proc/sys/kernel/core_pattern starts with '|', core dumps are
handled by a userspace helper such as systemd-coredump. In such setups
the test may hang waiting for children that are blocked in the core dump
path instead of testing the wait status itself.

However, only signals with dumps_core=1 (SIGQUIT, SIGILL, SIGABRT, etc.)
actually trigger core dump handling. Signals with dumps_core=0 (SIGHUP,
SIGKILL, SIGTERM, SIGPIPE, etc.) exit immediately without touching the
core dump path.

Detect pipe-based core dumps in setup() and skip only the affected test
cases (those with dumps_core=1) in verify_kill(). This preserves test
coverage for non-core-dumping signals while preventing hangs.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
Link: https://lore.kernel.org/all/20260708133726.223095-1-japo@linux.ibm.com/

Changes since v1:
- Skip only core-dumping signals (dumps_core=1) instead of all test cases
- Keep core_pattern detection in setup(), move skip decision to verify_kill()
- Preserve coverage for non-core-dumping signals

 testcases/kernel/syscalls/kill/kill11.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
index 3cf62feaed77..f9fa595a505b 100644
--- a/testcases/kernel/syscalls/kill/kill11.c
+++ b/testcases/kernel/syscalls/kill/kill11.c
@@ -25,6 +25,8 @@

 #include "tst_test.h"

+static bool pipe_based_coredump;
+
 static struct tcase {
 	int sig;
 	int dumps_core;
@@ -64,6 +66,12 @@ static void verify_kill(unsigned int n)
 	int nsig, status;
 	struct tcase *tc = &tcases[n];

+	if (tc->dumps_core && pipe_based_coredump) {
+		tst_res(TCONF, "%s: pipe-based core dump handler active",
+			tst_strsig(tc->sig));
+		return;
+	}
+
 	pid = SAFE_FORK();
 	if (!pid)
 		pause();
@@ -105,6 +113,7 @@ static void verify_kill(unsigned int n)
 static void setup(void)
 {
 	struct rlimit rlim;
+	char core_pattern[256];

 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);

@@ -121,6 +130,14 @@ static void setup(void)
 		rlim.rlim_cur = MIN_RLIMIT_CORE;
 		SAFE_SETRLIMIT(RLIMIT_CORE, &rlim);
 	}
+
+	/*
+	 * If core_pattern pipes core dumps to a user-space helper, the child may
+	 * remain in the core dump path until the helper completes. Store the
+	 * result and skip only signals that actually request a core dump.
+	 */
+	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%255s", core_pattern);
+	pipe_based_coredump = (core_pattern[0] == '|');
 }

 static struct tst_test test = {
--
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
