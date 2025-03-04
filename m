Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF9C282D0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 11:54:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 872DA3C9FD2
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:54:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5283CA02B
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 613071B61635
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:46 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248JUMQ025721;
 Tue, 4 Mar 2025 11:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LmcVmL38kPy19S85F
 fWj7n6TEM1bVoju/O73PeQ4eZ0=; b=Gsihoe/W8uYDnsp+uG+1gq03BCcwnJT7S
 Tx0f1vbmSdqrvYqkv6TlEds7wFEOiVYjJS6dkVVkAZP+nOw3507aVAuRFtq41Nd7
 yVmDZWG4QMfjQ6IPMUViFVLVfj19jNfVIflcp1tda5nMkq7RVYh+i4LspZed5/Dj
 q7nm4fLObSc8Hx1U5NGilNuplDuMnM+3N+BqeLPk4WwfUh3w8HMmKXfPTJMS++6n
 7EgceQPtI/Ntp5EyqNZOL8qro8p4YhZRBDpTRSG4UVcspUjUXdxBd2g5enZtNb1w
 MZFBaV+yV8yn+wb55UVxS5BOhfcoZBZKISI2Fzb4adNKT1aBKdIxg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455cf2q1hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Aev4K032243;
 Tue, 4 Mar 2025 11:53:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjswdsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 524BreQf47579458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 11:53:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 205A020043;
 Tue,  4 Mar 2025 11:53:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7811920040;
 Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.57.16]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  4 Mar 2025 06:53:30 -0500
Message-ID: <20250304115331.524842-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YdbllpIggr-IZ-fqMMGJLyjcHa-9Oe3r
X-Proofpoint-ORIG-GUID: YdbllpIggr-IZ-fqMMGJLyjcHa-9Oe3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=984
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] ima_violations.sh: additional open-writer
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
index 3f9f1d342..578cb1402 100755
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
@@ -161,6 +172,80 @@ test3()
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
