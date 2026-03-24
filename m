Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE86F54ABA
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774361447; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=xrN8/tsiCi8Ad3zCT0LZDOxOiRpPDkeZVHlEEoFjmg0=;
 b=CVaIEbKoUGoLrXLQdnGnyxopbBUvhRuLM77rAZNtZY3ICvKIBCUWybf8fynlnq/asWzUF
 6Hzj7SsqMHC0mV1zznYDRRPaFnO++LblLs/OvDvNHFnFY/DvDmIQuJBqlj5DYUwxmmq+USJ
 qOzmmEZtXXPECGmeNDNwjDVvkeElbSU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CEAA3E5549
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 15:10:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9617D3E4B6D
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:10:23 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFD1C1000425
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:10:22 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O5maeu406889
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dqtxKtBv+5tFsWDbDvYgn8CMDaNDP9avYridXfFOS
 VI=; b=GQZ/N+zYEp9ABPKNS7X13zYW0r+D/bTWP8JVKBZbUpZqAiYxCD1wC74aJ
 zzHXQo5fyTN/IY+A/8OxshZQ8ps3TARVi6g5qLxeKIot7boLgaC89OwJN/gagUTC
 BQDDmf0OgKCJA/hQGnwppbxdG69+IGtF1L2dAtashcVtKwHyAHmd019U9p6G6HiL
 5bXqF+SD98dDBF765NaVfAsPAldk3dsARCfFpbeQsE2l/NM3oByUYYoHJvg+RNm5
 RaF7xPrRAhvoLwnDaB/8jWMWQp4XA/uLjfK797EzDE4ObqF1pI6RKQ/SnBbumNhG
 FqS1xpHQIfOgobBH/HXNImaEnJ1BA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqbuuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:10:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OBkD1F005964
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:10:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yj9md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:10:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OEAH9J47448502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:10:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AD82004B;
 Tue, 24 Mar 2026 14:10:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EC3720043;
 Tue, 24 Mar 2026 14:10:16 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 14:10:16 +0000 (GMT)
To: ltp@lists.linux.it
Date: Tue, 24 Mar 2026 14:33:32 +0000
Message-Id: <20260324143332.2200651-1-sowmya.indranna@ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nQY3ZL8CB0JlfNUyPewG0lgft--lyIM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwOSBTYWx0ZWRfXyhdynoP0I7ip
 XbESCFyn94LLPv0RsAJAluJQ3SiHeb3eUKZBDQ7QF7Wxiqu/C3hiWrTnWhwlVH61rjnIXa1mRZh
 UMykfuo+gCEitgxjapsP9Sn+xfWmD2eQmMq2PtwzYgs5/vif6X1byFuPU/aHfeGGtM5TyZJmT2P
 7syG4x0a3/2HolY2YojfwW1AHfHXxGBDC0OoIN+Z8IPMscBLpdCMdDOe22yFfrEZVPQprTlaXz3
 y5oyliJYF+aBvy+LXqwU2geeZUSRhtvALjc8v3AVERSBplQFEgPiDOGi5egN8nYy/qcyBsL/qYi
 okMJ35J0nVXxLeAHSFk3QHqhlcC7QLS9fj4Od481fUIdanmvDyfVer7HwA6L5Er0CF91yQdk6E2
 U7qD4KxBSx7TwNK3ndz16q41XokZZXi4tu58+xwxFdu0gHsM8Y+UZCpk0EAmgGjrXZitkHo2N91
 /3fpuCewvcmtC1xD63Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c29b4c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ySMgbXq8RC-PSD8eFMoA:9
X-Proofpoint-GUID: nQY3ZL8CB0JlfNUyPewG0lgft--lyIM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240109
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] vmcp: skip test on non-s390x architectures
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
From: "sowmya.indranna--- via ltp" <ltp@lists.linux.it>
Reply-To: sowmya.indranna@ibm.com
Cc: Sowmya Indranna <sowmya.indranna@ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sowmya Indranna <sowmya.indranna@ibm.com>

The vmcp test is specific to s390x systems and is not supported on
other architectures such as ppc64le. Currently, the test fails on
unsupported platforms.

Add an architecture check to skip execution on non-s390x systems
by reporting TCONF, avoiding false test failures.

Signed-off-by: Sowmya Indranna <sowmya.indranna@ibm.com>
---
 testcases/commands/vmcp/vmcp_m.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
index 3924a6e11..e40dec4bd 100644
--- a/testcases/commands/vmcp/vmcp_m.sh
+++ b/testcases/commands/vmcp/vmcp_m.sh
@@ -15,6 +15,15 @@ TST_CNT=2
 TST_TESTFUNC=vmcp_main
 TST_NEEDS_CMDS="vmcp"
 
+# Check if running on s390x architecture
+check_arch()
+{
+	local arch=$(uname -m)
+	if [ "$arch" != "s390x" ]; then
+		tst_brk TCONF "vmcp test requires s390x architecture, current: $arch"
+	fi
+}
+
 vmcp_run()
 {
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
