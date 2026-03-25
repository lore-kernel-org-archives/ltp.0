Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663021093176
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 14:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA313E552F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:19:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352343E2FED
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80577602156
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD204D24C;
 Wed, 25 Mar 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReMdblYJN7A8qt/5tEzOIi7nXDRi7jDvU9P6NrlVoLY=;
 b=uzOJW7nWUhTq3Nj1ZK26pxwYC73lcZcuR0e0AmC8WuNYI/CWyw8Ru0C7KgoW51ecv0TYqN
 a0s+oXap8zvrYiL2FZfZJoPmcPE2fd8lWaybTSmcfnaPvsrXAQz7qRmw5GKsMn8S7rFUVJ
 5K+vlpNsiXqhUVkSehinUEpM+JFxmL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReMdblYJN7A8qt/5tEzOIi7nXDRi7jDvU9P6NrlVoLY=;
 b=fxWwh0ydlaUoj8Bv2HXkOk+qOZ49ETyJMN+ysHXGbdWvNg5WXf6BZoXIliufbvQzESvxLH
 zQ8JZtMD8Zuy55DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0+9yOEO1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UGrIp9tF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReMdblYJN7A8qt/5tEzOIi7nXDRi7jDvU9P6NrlVoLY=;
 b=0+9yOEO1eiz+iYGVH6MAp6+fvYP0+t9hQW3V43qDnbrc8Afix6d/nZUD7o7SWOGtIh0uhq
 1iGIiiU1E7deXD82K0JrzY3XyU4iShRexh1JgayspvzjWS8GjM81npn49/dpQ/cXHcU30G
 chY+nnpkFTpigLiX1OEjCVPZRQgrDPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReMdblYJN7A8qt/5tEzOIi7nXDRi7jDvU9P6NrlVoLY=;
 b=UGrIp9tFcl1Hb2KHcYGYlaLReP1xlT2vob8Ux3Byw5E3rkPHTEE2odpwRzISnJ4Yx6Upa3
 q5xmK81fhMZcbfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 467D644441;
 Wed, 25 Mar 2026 14:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oBF2D+Duw2nQPQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 14:19:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 15:19:11 +0100
MIME-Version: 1.0
Message-Id: <20260325-ioctl_getlbmd01-v1-2-00dc526e326f@suse.com>
References: <20260325-ioctl_getlbmd01-v1-0-00dc526e326f@suse.com>
In-Reply-To: <20260325-ioctl_getlbmd01-v1-0-00dc526e326f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774448351; l=4136;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=cg8VeVDI8wCZ/yr2HZjao+XKWM9bInwz+oLjHA5xgjM=;
 b=E6z8HzhFUysn1q4hznMhAfC+JBXJs3zPyhPI5rLoGllDa49tMrRcNMoVFN59QD9TA8qvCJmbQ
 0Fzdqk6NTW2AEIvGhcne19EbG83gQLHVG9/rIH8ghHAelsln+o+r/UD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6AD204D24C
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add new test ioctl_getlbmd01
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

Verify :manpage:`ioctl(2)` with FS_IOC_GETLBMD_CAP on block devices.

- fill struct logical_block_metadata_cap with non-zero pattern, call
  FS_IOC_GETLBMD_CAP on a block device without integrity support
  and verify the kernel zeroed out all fields
- call FS_IOC_GETLBMD_CAP on a regular file and verify it fails
  with ENOTTY

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_getlbmd01.c | 84 +++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a87f30e68e473c9019a6e6acc224738d9..e94a9cb58a1563dc15f26a16db480c8cac468375 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -624,6 +624,8 @@ ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
 ioctl_fiemap01 ioctl_fiemap01
 
+ioctl_getlbmd01 ioctl_getlbmd01
+
 ioctl_pidfd01 ioctl_pidfd01
 ioctl_pidfd02 ioctl_pidfd02
 ioctl_pidfd03 ioctl_pidfd03
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index dac4583fa7c05a4cdd937e86bd8f935dd15aebc8..63765dea61a795aac01e5b6b14996e441b56d3e3 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -30,6 +30,7 @@
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
 /ioctl_fiemap01
+/ioctl_getlbmd01
 /ioctl_pidfd01
 /ioctl_pidfd02
 /ioctl_pidfd03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_getlbmd01.c b/testcases/kernel/syscalls/ioctl/ioctl_getlbmd01.c
new file mode 100644
index 0000000000000000000000000000000000000000..56622977fa949e47ffaaf7403e1f266768366878
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_getlbmd01.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify :manpage:`ioctl(2)` with FS_IOC_GETLBMD_CAP on block devices.
+ *
+ * - fill struct logical_block_metadata_cap with non-zero pattern, call
+ *   FS_IOC_GETLBMD_CAP on a block device without integrity support
+ *   and verify the kernel zeroed out all fields
+ * - call FS_IOC_GETLBMD_CAP on a regular file and verify it fails
+ *   with ENOTTY
+ */
+
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+static int dev_fd = -1;
+static int file_fd = -1;
+
+static struct logical_block_metadata_cap *meta_cap;
+
+static void run(void)
+{
+	memset(meta_cap, 0xff, sizeof(*meta_cap));
+
+	TST_EXP_PASS(ioctl(dev_fd, FS_IOC_GETLBMD_CAP, meta_cap),
+		"FS_IOC_GETLBMD_CAP on block device");
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LU(meta_cap->lbmd_flags, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_interval, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_size, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_opaque_size, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_opaque_offset, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_pi_size, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_pi_offset, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_guard_tag_type, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_app_tag_size, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_ref_tag_size, 0);
+	TST_EXP_EQ_LU(meta_cap->lbmd_storage_tag_size, 0);
+
+	TST_EXP_FAIL(ioctl(file_fd, FS_IOC_GETLBMD_CAP, meta_cap), ENOTTY,
+		"FS_IOC_GETLBMD_CAP on regular file");
+}
+
+static void setup(void)
+{
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDONLY);
+
+	SAFE_TOUCH("testfile", 0644, NULL);
+	file_fd = SAFE_OPEN("testfile", O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+
+	if (dev_fd != -1)
+		SAFE_CLOSE(dev_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_device = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.min_kver = "6.17",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_BLK_DEV_INTEGRITY=y",
+		NULL,
+	},
+	.bufs = (struct tst_buffers[]) {
+		{&meta_cap, .size = sizeof(*meta_cap)},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
