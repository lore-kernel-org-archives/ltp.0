Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAC5C19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 14:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D8CC3CA0E0
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 15:56:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A5B33CA093
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75B691BD2578
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:39 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525ArSPg008101;
 Wed, 5 Mar 2025 14:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yHHRBDZIJVgbFSknx
 YrXzeJC0MQmU4oIq3enwGgiPx8=; b=KsCJJDF7LrwhTFUDWgme2BrM0WaiOSB7E
 rpY+WFnzoeaotqTkhPvuUfVjjPOpX8AmSa9FStCZX98wGo8Sz2r2XJ8Av+DoGPOe
 cVllZrCMaQQzcmRyRIbxHantxLeSTJVilCSXHB3yNuDgrH5u71Y94fVBvzKEWqjC
 95l4NVH91sAVHdJCHHtc9CNNAzhysnPIStfuCSV1/Z/Ma/UdOC3G4TUcfqztpAms
 1RkZ4O2mTNz/W4NTEFy0Xqpx4CbK/r675FvqhzY8IkLE4i5LLqQTjubXeBEAXXFK
 RxqPDMHGN8IskIMxkUhXMSKdXvfxYOt+qssSkpzzAUmm1Ul1yjVew==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppc75q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525BLN9v020841;
 Wed, 5 Mar 2025 14:54:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnkanu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525EsXED13304092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 14:54:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7734F20043;
 Wed,  5 Mar 2025 14:54:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B55D220040;
 Wed,  5 Mar 2025 14:54:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.124.31]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 14:54:31 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 09:54:21 -0500
Message-ID: <20250305145421.638857-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4KSx66GJD6S1wY-3ISK4BhfUVdxi_uHn
X-Proofpoint-ORIG-GUID: 4KSx66GJD6S1wY-3ISK4BhfUVdxi_uHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050114
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] ima_violations.sh: require kernel v6.14 for
 minimizing violations tests
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

Depending on the IMA policy and the number of violations, the kernel
patches for minimizing the number of open-writers and ToMToU (Time of
Measure Time of Use) violations may be a major performance improvement.

Most likely the kernel patches will be back ported, but for now limit
the new tests to new kernels with the applied patches.  Bail after the
first new test.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0395f8d0a..8e988fca6 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -177,6 +177,10 @@ test4()
 {
 	tst_res TINFO "verify limiting single open writer violation"
 
+	if tst_kvcmp -lt 6.14; then
+		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
+	fi
+
 	local search="open_writers"
 	local count num_violations
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
