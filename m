Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499DC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14C673C301F
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 14:58:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A02B3C26CA
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:58:19 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 54709102B121
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:58:17 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDTdpA013798
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5rvvS9mF4wVndlGHq1vhuSTpccUyMvmU7dDLZU8AR
 cE=; b=Jx6YmCte5B4gWyKa34AbbCfIomNdOPJyWVKjNfv+/WJqI3lBvgGgwxgxT
 x/LcdmS+B58dB4dc4P/BmjfgBhDovW6ChQcoDYuzbtlDOCDR4YUKfCfbefMW7H2s
 k7+vFNODnLFiNGs5hgQLWddt2OIcYWfqA5mGKAF/VrYj7YwgIpfsEl9Wj2xS6RIB
 XuhmVLMkF5eNVGlDyiLsk2PgW1P64o4+1j8ADHkZ04lFK5Ft4lQGDZUPRhsg0uhJ
 XDlVUyoIB8zbsJTBGqyeQyxldrssVI5COyNxxDxdnTvVU4vYtlxOmx12A1p8EEdj
 QHg0alxqvtIlh4q/HOVV7fw69n2vA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9b3m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDMSRK024268
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y8tsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50MDwCfi22479184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AA4020043
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E09620040
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:58:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
 id 20849E04FD; Wed, 22 Jan 2025 14:58:12 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 22 Jan 2025 14:58:08 +0100
Message-ID: <20250122135808.3827827-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3dUZL4mXlswR3Am6ltfsFCX7OeL2J0ER
X-Proofpoint-ORIG-GUID: 3dUZL4mXlswR3Am6ltfsFCX7OeL2J0ER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220100
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap01: fix check_file() test for file corruption
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
Changes in v2:

- check return value from SAFE_READ
- only verify bytes actually read

 testcases/kernel/syscalls/mmap/mmap01.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index c93c37ceda52..b5798c8d2367 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -35,15 +35,18 @@ static void check_file(void)
 {
 	int i, fildes, buf_len = sizeof(STRING) + 3;
 	char buf[buf_len];
+	ssize_t len;
 
 	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
-	SAFE_READ(0, fildes, buf, sizeof(buf));
+	len = SAFE_READ(0, fildes, buf, sizeof(buf));
+	if (len != strlen(STRING))
+		tst_res(TFAIL, "Error reading from file\n");
 
-	for (i = 0; i < buf_len; i++)
+	for (i = 0; i < len; i++)
 		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
 			break;
 
-	if (i == buf_len)
+	if (i == len)
 		tst_res(TPASS, "Specified pattern not found in file");
 	else
 		tst_res(TFAIL, "Specified pattern found in file");
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
