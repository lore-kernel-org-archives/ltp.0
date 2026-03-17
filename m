Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B571F33818
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:44:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53CA13E2B79
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:44:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11CC93C59E2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 09:44:31 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34BC7600952
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 09:44:29 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GFE2TG1256294; Tue, 17 Mar 2026 08:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=BEmlmbC4NeSmD6OD4tNLsH6aI6PtugG/udMQbR7Cw
 Qw=; b=NzO4rLvtocH23hYcpbyYA54S2y1tv9vtWNVWbwbibkUsKXj2+/S0lLCdC
 YwX7y+J6T0GSxSN2sl3hWaSMzaIxC2193kD6SniOYPIYgvxLyovHxEST3fzmcWHd
 tsKZTAhuCfiK+CNfjmskM6wqtWhAlWM1uFgTiyt5STbLWwDiW3yi0B3MwQQdMnyy
 0XelSxeCElFNPEYkNQP3+ttg/S0/OFKdxHG3zWvUZRltP2djVNfqm4Dy0p3Atli5
 L8PQc7jwfX2MzebHpkfLX0DBx4EkHp2DHYfMTYAT29lYd0hpLW7NNVPT11ZanLvC
 0cThcsNXoEEMJEUUEQ678JwdTwkDA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64kucu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 08:44:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H8F53o028496;
 Tue, 17 Mar 2026 08:44:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq18311-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 08:44:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H8iO6X49414582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 08:44:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DCC620040;
 Tue, 17 Mar 2026 08:44:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E99A2004B;
 Tue, 17 Mar 2026 08:44:23 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 08:44:23 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 17 Mar 2026 09:42:03 +0100
Message-ID: <20260317084203.2956-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cr02y1MDuktAE1RGiPHA9Yg2dD4DAkJg
X-Proofpoint-GUID: Cr02y1MDuktAE1RGiPHA9Yg2dD4DAkJg
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b9146b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5-pQ7yXENHXZ-_91MTEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3NiBTYWx0ZWRfX4/0Pr+AuRT0p
 hAwVs6prMWnNbhVPWCd1cYNi1dCdu0QtPK7dBW12H2r6V78udYufqLPcSpW/1qXd4M1OzuyFR4q
 pQBoR86QvbYd4XoS0EvxmmkUYeJjLyvuHmJT6rtBbW/tm/FoMJZLUD0o9tLXaa1FhZrb9+ZVgyU
 jy/iVh6uCfr+doCutIqYEFkntwNca5/SziVqCRtppkqAroSBm0T9p1xscZ/hR/1Q3qpjks8cSfA
 qo5gMWDdU47jicSz5ItXpKw+JaYh+nMuMtGDwrLIgUVXJNZy7AH1xjMihTZUPYmKYStnOM+ujtq
 9mfWIZv02+Qy0OtiJwtlvESYrbU9fUWtaW1KvBY8ubfls7Sc/O83Pxmx7+nEWETT0y/4LV6Xdra
 7m6iwxcJP70PTfBd3AXut/5evzXkCB0jGXR4oNq3xKx2iqSmuJPPROB8lCBLyjtyslM0wiMvNig
 xYZv2eYrNpFmyeTnY2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170076
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [LTP v2] controllers/cgroup: Skip regression test on
 cgroup v2 systems
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cgroup_regression_test.sh test2 attempts to mount a cgroup
filesystem and expects a cgroup v1 hierarchy. On systems using
cgroup v2 (unified hierarchy), the test fails with:

  TFAIL: Failed to mount cgroup filesystem

because the legacy cgroup v1 mount layout is not available.
Use the cgroup_lib.sh helpers to detect the cgroup version:

  cgroup_require "memory"
  cgroup_version=$(cgroup_get_version "memory")

If the memory controller is on a cgroup v2 hierarchy, mark the
test as TCONF since it is only applicable to cgroup v1.

This avoids false failures when running the controllers suite
on systems where cgroup v2 is enabled.

Changelog:
V2 -> V2
1. Use cgroup_lib.sh helpers to detect the cgroup version instead of relying on the /sys/fs/cgroup/cgroup.controllers file check.
Older Patch link: https://lore.kernel.org/ltp/20260316115800.GA311158@pevik/T/#mc4b1bb1d0f73d0267a74f3de9764fa8fb398eecc

Signed-off-by: Samir <samir@linux.ibm.com>
---
 .../controllers/cgroup/cgroup_regression_test.sh      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 276231fe8..cc8fa1f99 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -117,6 +117,17 @@ test2()
 {
 	local val1
 	local val2
+	local cgroup_version
+	
+	# This test is specific to cgroup v1
+	# Use cgroup_lib.sh standard way for version check
+	cgroup_require "memory"
+	cgroup_version=$(cgroup_get_version "memory")
+	if [ "$cgroup_version" = "2" ]; then
+		tst_res TCONF "This test requires cgroup v1, but system is using cgroup v2"
+		cgroup_cleanup
+		return
+	fi
 
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
