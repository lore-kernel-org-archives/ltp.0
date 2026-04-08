Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBB0FD5F77
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 05:11:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AF7B3E1E1B
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 07:11:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 555983C0648
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:11:01 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ABD111400B88
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:11:00 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637DvX7n2325942
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0mHDiTW5Q5PgpMhYoHZW8tIa3Kg/w0I4DSxg4Pb7H
 L0=; b=RGrRlb8WObufHhvSv6lwvzCGfrms5hRBXTrD8t56thY0fJo9+b4PrUVHu
 ccIMYmOfOba7syHmeVCiLnZsH3Pf3jCFlnwvVwhdHK1YEihAtualS33KBx2U2xSz
 olBXcQTBvFSYVq8ttbBguu+TyWcNNJyA+aInyOiBXtLEUBPDXewHhv7LP0EHiy+E
 GODhgQXUHFPSEHLEKhXl+Y/YD70XvEW6FHuzquQ8qFC6qLcSwGNVDaRj1ShuCgky
 MnJIRLl9yaeKKb7uYM7h1MYnYSL/I/grAR8gCrxEZvjlAQwBFnGVKDN1qUl7U1GQ
 jkKaaUwYje7bXUW63OTciHHZ7b5jw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdukx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:10:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63805Mqc018987
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:10:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9e3mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:10:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63859c7B29753826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2026 05:09:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 866E120043;
 Wed,  8 Apr 2026 05:09:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4E5220040;
 Wed,  8 Apr 2026 05:09:37 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2026 05:09:37 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 05:33:55 +0000
Message-Id: <20260408053355.3816672-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0MSBTYWx0ZWRfXytDouWtixDE+
 phEcl444MlqsX0hv1MdGgv1QgMgnrPkxG02lYPQCS1AYT7LPp91T1u13DiSmGppcqEtiCw0sZ89
 tbY8OmeIyuQGfKev2pCOpMYJj/yCK3KVyMieutgArxciJFriQdPetYoc4a6Wg9OFukfoWtCR0y3
 1cP7n2efb16pA7okpJEiYqnPZ7G9hIqYfM92HsAL7rv6bp4cjBLmAxO0GWvgMR9p/Yd7EjRcN7o
 TD4GO0CXOdA1+xqE/0ko1G2BJILtj87U7SQcwprGrGoD4+ofvz1/SHtfP014/VTXlJd87JGSwSQ
 zfBzx8ZTavp+Fu/AcSUhj3UXfhna95Y+cBNwqW7k5uPKQJWKeBd39FXJon5ZAJbnmvg5Iv2G3YU
 dL9uQ5q6B3KdeYVkrJGzQGBCw5PCyaloDdw2PJv6+tL+6AGI/tBeiR7Y9amazQVB5m1xGoPvtTv
 B5NekI+7/Cia4hWsbkQ==
X-Proofpoint-ORIG-GUID: -9_yR4vne3tmRhEW1PC-VPx-ZLqbhZL3
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5e362 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=fn1gDMpfVk7IrGffMVAA:9
X-Proofpoint-GUID: -9_yR4vne3tmRhEW1PC-VPx-ZLqbhZL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080041
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
