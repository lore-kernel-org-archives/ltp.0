Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAFBC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 14:54:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D1273CA0CB
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 15:54:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AFA93CA08B
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:34 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 369E060054B
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:32 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525CSVob032499;
 Wed, 5 Mar 2025 14:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dIsUEWCxqhEdj+mTgGu8xdt/PVIOMBGgS/hEVPIwg
 wE=; b=igYb5oItdSb0xnE+GdQpgH9i320UNZefULGnQaraOpVyR2swfTVobD4bM
 x4wTS6/RW4IdswzkCxdWJ//JiDiIjGEU7gX9JqXarzQHOCKGY1zuB3Wb6Kvghcil
 hLwCGYVTjZqzQnkBiUhsUAcFAapQcp2fIfsxIGfPalbguti+O5LXA3wJv4d0jQEa
 7lmSO4kuun00OpyRuWn9b0aMdOr/og66VsuXi9hYuu5e0bE+59AZX5wB2+dQpGoc
 r4ecl2YC3dfdOKzLqB14Y/SJJBppRCJ2kpgUYZmXTual/RrM/UIXFdo88OHr1b0w
 GFuHeLwJ2zspEIwfg2xszZTL33EAA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnarqdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525EVnfb009015;
 Wed, 5 Mar 2025 14:54:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyke6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525EsPt656230392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 14:54:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC2EF2004B;
 Wed,  5 Mar 2025 14:54:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F8D320040;
 Wed,  5 Mar 2025 14:54:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.124.31]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 14:54:23 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 09:54:17 -0500
Message-ID: <20250305145421.638857-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 08Wrky9M1XQegqMomOuHwtwvuqwf27t1
X-Proofpoint-GUID: 08Wrky9M1XQegqMomOuHwtwvuqwf27t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=806
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050114
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/5] ima_violations.sh: force $LOG ToMToU violation
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
