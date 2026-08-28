Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766BBC61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:14:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048483E5DF8
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:14:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F9C3E2FCB
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F005760006E
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCD01FBAD;
 Fri, 28 Aug 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=O2VVFfQAB2vjwlN1vWrznpZGvtDnf7MILvLVjZqhqGp/3JUq7qPqCSBK8fJb0Ar0y2XHJY
 wbhteGF8l9g40OdvTdouXwaqGFRzWdMft3E+NtDptAXONwFkQfZt6Udv6CisYsKVzUwYnY
 SDrcbECAfa3EYPOtLz5FLBJoMIfP7Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=FzIFESTCfi/EX3vKr4EmHJcetpYCXXADmIx25AM7df5TBTqfFKUFYFDwxNGH2OleDZW0T8
 NW2qcH7scKIBfbDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w9W0AOEX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xOMWsr+f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=w9W0AOEX1E0oBzAB5S7vVEDHRlRffkkRA1hgiZXMBPdAWGns9YJTKvKLYMCk2nKq+RH6T3
 FNaYNGkUM/OSsSvRykzQC4gF8Ls7GlYU8xBkWFSDvw8+vode9BWiibz5eYw7kXg8KvJc6c
 A+IfQw4EG2FdHgOuqTPRIo0FiFXaQZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=xOMWsr+fus1IcYmhWZ6FWvNDZ+JJlNljW1bVd4QWEWzzTp3QpkGsW+jjtFvFC8f+EkjHH9
 lZPszD15LERHRBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60CA513694;
 Fri, 28 Aug 2026 14:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mP/tFSGXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:42 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-8-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=3641;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tbK0jKt/233h5y5TPGqUeJEBmJ0+2HPHBhbZjrLEL7E=;
 b=ctO8O6PO6YNeqddB5JlXXFtMCn+iZNZlE1PPcUGj7QIoBHw0H1+Tp8iZZlWEs8A+tBvqjbiaM
 /Ra9rla2GI5B6Da9jWKKPWqz0i+qJUxjdB1mYgtjZskXo3nWU3xNZLw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 3FCD01FBAD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 08/15] fchroot05: test failfs root can not
 be referenced
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

Verify that once fchroot() moved the root into failfs, the root
directory can not be opened anymore, not even with O_PATH, nor pinned
by following the /proc/self/root magic link, although readlink()
still names it as "failfs:/" since it does not follow the link.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot05.c | 75 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 91dfdba08..49f51d637 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -4,3 +4,4 @@ fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
 fchroot04 fchroot04
+fchroot05 fchroot05
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 9270c1408..0697f10eb 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -2,3 +2,4 @@ fchroot01
 fchroot02
 fchroot03
 fchroot04
+fchroot05
diff --git a/testcases/kernel/syscalls/fchroot/fchroot05.c b/testcases/kernel/syscalls/fchroot/fchroot05.c
new file mode 100644
index 000000000..f183d749c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot05.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that the failfs root can not be referenced once it is the process
+ * root.
+ *
+ * After :manpage:`fchroot(2)` moved the root into failfs, the root
+ * directory can not be opened anymore, not even with ``O_PATH``, because the
+ * walk lands on the failfs root as its terminal. The root also can not
+ * be pinned by following the /proc/self/root magic link into it, although
+ * :manpage:`readlink(2)` still names it as "failfs:/" since it does not
+ * follow the link.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * /proc must be opened before entering failfs because every absolute path
+ * lookup fails once the root is unreachable. The test runs in a forked
+ * child so the root of the parent process is left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	char buf[PATH_MAX];
+	struct stat st;
+	int procfd, len;
+
+	procfd = SAFE_OPEN("/proc", O_PATH | O_DIRECTORY);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	TST_EXP_FAIL2(open("/", O_RDONLY | O_DIRECTORY), EOPNOTSUPP,
+		"open() of the failfs root");
+
+	TST_EXP_FAIL2(open("/", O_PATH), EOPNOTSUPP,
+		"O_PATH open() of the failfs root");
+
+	TST_EXP_FAIL2(openat(procfd, "self/root", O_PATH), EOPNOTSUPP,
+		"pin of the root via /proc/self/root");
+
+	TST_EXP_FAIL(fstatat(procfd, "self/root", &st, 0), EOPNOTSUPP,
+		"stat of the root via /proc/self/root");
+
+	len = readlinkat(procfd, "self/root", buf, sizeof(buf) - 1);
+	if (len < 0) {
+		tst_res(TFAIL | TTERRNO, "readlinkat() of /proc/self/root");
+	} else {
+		buf[len] = '\0';
+		TST_EXP_EQ_STR(buf, "failfs:/");
+	}
+
+	exit(0);
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
