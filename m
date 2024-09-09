Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE86ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E24333C19E0
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:04:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 153EE3C0F7B
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5A26460027D
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C23CD1F7AB
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1ijVg4MMEL1MmTTisxy1SeTU0hAjw6M7J4WNmkk0/E=;
 b=ALPvpge+CAqcj2MSz+sTyumLjAPsBGrd+Njr1GzKJtEKkE/hkiRO62JjeN5zbv5CdrttQ5
 3UbF+lZSgVf7DMyAQIAaqQk/fUfz6xZTz0onGD8jbAwrRstxe0G5ystjJPEqxZH9K0ByoN
 YX/50DwXZdMplG61Mfxr8gUeHxs32NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1ijVg4MMEL1MmTTisxy1SeTU0hAjw6M7J4WNmkk0/E=;
 b=H09x0EAsEDgFpEjs/poYhIFugy8tBHVIdCa5uC4N9wmqscsUwQlC64OBJIkuq+voaWFixz
 vsyV99yKOKKVdKDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ALPvpge+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H09x0EAs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1ijVg4MMEL1MmTTisxy1SeTU0hAjw6M7J4WNmkk0/E=;
 b=ALPvpge+CAqcj2MSz+sTyumLjAPsBGrd+Njr1GzKJtEKkE/hkiRO62JjeN5zbv5CdrttQ5
 3UbF+lZSgVf7DMyAQIAaqQk/fUfz6xZTz0onGD8jbAwrRstxe0G5ystjJPEqxZH9K0ByoN
 YX/50DwXZdMplG61Mfxr8gUeHxs32NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1ijVg4MMEL1MmTTisxy1SeTU0hAjw6M7J4WNmkk0/E=;
 b=H09x0EAsEDgFpEjs/poYhIFugy8tBHVIdCa5uC4N9wmqscsUwQlC64OBJIkuq+voaWFixz
 vsyV99yKOKKVdKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5272B13312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6E4OBkXH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:35 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-13-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=3324;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ztu4W0+j+6+6nhkAh5PRQgbJh/sT7A1TaJHTft5TE/o=;
 b=SnhGlM58IXSSV6e3cx0sC0u8eaBAs7JNTWAn6cFL3L32w4nenyMitmyVkWTGky8xGu8t7cYPg
 JYZbkHkTCSHBseQLrHQUq7uU0t94aLAr9n8c5mkhyCHjugrMIUOyQvs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: C23CD1F7AB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 RCPT_COUNT_ONE(0.00)[1];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 13/13] Add statmount07 test
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

This test is verifying that statmount syscall is raising the correct
errors according with invalid input values.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount07.c | 75 +++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 209e04b79..125d8fb00 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1574,6 +1574,7 @@ statmount03 statmount03
 statmount04 statmount04
 statmount05 statmount05
 statmount06 statmount06
+statmount07 statmount07
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index 03a75bd40..b2a55c077 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -4,3 +4,4 @@ statmount03
 statmount04
 statmount05
 statmount06
+statmount07
diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
new file mode 100644
index 000000000..2746bf424
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount07.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is raising the correct errors according
+ * with invalid input values.
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mntpoint"
+
+static struct statmount *st_mount;
+static struct statmount *st_mount_null;
+static uint64_t mnt_id;
+static uint64_t mnt_id_dont_exist = -1;
+static size_t buff_size;
+static size_t buff_size_invalid = -1;
+
+struct tcase {
+	int exp_errno;
+	char *msg;
+	uint64_t *mnt_id;
+	uint64_t mask;
+	unsigned int flags;
+	size_t *buff_size;
+	struct statmount **buff;
+} tcases[] = {
+	{ENOENT, "mount id doesn't exist'", &mnt_id_dont_exist, 0, 0, &buff_size, &st_mount},
+	{EOVERFLOW, "invalid mask", &mnt_id, -1, 0, &buff_size, &st_mount},
+	{EINVAL, "flags must be zero", &mnt_id, 0, 1, &buff_size, &st_mount},
+	{EFAULT, "invalid buffer size", &mnt_id, 0, 0, &buff_size_invalid, &st_mount},
+	{EFAULT, "invalid buffer pointer", &mnt_id, 0, 0, &buff_size, &st_mount_null},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_FAIL(statmount(*tc->mnt_id, tc->mask,
+		*tc->buff, *tc->buff_size, tc->flags),
+		tc->exp_errno, "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+
+	mnt_id = sx.data.stx_mnt_id;
+	buff_size = sizeof(struct statmount);
+}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
