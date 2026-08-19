Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEE3C5DF88
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787155877; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=nw7emCrXD/ShsMur7lUzdZrGUWexNdXgHBZvwtog0IE=;
 b=e4iY2S0hEOOzgr+IBIvRX7zeIG19zK6KsbUAydQMoPgd2kqubRj0aPJDGpTaefaKeV4GY
 K2WCIOj78TZELLJc5eMjKYGdMd3KtkZpHIvhMnchUb3UhEoPxHtTqjROIsmn9rkdbAldJPR
 /F4Zc9QXHqHeW/LVfHXrbQrQ+/YR6fM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 092D03CD674
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:11:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 115A73C0031
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:10:57 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E45620092D
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:10:55 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JF1XrV3801360
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=COh8LBWnAJIZYal94Wp804JVvl6srEx+O6JGL4Veg
 Ys=; b=O2FXMw8Med4IpS3GVrJHwE4tPkfKfAK2Td386SU69ADZFC/9uRPcJJnap
 1/OD0H1dML3YGR6C2zTNi0rWSMreASTu8hCwN5FbiQWMduBRqXx0AP/tGMJuHD+t
 tkphpdGhQ8nkSvDxra2eSZ6u7Mw/DcauT2GbLkm0idwcWRNi69uBvdiVSQF1USLh
 4WSwQRU6Fuflsra1Ep/zeez/md58hdPFzckTwLUqxcvfqHBzNlrMqAGYgsfqXUYb
 rsoqICdBRlRA7BLNg9amvB3jUQOcQA1kZjaXrX+GpfMuUI2QETK7Rkn0Kd+yH2x0
 5KeLEadFvR3mifSD5wnSPN5XNYQ6A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0cva9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:10:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JFuJCa024956
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:10:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yhhdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:10:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JGApZB47579414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 16:10:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 419A02004B;
 Wed, 19 Aug 2026 16:10:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62A3C20043;
 Wed, 19 Aug 2026 16:10:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.249.249])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 16:10:48 +0000 (GMT)
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 21:40:32 +0530
Message-ID: <20260819161032.1883-1-sowmya.indranna@ibm.com>
X-Mailer: git-send-email 2.48.1.windows.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a85d58e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=kpXN9IyGNGJCk1MaLTEA:9
X-Proofpoint-ORIG-GUID: HrDPuoH8eqMnDjCMJtWE8hwGjMHwvTR-
X-Proofpoint-GUID: HrDPuoH8eqMnDjCMJtWE8hwGjMHwvTR-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyNSBTYWx0ZWRfX83SUI5pwEyhN
 DmxxuxyIxDW3Tkz1DCJGxyNlkhUgRyv4/xzsT+t3ytAm8ErptlP9+nImPJk//ESEkRFwix2XlHx
 OXcgHHH1HOigIZHCXElXy2o/elNMj6g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyNSBTYWx0ZWRfX57wRu3ZY4pkp
 cjuJAlsapibEv+KwEja7YmKECV+O7UBP3wIjzQyW5zJI3t+y5izMQPneJdtfO+6LjygRqPjZQQf
 S1CXVNfh7bV+LaXhGBhTLRBwPbPzwkAkpHmLIwzcJeT0yWCDkTJXrxiIskB2hV7EldZ7lAnfBQx
 Z/wVRvP+uAgihe24DkiOGR9Ux+hgBuU3/eh/3HEZ5LKC6jFo3JC6XXGEaaP8Cymns/UaQriM8nn
 3JrjlwutVvpYWtGxSduQ+9Oxtox5sTkWpMYDunBpVbX7sRG8jqotZrkSneClrH0PQv8FRkm23As
 fDeRTJF9Vmd+BD8NKWz5xWAnomOFn3m02UHocj09Bxe0lQADdekaKT3UB/XAcXCkxYcFxQV5yNu
 FJ/XRwM42igfUypEWigMkBOdxqyRxk33BBofruBlzOkaBStj5uDACdgi2ioUlVsvcWACtop0QKH
 odcx1LxRCZlPLpUwvcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190125
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fs: Add fsplough entries to runtest
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
From: Sowmya Indranna via ltp <ltp@lists.linux.it>
Reply-To: sowmya.indranna@ibm.com
Cc: Sowmya Indranna <sowmya.indranna@ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sowmya Indranna <sowmya.indranna@ibm.com>

The fsplough tests are present in the source tree but are not referenced in runtest/fs. As a result, kirk is unable to select or execute these tests and reports:

Error: No tests selected

Add the missing fsplough entries to runtest/fs so that the tests are included in the standard LTP test selection and execution workflow.

Signed-off-by: Sowmya Indranna <sowmya.indranna@ibm.com>
---
 runtest/fs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/fs b/runtest/fs
index e45fba14b..36868f638 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -82,6 +82,8 @@ isofs isofs.sh
 
 fs_fill fs_fill
 
+fsplough fsplough
+
 binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
 
-- 
2.48.1.windows.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
