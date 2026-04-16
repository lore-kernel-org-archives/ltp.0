Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25EDF8A16B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:17:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7712F3E2638
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:17:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66AF63C1E06
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:16:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DFD5600AD1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:16:44 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G2FAvg1733164
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q79PLk1p6Fgo9Y3kg
 r/PprPKpokyLPVZkjq9cRj72hA=; b=Rt9O1t8KrlMirCCfZApgmA4+U3yIMwVyX
 1KAIOqYl1DM1n0/9XSsQbvqRbpU2ah8QXkCBy2myms3CV9PhWVVQwGitmU+0beql
 0tH5xd9Cd9rAokW4UhqyEM+diPqFrqLYHW15T+1FxQZ2D3L8cq/d8gEylnbICd3F
 Wk1Mb9U86hBSLGYBKRpri3gPmhAOlslor5xuZznWUmdSa31BW1o/Xp998VHcCs+o
 4PS5tpRdcYXHkFjCQvcx07fAXNy7P9TRJXwww18F2qRwd1NlIhorJm+Z4EZuMKm2
 9ogm8q0YckwGXK9hR6l//KAQoSlCYPPROvio4a+66h1yn2zVmMDWA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mcd1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCEL3M004175
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kjpsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCGeTh37028336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2D8820049
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11CC320040
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.36.193])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:39 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 17:46:38 +0530
Message-Id: <20260416121638.11858-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260416121638.11858-1-sachinp@linux.ibm.com>
References: <20260416121638.11858-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69e0d32b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0lvGaKBS8MktGGdRkRQA:9
X-Proofpoint-GUID: m7UVUy4LMC8LW1kHWaZemujYx6Fc4tkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMiBTYWx0ZWRfXwn/Ng6uzqv/X
 5pumypmuF7Ila0aGAmQtjIZ1Y/85ypUx7HIuSylG1XQQkPk/vteRYx5c9vArqWj+PXV2QUMm6Tj
 meKngHAL9VFHWT4u9GRuzl7dtFcJhFnFbGJXVat+GUQOZLc+SeBJbGKcykc5tcBFoIYOnYeS7lX
 5hMCRbvuiWNQ3c8VhANDHYviHlKXjLTU11GxMyDWSNu9ZJOnfAl6hIe/xzqfmFgF/grTLyViB1S
 GevjF+3drQWmsyYCX9QOnkHrqsQN28umehhPQjQvFlXCFYP1tCBDxbBbZS9Axh1ReRnM6KAwFLI
 PfUe9gx6hely7lkdy4RVGjrQszowmID5XzKhmqRktmsUva6EHOBF+RrXrnY6kN64p0xvVB1oImx
 qFD8a+ONkjwElctJGYfE2b+0jbUIhIeP5kYxr2WcRbj68AefCd0DwkIAKlDqhrDzNXHJMc+dT51
 AzvXGxgsrHHpFxzRMQw==
X-Proofpoint-ORIG-GUID: m7UVUy4LMC8LW1kHWaZemujYx6Fc4tkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160112
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] io_uring: remove unused
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
init_iovec_buffers(). Since io_uring_init_buffer_pattern()
was not used by any existing test, remove it.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 .../kernel/syscalls/io_uring/io_uring_common.h      | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index aa31339fb..7816b55dc 100644
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
