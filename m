Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FC7C54ED0
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 15:21:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1E83CC88C
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 17:21:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6553C9A6D
 for <ltp@lists.linux.it>; Thu, 22 May 2025 17:21:30 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFED56008FD
 for <ltp@lists.linux.it>; Thu, 22 May 2025 17:21:29 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDnRe4011149;
 Thu, 22 May 2025 15:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FA+8Sp+U9CNX27S/5NyOtU6gMiJhwzQEvLIStiyk0
 d4=; b=Kzwh4T+e9FBHc79AxhDwKehscw4FWC/ygE0OR0TEH8Nd5ivLC3110Rfo5
 qkhPSuRfyDzA42FTdD0QLDI4MdntMCr6nJ4c+1aFco7a+jQ3CX90lOW7s6uHzr9F
 63ZYeolNhI5/MHNtHDQsw0XVzGmVxs7dLUlpb+NXD3dVg64biEpaNoD8WuR4PTV+
 x4ouKiOqZKWhZmekdZHvYOPwCxXz2HxW+/2IFLb0L2bKK0oiuz90dJZuBBlMohI5
 RD/Wtyrb9sMAXUJZchAkFX/MjP+rvbHoy9Y7/BtQQtVjbcv7/VeZxwscjbqDpMGp
 62dl1uxtOA1Yz2gqx+QBv5ySMvjTA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t5530ewy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 15:21:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDxuPC032070;
 Thu, 22 May 2025 15:21:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmj07d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 15:21:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MFLNwA53412190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 15:21:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E752520043;
 Thu, 22 May 2025 15:21:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A079920040;
 Thu, 22 May 2025 15:21:22 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.61.232]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 15:21:22 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 22 May 2025 17:21:18 +0200
Message-ID: <20250522152118.35942-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ttHQtFBQ9Q9YvFlSPl8lGXGeYxCLTWFC
X-Proofpoint-ORIG-GUID: ttHQtFBQ9Q9YvFlSPl8lGXGeYxCLTWFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1NCBTYWx0ZWRfX53FjXK5jj+5v
 vXv4kwzNOeSXULCbqSVd/mxdGgecf0sUUS8CMzzQn+fESaq08nV1+Rfw63oV7MQKLEnwcjbwwjm
 nk7PIwA2wGT6gEDlwwbWdNKyo3MtRS8w7TuwRc2XsylaxOR2ytnJVnBqNGFRSYqta38UrO3Qw4k
 pUmtlNdT3QrvWQlNYiEmOUOrDE+Md3HZo33lgZIZ7QCtzzIm/TDrIQ37F+llgBchHVduNHOaQyv
 gg6SB4aN13RFaxtusmuGb1+fhsdULG/YHTYSoRrc1FwbWocWplfBrlkdwouD67NyL32wbCVIBBg
 MzPb8kY4RvUVX9g71GhogH7f5Z2rD0E9qq54Bzn4P3gTbRZijGWFovksC79TVmKiZFFuyuWvEFi
 tK9vKiIVwyAz7VuUP4IDgIhmxvLKHB3e877WvfbAFgKwfQ2sBnEPceEZjDkaRZpbOywdF2ZW
X-Authority-Analysis: v=2.4 cv=BOmzrEQG c=1 sm=1 tr=0 ts=682f40f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=9x3qNozUb_5_nAeUTvYA:9
 a=Ww0i4ybIxbYA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220154
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] overcommit_memory: Disable optimization for
 malloc to prevent false positives
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
Changes since v1 (thanks to Cyril Hrubis):
- Use LTP_VAR_USED macro to prevent GCC from optimizing away malloc().

 testcases/kernel/mem/tunable/overcommit_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index b5beebbcd3c4..9b2cb479d5ee 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -62,6 +62,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
+#include "tst_common.h"
 #include "tst_test.h"

 #define DEFAULT_OVER_RATIO	50L
@@ -155,7 +156,7 @@ static int heavy_malloc(long size)
 {
 	char *p;

-	p = malloc(size * TST_KB);
+	LTP_VAR_USED(p) = malloc(size * TST_KB);
 	if (p != NULL) {
 		tst_res(TINFO, "malloc %ld kB successfully", size);
 		free(p);
--
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
