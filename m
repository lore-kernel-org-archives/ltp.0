Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22470FD5F77
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 05:14:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C12D83E1E5A
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 07:14:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3520E3C0648
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:14:00 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4C3F100036F
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:13:59 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637DiZle2299537
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6MvWyl9YrnP2L3XSJx4GfTcAMdGH3PjAxD+/cUjCd
 Is=; b=HiQyw807yg5twpBTLZKXhQE1i98/RE0LqZB5y8VFQAI1qXDdyGlmFNPso
 efU5DBqLk6qt6FxMrUXKsdNC4H4zNguXCu+KaKVx4Knm9/S6k2pFO3Kwbr+bk067
 n0ztU6EaTvY/0MLo/2t/7n66/gGlsFvjwijIXH+VmlLDIVxN8+ceisjo4mYjW6/k
 NZuwbYVrzjNOx8zxWhLpg+7BlrkwH2iBki8yBqpxf5u1dPstVHLrYFsOWFSazoH8
 dbq0K6d724jdiRZ4gMW4M8SRjuxuU+GDxTxkCiJZbXBD9xuS76yPBFbsj1+YPRIL
 7M1rP0QTnm8a1QDFwCi9WooExdgPA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwv72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:13:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380PV2Q026707
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:13:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7x2g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:13:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6385CcnR52625796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2026 05:12:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A9520043;
 Wed,  8 Apr 2026 05:12:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A457D20040;
 Wed,  8 Apr 2026 05:12:37 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2026 05:12:37 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 05:36:55 +0000
Message-Id: <20260408053655.3818590-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5e416 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=fn1gDMpfVk7IrGffMVAA:9
X-Proofpoint-ORIG-GUID: ixtEcKIaifO1EysoWn7t1tJR-cl9ZxIt
X-Proofpoint-GUID: ixtEcKIaifO1EysoWn7t1tJR-cl9ZxIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0MSBTYWx0ZWRfX5nwZkhho2Ktb
 23C5mZXrhVnYj3dIJLjeSw1yKX7hRY1mUD3/xcEE9VeqpxeadzBP0AuJ2grQKSarml+7l+nEKQm
 xXRSUZk5Cqnp3CJ6DRzvPTbuD/vpuMSDFYxbKMH7dln8CZhW17sByiZyO2RD9N49SJDodZYWZBO
 M2QIZzLcXxSV5fBmtc7wOTCzNgfDh1PEB8nNw/42+yqHj4D78qaHLy/aZojgzJwGGredq42jXkD
 OvKybMZcpZn9eCz7O8eiSzuMkpiRXny5bEjlUx7EJt9ziVz45R0I7jnJKqKJo6WuqdDhWJdLetN
 VsQE4IyFpp0yjM0dhfOmX6atCOOqeDwQkhLK3NMf5TdgUTQDQ2GapxQ3o3XqESeOcBOsMMeIv4j
 1TtPRBSRChNtfjg+BWTQExrUScVwarrQ0q0J3p+63nRmjo+BS5cbRe1rD1442IViqM1XpUY1H8K
 oaAi/rGIqwrxt2f6Bqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080041
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Added new_behavior flag to detect kernel version
 Kernel >= 6.11: Tests that creat() succeeds (write to executed file
 allowed)
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>

Signed-off-by: lekshmi-cpillai <lepillai@linux.ibm.com>
---
 testcases/kernel/syscalls/creat/creat07.c | 38 ++++++++++++++++-------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c7b85ee69..762022301 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -19,6 +19,8 @@
 
 #define TEST_APP "creat07_child"
 
+static int new_behavior;
+
 static void verify_creat(void)
 {
 	pid_t pid;
@@ -33,16 +35,26 @@ static void verify_creat(void)
 
 	TEST(creat(TEST_APP, O_WRONLY));
 
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "creat() succeeded unexpectedly");
-		return;
+	if (new_behavior) {
+		/* Kernel >= 6.11: write to executed file is allowed */
+		if (TST_RET != -1) {
+			SAFE_CLOSE(TST_RET);
+			tst_res(TPASS, "creat() succeeded as expected (new behavior)");
+		} else {
+			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
+		}
+	} else {
+		/* Kernel < 6.11: write to executed file returns ETXTBSY */
+		if (TST_RET != -1) {
+			tst_res(TFAIL, "creat() succeeded unexpectedly");
+			SAFE_CLOSE(TST_RET);
+		} else if (TST_ERR == ETXTBSY) {
+			tst_res(TPASS, "creat() received ETXTBSY");
+		} else {
+			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
+		}
 	}
 
-	if (TST_ERR == ETXTBSY)
-		tst_res(TPASS, "creat() received EXTBSY");
-	else
-		tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
-
 	SAFE_KILL(pid, SIGKILL);
 	SAFE_WAITPID(pid, NULL, 0);
 }
@@ -50,9 +62,13 @@ static void verify_creat(void)
 static void setup(void)
 {
 	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
+		new_behavior = 1;
+		tst_res(TINFO, "Testing new behavior: write to executed file is "
+			"allowed since 6.11-rc1 (2a010c412853)");
+	} else {
+		new_behavior = 0;
+		tst_res(TINFO, "Testing old behavior: write to executed file "
+			"returns ETXTBSY");
 	}
 }
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
