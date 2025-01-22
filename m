Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DA8C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 10:10:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3A3F3C2ED7
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 11:10:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26C063C2CD6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:09:47 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C91B2142AA58
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:09:46 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M5OGEq015160
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0tGKbKYxkJFaCkRU5kg5lBIPa8Ql1NZXYbZIOSOPN
 Tc=; b=myeRmXW5DvV4g1sbMU5wonUc4eKiCk2l1BBXbXAUR7o5FR8HckBNSrJZs
 0mEgEsOrmxg98O53ZIujoIqhl37SuQQkQD9JsUwZYrx04YWwXois0Eh43+Z80q3P
 UEd4dFIcv4wYJKCP5ZYxI7WZH7C9iWCVlylDANY+5FTDryXHK2/WudTRoA2ZncFr
 ki7At0MQVAMgIt+xeRg1LsxLNZKa1wMGb6ddBEEzE+cucJQ/gweooUvojTo7Xut4
 pD+jwc6SkhyvwdWAKlPABP+LyBN020Veu+c9Wl9emfoZZRy8EjSD6WL52sZKIDjg
 yLd58rFqCm78z+sIRbuzDeijqCS9A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44atg8165e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MA8gTI022449
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k7sr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50MA9eQn58720624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAA020043
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82C9B20040
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:09:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
 id 3E0EEE02AD; Wed, 22 Jan 2025 11:09:40 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 22 Jan 2025 11:09:14 +0100
Message-ID: <20250122100915.3126008-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oZCA-eJ04HiJ89nor_6PCtHP85zkx-NP
X-Proofpoint-ORIG-GUID: oZCA-eJ04HiJ89nor_6PCtHP85zkx-NP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=842 clxscore=1011 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220073
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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

mmap01 reported random test failures. Turns out the
the temporary buffer in check_file() isn't initialized.
The SAFE_READ reads less then sizeof(buf) bytes so the
rest stays initialized and might contain bytes check_file()
is looking for.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 testcases/kernel/syscalls/mmap/mmap01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index c93c37ceda52..ff09bc635c74 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -36,6 +36,7 @@ static void check_file(void)
 	int i, fildes, buf_len = sizeof(STRING) + 3;
 	char buf[buf_len];
 
+	memset(buf, 0, sizeof(buf));
 	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
 	SAFE_READ(0, fildes, buf, sizeof(buf));
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
