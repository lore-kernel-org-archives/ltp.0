Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1EAC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 14:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 351013C4D64
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 15:36:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFA243C300D
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 15:36:41 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FBD11BCAEE6
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 15:36:40 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NC9gWu027703;
 Thu, 23 Jan 2025 14:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lTMSHX/3a1KLVXw8GLhSACNkoxbXkG9Wm11AXGyhN
 hA=; b=oDcgLEoUH/LUUNQwgfcmGUHNA3FZpDydcsvn7FvvKDPNj83nK+8ByyJo2
 DjIDwjXGtGBhs7eOPWk4msZoiH++DHiWB7d1f0TaILNJ2kORIFe0M5BixNskUkiK
 1+SZ4pPFwZtRAsT/zoFzguoRT2ULpHtFo9nIDFq3fij8qTlwm1unGgeFiTiqenyY
 tpMcVecsAGI0QwJdxuFlT6SbZ5fh5p82ANB+GP7x2T5cge+KXgSwjOVBpXykCDnv
 i8Fed56PC+Iv0rtZNb+rR1UtKNwS2kobFd8p+Uxe4XLOV+SiNrgCcwS+aJ7ByWB3
 JyARA4IZ/gOrkzEZofmtRVxvNz9iA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xyp2m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 14:36:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NAosXC029610;
 Thu, 23 Jan 2025 14:36:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnnxtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 14:36:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NEaYlo14745992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 14:36:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76BB720043;
 Thu, 23 Jan 2025 14:36:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68AB320040;
 Thu, 23 Jan 2025 14:36:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Jan 2025 14:36:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
 id 20769E030C; Thu, 23 Jan 2025 15:36:34 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 23 Jan 2025 15:36:33 +0100
Message-ID: <20250123143633.3680575-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: audJdKTnPHTKIO3V8HT2bBZbb2ep8lGP
X-Proofpoint-ORIG-GUID: audJdKTnPHTKIO3V8HT2bBZbb2ep8lGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=815 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230108
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mmap01: fix check_file() test for file corruption
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

mmap01 reported random test failures. Investigation showed
that check_file() will compare the whole buffer even if less
bytes were read from the file. Adjust check_file() to:

- fail the test if the not the correct amount of data has been read.
- only compare the bytes actually read

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
Changes in v3:
- remove LF from log message
- also log read size and expected size

Changes in v2:

- check return value from SAFE_READ
- only verify bytes actually read

testcases/kernel/syscalls/mmap/mmap01.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index c93c37ceda52..ffbe6485a09c 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -35,19 +35,23 @@ static void check_file(void)
 {
 	int i, fildes, buf_len = sizeof(STRING) + 3;
 	char buf[buf_len];
+	ssize_t len;
 
 	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
-	SAFE_READ(0, fildes, buf, sizeof(buf));
-
-	for (i = 0; i < buf_len; i++)
+	len = SAFE_READ(0, fildes, buf, sizeof(buf));
+	if (len != strlen(STRING)) {
+		tst_res(TFAIL, "Read %zi expected %zu", len, strlen(STRING));
+		goto out;
+	}
+	for (i = 0; i < len; i++)
 		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
 			break;
 
-	if (i == buf_len)
+	if (i == len)
 		tst_res(TPASS, "Specified pattern not found in file");
 	else
 		tst_res(TFAIL, "Specified pattern found in file");
-
+out:
 	SAFE_CLOSE(fildes);
 }
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
