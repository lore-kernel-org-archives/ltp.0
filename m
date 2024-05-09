Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3348FC10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:10:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BE73CE10E
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:10:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61D63CD1CA
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:10:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0BD781A007AE
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:10:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83FED22094;
 Thu,  9 May 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74CF513941;
 Thu,  9 May 2024 12:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bQaXGzS9PGYXXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 May 2024 12:10:28 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: ltp@lists.linux.it
Date: Thu,  9 May 2024 14:09:42 +0200
Message-ID: <20240509120942.14952-1-metan@ucw.cz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.40 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[metan@ucw.cz,chrubis@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_NEQ_ENVFROM(0.10)[metan@ucw.cz,chrubis@suse.cz];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: arch_prctl01.c fix compilation on old
 distros
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

From: Cyril Hrubis <chrubis@suse.cz>

There are distros that have asm/prctl.h without the ARCH_{GET,SET}_CPUID
definitions, fix the compilation on such distributions by adding
lapi/arch_prctl.h.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/arch_prctl.h                          | 22 ++++++++++++++++++++++
 .../kernel/syscalls/arch_prctl/arch_prctl01.c      |  7 +------
 2 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 include/lapi/arch_prctl.h

diff --git a/include/lapi/arch_prctl.h b/include/lapi/arch_prctl.h
new file mode 100644
index 000000000..6d0ef51f4
--- /dev/null
+++ b/include/lapi/arch_prctl.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+#ifndef LAPI_ARCH_PRCTL_H__
+#define LAPI_ARCH_PRCTL_H__
+
+#include "config.h"
+
+#ifdef HAVE_ASM_PRCTL_H
+# include <asm/prctl.h>
+#endif
+
+#ifndef ARCH_GET_CPUID
+# define ARCH_GET_CPUID 1011
+#endif
+
+#ifndef ARCH_SET_CPUID
+# define ARCH_SET_CPUID 1012
+#endif
+
+#endif /* LAPI_ARCH_PRCTL_H__ */
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
index e30b5667a..b98ef99d2 100644
--- a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -13,10 +13,9 @@
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "lapi/syscalls.h"
+#include "lapi/arch_prctl.h"
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ASM_PRCTL_H
-#include <asm/prctl.h>
 
 static int arch_prctl_get(int code)
 {
@@ -76,7 +75,3 @@ static struct tst_test test = {
 	.min_kver = "4.12",
 	.supported_archs = (const char *const []){"x86_64", "x86", NULL}
 };
-
-#else /* HAVE_ASM_PRCTL_H */
-TST_TEST_TCONF("missing <asm/prctl.h>");
-#endif
-- 
2.12.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
