Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C8CCF9E3
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 19:26:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18DF83CC656
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 20:26:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6673CBA5A
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 20:25:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7390F2000D9
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 20:25:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F01421F76B;
 Thu, 30 Oct 2025 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761852348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dSoPA/bdbmr+V/B0LW00GkERE6AvCmmrbfe1i7Kt3hA=;
 b=FqoJDtkfFx65GBkrfByun2XsPaANMOTCaDp959c271goUQAZBwjeI56QKbwhxVeX2UJDv8
 ZnQrAHnxw41C31nYs4HCQ6FwEzc8IhLaJfBMk2kVODJR4qMp8OpWXSiQufGOfzLjdahark
 v3DJVGgJHKJ5+MsuZEAvR1thohhAkQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761852348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dSoPA/bdbmr+V/B0LW00GkERE6AvCmmrbfe1i7Kt3hA=;
 b=KzZBcpgtjDc3FXOcsW16fc9tS/fgMhL9lD7UhRA+Gdipp4+ZUSq15PGjK9xudcmU5WcdE6
 +r7TNByfXoc/ubBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hxQdbprv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RyQ/0Ujg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761852347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dSoPA/bdbmr+V/B0LW00GkERE6AvCmmrbfe1i7Kt3hA=;
 b=hxQdbprvbl7uVi/vqstsN85z0evIUwLDy64z7K+OcM5idk+rSfiUzblzXou0qsP9g/Vs+S
 tjK5SUg4Wi7Hn3iRLDfA5676QXipzWoqRDKoCSaFXh7eTfq8SIOM6zt5LrT73tVxn3a86+
 PCUJmCB2FilvU3YUsu+aySOA1OVkt6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761852347;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dSoPA/bdbmr+V/B0LW00GkERE6AvCmmrbfe1i7Kt3hA=;
 b=RyQ/0UjgqIR8lsjduumfnhtNzom3E3ZqXv64i84CRiMc3QTB7scf6jb5MFz/1DGU8etPga
 gtUgFTWH/K35b3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A6113393;
 Thu, 30 Oct 2025 19:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l2XHH7q7A2ldRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 19:25:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Oct 2025 20:25:43 +0100
Message-ID: <20251030192543.761804-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: F01421F76B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: dirtyc0w_shmem: userfaultfd01: Add
 safe_userfaultfd()
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

Use TINFO in tst_res() followed by tst_brk(TBROK, ...).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: SAFE_USERFAULTFD() could be used also in Wei's mremap07.c
https://patchwork.ozlabs.org/project/ltp/patch/20251030054029.23511-1-wegao@suse.com/

 include/lapi/userfaultfd.h                    | 33 +++++++++++++++++++
 .../dirtyc0w_shmem/dirtyc0w_shmem_child.c     | 15 +--------
 .../syscalls/userfaultfd/userfaultfd01.c      | 18 +---------
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index 4d52b7c4bb..8c9482c3d1 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2007 Davide Libenzi <davidel@xmailserver.org>
  * Copyright (C) 2015,2022 Red Hat, Inc.
+ * Copyright (c) Linux Test Project, 2025
  *
  * Mostly copied/adapted from <linux/userfaultfd.h>
  */
@@ -9,6 +10,7 @@
 #ifndef LAPI_USERFAULTFD_H__
 #define LAPI_USERFAULTFD_H__
 
+#include <stdbool.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include "lapi/syscalls.h"
@@ -187,4 +189,35 @@ struct uffdio_continue {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #endif /* UFFD_FEATURE_MINOR_SHMEM */
 
+#define SAFE_USERFAULTFD(flags, retry) \
+	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
+
+static inline int safe_userfaultfd(const char *file, const int lineno, int
+				   flags, bool retry)
+{
+	int ret;
+
+retry:
+	ret = tst_syscall(__NR_userfaultfd, flags);
+	if (ret == -1) {
+		if (errno == EPERM) {
+			if (retry && !(flags & UFFD_USER_MODE_ONLY)) {
+				flags |= UFFD_USER_MODE_ONLY;
+				goto retry;
+			}
+			tst_res_(file, lineno, TINFO,
+				 "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
+			tst_brk_(file, lineno, TCONF | TERRNO,
+				"userfaultfd() requires CAP_SYS_PTRACE on this system");
+		}
+		tst_brk_(file, lineno, TBROK | TERRNO,
+				 "syscall(__NR_userfaultfd, %d) failed", flags);
+	} else if (ret < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid syscall(__NR_userfaultfd, %d) return value %d", flags, ret);
+	}
+
+	return ret;
+}
+
 #endif /* LAPI_USERFAULTFD_H__ */
diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index 2a982347c5..9c60fbfa34 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -128,21 +128,8 @@ static void setup_uffd(void)
 {
 	struct uffdio_register uffdio_register;
 	struct uffdio_api uffdio_api;
-	int flags = O_CLOEXEC | O_NONBLOCK;
 
-retry:
-	TEST(tst_syscall(__NR_userfaultfd, flags));
-	if (TST_RET < 0) {
-		if (TST_ERR == EPERM) {
-			if (!(flags & UFFD_USER_MODE_ONLY)) {
-				flags |= UFFD_USER_MODE_ONLY;
-				goto retry;
-			}
-		}
-		tst_brk(TBROK | TTERRNO,
-			"Could not create userfault file descriptor");
-	}
-	uffd = TST_RET;
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index c2c684d2b8..5a973ad8e9 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -23,11 +23,6 @@ static char *page;
 static void *copy_page;
 static int uffd;
 
-static int sys_userfaultfd(int flags)
-{
-	return tst_syscall(__NR_userfaultfd, flags);
-}
-
 static void set_pages(void)
 {
 	page_size = sysconf(_SC_PAGE_SIZE);
@@ -80,19 +75,8 @@ static void run(void)
 
 	set_pages();
 
-	TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
-
-	if (TST_RET == -1) {
-		if (TST_ERR == EPERM) {
-			tst_res(TCONF, "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
-			tst_brk(TCONF | TTERRNO,
-				"userfaultfd() requires CAP_SYS_PTRACE on this system");
-		} else
-			tst_brk(TBROK | TTERRNO,
-				"Could not create userfault file descriptor");
-	}
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
 
-	uffd = TST_RET;
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = 0;
 	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
