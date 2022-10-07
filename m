Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D34C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:25:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384373CAE8E
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:25:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11BEF3C3030
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 12:57:40 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6000F1A01939
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 12:57:38 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2979ktTH019481
 for <ltp@lists.linux.it>; Fri, 7 Oct 2022 10:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jkpniCGsbK7xFy0d9pMDeRUZFAZN5CvTcO1B9YzC0Ik=;
 b=ppTkL1d88sHj9ZmcU34Sc83fPOPVH5h3bGAw9LrxlHjuIyvidFZNHV08QNRHfqsAt3dV
 y1M/aLScWmZg+c4M/jvdKvHBzQRXTVOfJMje9M9orMl2U4+9wqb2AMQwPNz3+kwb4dKX
 1y8gWl313Q1thSKAbR60JXi2nnveLhG8diMsQUu+5Y3bZsgnKb2WiPJq52rrLsixCHIc
 1FF0PByLrPwuUuByXRv0aKbsFJFM5h1QTb35CZjuu40m8uIgz9Si/P2elnupJCm5JYSQ
 eRoQENUX1cB1prznUxPOMbM+hIzEBIRpWLT4qZrLvFO7y3Ol2aUz/fxsbjRgOowEroxt yw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2hsja1hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Oct 2022 10:57:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 297AocUZ031614
 for <ltp@lists.linux.it>; Fri, 7 Oct 2022 10:57:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3jxd698g9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Oct 2022 10:57:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 297AvWRK8651422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 7 Oct 2022 10:57:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C77D2AE04D
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 10:57:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6203AE045
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 10:57:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 10:57:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
 id 51D02E0256; Fri,  7 Oct 2022 12:57:32 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  7 Oct 2022 12:57:27 +0200
Message-Id: <20221007105727.2303349-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8cL2mFK46KBxA_6j5IX5FtVREbBOVd4r
X-Proofpoint-GUID: 8cL2mFK46KBxA_6j5IX5FtVREbBOVd4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210070064
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 10 Oct 2022 14:25:33 +0200
Subject: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER flag
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

since linux kernel commit 195624d9c26b
("tun: support not enabling carrier in TUNSETIFF") IFF_NO_CARRIER
is a valid flag. Therefore add it to the list.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index 3d4ac3e24..5a7a0a6a2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -40,6 +40,10 @@
 #define IFF_NAPI_FRAGS	0x0020
 #endif
 
+#ifndef IFF_NO_CARRIER
+#define IFF_NO_CARRIER	0x0040
+#endif
+
 static struct {
 	unsigned int flag;
 	const char *name;
@@ -51,7 +55,8 @@ static struct {
 	{IFF_VNET_HDR, "VNET_HDR"},
 	{IFF_MULTI_QUEUE, "MULTI_QUEUE"},
 	{IFF_NAPI, "IFF_NAPI"},
-	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
+	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"},
+	{IFF_NO_CARRIER, "IFF_NO_CARRIER"}
 };
 
 static void verify_features(void)
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
