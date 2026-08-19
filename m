Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4153EC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8DA13C06E3
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:28:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C323F3CD600
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D03D46008AE
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 580D684D37;
 Wed, 19 Aug 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLpiJ0IzDce9I++Pb1PTDKBn5AjmV90SRzLluC+1fJ8=;
 b=V2pVu/FuTJk2Zmv5IwY7X4+0cgJyuPJ04mUWCL6VgbqsVehEvFZnMj2u/xhUStXYQJcU9x
 F9TqDRZHwY4YnADsP0oguSN1qQF2eo6ub18yn7JBCEla4WwpEF59CBDQGvwhhW/GsHLNkP
 MPy0HcCnKwKjViWU+ScCI7ekRIljTA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLpiJ0IzDce9I++Pb1PTDKBn5AjmV90SRzLluC+1fJ8=;
 b=c05nxyXOsQ9YwPhknqZsAjEOwYu1ieJg/xmZ0wWZuTPCES2wSL/ABPuYuoQzz+f4u9Z4r/
 P8Gmzc2znNxczeCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bSA3JFhn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1XWO8Gka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLpiJ0IzDce9I++Pb1PTDKBn5AjmV90SRzLluC+1fJ8=;
 b=bSA3JFhnqiNXLRCfpdwjSUJhg75cT4tKblhqdPCu4IjjSwC2515POjI8Wz4DD39uocvRPu
 RLxPE7LBavUYAbRxr9FKUjHOvEtGH8EQWxeeAqX8P4OaECYRPeeJRJnOUtA5KXgDcUnrj/
 qI5xs8fKv8NNZCwkxUIKvYSVwN7J0dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLpiJ0IzDce9I++Pb1PTDKBn5AjmV90SRzLluC+1fJ8=;
 b=1XWO8GkatJTh03hcJaePhIyZCzVnnCOIJtu/eO9Z0+zzZetx9ldYnHNabrJF38OW70SDJd
 QNgPSMO70YjcPECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF073684;
 Wed, 19 Aug 2026 21:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WJdoBwcfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:27 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-12-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3353;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Fd4VXjDdJbHGFt99ygxkQhj44hzAMb+Yjjmxv/yALHU=;
 b=mjZ+Pk5ANIPZGsSA3/QnwMNoYdWH528IH9ElCS4kulLgXWZ+2aIgysLEqMDwXcIFp/LlvGwfJ
 wspINfGwK3bAnwwWSwZFaZ0GDJG/rYfBojpfiR+WkrX6RGgJmsK9f6S
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 580D684D37
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 12/16] fchroot09: test setns escape from
 failfs root
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

Verify that entering failfs with fchroot() is hard to undo: a process
inside counts as chrooted, so the remaining way out is a pre-opened
mount namespace fd. setns() into it resets both the root and the
working directory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot09.c | 70 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 8dfe95c4a..23f6c6a20 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -8,3 +8,4 @@ fchroot05 fchroot05
 fchroot06 fchroot06
 fchroot07 fchroot07
 fchroot08 fchroot08
+fchroot09 fchroot09
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index c099b4b3a..e803fa2b7 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -6,3 +6,4 @@ fchroot05
 fchroot06
 fchroot07
 fchroot08
+fchroot09
diff --git a/testcases/kernel/syscalls/fchroot/fchroot09.c b/testcases/kernel/syscalls/fchroot/fchroot09.c
new file mode 100644
index 000000000..196a6844d
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot09.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`setns(2)` escapes the failfs root.
+ *
+ * Entering failfs with :manpage:`fchroot(2)` is hard to undo: a process
+ * inside counts as chrooted, so :manpage:`chroot(2)` and fchroot() back
+ * out require CAP_SYS_CHROOT. The remaining way out is a pre-opened mount
+ * namespace file descriptor: setns() into it resets both the root and the
+ * working directory.
+ *
+ * Root is required because entering failfs requires CAP_SYS_CHROOT and
+ * :manpage:`setns(2)` into the mount namespace requires CAP_SYS_ADMIN.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/sched.h"
+#include "lapi/setns.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		struct stat realroot, realcwd, st;
+		int nsfd;
+
+		SAFE_STAT("/", &realroot);
+		SAFE_STAT(".", &realcwd);
+		nsfd = SAFE_OPEN("/proc/self/ns/mnt", O_RDONLY);
+
+		TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+		TST_EXP_FAIL2(open("/etc", O_PATH), EOPNOTSUPP,
+			"absolute lookup after entering failfs");
+
+		TST_EXP_PASS(setns(nsfd, CLONE_NEWNS),
+			"setns() back into the mount namespace");
+
+		SAFE_CLOSE(nsfd);
+
+		SAFE_STAT("/", &st);
+		TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
+			st.st_ino == realroot.st_ino,
+			"root restored after setns()");
+
+		SAFE_STAT(".", &st);
+		TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
+			st.st_ino == realcwd.st_ino,
+			"working directory restored after setns()");
+
+		exit(0);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
