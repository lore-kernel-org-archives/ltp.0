Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580BACEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E50353C1C42
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:46:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224543C178C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:42 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 35A931401713
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 942AC21A32;
 Tue,  8 Oct 2024 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xu8UDStoIsaBfF4paY4rIP5ZCyDpW3jsWGxiOtiFUo=;
 b=Dz0k8B3Mi3SXVnHwG9ySBZ68Gk6qJewQqBxfV6OjuFjPp4Eck2MBGSTvwCRyieMJkyfT1t
 /hY1TSNUc/UJRxezLU+Se/uSSKGM2rL53zawO0CU3klUufaBi2KsevApQbJ2P4wPo0zGXO
 ZVdNs4zxlkEgDpz/+mccIgm/ay1Egx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xu8UDStoIsaBfF4paY4rIP5ZCyDpW3jsWGxiOtiFUo=;
 b=9tKG9ccBpuoz5v9NC2qX4CC7+AK0Sb27h/O6c31xOxU+zftYi4udq2E81KiCAwxitj7dr9
 Q/gibV/pa29+wRDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dz0k8B3M;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9tKG9ccB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xu8UDStoIsaBfF4paY4rIP5ZCyDpW3jsWGxiOtiFUo=;
 b=Dz0k8B3Mi3SXVnHwG9ySBZ68Gk6qJewQqBxfV6OjuFjPp4Eck2MBGSTvwCRyieMJkyfT1t
 /hY1TSNUc/UJRxezLU+Se/uSSKGM2rL53zawO0CU3klUufaBi2KsevApQbJ2P4wPo0zGXO
 ZVdNs4zxlkEgDpz/+mccIgm/ay1Egx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xu8UDStoIsaBfF4paY4rIP5ZCyDpW3jsWGxiOtiFUo=;
 b=9tKG9ccBpuoz5v9NC2qX4CC7+AK0Sb27h/O6c31xOxU+zftYi4udq2E81KiCAwxitj7dr9
 Q/gibV/pa29+wRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F12913A6E;
 Tue,  8 Oct 2024 09:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mPJSCY/+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 09:42:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:42:06 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-13-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=3369;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=lscR25OvpMqDtPityOvo0OeLv3rKLz8S0liaFaPm80Q=;
 b=jfIyNK7Z8plgCcFxqyvOQPeQr497tfGTjXBq+wxf7vsWry6nqzBDS/8F5bsQP4Dw5N6q4wd0W
 1Jx/op7QyFgDhX5lgY5GKbNQKFKot389sQjBPnPmV82QQtQ1fInuV1Y
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 942AC21A32
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.cz:email,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 13/16] Add statmount07 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount07.c | 75 +++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a742e405b..bf222e466 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1580,6 +1580,7 @@ statmount03 statmount03
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
