Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4A5C44503
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF723E5CD9
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:42:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32ED93E2788
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:42:14 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60A992009D5
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:42:13 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CIYii2611696
 for <ltp@lists.linux.it>; Wed, 8 Jul 2026 12:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=t9Y+hC5x0p/RBF2oHTZDnPAVx/R0Nl60XXlGzy8EW
 50=; b=GZ/rdK454gHec0Qts1mVm1z/aX06l2AsF0IwRTrLNCmUwTUw6/tRAuvYq
 XXDIC+fMHdGKxZbsjGVKDZRWzX2Paycbdlrx1BGH1CZooTk6qtHjCdZVYzNOFzOp
 HZg7aHLog/BPPulgGun9C7W5BNasm/oXQ/EVP9/kFHQIGJ05fsNfDCX7o9KBpziK
 SHXrdFbSYT9u85yIV+pukorgVQUuhegxH186ZhO8cBNv7A7nvRYk/+oCsGMvT21d
 eImjZJJEQFWwd4W54tDOegmPIexAK7JUmpY5E4P2ZMZ5UYS3gLNfoeyfIzerjV5A
 vw3aYtwFPtGjQPodTD8M1TKvN3xfQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdvuny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 12:42:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668CYdPu017152
 for <ltp@lists.linux.it>; Wed, 8 Jul 2026 12:42:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hfw8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 12:42:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668Cg8Mt48890122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 8 Jul 2026 12:42:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AB4420043
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:42:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0799220040
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:42:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.41.170])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:42:07 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 18:12:05 +0530
Message-Id: <20260708124205.7409-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4e45a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nyxWZ1fQjHKjYAoMafkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfXy2XRDgLP+dPR
 qfGGePLiLUwxtlsEqVaSDQPoSSSKmfat4YgkSMs6emZxD2NnsvCrkkGMXxLg17DumYJRfxfKbYr
 X82uT7YF14sz1ijCdEwBjJrHGthVhPyXXEsVhcFLdCm2n2hxkSiRBbhFcqxsBRhOfZeAYJBUds3
 55wpIG6q109s56GDBN2Txgdvj+H91wqqoNfKcwrkAfyIrcw0yyHAgXrBra9pf1ySNm+KSYS7UlC
 EKJ0Gr0hnw+zmNp8IZJsJCAP6uEflbm0eBoQfhxT9+c0kv2FIWDSYdsvoH/TXvh92vmlqOPqRqO
 5JjWWj71p8GUshLx/3U3jhczQBFmZ9ZEBGa+FhE/wpwd4PHw57pDSCsblWBVGaVLcDuvHlxkLjs
 swYuON0vUSw2dTqfc/7thje+AR4TY6F7FChYK8nI7tCD4r1vWe7GRVldA3KgfTHYXVUPWYTMAnI
 E726OJ5xS+x6KkyoQRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyMCBTYWx0ZWRfX3QZT7N99IPV8
 +JW13T+oWzGyPFUhye+OZiFZzUzGSqzZ8bDZO5meNB7nOSNRnBv24MENay2ntOgVnWFjU7aRQkS
 3W1ozhKVADVgHC6kNfT671HpqcVD8vU=
X-Proofpoint-GUID: ikpQqIEUup2rRukozU6PQXOz9tbb_oI8
X-Proofpoint-ORIG-GUID: ikpQqIEUup2rRukozU6PQXOz9tbb_oI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080120
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mem/min_free_kbytes: Fix incorrect pass/fail
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

Fix this by:
- Removing the tst_res(TFAIL, ...) from check_monitor() and replacing it
  with a local 'violated' flag; the TINFO diagnostic is kept so the exact
  MemFree and tune values are still logged.
- Returning 'violated' from check_monitor() and passing it directly to
  exit(), so the child exits non-zero when a violation was detected.
- Restructuring the parent's wait-result check so that TPASS is only
  emitted when the monitor child exited normally with status 0; any other
  termination (signal death, unexpected non-zero exit) maps to TFAIL.
  A violation exit (status == 1) emits a semantically accurate message;
  all other abnormal exits fall back to tst_strstatus() for diagnostics.

After the fix the summary correctly reflects the outcome:
  - No violation:  passed 1 / failed 0
  - Violation:     passed 0 / failed 1

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 .../kernel/mem/tunable/min_free_kbytes.c      | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index bdc9126c2..5bed61db5 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -41,7 +41,7 @@ static unsigned long total_mem;
 
 static void test_tune(unsigned long overcommit_policy);
 static int eatup_mem(unsigned long overcommit_policy);
-static void check_monitor(void);
+static int check_monitor(void);
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
 
 static void min_free_kbytes_test(void)
@@ -57,8 +57,7 @@ static void min_free_kbytes_test(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/* startup the check monitor */
-		check_monitor();
-		exit(0);
+		exit(check_monitor());
 	}
 
 	test_tune(2);
@@ -68,11 +67,15 @@ static void min_free_kbytes_test(void)
 	SAFE_KILL(pid, SIGUSR1);
 	SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_res(TFAIL, "check_monitor child exit with status: %s",
-			tst_strstatus(status));
-
-	tst_res(TPASS, "min_free_kbytes test pass");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
+			tst_res(TFAIL, "MemFree dropped below min_free_kbytes");
+		else
+			tst_res(TFAIL, "check_monitor child failed: %s",
+				tst_strstatus(status));
+	} else {
+		tst_res(TPASS, "min_free_kbytes test pass");
+	}
 }
 
 static void test_tune(unsigned long overcommit_policy)
@@ -171,8 +174,9 @@ static int eatup_mem(unsigned long overcommit_policy)
 	return ret;
 }
 
-static void check_monitor(void)
+static int check_monitor(void)
 {
+	int violated = 0;
 	unsigned long tune;
 	unsigned long memfree;
 
@@ -182,12 +186,14 @@ static void check_monitor(void)
 
 		if (memfree < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
-			tst_res(TFAIL, "MemFree < min_free_kbytes");
+				"min_free_kbytes is %lu kB", memfree, tune);
+			violated = 1;
 		}
 
 		sleep(2);
 	}
+
+	return violated;
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
