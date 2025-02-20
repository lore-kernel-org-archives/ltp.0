Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1DC021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 16:02:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89CF53C280D
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 17:02:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4554B3C6BA8
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:01:11 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38A771BDC8D2
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:01:09 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7Wq9X008224;
 Thu, 20 Feb 2025 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/UUSWhrXooLS6NXNd
 9cpiIivxQgEZ21j5nQ3LsB5ejY=; b=S6bLBx9iByg2yta8dal8xykRi8w9pb3dV
 esJKVsZxhvJSpjBrfXrfkxqZJv9gW/mNuiKryLE3nNMqqze817nNSMWm0ILKB/Nb
 szq0i5b2ehzgftNbbDe3PO56Py0nsIgYwKUpAsFBsVQvcZhzXxsGr11e39DR2YGx
 OVMOZLtILKt5mHfPMB31Agtaxi6WTjbWkECo9rAKAhhWwG8LVseAR7xGOCMRpBgC
 RjLa7yKD/FpehA+w0J0nX+UtNZ3nfukWzBMEojs39y8wL+9xrqnXCEOhNIjg6Dwj
 9IgBP0uUHqcmNq9qU3GQS6DNjrVxPSBi9xZQtwNfQfaV5XcnF+4Kw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x03qthka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 16:01:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KF7x6T005771;
 Thu, 20 Feb 2025 16:01:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xjtj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 16:01:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51KG125G43516188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 16:01:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D41420043;
 Thu, 20 Feb 2025 16:01:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 337E820040;
 Thu, 20 Feb 2025 16:01:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.68.26]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2025 16:01:00 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date: Thu, 20 Feb 2025 11:00:54 -0500
Message-ID: <20250220160054.12149-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220160054.12149-1-zohar@linux.ibm.com>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tbRq0PLQX38hTjWatrv4JsZBqxCpznMF
X-Proofpoint-ORIG-GUID: tbRq0PLQX38hTjWatrv4JsZBqxCpznMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=581 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 3/3] ima: additional ToMToU violation tests
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
Cc: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernel patch "ima: limit the number of ToMToU integrity violations"
prevents superfluous ToMToU violations.  Add corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 65c5c3a92..5b6d7e993 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=6
+TST_CNT=8
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -245,6 +245,50 @@ test6()
 	validate $num_violations $count $search 2
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
+	validate $num_violations $count $search 1
+}
+
+test8()
+{
+	tst_res TINFO "verify new open reader causes additional ToMToU violation"
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
+	validate $num_violations $count $search 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
