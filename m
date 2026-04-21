Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B2DEA71BA
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 04:39:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F414E3E25AC
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 06:39:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3200F3CECA7
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 06:39:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1CFE2600A36
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 06:39:12 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJgeIm1926205
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 04:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0mHDiTW5Q5PgpMhYo
 HZW8tIa3Kg/w0I4DSxg4Pb7HL0=; b=D+O805g0S05STN1gp4raqqX3pr7Mo7Th7
 jVrvf8BPVCw6GgokQIrvVtaL0CM3LsKyRV0llnc2h9NML52lk4c4tL3OfmxG81la
 Z3lbWxidQjPOe37KycisntjO3/lc8cDDMiJqNmAddDZ0dkgsDMCFBs1qEMO402vl
 /3vU8IZxkIqalCXMeMzaJy86M+D+SvHU5bKhWqwsoEa16l+M971El0S6jPq51aEZ
 JwlZlXiUa4s7dVOTV4l1VjMPfL7+kBuZR4M9T3yxp3hIMFxZFV4ZLHKYLaRu0mck
 ba5CralzBB+K0OzRksFOco1xlyy50G3IYkB6q5amPfW/lZxgM6oaA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf2p0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 04:39:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63L4ZN06016042
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 04:39:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvqep6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 04:39:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63L4bos328967414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 04:37:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 774ED2004D;
 Tue, 21 Apr 2026 04:37:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAA8A2004B;
 Tue, 21 Apr 2026 04:37:49 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 04:37:49 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Tue, 21 Apr 2026 05:02:51 +0000
Message-Id: <20260421050251.3662828-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260408053655.3818590-1-lepillai@linux.ibm.com>
References: <20260408053655.3818590-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KqFMh0R7JhnS733qWmbGJKZszzzSPh5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAzOSBTYWx0ZWRfXzf0W+NTUpsP7
 Xg2AldiJdnGBUVOhd4he6Y+Yj8qvmjKCkG0M3sKPuYmcT3P8ADg+uyxjQN3/a6m3MYK4bf5yvLL
 X0rCxr8xZR0n9lEb4tXFIddilvpDMOqYayCQz3B+JS1e+awnuN+gI4sTgxUCzLv2u3n1pt42Nji
 60fy2yM9NFK0LyLMjkQ55XuUd39U4A5M9XyyWcgusq7zinvXrQMR8+j/T0PT1XCSv9Yi2o+XhZ0
 mZsBMD57J3ZdPnlqfmjIXC82mMXHacNlOG4+KkOoU3bSP13Pul4nJqRipD+69Hiu+NWQHDIbWjK
 S6r4PTp5EjhKeJxDo6ubdbDFTsBJwe3Wh55DDQEQe5PpiRKxhpt8oItKAC6KJi5iNs3iOIhEe6o
 /ZjKqyqn93mlc6Z3gutbnVdZfYalvOmvY1QHuodI73Lmie1bpUuGZ5nQvRMiJeU3lCb/ERtCXV4
 WaIMBic6qgGpgtGTdnQ==
X-Proofpoint-GUID: KqFMh0R7JhnS733qWmbGJKZszzzSPh5u
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e6ff6e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=fn1gDMpfVk7IrGffMVAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210039
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
