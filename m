Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8A8CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:38:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A46B63E6173
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 20:38:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D10E33E1FBC
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:59 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B3251A00276
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:58 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646HUXA42492757
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cMCrNO12FhMkzdL8/
 mQs1mpUgLOAmLRRXT79V6yWyiM=; b=UZqPFyGyK6LhLsQaWL4zn+YK2+t+C4tfW
 O4Jdqc95nBIiJtTx6AsI/aRKHK8sW9/cJbAr/2Byb5vlXj4STJzfTqu1PFI40xWG
 pQU714BMfSd3I8nvq2VhcIkwvIK9VonYN2jJ4sYYNuKGWWzkcICmiTHT4rlijWdS
 uKzGfepe3fzdjAYb9oqK+gHXRGbqhjVtMCulJCW4HJU9+ZgN9vXVTIRgK4pY2c4E
 FS4xX/YSCKFVHXLAIP0rtnuRjzvC6gComgPH4y9zUEqLHDqmxtOW8c8Yh/sJLhPX
 G52UfPIpPrIG5bBSbMheGcuOuQba7WGZc9zA4cHTYjs33Vo13rkTg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6hh28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646IOW5o027373
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqfrd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646IbsVE52035982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9984B20043
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1494920040
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.100.23])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:53 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 00:07:50 +0530
Message-Id: <20260506183750.97191-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260506183750.97191-1-sachinp@linux.ibm.com>
References: <20260506183750.97191-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb8a85 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0lvGaKBS8MktGGdRkRQA:9
X-Proofpoint-ORIG-GUID: 07jsJMFF6JMqdozY7UeFXZfKZMMFzuYg
X-Proofpoint-GUID: 07jsJMFF6JMqdozY7UeFXZfKZMMFzuYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MiBTYWx0ZWRfX2hqhd7kBGhYx
 TCLBRiUagk6jteG123vvG8MFvqFqrpnraVf/QRLpXYwBMW3k2KJ1IIAoF/gbB9DZqMNff7mWiSE
 drw3wVCJ6DVdCnY2503mHYgLKqkqCdwA6vO1p2fGT2YBmwZNzX/+lswxxPzJA46tvw7wUGsJin6
 I6AlFznHls+Nnp+z9Js0hpd5xA8SvGULWeZUlmDWcZG/C5d8ybbXCCGjM/cFYsCUmT9XwLW40fA
 DCnqNxcd3sg0Iyc/9j6Pge28XbOMxQrZf3jtEcdKKs8g86HEZF8qKSCPgj+AtD6OQ/9rSkniF8i
 jWdqw+LcFkGw5nQUIwhzqSg8u56LKRira23VP1SFMcxCdMrGORZX0jgeKriMmW4l3SbFblfOZ1E
 ydjnGecRbMgP6XFxb9726MNhz/TEF54QlQRXwoxmomeVYEOtwsyVZEJmKGd+xjDossDw+HmiSCp
 e6g18QbBfLsZzIT2E1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060182
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] io_uring: remove unused
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
io_uring_init_iovec_buffers(). Since io_uring_init_buffer_pattern()
is not used by any existing test, remove it.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
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
