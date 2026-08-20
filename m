Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15061C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82CAD3CE356
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:47:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0072B3CDE35
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7FA6410000E5
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4310B3EC1;
 Thu, 20 Aug 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWU5Cjhl+ayGleLtb2CxHymx61L0uj352Mu3KDCC8v4=;
 b=BEnwrAttUaapZNnry6WAEwpmze6d+oywccAo9ihHG6T/d46scLoMkaftPXdttoGUJ5ZzXg
 bWsjFLXTl3keJDYZW4iR/s64iLZC3gg7yvQzuhw9QEtl9E87QDmHb26VyYDGMwec/D5F/p
 T9fbMBlFMPsdlGLcyipmt1UIcgdrpt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWU5Cjhl+ayGleLtb2CxHymx61L0uj352Mu3KDCC8v4=;
 b=uFUtK3oS6wIqjF5DzF7v/5j9XgKkyjx+OFpvbEzh3cyYcM1icLTZGY/1NSZ/FvIFWf+e7+
 YnNPArGyjrnR2FDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15ZZVTxz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/acz/Icg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWU5Cjhl+ayGleLtb2CxHymx61L0uj352Mu3KDCC8v4=;
 b=15ZZVTxzhEoMlMM9RZ3OB4imhxb/QYA55L+cRtWoFsG0lQK7HbnuW/F3l01BukwB6NxJai
 j6wx9u1U1yf3uQBbksYhWw/Rw9MD203tIPSjjKZUI/udVhJKHY83HOEsLKm0iMAFZzScjr
 Xskt3u9rSbEx2rOqHZjEeRzrXESayw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWU5Cjhl+ayGleLtb2CxHymx61L0uj352Mu3KDCC8v4=;
 b=/acz/Icgiyc46/jLTs21Lp8OgQ5CAoKgMMDTc6fmGHS5MN7eJ72tOfdJk5El+I4mtvRgDZ
 l6CkNmDfe6N7aXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49609367D;
 Thu, 20 Aug 2026 07:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yE7LDm2whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:46 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-6-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3340;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=VN77ZUYOTOHc0MZMmgOB8pOsjzNY7uIXUzJHncB//vQ=;
 b=fJlU88RVLBTgPX4qe5GAj8jP9UrLAOZdvvxga9WmbDgK2O1UPNp/XSUfnoOPpVlGENwGM1zxx
 SL39pqN+ZZIDa6nrDRdB2qzZOK4E25vlca60oViwVWmsXvi8HdHTnuS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4310B3EC1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 06/16] fchroot03: test fchroot() permission
 checks
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

Verify that with a regular directory fd the kernel first checks the
execute permission on the directory and then CAP_SYS_CHROOT: an
unprivileged process with an accessible directory fails with EPERM and
a process without execute permission fails with EACCES.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot03.c | 78 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index e12230218..13635037b 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -2,3 +2,4 @@
 
 fchroot01 fchroot01
 fchroot02 fchroot02
+fchroot03 fchroot03
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index fb3287612..235befd99 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,2 +1,3 @@
 fchroot01
 fchroot02
+fchroot03
diff --git a/testcases/kernel/syscalls/fchroot/fchroot03.c b/testcases/kernel/syscalls/fchroot/fchroot03.c
new file mode 100644
index 000000000..79d3daf7d
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot03.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` permission checks with a regular directory
+ * fd.
+ *
+ * :manpage:`fchroot(2) `was introduced in Linux v7.3. With a regular directory
+ * fd the kernel first checks that the caller has execute permission on the
+ * directory, then that it holds ``CAP_SYS_CHROOT``:
+ *
+ * - an unprivileged process with an accessible directory fails with ``EPERM``
+ * - a process without execute permission on the directory fails with
+ *   ``EACCES``, proving the permission check comes before the capability
+ *   check
+ *
+ * Root is required to open the directory file descriptors before dropping
+ * to an unprivileged user in forked children.
+ */
+
+#include <fcntl.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static struct tcase {
+	const char *dir;
+	mode_t mode;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{"pubdir", 0755, EPERM, "no CAP_SYS_CHROOT"},
+	{"privdir", 0600, EACCES, "no execute permission"},
+};
+
+static struct passwd *ltpuser;
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (SAFE_FORK())
+		return;
+
+	int dfd = SAFE_OPEN(tc->dir, O_PATH | O_DIRECTORY);
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, dfd, 0),
+		tc->exp_errno, "fchroot() with %s", tc->desc);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	unsigned int i;
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		SAFE_MKDIR(tcases[i].dir, tcases[i].mode);
+		SAFE_CHMOD(tcases[i].dir, tcases[i].mode);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
