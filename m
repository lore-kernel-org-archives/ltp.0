Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF967F8A16D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B6623E2DED
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:42:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D8F83C1E06
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:41:52 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 92B9D1400998
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:41:50 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8DJDY1834976; Thu, 16 Apr 2026 12:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=jakdZ2s6iRIP6mMD9FEugAfmL9VBz9+8+i8Ad6LrO
 vw=; b=HFKC8NINfahBxEou7LrWKgYnR8M5nM3lUW1Q7GWu6Y9CwNVL1ARIt27XA
 70L2Litb446sNQFEEOT8mDW8UY/UtR9FaesxGmp5ZEHAX8NZQwnUXW/yOJ0leQYt
 KAuTpJaxIr8Enh4EvQtKfgNEhlm0NWSkx/drSZqeSYjIEGZ1I5VwPW+o3zOuUb+G
 esyRjgqlNFwx1EQhiUALg7VmAcnbpoDbtgw0pEsIzsJ6PQjKDzracAFVpi92dbxI
 MIeqtgA/S7tBYwchxmAY2elzKQyYqvO5Xgwp/nBqmGkmQ8+HTbbXtQeWV4u7idzr
 RRU8EixgtiAeTUTlZVSTQV8J+ea+g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rnd6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:41:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G83E96003379;
 Thu, 16 Apr 2026 12:41:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh94exd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:41:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCfkhi57934210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 12:41:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 415AE20049;
 Thu, 16 Apr 2026 12:41:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 687E520040;
 Thu, 16 Apr 2026 12:41:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.36.193])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 12:41:45 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 18:11:44 +0530
Message-Id: <20260416124144.19343-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExNyBTYWx0ZWRfXwr/MLvmXpefT
 o6kWviK8OI9FKHJDKfYNJj7JHLIVZCqJOxetfcAnBi9XCnt6U47wc4qxxcEzUQCU/k1zKUZBXi/
 vdqs9estoTRMQ9qnjeVXwSzZM0FyFvcidpUSWI4NHaRshO0ccvMFs9mWPvBgSnGp3zvQPlsL8Or
 qjcAg9+z4FrU7TNTuLHfwu8i8x3ayCQ5Jx2QWYZ9wZqdATtbkL8JPFfozL7i732LoSsJDhiGOk4
 YBB5sBbaUfh6RcY7jemZ6ygL3WPlNZSYmOnt3JhE1gZtq0z5zojgKVck2jZaR5ul56ywCRxQVBi
 fkvjyBrLMghxzazjIGHchL2dskty6LBXrV8+hMCMtb3BdM5kh1TYS8WXuCBLyA/ZT3qKIw+rKvP
 1cQk0ST+nGw+EU35pRlXEUh5yHrkqwTP2hlvk7559/K1xazGUIoItm6h69NbgSrsudsFHFSLV4U
 hBObmq7lHa1Yc/vVuhg==
X-Proofpoint-ORIG-GUID: z7qhPVEHCCluiCx6wpLS0TjePFhjpfZS
X-Proofpoint-GUID: z7qhPVEHCCluiCx6wpLS0TjePFhjpfZS
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e0d90c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=mzktdtn0ohvn0wdvKOkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160117
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/io_uring: Add fallback definitions for
 OP_READ(WRITE)
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

Add fallback definitions for IORING_OP_READ and IORING_OP_WRITE
opcodes to support building on older distributions with kernel
headers between v5.1 and v5.5.

These opcodes were introduced in kernel v5.6, but some distros
may have io_uring support from v5.1+ without these newer
operation codes.

Fixes: fcc4887e73ca (io_uring: Test IORING READ and WRITE operations)
Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 include/lapi/io_uring.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index c05517595..d95a4cd59 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -267,6 +267,16 @@ struct io_uring_probe {
 #define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
 #endif /* IOSQE_ASYNC */
 
+#ifndef IORING_OP_READ
+/* Added in kernel v5.6 */
+#define IORING_OP_READ		22
+#endif /* IORING_OP_READ */
+
+#ifndef IORING_OP_WRITE
+/* Added in kernel v5.6 */
+#define IORING_OP_WRITE		23
+#endif /* IORING_OP_WRITE */
+
 #ifndef HAVE_IO_URING_REGISTER
 static inline int io_uring_register(int fd, unsigned int opcode, void *arg,
 	unsigned int nr_args)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
