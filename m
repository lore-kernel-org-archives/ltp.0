Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1953DC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 16:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAD0E3CAE18
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:44:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60FAC3C2C26
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 18:43:55 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A822520115F
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 18:43:53 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296GfcPd018045;
 Thu, 6 Oct 2022 16:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XB6yEocB1ng5TP7tzrFAgDEQvK8b3uR3GOA3XeFUW2s=;
 b=R/mznhOVpLyKnuzLzpLX0xUj8JbaJznhLbeHxs5x2+RrXf4jihNS82Shwh/yMjcgdR8S
 58PWszE7sUIJcZ0h8vshR98KrBbIKiHI7bW1voBcx4f2gMDPjRHGoQHE6ckUYnW2MHyc
 oVzY1PwauLjZDGHtbWjyqm9/RTIcDbtgyAenkv/C73hPWvLdS1XkibIrv19HE1Zc30mX
 NqYU6uha9roU7+FTJSg1h7NeiahBW8D0EKEsJTo+DHUnKxZkB60gKcqSTKLQLJ3p8UQn
 Hgmuaczfwe8kaRAOKVx4oH0HGIXirLWnC26G9j+A1aPu1v/w659WPv8ogQXrc2gD25q7 XQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k22rvr1ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Oct 2022 16:43:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296GagSm007804;
 Thu, 6 Oct 2022 16:43:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3jxd697da8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Oct 2022 16:43:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 296GiGJR42336522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Oct 2022 16:44:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20C0042041;
 Thu,  6 Oct 2022 16:43:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84C3E4203F;
 Thu,  6 Oct 2022 16:43:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown
 [9.77.159.79]) by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  6 Oct 2022 16:43:45 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  6 Oct 2022 12:43:42 -0400
Message-Id: <20221006164342.68763-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SDk94uv2NH4p2J6IsMDgZUELkkH_knTz
X-Proofpoint-ORIG-GUID: SDk94uv2NH4p2J6IsMDgZUELkkH_knTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060095
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] security/ima: limit the scope of the LTP policy rules
 based on the UUID
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The LTP policy rules either replace or extend the global IMA policy. As a
result, the ordering of the LTP IMA tests is important and affects the
ability of re-running the tests.  For example, ima_conditionals.sh
defines a rule to measure user files, while ima_measuremnets.sh verifies
not measuring user files.  Not limiting the LTP IMA policy scope could
also affect the running system.

To allow the LTP tests to be re-run without rebooting the system, limit the
scope of the LTP policy rules to the loopback mounted filesystem based on
the UUID.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_conditionals.sh       | 2 +-
 .../kernel/security/integrity/ima/tests/ima_policy.sh      | 7 ++++++-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 4 ++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index 0d50db906..d5c5f3ebe 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -28,7 +28,7 @@ verify_measurement()
 	ROD rm -f $test_file
 
 	tst_res TINFO "verify measuring user files when requested via $request"
-	ROD echo "measure $request=$value" \> $IMA_POLICY
+	ROD echo "measure $FSUUID $request=$value" \> $IMA_POLICY
 	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
 
 	case "$request" in
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index af1fb0028..95e7331a4 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -27,7 +27,12 @@ load_policy()
 	exec 2>/dev/null 4>$IMA_POLICY
 	[ $? -eq 0 ] || exit 1
 
-	cat $1 >&4 2> /dev/null
+	if [ -n "$FSUUID" ]; then
+		sed "s/measure /measure $FSUUID /" $1 >&4 2> /dev/null
+	else
+		cat $1 >&4 2> /dev/null
+	fi
+
 	ret=$?
 	exec 4>&-
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index df3fc5603..016a68cb2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -178,6 +178,10 @@ ima_setup()
 	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
 		cd "$TST_MNTPOINT"
+
+		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
+		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
+		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
 	fi
 
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
