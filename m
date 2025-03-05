Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D58EC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 14:55:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DDB83CA0D7
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 15:55:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00D73CA0C0
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E06032206CD
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:37 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Aux0G014524;
 Wed, 5 Mar 2025 14:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wzBYCtoFjoQzKoLWG
 ylW8AnaF+6J8BCZPX7uWvWMduA=; b=Tg7Kx+Ch/VsnsWjVVzvVIUGrTRyGO8dKo
 XyrwjSdLppxpgy6f7OVRnCbzYt1qCsLt2IyWNQvraTLuP+w6Y64H/U0qbba5qFR3
 bZmWuRpRrnPVEQlQFqXtr+2/YopSLkGViStrV1Azw9bdqiMSwc+o77kl5lN/AlVS
 DeGjHDxbQ7E5fCuyuwI5g5Ocwk0GIObUuvKdyPzWq/sfRGaL3msEC/vdQgssC3th
 le4BcA/BcG0996i90JTk+9W8OLOQXtuE2fSFZCL9VIwwQk/oZLQmdMt36L2/AAUz
 /aTcdV4ZIARHzZ7RmOQL7OO7FH9Ct1R5hjyBum0v4zSqDdSeBrHsg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0m6m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525BE4C3013805;
 Wed, 5 Mar 2025 14:54:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2ku7e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525EsTEt56361224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 14:54:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F0C720043;
 Wed,  5 Mar 2025 14:54:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D264420040;
 Wed,  5 Mar 2025 14:54:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.124.31]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 14:54:27 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 09:54:19 -0500
Message-ID: <20250305145421.638857-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: guUI_ohwhEFLzwUAx0Mjg9khRZB5spg9
X-Proofpoint-ORIG-GUID: guUI_ohwhEFLzwUAx0Mjg9khRZB5spg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=984
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050114
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] ima_violations.sh: additional open-writer
 violation tests
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

Kernel patch "ima: limit the number of open-writers integrity
violations" prevents superfluous "open-writers" violations.  Add
corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250228205505.476845-2-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 37bf2182b..d3081a4d1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=3
+TST_CNT=6
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -61,6 +61,17 @@ close_file_write()
 	exec 4>&-
 }
 
+open_file_write2()
+{
+	exec 5> $FILE || tst_brk TBROK "exec 5> $FILE failed"
+	echo 'test writing2' >&5
+}
+
+close_file_write2()
+{
+	exec 5>&-
+}
+
 get_count()
 {
 	local search="$1"
@@ -162,6 +173,80 @@ test3()
 	tst_sleep 2s
 }
 
+test4()
+{
+	tst_res TINFO "verify limiting single open writer violation"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_read
+	close_file_read
+
+	close_file_write
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test5()
+{
+	tst_res TINFO "verify limiting multiple open writers violations"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_write2
+	open_file_read
+	close_file_read
+	close_file_write2
+
+	open_file_read
+	close_file_read
+
+	close_file_write
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test6()
+{
+	tst_res TINFO "verify new open writer causes additional violation"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_read
+	close_file_read
+	close_file_write
+
+	open_file_write
+	open_file_read
+	close_file_read
+	close_file_write
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
