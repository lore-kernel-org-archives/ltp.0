Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC50C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:49:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F0FD3CE127
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:49:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62B2A3CE52A
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 20D5A1A00661
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8880C84F97;
 Thu, 20 Aug 2026 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvi3lF/HVWe7UjsaK3GHb60EESJ80OS6aiNAuzR9oNY=;
 b=W2rU2Nmwa8dHIKUXn1s5hQqnVyopWjKtY7hhEmn0u7ojvQqc9MPXpWEyLXMEG8tLrZy3R2
 ltVV+NRQ7R9cM1dk/wNTYhi808bAR+LiALwKZOC39GU61+j59lOZ4Nx0ARU5IftLuc7AvT
 i05AW6xxkN5hDlu5wVgr8uXRd2FO1Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvi3lF/HVWe7UjsaK3GHb60EESJ80OS6aiNAuzR9oNY=;
 b=jjQ4dyb1eFvRFIKcBlgPlA5HeFufCup3YKAnuFjykPl5g8hOJONflWQf+r0A9eIbkGMY1q
 so2D3mGEdZjGhDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvi3lF/HVWe7UjsaK3GHb60EESJ80OS6aiNAuzR9oNY=;
 b=VFqgcBxv9LkcTU8/K3LGg1pWzxD/CMu3wsr62fdcz8D3OJaChfbpK5eGvQZEsyQ/QiuaMV
 CRy25A7h7g3Nol+lxidRbtZHA51CfUPh0/xItfeOQEkcYUiA8kSPd1U53pATINw5VJuTwu
 q8GaYvkKBotT8is4+APSI/y2NmpqeuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvi3lF/HVWe7UjsaK3GHb60EESJ80OS6aiNAuzR9oNY=;
 b=pQHMVVoGoMgb0pEy+tTcPU9Y+465H8hrVVAbOP3Dubyv6Lqzg9b99G1LRXFxVysp7cMFHi
 5iwHMJ6LLIdce0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E928C3689;
 Thu, 20 Aug 2026 07:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aILVNW+whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:56 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-16-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3005;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gnDML6rE8PrmmZDtAUIR1eOJqp3CA+I6pd0QLEE8OoQ=;
 b=KTlRQkClI3UN4+9aerkGTFluNsL/nWfXeI8HV9CRNrWTVEkyn/hB5RCtdYT3WuQfa2kYrSLms
 sa044x8l5SXBk1qyr5kBiYZEUFzRGNngRp/YVn0NW4Re16Gt46iKvu4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 16/16] fchroot13: test failfs entry when
 chrooted
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

Verify that unprivileged fchroot() into failfs is refused when the
process is already chrooted: moving the root of a chrooted task into
failfs would allow it to escape its chroot via openat(fd, "..") with
a pre-opened directory fd, so the kernel refuses the syscall with
EPERM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot13.c | 63 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 1655b6813..95e777ffb 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -12,3 +12,4 @@ fchroot09 fchroot09
 fchroot10 fchroot10
 fchroot11 fchroot11
 fchroot12 fchroot12
+fchroot13 fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index de8ca0688..0c4461611 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -10,3 +10,4 @@ fchroot09
 fchroot10
 fchroot11
 fchroot12
+fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/fchroot13.c b/testcases/kernel/syscalls/fchroot/fchroot13.c
new file mode 100644
index 000000000..e90e6f663
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot13.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * when the process is already chrooted.
+ *
+ * The root directory is what confines ".." resolution and the failfs root
+ * can never be reached by walking up a real mount tree. Moving the root
+ * of a chrooted task into failfs would allow it to escape its chroot via
+ * ``openat(fd, "..")`` with a pre-opened directory fd, so the kernel refuses
+ * the syscall with ``EPERM``.
+ *
+ * Root is required to create the chroot jail before dropping to an
+ * unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/syscalls.h"
+
+#define JAILDIR "jail"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_CHROOT(JAILDIR);
+	SAFE_CHDIR("/");
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EPERM, "fchroot() from a chrooted process");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_MKDIR(JAILDIR, 0755);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
