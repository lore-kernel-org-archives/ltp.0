Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB9CC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 14:55:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171073CA0A7
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 15:55:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E4823CA091
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:34 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 818F6210B0A
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 15:54:33 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AJLM9025087;
 Wed, 5 Mar 2025 14:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gC84LdE35S4K++oOO
 gPsesF6e7Hj9gWh2zwcBlqZMa8=; b=mtbaNAdbbr/TAYoQBPiRGbXgLlkccW+jN
 VqxFUaKlV9VPEOm9nDoQIOCMUySW9yFCsC+1K37L2CTQYtz/4h1lRCmV6tOYrZGH
 hd1LP1Mh2tVcfIhlEke2VHwBei/Bk3AJjuxlzOXDqjJy9nvsTrF/joE/WrUVwP0i
 TjjAx8nvDVuSVR1RcQVUWX8BioXIsJwLE4GGNLjAW17HzUqxxuJPa+98g68VRFfs
 VzvgzMmpJYiW1m2+5HnCpX8HWTJg/WV01umnMLSY69OuPkR8hYcxxEYvhyzsng29
 Z29E9OKgBd8IzSFz/vItYPa7pzst8lrhFkzlEV/nd2McO0sVnjAUg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x545rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525BABxF020871;
 Wed, 5 Mar 2025 14:54:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnkanf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 14:54:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525EsR6t57934102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 14:54:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D04A2004B;
 Wed,  5 Mar 2025 14:54:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 070EC20040;
 Wed,  5 Mar 2025 14:54:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown
 [9.61.124.31]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 14:54:25 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 09:54:18 -0500
Message-ID: <20250305145421.638857-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VDHbSiairrhqdRnfPdw1UelQJwUWZpMd
X-Proofpoint-ORIG-GUID: VDHbSiairrhqdRnfPdw1UelQJwUWZpMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050114
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] ima_violations.sh: Update validate() to
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

Add optional support for the number of expected violations.  Include the
expected number of violations in the output.

Limit the new expected violations to the new tests, so that the existing
tests continue to work properly with/without the kernel changes.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_violations.sh    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 22863fb72..37bf2182b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -72,20 +72,27 @@ validate()
 	local num_violations="$1"
 	local count="$2"
 	local search="$3"
+	local expected_violations="$4"
 	local max_attempt=3
 	local count2 i num_violations_new
 
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+		if [ -z "$expected_violations" ] && \
+		   [ $(($num_violations_new - $num_violations)) -gt 0 ] || \
+		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
+			[ -z "$expected_violations" ] && expected_violations=1
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
