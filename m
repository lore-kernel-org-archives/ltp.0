Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ECDCD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 770BB3E2C2F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:35:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 277EB3E2875
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:27 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9841B10000FB
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:26 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64717Jtk2607845
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=d8Sk34RDXb8oi1mod
 EL4LkKMc92icjUNQS4G0IJ01g8=; b=if7KZbWf76TTWFajA2ZgLLdyBz9yAJuez
 yRx8FGnCOsuy4UsYiVQlHFmHDSMf3TpqjA2pFboaCcW/9ysv37Efr+KCkBrfRODO
 LUp1MemzP8BmpVmkwyWBZOjnQ5T8b+d/Rzyp7oJRqkj2maOmerzMlHN+fvfeLufo
 tYMcdu8aFKIXdWst3v6SiUJeajG2DOQV65zboNPc/9n/8BmbnwYhuFoAbhQ1Ou82
 cBYr7jxjj2DNpZHE8o39JLGO43V3uNih5kRtVl3GvsZZx6HBn6MkqiRpkfEHhOmA
 vFLkrYhFEbWQnD6JKOi8uO9VQ3rc4nJGwoMACILU3yrQuZEGJyUrQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1ms7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:34:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6477OZCx025183
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqj6e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:34:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6477YMLJ44892474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A3162005A
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C37120040
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.69.33])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:21 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 13:04:17 +0530
Message-Id: <20260507073417.64123-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260507073417.64123-1-sachinp@linux.ibm.com>
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F7yomT7krsXDFL229IQtwY9UFh9Y4ZCd
X-Proofpoint-GUID: F7yomT7krsXDFL229IQtwY9UFh9Y4ZCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2OCBTYWx0ZWRfX3Fw9Rk4eP4ZK
 qAO7XbhrnvbDUbbCqjncOvagPdkJyfMC+K4MWtUyIQUpRhK1gNfJTy3K+6U4F2Gk+mKlA40DSQE
 Le214rE6DPOn2NKBEt5ycrxktCMeh7wI7IqfwJivJug2G+WsoAgU+0FpDHltOx+o7hhbTcyx3D/
 85A+2VzvnpbFdkytp3JyZobci/bq/ZODXJIm3fNeIIlPqB12pFCCHRkRkIUUrAiRLNlD3/fhSBr
 Ri3i3yReRA7kScj7Yh3EeKJhaqdTUcajUhdK+6bKbrUjabelHmf+16Eh3kaS/xZKJe1K2HqvP0m
 xL5kbB4yyow3mfPzqUTzeE/oUiBguRXUgivYbLY+g7rD0CHZziY3C6MSNotsWMjKem01/taAEWH
 NdndM9/dWLRZF9SPhcGbXc9g8O3QQDMihyTeO8odIi9MiH1L4KvP/+ouvrODCIuvKl5ve09zCxh
 2JNH7HES9pxRehrddTw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc4080 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NEsGHrCfXOzn3OoTPZoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070068
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] io_uring: remove unused
 io_uring_init_buffer_pattern()
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

The io_uring04 test merged the functionality of
io_uring_init_buffer_pattern() into the unified function
io_uring_init_iovec_pattern(). Since io_uring_init_buffer_pattern()
is not used by any existing test, remove it.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V2 changes:
- Update commit message to reflect correct function name
- Link to v1 https://lore.kernel.org/ltp/20260506183750.97191-1-sachinp@linux.ibm.com/T/#t
---
 .../kernel/syscalls/io_uring/io_uring_common.h      | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index 523f686f8..84f93c7b1 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -230,19 +230,6 @@ static inline void io_uring_wait_cqe(struct io_uring_submit *s,
 	*cring->head = head + 1;
 }
 
-/*
- * Initialize buffer with a repeating character pattern
- * Useful for creating test data with predictable patterns
- */
-static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
-						char pattern)
-{
-	size_t i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = pattern;
-}
-
 /*
  * Submit and wait for a non-vectored I/O operation
  * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
