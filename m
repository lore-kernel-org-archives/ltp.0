Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB4DC5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 22:29:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4532E3D75B9
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 00:29:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D7133CFEB3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 00:29:30 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C29DF140025D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 00:29:29 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QL1tEJ853478; Wed, 26 Aug 2026 22:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=L853njexZJ//RSiZG+KeWf1FauvA2KERRE/cGUEIU
 Bg=; b=dblbpITvViAg9NZCjc0fRwxc6h3vUugyiO1sa0W0FW9locwaxilRkiGdY
 YTiqCHCD5EIsKRlbEiF80O7gX0PgzHl0/7EBkxayaT4Yyf8E8GHJQjtma44q57iu
 4CCqZ1LX3ySpJEu4AKpvtdOkIXIZS0ucJP9Uey9eVQFzBJfOJkWMOncGxolS7md3
 k5DWSgnlFhZTJSj71JK5WXOfbvOmYX1224YjBP1xlzWs8sc1GWWGBhnx9Uq1JhFE
 kKzxiwQeF38S12KAob+ygc2o0q/586v8ujMuycPYLdE494XuBmT5F2s1m4Ge2bFg
 5oEM9IJONcQFXab4s0zIrbyl3nQZg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j1n09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 22:29:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QMQGFS032251;
 Wed, 26 Aug 2026 22:29:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragmcdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 22:29:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QMTOVf49217824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 22:29:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D3F220043;
 Wed, 26 Aug 2026 22:29:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A42920040;
 Wed, 26 Aug 2026 22:29:23 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home
 (unknown [9.61.80.63])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 22:29:23 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 26 Aug 2026 18:29:13 -0400
Message-ID: <20260826222913.802598-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4NSBTYWx0ZWRfX/OlTqOoioLWx
 lQGN4YWSEYO8pChBpWKs6L+5qxrvhPUiiePcau+kYbWgN/oiHxsnMDlHPmTmVSluK81AbPMCz9W
 sDV9dkZEqdl09gB5yeTUcCu62JWt46c=
X-Proofpoint-GUID: 455Zp8SfPEsdM_ofYhCSZVnsXtt6cKl6
X-Proofpoint-ORIG-GUID: 455Zp8SfPEsdM_ofYhCSZVnsXtt6cKl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4NSBTYWx0ZWRfXy6oswekeXHBE
 99Eq8T607GGwzjxThPAK2mfvhETdbXWl1MxHSgI2cO7IA/jI9lpjrX7N4hWASJM4fa8rlWSQOCC
 UDyf25HZuW3ex0bWq/kxceCyGwyEdkFNc+WVZcqqppkWCrWeDHtf1wTv1Cd7azOaLDwn2xcvvNQ
 H/YRLboWBuAb6zP4KRXfQ9IcP4toEh+315jXdz4IdYigR27J04wdHyOnmm4O7FWKhgnOPt2TSie
 d5QsuFNZyBVqw5ktmeZI71+Sj7CFb+jQ2gv4hGB6fsWGlnNZkFw4s5jCHTsOzmW3eSBwWsbsuj1
 91seSnW8oMGBeQKdOxydgri17B/3wtK+4+r16opoAueSg8knuM3UaKGzTWDqQ0EfUXDvvXYE6w+
 OAAXUpgEAlg2pWO+ghNLu7zw88z5/csubgVry4AkNIiTunmB13ciGTH+857XlkZXIvzoneapt88
 yji7Jy6aepPjdh0TN6A==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f68c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DcaeczIwcw92CAh3fjEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260185
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ima_tpm.sh: properly detect failure to verify the
 IMA measurement list
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
into account that the measurement list might have grown.

evmctl returns success/failure when verifying the IMA measurement list
and displays the measurement list line number that matched.

Update test2 to check the return code, before failing the test.
Include the matched line number and total number of measurement
list records.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog:
- addressed AI comments, minimizing changes

 .../security/integrity/ima/tests/ima_tpm.sh   | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index acd8b6d30..8bb86ea4a 100755
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
+		return $ret
 	fi

-	echo "$pcr"
+	lineno=$(grep -E "^($ALGORITHM )*PCR(.*10)*: succeed at entry" \
+		 hash.txt | tail -1 | awk '{print $NF}')
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

@@ -288,7 +293,9 @@ test2()
 	tst_res TINFO "real PCR-10: '$hash'"

 	get_pcr10_aggregate > tmp.txt
-	pcr_aggregate="$(cat tmp.txt)"
+	ret=$?
+
+	pcr_aggregate="$(cat tmp.txt | awk '{print $1}')"
 	if [ -z "$pcr_aggregate" ]; then
 		return
 	fi
@@ -296,6 +303,14 @@ test2()

 	if [ "$hash" = "$pcr_aggregate" ]; then
 		tst_res TPASS "aggregate PCR value matches real PCR value"
+	elif [ $ret -eq 0 ]; then
+		lineno="$(cat tmp.txt | awk '{print $2}')"
+		if [ -z "$lineno" ]; then
+			return
+		fi
+		total_measurements=$(cat "$measurement_count")
+
+		tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"
 	else
 		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
--
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
