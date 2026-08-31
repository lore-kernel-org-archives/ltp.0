Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD6DC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4208E3E599C
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:03:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705153CE1C1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B200100096D
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 973FA223C7;
 Mon, 31 Aug 2026 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hblXXwGVuRcg/arsHaocs9N6yqlqC1/KdTpC2P0rf4=;
 b=hh8G1qzV+UknmEWKgRYkJEXaezvFJbrqMlGqHyGq6saw+jNxZsXpS3utJzltRcbJSGkwWX
 egnDi3bKI4bKAYkdc9Ms8ipSCCfFSL/pBWo2akJ3riREXTD3X0+gA+1kopf5clmamVEYBy
 iKvQ/6NICxl/EpcwpX2JMDNjTISuhjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hblXXwGVuRcg/arsHaocs9N6yqlqC1/KdTpC2P0rf4=;
 b=R2LE4fnfc5Lri1u46tv5sld+7THjXzn8RbIVB1e/osVJssORAA09EdhmRgDbrOFWw9QHwy
 lipZihGkfqfdNSBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lAdocrVI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nd0D9UXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hblXXwGVuRcg/arsHaocs9N6yqlqC1/KdTpC2P0rf4=;
 b=lAdocrVITBp7okFtOHNweXmquNH/Mg3jPBVLFGLARhhWz54wr3ZG3ut6yIh+fW3GAG+ORp
 Ry2hUCiM8F2U+CTEnvJ6Aw3FpR9IvCL6GccZQlznqZhvrvXsAbHYbibG9fb1hJPsYv335T
 XHZ/rfzrTm0bM6Uco6+oYwHVsvMYC4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hblXXwGVuRcg/arsHaocs9N6yqlqC1/KdTpC2P0rf4=;
 b=nd0D9UXQYHN5c4sbjGfUTKB6sex6vqO8WKP7FxvyZ0yfMJWv38eUL72no6Y+Q5erqCIM3U
 sEVqX3MBPMUmB6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAEBA136DE;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yH+yN4Y0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:08 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-7-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3361;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OggNx+0pg9EvHW8QJVKHbnsxzT9adhyQDymWZCQiUaw=;
 b=cZN890ENzqPKwWdZuyzb4HLxEeXNuuSmwBdpyPQaqNBcBi97f8jITcDwaXh2eVQD/4U4tjGRZ
 MbONCe4Tpe1C5dXXRabfeOPuxuaMai71cx1UErzaehBfKQ/C+4kU+bg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 973FA223C7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 07/16] fchroot04: test fchroot() into
 failfs as root
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

Verify that entering failfs with the FD_FAILFS_ROOT sentinel succeeds
with CAP_SYS_CHROOT and that every absolute path lookup then fails
with EOPNOTSUPP, while the working directory is reported as
unreachable by getcwd().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot04.c | 69 +++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 13635037b..91dfdba08 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -3,3 +3,4 @@
 fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
+fchroot04 fchroot04
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 235befd99..9270c1408 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,3 +1,4 @@
 fchroot01
 fchroot02
 fchroot03
+fchroot04
diff --git a/testcases/kernel/syscalls/fchroot/fchroot04.c b/testcases/kernel/syscalls/fchroot/fchroot04.c
new file mode 100644
index 000000000..14dbbff98
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot04.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test :manpage:`fchroot(2)` with the ``FD_FAILFS_ROOT`` sentinel as a
+ * privileged process.
+ *
+ * :manpage:`fchroot(2)` was introduced in Linux v7.3 together with failfs,
+ * a kernel internal filesystem where every operation fails with
+ * ``EOPNOTSUPP``. The ``FD_FAILFS_ROOT`` sentinel moves the process root
+ * there without needing a file descriptor: it is the ``fs_struct`` equivalent
+ * of ``RESOLVE_BENEATH``.
+ *
+ * The test verifies that entering failfs succeeds with ``CAP_SYS_CHROOT`` and
+ * that every absolute path lookup then fails with ``EOPNOTSUPP``. The working
+ * directory, left behind in the real filesystem, is consequently reported
+ * as unreachable by :manpage:`getcwd(2)`.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define UNR_TAG "(unreachable)/"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	char buf[PATH_MAX];
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
+		"absolute file open");
+
+	TST_EXP_FAIL(mkdir("/foo", 0700), EOPNOTSUPP,
+		"absolute directory creation");
+
+	/*
+	 * The libc getcwd() wrapper rejects the "(unreachable)"
+	 * prefix produced by the kernel, so call the raw syscall.
+	 */
+	TEST(tst_syscall(__NR_getcwd, buf, sizeof(buf)));
+	if (TST_RET > 0)
+		TST_EXP_EQ_STRN(buf, UNR_TAG, sizeof(UNR_TAG) - 1);
+	else
+		tst_res(TFAIL | TTERRNO, "getcwd() failed");
+
+	exit(0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
