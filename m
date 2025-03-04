Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522E2C282D0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 11:54:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92BE53CA020
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:54:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06FB93C9F97
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCCED140BE9E
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 12:53:44 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249aV82019982;
 Tue, 4 Mar 2025 11:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QGbeJRF925HXWhPNN
 J8aV16aHxXe85Vff5z/3n8rWIQ=; b=kke0AGF2rE4KtNYGA4qYAyWq6ad9bSVzG
 40BYwxyQOwGjro+tAETN/IthwJmdy2paMpWwSPzfdlpcwyHPVc1Wrb1xE3H6VnrS
 phjqlWIuaJDedsrBB6ZI/OCu7vkVz93aN6MUNAEKKpr26l9CHT2mkgo2vpILKtCA
 vOhliBgWl4hOuSoQNdAhLs3XsYX8sMqhnoOhWx41ZiDGqh3sDbdwM73SKufD0gyC
 LN9nAMv0YIbrnkKhnoVFKcLqMD4l2rZ7bZS4t3iXYRunTGa4I0LtLS7/OqzI42wR
 4rDhwsafb8mUiTWoKXcPPmGG3cee+iOvYZHulCF6gYEZGgh9Li2CA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyknst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5249OKNA020877;
 Tue, 4 Mar 2025 11:53:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjvvhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:53:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 524Brcsc46858514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 11:53:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1701D20043;
 Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C45E20040;
 Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.57.16]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  4 Mar 2025 06:53:29 -0500
Message-ID: <20250304115331.524842-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YDGoMroYa3wtpnbpN-USTH_EBYSyU7Xp
X-Proofpoint-GUID: YDGoMroYa3wtpnbpN-USTH_EBYSyU7Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=945
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] ima_violations.sh: Update validate() to
 support multiple violations
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

Add support for the number of expected violations.  Include the
expected number of violations in the output.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_violations.sh     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 22863fb72..3f9f1d342 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -72,20 +72,26 @@ validate()
 	local num_violations="$1"
 	local count="$2"
 	local search="$3"
+	local expected_violations="$4"
 	local max_attempt=3
 	local count2 i num_violations_new
 
+	[ -z "$expected_violations" ] && expected_violations=1
+
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+		if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
 			if [ $count2 -gt $count ]; then
-				tst_res TPASS "$search violation added"
+				tst_res TPASS "$expected_violations $search violation(s) added"
 				return
 			else
 				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
 				tst_sleep 1s
 			fi
+		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
+			return
 		else
 			tst_res $IMA_FAIL "$search violation not added"
 			return
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
