Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EA7C28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 11:39:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B0A3CA2CC
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 13:39:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A12AD3CA34D
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id B556820096A
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:42 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B0212FC;
 Mon, 22 Aug 2022 04:38:43 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09F73F718;
 Mon, 22 Aug 2022 04:38:39 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Mon, 22 Aug 2022 12:39:17 +0100
Message-Id: <20220822113919.196953-3-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822113919.196953-1-tudor.cretu@arm.com>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] syscalls/mprotect01: Invoke the syscall
 directly instead of the libc wrapper
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

per POSIX: The mprotect() function shall change the access protections
to be that specified by prot for those whole pages containing any part
of the address space of the process starting at address addr and
continuing for len bytes.

Issue 6 of POSIX introduces: The implementation may require that addr
be a multiple of the page size as returned by sysconf().

Therefore it's not strictly required that addr is a multiple of the page
size. Some libcs (e.g. Musl) indeed don't have this requirement, so calling
the C standard library function doesn't fail in their case. As the
testsuite focuses on mprotect(2), the testcases should call the syscall
directly instead of the libc function.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/mprotect/mprotect01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index be4d982ea..aa4685258 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -43,6 +43,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
+#include "lapi/syscalls.h"
 #include "safe_macros.h"
 
 char *TCID = "mprotect01";
@@ -97,7 +98,7 @@ int main(int ac, char **av)
 			if (TC[i].setupfunc != NULL)
 				TC[i].setupfunc(&TC[i]);
 
-			TEST(mprotect(TC[i].addr, TC[i].len, TC[i].prot));
+			TEST(tst_syscall(__NR_mprotect, TC[i].addr, TC[i].len, TC[i].prot));
 
 			if (TEST_RETURN != -1) {
 				tst_resm(TFAIL, "call succeeded unexpectedly");
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
