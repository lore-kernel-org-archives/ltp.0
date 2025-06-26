Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517D2C7EE32
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:35:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9819E3CCB95
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:35:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98E613CAB13
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7686620005D
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 481C51F441;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzMK95l1XOAO/39MhxmsqsfMgNktjn8skN6//Ml4P68=;
 b=W6iZrc6kZIQwzN8g5Xsdk7t1zA5UEi8MvJE25R4ixPXgWp2cWW3nReEdNNQrmrnJJnF0SC
 0nNkYFMKnXxDoIshGDL+kVOZCqZzok3gP0HtaSX5LHn9ajZP4WH+uFRJiIBuybiRB3WTAf
 ZnixyFsb0AMppQLqX0KnOkqNjYTgkyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzMK95l1XOAO/39MhxmsqsfMgNktjn8skN6//Ml4P68=;
 b=4dsW4fMQSOdHPQVEE8KxzkLgHrpG7fwbaehqVykvdamrY90ouaSlGdAKaFVyuRIVEp701Q
 FiW31dYWmkCJ0SCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzMK95l1XOAO/39MhxmsqsfMgNktjn8skN6//Ml4P68=;
 b=W6iZrc6kZIQwzN8g5Xsdk7t1zA5UEi8MvJE25R4ixPXgWp2cWW3nReEdNNQrmrnJJnF0SC
 0nNkYFMKnXxDoIshGDL+kVOZCqZzok3gP0HtaSX5LHn9ajZP4WH+uFRJiIBuybiRB3WTAf
 ZnixyFsb0AMppQLqX0KnOkqNjYTgkyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzMK95l1XOAO/39MhxmsqsfMgNktjn8skN6//Ml4P68=;
 b=4dsW4fMQSOdHPQVEE8KxzkLgHrpG7fwbaehqVykvdamrY90ouaSlGdAKaFVyuRIVEp701Q
 FiW31dYWmkCJ0SCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2698E138A7;
 Thu, 26 Jun 2025 12:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EIHBB2k+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:40 +0200
MIME-Version: 1.0
Message-Id: <20250626-ioctl_pidfd_suite-v1-3-165b9abf0296@suse.com>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=2771;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2ljZwWTTzecz7iVj77LJsvjpyrqt2pByKIyAkiP1+Uc=;
 b=D+yebmGy1FrpRI4hs+AQo1Vslwzl23+wTR1FYWMLzqozlPhXcEu5MCMkbbtW8S+rIqQNrA0Pj
 Llxg2/deLn/DVeUPjOOBitnMatrmBhSy0CvTkAH/skvMfvnEEWMQ+dC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] Add ioctl_pidfd01 test
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

Verify that ioctl() raises the right errors when an application provides
the wrong file descriptor.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |  2 +
 testcases/kernel/syscalls/ioctl/.gitignore      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 582422ac9ca8ccae598c626a11cf6ee7c30f0e3a..7f6312ce5fa241a778d8dda7f8ee9edd0a8800e6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -612,6 +612,8 @@ ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
+ioctl_pidfd01 ioctl_pidfd01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 53a82bb5770ba196811965150fd262ec5d4a6e01..aa952c1a7bae0ae2dbb04de0595f10d508b6759a 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -29,3 +29,4 @@
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
 /ioctl_fiemap01
+/ioctl_pidfd01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
new file mode 100644
index 0000000000000000000000000000000000000000..dbece2b611ecea2e253bd5e784b196f4e0ee73f2
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ioctl() raises the right errors when an application provides
+ * the wrong file descriptor.
+ */
+
+#include "tst_test.h"
+#include "lapi/pidfd.h"
+#include "lapi/ioctl.h"
+
+static int exp_errnos[] = {
+	EINVAL,
+	EBADF,
+	ENOTTY,
+};
+
+static struct pidfd_info *info;
+
+static void test_bad_pidfd(struct tst_fd *fd_in)
+{
+	if (fd_in->type == TST_FD_PIDFD) {
+		tst_res(TINFO, "Skipping pidfd: SUCCESS");
+		return;
+	}
+
+	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
+		  exp_errnos, ARRAY_SIZE(exp_errnos),
+		  "ioctl(%s, PIDFD_GET_INFO, info)",
+		  tst_fd_desc(fd_in));
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd));
+		test_bad_pidfd(&fd);
+	}
+}
+
+static void setup(void)
+{
+	info->mask = PIDFD_INFO_EXIT;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.min_kver = "6.15",
+	.bufs = (struct tst_buffers []) {
+		{&info, .size = sizeof(*info)},
+		{}
+	}
+};

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
