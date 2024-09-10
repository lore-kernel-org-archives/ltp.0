Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7C8ECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:56:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC9723C19F9
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:56:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE3253C19E4
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:56:00 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2509B6013C3
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:55:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5853B21A05
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725958558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw+wiJzBu1cvN+Qc24Yzg9hA48RhGoZ848zr61CxNhw=;
 b=aWMW6NhxOlt85uQUi4uERGDDyXmZIedxfRu70GWtGwH0bF0Fs5qaBc+ZXJMa/SfFauIIIw
 GZxfNuBi9Ml9/MnzfYCoS6IewEK9djbV7mhgc5SlNhCcTNIN7FI5+8/nBVVA9lcGR0Hgy9
 zixBAiG0J5G5tddxrYxXuMbrB4tzYw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725958558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw+wiJzBu1cvN+Qc24Yzg9hA48RhGoZ848zr61CxNhw=;
 b=BceoEYA804VSZG+VFkLe6jVvySkcYeGqle1yNNyD14VSDmc9VrDsiE1dsUxJ/3ODhbGZaE
 IZtwdMBQS7UkFeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725958558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw+wiJzBu1cvN+Qc24Yzg9hA48RhGoZ848zr61CxNhw=;
 b=aWMW6NhxOlt85uQUi4uERGDDyXmZIedxfRu70GWtGwH0bF0Fs5qaBc+ZXJMa/SfFauIIIw
 GZxfNuBi9Ml9/MnzfYCoS6IewEK9djbV7mhgc5SlNhCcTNIN7FI5+8/nBVVA9lcGR0Hgy9
 zixBAiG0J5G5tddxrYxXuMbrB4tzYw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725958558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mw+wiJzBu1cvN+Qc24Yzg9hA48RhGoZ848zr61CxNhw=;
 b=BceoEYA804VSZG+VFkLe6jVvySkcYeGqle1yNNyD14VSDmc9VrDsiE1dsUxJ/3ODhbGZaE
 IZtwdMBQS7UkFeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD7C613A3A
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KYXLHZ0J4GZIQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:55:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 10 Sep 2024 10:55:54 +0200
MIME-Version: 1.0
Message-Id: <20240910-regen_shutup_lsp-v2-1-528f552c6c1d@suse.com>
X-B4-Tracking: v=1; b=H4sIAJkJ4GYC/32NQQ6CMBBFr0JmbU2pUsCV9zCEFDrQJlpIhzYa0
 rtbOYDL95L//g6E3iLBrdjBY7RkF5dBnAoYjXIzMqszg+DiylveMo8zup5M2MLaP2ll6lJJLlX
 T1IOEPFs9TvZ9JB9dZmNpW/zneIjlz/6JxZKVTMtKaV4PjRDTnQLheVxe0KWUvmkq4HuvAAAA
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725958557; l=3530;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=6DjBudHaeWkH6YUDv9iREPGSi6fGD5fkXHPdP46aPzY=;
 b=eA2M2ATzQl7iPi0hNNeVe5BrWbikf0hpqxBXomQYVwu9Ci3ba4TMwPt1hBuSb7ggICaLiCFU5
 hHt9WSH6nN9Dt5jFKT4Y6hn5o0ztph8uj0cmS8gFimCgZaixdPHX+SN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
Subject: [LTP] [PATCH v2] Remove cleanup.c inclusion from syscalls generation
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Remove cleanup.c from syscalls.h as it is part of the old library and
its usage is discouraged. LSP(s) supporting C language correctly flag
this file as problematic. This patch ensures that the lapi/syscalls/regen.sh
script will no longer include cleanup.c, preventing unnecessary usage in
generated headers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- delete cleanup.c
- use "inline static" for dummy cleanup
- Link to v1: https://lore.kernel.org/r/20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com
---
 include/lapi/syscalls/regen.sh |  5 +++--
 include/old/cleanup.c          | 47 ------------------------------------------
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 97027e2f3..663ce4458 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -33,7 +33,6 @@ cat << EOF > "${output_pid}"
 #include <errno.h>
 #include <sys/syscall.h>
 #include <asm/unistd.h>
-#include "cleanup.c"
 
 #ifdef TST_TEST_H__
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
@@ -41,8 +40,10 @@ cat << EOF > "${output_pid}"
 		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #else
+inline static void dummy_cleanup(void) {}
+
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
-	tst_brkm(TCONF, CLEANUP, \\
+	tst_brkm(TCONF, dummy_cleanup, \\
 		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #endif
diff --git a/include/old/cleanup.c b/include/old/cleanup.c
deleted file mode 100644
index 040dff852..000000000
--- a/include/old/cleanup.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Default cleanup logic because linux_syscall_numbers.h's need for cleanup
- * and binutils bugs suck.
- *
- * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-#ifndef __CLEANUP_C__
-#define __CLEANUP_C__
-
-/* Did the user define a cleanup function? */
-#ifndef CLEANUP
-#define USING_DUMMY_CLEANUP 1
-#define CLEANUP dummy_cleanup
-#endif
-
-/* A freebie for defining the function prototype. */
-static void CLEANUP(void) __attribute__ ((unused));
-
-#ifdef USING_DUMMY_CLEANUP
-/* The stub function. Wewt.. */
-static void dummy_cleanup(void)
-{
-}
-#endif
-
-#endif

---
base-commit: cc9730eae07446e9d083219c112b0512892d16da
change-id: 20240909-regen_shutup_lsp-a35606a887b6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
