Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C776DC3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 20:02:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84D483D1C4F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 22:02:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446FA3D0895
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 22:02:41 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39E3020118B
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 22:02:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FFD821998;
 Wed, 24 Jul 2024 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721851358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UpyhWv6/q1DfqiOm8ckuXgWF46Ac5Ebfa9ZGbVIlvc=;
 b=L2X4t3AMy+fK64drmxidNZf5D9IuDji8AniBbWfaD4ubqjbfDZFHguSfSGdTArOkquQftB
 AZuRUA+CEOow0/4P9veXHubelKzgZkX1f9XcN0y4FgZ1tTNtc32Kce9y5nlTa+dD/P8x7d
 tETcNohAazLDbqAiGRZ3id1QqxHaAiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721851358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UpyhWv6/q1DfqiOm8ckuXgWF46Ac5Ebfa9ZGbVIlvc=;
 b=WA00eBWUm6mKvibe6TO5XJofqpobcctUTN3dlWRVvyrAmT5TyrAPWntuoQc8BjfqtKafrQ
 Ouitk39ViH+GxoDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L2X4t3AM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WA00eBWU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721851358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UpyhWv6/q1DfqiOm8ckuXgWF46Ac5Ebfa9ZGbVIlvc=;
 b=L2X4t3AMy+fK64drmxidNZf5D9IuDji8AniBbWfaD4ubqjbfDZFHguSfSGdTArOkquQftB
 AZuRUA+CEOow0/4P9veXHubelKzgZkX1f9XcN0y4FgZ1tTNtc32Kce9y5nlTa+dD/P8x7d
 tETcNohAazLDbqAiGRZ3id1QqxHaAiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721851358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UpyhWv6/q1DfqiOm8ckuXgWF46Ac5Ebfa9ZGbVIlvc=;
 b=WA00eBWUm6mKvibe6TO5XJofqpobcctUTN3dlWRVvyrAmT5TyrAPWntuoQc8BjfqtKafrQ
 Ouitk39ViH+GxoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 548DB1324F;
 Wed, 24 Jul 2024 20:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zi8GEd5doWaKewAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 24 Jul 2024 20:02:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 24 Jul 2024 22:02:11 +0200
MIME-Version: 1.0
Message-Id: <20240724-ioctl_ficlone-v3-1-bdf7551380ee@suse.com>
X-B4-Tracking: v=1; b=H4sIAMJdoWYC/13M0QqCMBTG8VeRXbc425rDrnqPiNB5lgfMxWajE
 N+9KUHh5ffB/zexiIEwsmMxsYCJIvkhD7UrmO3q4Yac2ryZBHkALStO3o791ZHt/YC80rYE5Yx
 otWK5eQR09Fq98yXvjuLow3vlk1jer6RgIyXBgbu6Kh2YFpytT/EZcW/9nS1Qkr/YSLWNZY6VA
 qObxgph3F88z/MHV9IUQ+YAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=WlVSvEEeeP9erNQwWSUptBJhjlKSOPH1L5h7CTH6ZFs=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmoV3F6Fg9fLS/Z6kiSzfRCsV26WBsVY3XRbmNR
 Aeo5y6l+L+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqFdxQAKCRDLzBqyILPm
 RrG2DACjzXDVNOL3xUZ5jAVLDBUxc8bTA4aabJfWuefmMTWlu/pMLzWk1N3qmd1VvG16r2h/xmv
 kpM/sKhnFQTJ7+9sFXR96OWvBZsdS55I0gElG8frRZOC9Pezs6vcKrt+O3HjlOw9ZNTwnJkDlVW
 9PkGfOITYszkjLdwSFG90sokktTWAzn/SLGR695uY60ARp581XF7ScEuBiIX6/4pB0+P8S44owO
 5xyENgKvqI2GdOkSbzNKbHqD8Qir3kNCT1HCBYP92q1Ff0cu6mWOrq0saosQIxooYvqr3Fxaq6z
 aNwLJFDx4myY1ECnJKYJeQtGzZV0FBQlN2emfRekcM2YIsZUpS2VJBGVk+mmc+voSdCiuA+SxYz
 wfJvNNBgXZMmrGqrX2sI+MxZlRCK8j3dwrqjeAg1i2VqJ8JGvIhVkGZ7f6baSQ/0FSZYVlhJ/N6
 79MaaoLAXouR447hSLO8UcUaZqlmTdY0h6TpFv+SUaaK2jcVKICqdyS1ZhGNFn19S293A=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8FFD821998
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add ioctl_ficlone04 test
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
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies that ioctl() FICLONE/FICLONERANGE feature raises
the right error according with bad file descriptors.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This testing suite is testing ioctl() FICLONE and FICLONERANGE
functionalities. In particular, file clone and error codes.
---
Changes in v3:
- ioctl_ficlone04: use a generic array for expected errors
- Link to v2: https://lore.kernel.org/r/20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com

Changes in v2:
- add fallback definitions
- algorithm steps using '-'
- avoid assigning -1 to file descriptors after close()
- use SAFE_UNLINK() instead of remove()
- enable both xfs and btrs for all tests
- Link to v1: https://lore.kernel.org/r/20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com
---
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c | 55 +++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 9f995b1ad..1f099ff95 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -25,5 +25,6 @@
 /ioctl_ficlone01
 /ioctl_ficlone02
 /ioctl_ficlone03
+/ioctl_ficlone04
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
new file mode 100644
index 000000000..8420c269c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE/FICLONERANGE feature raises the right
+ * error according with bad file descriptors.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
+{
+	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
+		tst_res(TCONF, "Skipping file: SUCCESS");
+		return;
+	}
+
+	if (fd_src->type == TST_FD_MEMFD && fd_src->type == fd_dst->type) {
+		tst_res(TCONF, "Skipping memory: EOPNOTSUPP");
+		return;
+	}
+
+	int exp_errnos[] = {
+		EISDIR,
+		EBADF,
+		EINVAL,
+		EXDEV,
+	};
+
+	TST_EXP_FAIL2_ARR(ioctl(fd_dst->fd, FICLONE, fd_src->fd),
+		exp_errnos, ARRAY_SIZE(exp_errnos),
+		"ioctl(%s, FICLONE, %s)",
+		tst_fd_desc(fd_src),
+		tst_fd_desc(fd_dst));
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd_src) {
+		TST_FD_FOREACH(fd_dst)
+			test_bad_fd(&fd_src, &fd_dst);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};

---
base-commit: c68112b0774bf4f13bfb7b121ecc6671d15d133e
change-id: 20240529-ioctl_ficlone-95c603f71d53

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
