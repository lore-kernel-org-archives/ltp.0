Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C353C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 00:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2D6D3C6EBE
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 02:35:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B91B3C062E
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:34:57 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 565C71A000A0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:34:55 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q0VXo92458019; Wed, 26 Aug 2026 00:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4wFA3SYsMF8qzznrAP91sb5p35mXskhnffM5ho5oL
 5E=; b=Q1UCA2VtPdVikKHxO9AobzXLQ/oPA7NcwcjZ8qFaoOedKnDUjHJ3HHDR3
 7XnfkZlBbUXE7Xqy/AjsMBHLvT0LRLVVoq9Fnj/HXpAgG/cCsTCecWyaEz3lNkpW
 THaRAj62QgA7rhSfIEBg/8sYFxsghSvTQZPp0t+xuzRSVRmHnu6Kvlc+xT2jKg3r
 5SDBZItieizftMKYLxU9gsNiwHXPyxqBOqpvdVKLtvbvQbslmR/Xi6so1D8G0lmp
 EjmIoamiiO4y1aG455rnIQaHoIRS+YkU7TW07saJGYka/NRaJVYUJm4Yo56k0VS+
 ecvOMB+UlYYAjy2w0bTf8C30G1s+Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4umkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 00:34:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q0QSOo017865;
 Wed, 26 Aug 2026 00:34:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy70h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 00:34:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q0YnZZ48628190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 00:34:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D7482004B;
 Wed, 26 Aug 2026 00:34:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0CA420040;
 Wed, 26 Aug 2026 00:34:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home
 (unknown [9.61.20.77])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 00:34:47 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 20:34:44 -0400
Message-ID: <20260826003444.424097-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kv3XaVqllBMohAAtYBciMSbGWB7UEKgd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAwMyBTYWx0ZWRfX0tCkzR0mNa3f
 +AYeWodgZbM2cboguBV+m4rhtlPCKALIREvCHTxjM2HAfTWAZdnRvgM0uiLCu7aujDJkhdniWGP
 fO7eGGmKkzoGkfEJdxfLsiwBpBUVwz4=
X-Proofpoint-GUID: kv3XaVqllBMohAAtYBciMSbGWB7UEKgd
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e34ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tqA8ivxAeGEm9z13NQ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAwMyBTYWx0ZWRfX7voLwNN4DpUS
 Fmp6JkcPHgfAZJeXsZqBLw0pHDRm9svwkv4Tsyf2M0kymIBifiUhpgQh4laf9dcHshrAJU9S/iE
 elI5uOmFKUDz/y4wLjNItxY5wJBS5xv//vkLpy8qbhWZXYZaUQJWuTib+xZmhFVPbAc7b1SadDY
 nfszLaiIP14voRFrttJVlqhPgiOrWfZsPAkI2RmnPGmratn16W6yJKPbQs5jPRgQP7nwNyaUFgG
 PUL3WlDnUQRO2CILxomqdBYHFjIC7CWc6zjLLKhp3evAm8SYaE32ZTYu8x+cplFLUi11PBGPQIL
 cNgh8nbblTrecdufPYJJ8UQPQyQ4AQ0m8MgNcc2AN1KNDpPsH7s2fnWDvzdrTr9xznW74HlydG+
 6YRUulIdCMvaKpuYrhBkz4oZy8PPMzA1BT6Wq2SNyPK/HWnnIBuNGudz7zG30Dp2tJbSdwdOSNM
 rPty4vLxQz+x5SjhE/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_07,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260003
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

test2 attempts to compare the aggregate PCR-10 value with the current
TPM PCR value based on the current measurement list, but does not take
into account that the measurement list might have been extended.

evmctl returns success/failure when verifying the IMA measurement list
and displays the measurement list line number that matched. Update
test2.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_tpm.sh   | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index acd8b6d30..5f7a5e983 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -146,7 +146,7 @@ get_pcr10_aggregate()
 	local num_violations=0
 	local msg="$ERRMSG_EVMCTL"
 	local res=TCONF
-	local pcr ret
+	local lineno pcr ret
 
 	if [ -z "$MISSING_EVMCTL" ]; then
 		msg=
@@ -178,10 +178,13 @@ get_pcr10_aggregate()
 		tst_res $res "failed to find aggregate PCR-10 $msg"
 		tst_res TINFO "hash file:"
 		cat hash.txt >&2
-		return
+		return 1
 	fi
 
-	echo "$pcr"
+	lineno=$(grep -E "^($ALGORITHM )*PCR(.*10)*: succeed at entry" hash.txt | tail -1 \
+		| awk '{print $NF}')
+	echo "$pcr $lineno"
+	return $ret
 }
 
 test1_tpm_bypass_mode()
@@ -249,7 +252,9 @@ test1()
 
 test2()
 {
-	local hash pcr_aggregate out ret
+	local hash pcr_aggregate lineno out ret
+	local measurement_count="$IMA_DIR/runtime_measurements_count"
+	local total_measurements
 
 	tst_res TINFO "verify PCR values"
 
@@ -288,14 +293,21 @@ test2()
 	tst_res TINFO "real PCR-10: '$hash'"
 
 	get_pcr10_aggregate > tmp.txt
-	pcr_aggregate="$(cat tmp.txt)"
-	if [ -z "$pcr_aggregate" ]; then
-		return
-	fi
-	tst_res TINFO "aggregate PCR-10: '$pcr_aggregate'"
+	if [ $? -eq 0 ]; then
+		pcr_aggregate="$(cat tmp.txt | cut -d " " -f1)"
+		if [ -z "$pcr_aggregate" ]; then
+			return
+		fi
+		tst_res TINFO "aggregate PCR-10: '$pcr_aggregate'"
 
-	if [ "$hash" = "$pcr_aggregate" ]; then
-		tst_res TPASS "aggregate PCR value matches real PCR value"
+		lineno="$(cat tmp.txt | cut -d " " -f2)"
+
+		if [ "$hash" = "$pcr_aggregate" ]; then
+			tst_res TPASS "aggregate PCR value matches real PCR value (line: $lineno)"
+		else
+			total_measurements=$(cat "$measurement_count")
+			tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"
+		fi
 	else
 		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
