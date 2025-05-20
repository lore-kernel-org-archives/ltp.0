Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C18C3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 15:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E5D23CC6F9
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:26:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D721A3C9FDE
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:26:04 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FFC36011BA
 for <ltp@lists.linux.it>; Tue, 20 May 2025 17:26:02 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7Kvbm014296
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gZgh1aS6zvA6Hnp3D19IngeUNPfQ1qNc8fMLgf/tu
 +Y=; b=rT3htiSo4ijbLOJMMbgmmiqvB9YuNnDzdlnFUXWc7vHcQn78fmJ0DzVaS
 zQOAG3YMOfgmtbuth94s2fmGuLQfqKnQYNtD7lgcACbfjla/0cugFr21c9LUaLzw
 AZwHtrPxJZLZUBU3M2HAN9VUer/LvvRFe0dOxwcVlbTzV0fddVUrhzknPnGrQaXF
 UxoNxmHIWNmPXsybtt6USzvHQtNygPYfkvR6xqJZMvx8iHu6f7urpw9PPU2dGZAE
 Pig7sK/AZErZYeNAt3cXe/1MoNL+szOtVoCd7VO8Ra0ZUGzCamfYqYmMvMXAKWNr
 XrtrwPsobvtRRzmumQalrtqTzMftA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ra99n5bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:26:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDGX6K013863
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:25:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4stcttk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:25:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54KFPtdB48955656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 15:25:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E208C2004B;
 Tue, 20 May 2025 15:25:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1B4920040;
 Tue, 20 May 2025 15:25:55 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 May 2025 15:25:55 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 May 2025 17:25:51 +0200
Message-ID: <20250520152551.390069-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J/mq7BnS c=1 sm=1 tr=0 ts=682c9f08 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=9x3qNozUb_5_nAeUTvYA:9
 a=Ww0i4ybIxbYA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMyBTYWx0ZWRfXxCRKYR7K+s+r
 SJc0kQUtDF/0NOHBCDhj8mROimb+e8nlrIFA0426vsqL9V+umonDj+zMfgOW35m8f8OoOMvvFyl
 WovMz8HsdRHKf+Qm0ojk/9EsJltrqnSGoeMnBCA6O90Kr4O6wIGY3aRD60CgASQtSHch+0HSNRZ
 JCOSzWaraa9ZPauaWJ0PYXkboo512e3rFBAc5iFZVbnaOe6RteimnOieKVAAEzbY4nHO8PipxS9
 l/aVVWM9y1fK6jKXigPLbbN2FFi9HlmscVCl/Y+wa+VOPaUhVnWzM8XQDPR9/U7Mm2sgDxyXe5u
 HHjlT4Yr9aq2nV9eQReHjwpySCXer6MNJfH3Ejl72q8mgqqaLJOmCfs3Au+059iQI6RZgfskWxj
 sZw8NFbg/z2NFln7cxK+xAI0pI6+TNJsqOT9LkBbxmvI8FqsuQDRRthIa7uMG0OlH0juyUDz
X-Proofpoint-ORIG-GUID: vuUnBkRYpFAHnyHKuG6RpBLeHKD_5Vph
X-Proofpoint-GUID: vuUnBkRYpFAHnyHKuG6RpBLeHKD_5Vph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200123
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v1 1/1] overcommit_memory: Disable optimization
 for malloc to prevent false positives
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

When compiling with GCC 15.1.1+, the default-enabled -fmalloc-dce=2 and
-fallocation-dce under -O2 can eliminate the entire malloc block because its
result is only compared to NULL and/or passed to free().

This leads to false positives in tests that expect malloc() to fail under memory
pressure, as the allocation is optimized away.

Disable this optimization for the affected function to preserve the intended
test behavior.

References: https://gcc.gnu.org/onlinedocs/gcc-15.1.0/gcc/Optimize-Options.html
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/mem/tunable/overcommit_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index b5beebbcd3c4..fb42dbb75a00 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -151,6 +151,7 @@ static void overcommit_memory_test(void)

 }

+__attribute__((optimize("O0")))
 static int heavy_malloc(long size)
 {
 	char *p;
--
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
