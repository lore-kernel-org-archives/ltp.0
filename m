Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419BFC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 16:01:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C48C3C6F9F
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 17:01:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55BB83C53D7
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:01:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32DA124CCC8
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:01:06 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KChoQ1002255;
 Thu, 20 Feb 2025 16:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rbxod9JTGJoVOfBeZ
 k/WaVpR0qDcIB1nEh0Q2tRv6Cg=; b=izQqHok8jSfFFlqiVVKXrazRb7VDcvmTF
 2iGfg4g/YS/SVpF/qDmXSB2r7b7mwq5P5IJikLcjJq5FQwdoZAJpgsWbpUrkSvAc
 OFv0ciDQzR16Cc2UAe3WVQgDRhm+EQhiFEk1WfndaR97b6eXvrgX3HoDdLD/Rb1A
 ZXV5CqqbOPcwU0DfHgyJbIQj0XP4Xz1PzcsYIDAwJIpI3/i8T7Bj7p0HVm8TwlCU
 UqXGF979pxA7Frh7efbC2aIzROni7vXw8OFgOWmBz3lYNorPPY/IAxheVoCqS9BK
 TQCiOHzs31QMHjiMsCgLPiB6DJSDxzkPDY6r6TVCtM3hAirOYkgOQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa3vxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 16:01:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEt3kl009691;
 Thu, 20 Feb 2025 16:01:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03yauc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 16:01:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51KG10A547972822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 16:01:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7A0E20043;
 Thu, 20 Feb 2025 16:01:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71FE520040;
 Thu, 20 Feb 2025 16:00:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.68.26]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2025 16:00:59 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date: Thu, 20 Feb 2025 11:00:53 -0500
Message-ID: <20250220160054.12149-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220160054.12149-1-zohar@linux.ibm.com>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRJqZnyL4wCpdTttUCOXzBT53TClYZkP
X-Proofpoint-GUID: RRJqZnyL4wCpdTttUCOXzBT53TClYZkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=905
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/3] ima: additional open-writer violation tests
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

Kernel patch "ima: limit the number of open-writers integrity
violations" prevents superfluous "open-writers" violations.  Add
corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-2-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 7f0382fb8..65c5c3a92 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=3
+TST_CNT=6
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -60,6 +60,17 @@ close_file_write()
 	exec 4>&-
 }
 
+open_file_write2()
+{
+	exec 5> $FILE || exit 1
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
@@ -160,6 +171,80 @@ test3()
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
+	validate $num_violations $count $search 1
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
+	validate $num_violations $count $search 1
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
