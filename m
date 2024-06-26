Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17027C2BBCA
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719363962; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5Q5xfZ7fP7Xz9UEgnhPVRKtKGjluH+H1MIweo+l2GEM=;
 b=bF/6Hqx6eUftqYvGARaCSGAWz29Bgw93mYbQNQsZBTNCx5hZG4m79YktRK368Ya4AGRtt
 fmDDvfHTh1GpUwTnf2fkBcmBeG0hpaDOb0eVGdflBBI/IWuHFct1HCYnf5FAzZZ06Dixi10
 XKr6tg5a662YoO59pWnRmo7S67zmPII=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59B9A3D1157
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 03:06:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E88783CE7BC
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 03:05:39 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0034600468
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 03:05:36 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBTZF006916
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=YrIZ/dXI08ia0W
 Un3tQ6KqMsZzf6fbqv1EmYW4dlPJ8=; b=hw4qB0I3Xj39Q6FgIF/Qxv3h0xu1O2
 t/SCJavK8nJNg1AMierue5E5Djum76VRurFCB1JZj/CqHqKwNyLX7+zehT684v3U
 2Wvd54W3pi5QyvJOk1ZlLNmwYSGOTR7MQF0p6T56eWSaIW8TtgcRQ2jbPWf4aZTV
 O79dipEaLamSl79hqvgwrKBPm2pTDKQ20sD4ZstrVYXfuu6gwXoOfsF9/2s98o0B
 GeVVSODy2oYGO6EVi7UDvBmzMBzv6FyWZrdolwIfPrJTsw7OfwA6Ffe2JhT2snvX
 tQuSixx69r6/aO83ocUzYTiYHUZTQ6/FeYqEFEMGLtNitA5NpBZnKrxg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70a1k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:05:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45PMPNtb017801
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:05:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn28a7c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:05:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45Q15X8j025094
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:05:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3ywn28a7c3-1; Wed, 26 Jun 2024 01:05:33 +0000
To: ltp@lists.linux.it
Date: Tue, 25 Jun 2024 18:05:32 -0700
Message-ID: <20240626010532.2845919-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_19,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260007
X-Proofpoint-ORIG-GUID: g2n5gkpeyfyAgb2mh8SibJl0jms8gmHA
X-Proofpoint-GUID: g2n5gkpeyfyAgb2mh8SibJl0jms8gmHA
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fallocate03: FALLOC_FL_PUNCH_HOLE must be used with
 FALLOC_FL_KEEP_SIZE
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
From: Samasth Norway Ananda via ltp <ltp@lists.linux.it>
Reply-To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The fallocate03 ltp test fails with "failed: EOPNOTSUPP" if we just use
FALLOC_FL_KEEP_SIZE for the mode instead of ORing it with
FALLOC_FL_PUNCH_HOLE.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 testcases/kernel/syscalls/fallocate/fallocate03.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index b3e6b3817..20ce13cd4 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -30,10 +30,10 @@ static struct test_case {
 	{DEFAULT_MODE, BLOCKS_WRITTEN},
 	{DEFAULT_MODE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS / 2 - 1},
 	{DEFAULT_MODE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS + 1},
-	{FALLOC_FL_KEEP_SIZE, 2},
-	{FALLOC_FL_KEEP_SIZE, BLOCKS_WRITTEN},
-	{FALLOC_FL_KEEP_SIZE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS / 2 + 1},
-	{FALLOC_FL_KEEP_SIZE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS + 2}
+	{FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 2},
+	{FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, BLOCKS_WRITTEN},
+	{FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS / 2 + 1},
+	{FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS + 2}
 };
 
 static int block_size;
@@ -82,7 +82,7 @@ static void verify_fallocate(unsigned int nr)
 	TST_EXP_PASS(
 		fallocate(fd, tc->mode, tc->offset * block_size, block_size),
 		"fallocate(fd, %s, %ld, %d)",
-		tc->mode ? "FALLOC_FL_KEEP_SIZE" : "DEFAULT_MODE",
+		tc->mode ? "FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE" : "DEFAULT_MODE",
 		tc->offset * block_size, block_size);
 }
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
