Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C27C5DF8C
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 20:07:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E8103DCD68
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 22:06:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4204A3C0962
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 22:06:38 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61380600948
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 22:06:36 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LIVexq1237239; Fri, 21 Aug 2026 20:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ud0M7LVjTPzoYvjbtwz3P0o6sVL8jTDAPuquyjVBf
 0o=; b=O++JfINyJ4tkJv2gUNsaQVZv7bQNcIuZPsPfA87yXoFcoIOS/C/rjj2ag
 PxyVieOwwX1BDP3HbzhWtItNRMeqWYvkLw7qIzercxkupq7Ig+PWVNBxMotbYJ0l
 /jHzBBLh6OOHMbxxxQmpPMZ3Y4lsSMiaNEtl+MMfCQDw1XzHu69DUxCcNdj3mDTv
 4pTPA2hwZL14HsFHfSpPViCDWalDtLC6XPVOYnYg8V0u99C5It0uZUFXjYlKLcce
 cQyXS+bBSee2w48ztl80FrOPLSCBOyCTrgZxSiDZKShg9odW+pLjyLBALmxcM8Ui
 EyEjZ5l8GbdSp9Qb8uc/5vs9eW+Pg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2ktt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 20:06:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJuKT7009952;
 Fri, 21 Aug 2026 20:06:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpxs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 20:06:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LK6Vks35717456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 20:06:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEA882004B;
 Fri, 21 Aug 2026 20:06:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78D6120049;
 Fri, 21 Aug 2026 20:06:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.mynetworksettings.com
 (unknown [9.61.97.171])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 20:06:29 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 21 Aug 2026 16:06:20 -0400
Message-ID: <20260821200620.902699-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88afc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=okxfWEJuFnmLN7zTFJYA:9
X-Proofpoint-GUID: MHFFpccppfVI3AWxF8yk-E7GU9rPhWMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfXxJZp0ael4b5k
 abH10qCCeppxvQUSmBy6/WSdfwsDmcxM2JgnqvycjyeIa27Jf0PKPFpk6vgE4Sdy0xBsFcNgWvL
 S7kOBFhXWFt7hiTmB2vA01A7S00MtP/97FFVnkOSVNAzfrIwy00zNXicY51HuZoWLECucsd0DTi
 RepTbPvGt9fAlYMAIwM5LdFGVgNcX21Ts/jZdu5uEt5UYpCgc9QBpU8UnFuEcmFMlJddRpmxIiz
 uzzH/DbBStXlBcTjGf0JTU4tAVcA2SYNOvUHXaQhpSWw9e+pjyy71/tlzVAr1+jYx8kwMHq43zL
 Qv1ZoavmweSVpIg90gpa6udhz7k+JB4hG3uFMMbK+rd/rGedlnbW2YtVgPsR4SqiW5mNCp0oClQ
 AboAdExeD+s+JTYAL10G0mmNgNHSueZ+m7r6kJbry/DwtCmFncepK0EqEHb0N1IF6ZZQ+ocm0cM
 fxKS08ts0BUdSpzCg5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfX0DzdBsjlSvKy
 oraAVkWn9lfosUcodhpAx9LcngrwOjIkgrnoo9nIVFfq5YRpIbNfH58sGzrUvYJmNFCm6+58D4b
 r8tvBf4Cptxn6ARCNHdIreH6UYcH/yM=
X-Proofpoint-ORIG-GUID: MHFFpccppfVI3AWxF8yk-E7GU9rPhWMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210160
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_selinux.sh: test2 assumes
 CONFIG_IMA_DISABLE_HTABLE is configured
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
Cc: linux-integrity@vger.kernel.org,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

test2 uses the last "selinux-state" record stored in the IMA measurement
list to determine whether SELinux is in enforcing mode and then compares
it to the selinux enforce file status.

The tst_update_selinux_state flips the SELinux enforce status
(/sys/fs/selinux/enforce) to force a new "selinux-state" record to be
appended to the IMA measurement list.  However, this only happens when
CONFIG_IMA_DISABLE_HTABLE is configured.

Don't fail the test when CONFIG_IMA_DISABLE_HTABLE is not configured.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../kernel/security/integrity/ima/tests/ima_selinux.sh      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index e64a7739f..9b312f8b7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -147,7 +147,11 @@ test2()
 	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $4}')
 	expected_enforced_value=$(cat $SELINUX_DIR/enforce)
 	if [ "$expected_enforced_value" != "$enforced_value" ]; then
-		tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
+			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"
+		else
+			tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		fi
 		return
 	fi
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
