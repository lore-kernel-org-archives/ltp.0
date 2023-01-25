Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1766C27C76
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 22:27:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E3423CD3B8
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 23:27:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FB473CC756
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4844C1000676
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A98651F8A6;
 Wed, 25 Jan 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674685627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf7eQgV4Eify6/XID5l0yM8TqRJE6L1wu5p02uhtlsY=;
 b=n/NOpNWUwgSuBB82mU/sqCpPvGEIxxIDo0TBoHjfhBLFf4H1uGIJsoxn0RhwxfcpTtitTJ
 mG80Dv22AaOPOXWovyne2mrQol1rJhgCo/jmARAiU7ee8SN9unR5WMy1qkM1e0Jg7QEKNX
 xTTF7XnPZr9Hplc+oeYlSW/VMBIleok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674685627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf7eQgV4Eify6/XID5l0yM8TqRJE6L1wu5p02uhtlsY=;
 b=RhyDMrbz0R176A2MnwrPuFsfRloCWzDDwYUHtlpy0xVLR7uB9OC6BdhUanCUxsQbuN66FT
 6Q84JhqDBhO1UiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75E931339E;
 Wed, 25 Jan 2023 22:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sCGaG7us0WPoNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 22:27:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Jan 2023 23:27:03 +0100
Message-Id: <20230125222703.19943-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125222703.19943-1-pvorel@suse.cz>
References: <20230125222703.19943-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] hugemmap15.c: Use TST_TEST_TCONF() for
 unsupported archs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

15625f6185 broke LTP build at least on riscv32 and mipsel32
(and for any new arch in the future). Replace #error directive with
TST_TEST_TCONF() fixes that.

Fixes: 15625f6185 ("Hugetlb: Migrating libhugetlbfs icache-hygiene")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 4730d8d184..836225acd8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -19,6 +19,13 @@
  */
 
 #define _GNU_SOURCE
+
+#include "hugetlb.h"
+#if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
+	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
+	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64) || \
+	defined(__i386__) || defined(__x86_64__) || defined(__arm__)
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <setjmp.h>
@@ -30,8 +37,6 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
-
 #define SUCC_JMP 1
 #define FAIL_JMP 2
 #define COPY_SIZE	128
@@ -142,8 +147,6 @@ static void sig_handler(int signum, siginfo_t *si, void *uc)
 		siglongjmp(sig_escape, FAIL_JMP + SIGSEGV);
 	}
 #endif
-#else
-#error "Need to setup signal conditions for this arch"
 #endif
 }
 
@@ -241,3 +244,6 @@ static struct tst_test test = {
 	.test_all = run_test,
 	.hugepages = {3, TST_NEEDS},
 };
+#else
+	TST_TEST_TCONF("Architecture not supported");
+#endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
