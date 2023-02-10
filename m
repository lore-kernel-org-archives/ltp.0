Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B3C05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 22:34:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21F823CC08F
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 23:34:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B712A3C03EB
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 23:33:57 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BAAE52005E6
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 23:33:56 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31AMHaxF020862; Fri, 10 Feb 2023 22:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q/qqCnqKzsebN3QRvp52fvanOx52nquq0D+wsaw7c9k=;
 b=ZmPwB22Gkze5E/IN/kW7RDXsDnLKWH4psaN9/bRSTrng0Bzwgl7cAI/BDhCr1qMuHObY
 LRzUXllemSqs79EVQvR/CwrMm//n1IAbTj5jrs6ftcBLKr7QW6kY8x+4EpuaQeBwwznU
 ujn3zdOv9PWdwVd5gjO5GC3yLygU1POFQa6fxDxXgOjrg/9mLqwvUpf9T4SDbgq1eEuX
 4RD7RqOclMqwC2alKRoR5TlYxi/dtksZ5Xi8gSZG6kUZSw8fAt2gRG38aGJgeGEtyxsJ
 cf1QoI43y3hkUEXD5XtMp56FYP7HBC/1dzTy/TBjf5WVJpSuChs5lIKhb+Gz9nAS2lPt Ww== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnxkf08f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Feb 2023 22:33:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31AGGh6R004425;
 Fri, 10 Feb 2023 22:33:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06nqu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Feb 2023 22:33:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 31AMXoR245613468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Feb 2023 22:33:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73CBA2004B;
 Fri, 10 Feb 2023 22:33:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 933B520040;
 Fri, 10 Feb 2023 22:33:48 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.90.5])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Feb 2023 22:33:48 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 11 Feb 2023 04:03:42 +0530
Message-Id: <20230210223342.240969-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230125222703.19943-2-pvorel@suse.cz>
References: <20230125222703.19943-2-pvorel@suse.cz>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XeFEs3Za6tVefZoTWKayHzv6jCle8jmV
X-Proofpoint-ORIG-GUID: XeFEs3Za6tVefZoTWKayHzv6jCle8jmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=864 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100193
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugepage15: Resolve compile time warning generating
 with -O0
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

Instead of turning off the optimizaton with -O0 to resolve unwanted
behaviour of clang with goto statements, this will make use of clang
pragma to turn off the optimization for just clang compiler. This way,
gcc won't throw unwanted warning on turning off optimization:
"warning: _FORTIFY_SOURCE requires compiling with optimization (-O)".

Also, removed redundant header-includes.

Reported-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |  1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 12 ++++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6f10807cd..2d651b4aa 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -8,5 +8,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-hugemmap15: CFLAGS+=-O0
 hugemmap06: CFLAGS+=-pthread
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 4730d8d18..aae234135 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -18,17 +18,13 @@
  * remap, or because the icache happens to get flushed in the interim.
  */
 
+#if defined(__clang__)
+	#pragma clang optimize off
+#endif
+
 #define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
 #include <setjmp.h>
-#include <unistd.h>
 #include <signal.h>
-#include <sys/mman.h>
-#include <ucontext.h>
-#include <limits.h>
-#include <sys/param.h>
-#include <sys/types.h>
 
 #include "hugetlb.h"
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
