Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF70FC636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:27:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFB5D3CBF8B
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:27:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F8133C1D84
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:27:29 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54CEC600821
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:27:27 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31DFEoiC008236; Mon, 13 Feb 2023 15:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U0O1inOL7gRTv18+desRdnLjBWnbsvrx6LNbFxii/hg=;
 b=Hrt3+T6fChK8rtCwsjKyAt+c3F8AMM0tfEAUQrXkA5n31M0a+tssZPpDcwrG5kGjHKAo
 q6vcz/wyjIwjn6XCPaiol5wlh5QkfTSGNqKXpvl1diKlxkEtlGwXEtrc5dMPO+eKr8rR
 sJJGTMeUrgtx1cxSv3K1MK+S6r/y0RWU/jwzD8I8iPiIqmTXspEzU560/OUJhgol7HFc
 QV9lrOnUjkttsmgsaYNdivw4zJA+2oh6OaIPnRj5cQb3LoTRxQouMDiG7UZn9oVwJwax
 YmDFbWwQSX4VQDP3pmH/2ioDJ7MrWK4bKR2rqyg6ARpbF5DgyJ7uMz7MXFa6aG6aD114 3Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqp5euawq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Feb 2023 15:27:25 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8HkRi009865;
 Mon, 13 Feb 2023 15:27:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a3sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Feb 2023 15:27:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 31DFRL8x45023742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 15:27:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED6522005A;
 Mon, 13 Feb 2023 15:27:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C25C820040;
 Mon, 13 Feb 2023 15:27:18 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.27.182])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Feb 2023 15:27:18 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 13 Feb 2023 20:56:55 +0530
Message-Id: <20230213152655.64295-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230125222703.19943-2-pvorel@suse.cz>
References: <20230125222703.19943-2-pvorel@suse.cz>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G3zL6drp_cocqOkd6r_ENgVnxwI7ZTjV
X-Proofpoint-ORIG-GUID: G3zL6drp_cocqOkd6r_ENgVnxwI7ZTjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=836 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130136
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] hugepage15: Resolve compile time warning
 generating with -O0
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
v2:
	- rebase and added Reviewed-by

 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |  1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

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
index 07e65a160..4d1984070 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -19,6 +19,10 @@
  * remap, or because the icache happens to get flushed in the interim.
  */
 
+#if defined(__clang__)
+	#pragma clang optimize off
+#endif
+
 #define _GNU_SOURCE
 #include "hugetlb.h"
 
@@ -27,16 +31,7 @@
 	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64) || \
 	defined(__i386__) || defined(__x86_64__) || defined(__arm__)
 
-#include <stdio.h>
-#include <stdlib.h>
 #include <setjmp.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <ucontext.h>
-#include <limits.h>
-#include <sys/param.h>
-#include <sys/types.h>
 
 #define SUCC_JMP 1
 #define FAIL_JMP 2
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
