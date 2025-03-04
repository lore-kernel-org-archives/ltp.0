Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61993C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 11:54:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D03B3CA05D
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:54:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81C323C9F97
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:45 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB1D5234E03
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:44 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249rK5v026395;
 Tue, 4 Mar 2025 11:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dIsUEWCxqhEdj+mTgGu8xdt/PVIOMBGgS/hEVPIwg
 wE=; b=bqPDeVcga3sKu45+Jkpj/BG9zYMFd7LL1J8CKYJ7UYwjSLMgUjj06AG5g
 yk7OnPgMFzsDm8NI5gnTSJCMXpSEE1Y/SIDD++OewkO6kq/fX6bolxwCwGjeBW7+
 3GnIOmY5XAbUfbbTJ7eCVheuNLoJcwUUpgNws89x/gAIprWtnslmopxazXRJUKil
 sXyv61bTrnTHlmsTGkpzTG4eytwkS2FxUfhHUQDXpRjq2XzvaLe9hc9s8aDUyPdS
 cIZSmbVdViinIb9ZEEvYVzKXeAgY7+1W6FliSCqWx7j008Lkg7CGk+c1Rh4NLxIV
 DfdnW/4YCH4YVIbC2cAshMlohHHvw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kkpbncu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524BmaCC020911;
 Tue, 4 Mar 2025 11:53:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnd73e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 524BraBH59572704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 11:53:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F72920043;
 Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79C6220040;
 Tue,  4 Mar 2025 11:53:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.57.16]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 11:53:34 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  4 Mar 2025 06:53:28 -0500
Message-ID: <20250304115331.524842-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DMPT953wXYhrz0w3Bqn7xhNzyVE7aAN5
X-Proofpoint-ORIG-GUID: DMPT953wXYhrz0w3Bqn7xhNzyVE7aAN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=807
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040097
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU violation
 earlier
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
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Violation tests are dependent on searching the $LOG file, which may
itself result in a ToMToU violation.  Preempt getting an additional
violation during the tests by forcing the $LOG ToMToU violation
earlier.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 37d8d473c..22863fb72 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -30,6 +30,7 @@ setup()
 	if [ ! -e "$LOG" ]; then
 		tst_brk TCONF "log file not found, install auditd"
 	fi
+	exec 3< $LOG || tst_brk TBROK "failed to read log file"
 	tst_res TINFO "using log $LOG"
 }
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
