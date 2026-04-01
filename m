Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B01076371
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 05:44:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA4E83E2A26
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 07:44:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B53163E1515
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 07:44:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB5FC600A6D
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 07:44:02 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VJX1YY108580; Wed, 1 Apr 2026 05:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iZw71CshpYUv1MlXqJDhJiIBs/EnrEfjZSz2wMx9B
 JI=; b=jkDqURZ6WfXjWnXIU0dZAhZHtzH+cMgUNwALvBUYu+c/Eu2aUGdaitOmj
 xrzZAAHGnATBKmGXdgNLCMYfhDt5HUHNLasBfbOCf95jQtHatsDr3KfS6PR4yer2
 Smc3p2WWsPdL961HX4JR6WEEa26GK8FJen89OS4Be0o6FlGDYk27GCKS04ScKyfl
 OkKXWbijvy7+TOW01hipFj5SnUbqDXkHtx8ehUQiyW28jOIgMPzsn2+RXAR1hshA
 CSwEXPDkdx3iDqhCJqGXEeaxvuSeDbUT3sJ3nUqwNM0TAefwjyP387WodX/Q5YJr
 0KwlCAIlICpUHpADPqR2fPabNtXKA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dce2aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 05:44:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6311kr4p013898;
 Wed, 1 Apr 2026 05:44:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkm627-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2026 05:44:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6315huEU49152344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2026 05:43:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23AFF20049;
 Wed,  1 Apr 2026 05:43:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 530C420040;
 Wed,  1 Apr 2026 05:43:55 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2026 05:43:55 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  1 Apr 2026 11:11:46 +0530
Message-ID: <20260401054146.99060-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ccb0a1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=6uQK6bpgce_nHWxh8o0A:9
X-Proofpoint-GUID: P0ezKXPNLinczgx_qN4tAzWT-7oT7kv6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA0MyBTYWx0ZWRfX1iLh/L4CqGEm
 4qW33FXWLd6LlwfrBdJlMzxpxn3ghnlFna1+eHcZtYA9gAhhNUkj1T0oVN8TE0PtaaKI8PXsLxg
 T/zvwQz/rVPsf/7CTPq/7j2K8kvcGgbM1goSyyJza4CPR9mSOj1OwcP84/bWu18e+sIJVkRPW9B
 7mGvpkj166wW+iaSUny9Rr9NhkWnhkobDdRCqakhR631V+ojfrx2s4Dv/pGouWBG9xJEnb+5eIf
 cKQR2lGFM2RSF8zuCmYhI5CG2xAn3aaTOwf7p66Bsnsbk9Hnus26//7rtWtRznP7iHJIbSDe+hy
 oXRau9sgKFtNjFWNPbWMCKC77LStyR6VFZOhfDIIP82sIE6ZCNHcG/orHtvW4AUh2ZIYvW4e8JT
 9tbOJw2GeTDRw5BiSL+tkcDzP7HTE1QG8NWMYc/FN7VbjODXuIYE0KLK6kFNTsWtEbyAp6U+jBR
 0P+LaLn7PDScFub/Tiw==
X-Proofpoint-ORIG-GUID: P0ezKXPNLinczgx_qN4tAzWT-7oT7kv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010043
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise09: Make memory map output conditional and
 more informative
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
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The memory map was being printed unconditionally for every test run,
creating verbose output even for successful tests. This change makes
the output conditional and adds useful context.

Changes:
- Only display memory map when there are issues (corrupted pages or
  no pages freed), eliminating verbose output for successful runs
- Add legend to memory map output explaining symbols:
  p=present, _=freed, ?=corrupted
- Enhance TPASS message to show freed page count (e.g., "126/128 freed")
- Improve TFAIL message to show count of corrupted pages

Before:
  TINFO: Memory map: p_________p_____________________...
  TPASS: Pages MADV_FREE were freed on low memory

After (successful run):
  TPASS: Pages MADV_FREE were freed on low memory (126/128 freed)

After (failure with issues):
  TINFO: Memory map: p_________p??___ (p=present, _=freed, ?=corrupted)
  TFAIL: Found 2 corrupted page(s)

This improves test output readability while preserving debugging
information when needed.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 1fad983fd..87fe096fb 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -219,15 +219,17 @@ static void child(void)
 	}
 	map[PAGES] = '\0';
 
-	tst_res(TINFO, "Memory map: %s", map);
+	/* Only show memory map if there are issues or for debugging */
+	if (corrupted || freed == 0)
+		tst_res(TINFO, "Memory map: %s (p=present, _=freed, ?=corrupted)", map);
 
 	if (freed)
-		tst_res(TPASS, "Pages MADV_FREE were freed on low memory");
+		tst_res(TPASS, "Pages MADV_FREE were freed on low memory (%u/%u freed)", freed, PAGES);
 	else
 		tst_res(TFAIL, "No MADV_FREE page was freed on low memory");
 
 	if (corrupted)
-		tst_res(TFAIL, "Found corrupted page");
+		tst_res(TFAIL, "Found %u corrupted page(s)", corrupted);
 	else
 		tst_res(TPASS, "All pages have expected content");
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
