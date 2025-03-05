Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13CAC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 14:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0948D3CA0CB
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 15:55:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D5593CA0A7
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50BAE101D8D4
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:36 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AsFCZ028235;
 Wed, 5 Mar 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K3BIVVofhQVjkD+94
 1L35A8B/+mxTg7bA9YUtM1C09s=; b=Bqdr6cPynsjhT51Xb1QX0jCLKbQbZrtUG
 Utqr6ZqKsJWnhmIjU3ce2mpPnol9ZjiQhD6h3jTXsWhrAGZggbLKUEyAqoCeo4ck
 eCQ6rYqTQ9DSnYHLPjBT6PgMGHoso3x6XHypsvDhodFH84hxFHhSJE5RcmXNcfsa
 szP+zWogqFXedIOHbQlW0Q6VCFIhRU7CrPzvit6vZRXKUpJWd8E8kzM6pANXxKhq
 4db1iE2mEOux0wWIKwS4hU5YuFHbdqsgqygRtc3+GGUGAb6mqtddp03NuBXDd1TQ
 lb3Ri71/K0NaZzpYX+DgtyoZujGBdYMMQT9RkxAu+RRyGw9Dm/4dw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x545s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525EMo6o032219;
 Wed, 5 Mar 2025 14:54:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt3gyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525EsVNv31654350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 14:54:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DA520043;
 Wed,  5 Mar 2025 14:54:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB66920040;
 Wed,  5 Mar 2025 14:54:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.124.31]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 14:54:29 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 09:54:20 -0500
Message-ID: <20250305145421.638857-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n8T14XmXTmSQFopoHdMl1jOLZIdc_dkW
X-Proofpoint-ORIG-GUID: n8T14XmXTmSQFopoHdMl1jOLZIdc_dkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=649
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050114
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] ima_violations.sh: additional ToMToU violation
 tests
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

Kernel patch "ima: limit the number of ToMToU integrity violations"
prevents superfluous ToMToU violations.  Add corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250228205505.476845-3-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index d3081a4d1..0395f8d0a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=6
+TST_CNT=8
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -247,6 +247,50 @@ test6()
 	validate "$num_violations" "$count" "$search" 2
 }
 
+test7()
+{
+	tst_res TINFO "verify limiting single open reader ToMToU violations"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test8()
+{
+	tst_res TINFO "verify new open reader causes additional violation"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate "$num_violations" "$count" "$search" 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
