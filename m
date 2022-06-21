Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20888C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1ABF3C93DA
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 11:07:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 342FC3C04EF
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:07:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E902E6007AF
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:07:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 055391FADF;
 Tue, 21 Jun 2022 09:07:47 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D895613A88;
 Tue, 21 Jun 2022 09:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qOaSMmKKsWKFHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 09:07:46 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Jun 2022 11:09:51 +0200
Message-Id: <20220621090951.29911-1-metan@ucw.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, arnd@arndb.de,
 linux-api@vger.kernel.org, dhowells@redhat.com, David.Laight@aculab.com,
 zack@owlfolio.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Cyril Hrubis <chrubis@suse.cz>

This changes the __u64 and __s64 in userspace on 64bit platforms from
long long (unsigned) int to just long (unsigned) int in order to match
the uint64_t and int64_t size in userspace.

This allows us to use the kernel structure definitions in userspace.

For example we can use PRIu64 and PRId64 modifiers in printf() to print
structure membere. Morever with this there would be no need to redefine
these structures in an libc implementations as it is done now.

Consider for example the newly added statx() syscall. If we use the
header from uapi we will get warnings when attempting to print it's
members as:

	printf("%" PRIu64 "\n", stx.stx_size);

We get:

	warning: format '%lu' expects argument of type 'long unsigned int',
	         but argument 5 has type '__u64' {aka 'long long unsigned int'}

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/uapi/asm-generic/types.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

v2: Make sure we do not break C++ applications

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f..11e468a39d1e 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -1,9 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_GENERIC_TYPES_H
 #define _ASM_GENERIC_TYPES_H
+
+#include <asm/bitsperlong.h>
+
 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
  */
-#include <asm-generic/int-ll64.h>
+#if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
+# include <asm-generic/int-l64.h>
+#else
+# include <asm-generic/int-ll64.h>
+#endif
 
 #endif /* _ASM_GENERIC_TYPES_H */
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
