Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30EBC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:26:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B053D1F29
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:26:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFBD3CF09B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:26:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB8FC1401260
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:26:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00CAD1FB4C;
 Thu,  1 Aug 2024 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2H1cSoQU1hfBROJv0eb7iQOqaV70GrXDKfQdrvydfJU=;
 b=WDTijRb+WsfRNocbjoFAvoTzVDlkxWikUcNtQjFpApIYkkN6nWTjGlC7oQcOPCTPP9TSbX
 aohDV147JVAcZXGAFTckYIbuY3Q6POMGjb7FcsQEHDYLP7i4jCqJvv1i0L2f6BNMQtfP4V
 3s4p2HujPzlJcvhQIx6VHm/wt/OVSho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2H1cSoQU1hfBROJv0eb7iQOqaV70GrXDKfQdrvydfJU=;
 b=ZpZnVxb1IHGouyD9zGglZyBfZ+Y2Vdwctqp+p+YpHvyVYE1hkVfHYyPwhWkHEF3IRTJrvZ
 bDZArB5gJPAagSBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WDTijRb+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZpZnVxb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2H1cSoQU1hfBROJv0eb7iQOqaV70GrXDKfQdrvydfJU=;
 b=WDTijRb+WsfRNocbjoFAvoTzVDlkxWikUcNtQjFpApIYkkN6nWTjGlC7oQcOPCTPP9TSbX
 aohDV147JVAcZXGAFTckYIbuY3Q6POMGjb7FcsQEHDYLP7i4jCqJvv1i0L2f6BNMQtfP4V
 3s4p2HujPzlJcvhQIx6VHm/wt/OVSho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2H1cSoQU1hfBROJv0eb7iQOqaV70GrXDKfQdrvydfJU=;
 b=ZpZnVxb1IHGouyD9zGglZyBfZ+Y2Vdwctqp+p+YpHvyVYE1hkVfHYyPwhWkHEF3IRTJrvZ
 bDZArB5gJPAagSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD11E13946;
 Thu,  1 Aug 2024 12:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b1NcL+N+q2ZPXQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:26:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:26:07 +0200
MIME-Version: 1.0
Message-Id: <20240801-ioctl_ficlone-v5-1-ab44ee1d8709@suse.com>
X-B4-Tracking: v=1; b=H4sIAN5+q2YC/13M0YrCMBCF4VeRXG9kJtN0tl75HiJLm0zWgNtIo
 8VF+u5GWdiSy3Pg+x8qyxQlq93moSaZY45pLMN+bJQ79eO36OjLVgZMA9Z0OiZ3PX+F6M5pFN1
 Z1wIFRm9JFXOZJMT7u3c4ln2K+Zqm33d+xtf7VyKoSjNq0KHv2gDsIbh+n29Zti79qFdoNv+YD
 dXYFEwEbIfBIXKoMK1xU2PSqAcf2FqkTxCpcLPGbY2bghlBPOMgwrDCy7I8AQU8idNgAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3231;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Scw1y6nkOrpaNRMTpjaAhCqVJDRJtTyDCpZqUzmsIZw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq37fTKWLHNXaFfbSmq3KnucF/rq2XYtkJAFaS
 Vg+DShZ1oqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt+3wAKCRDLzBqyILPm
 RlI8C/0eRpjzMcvR2KmxfXLk4fEh2HlocTNHP4zhDGt0jjJNES5GDaUVqO2SBr63L/32tzVF4Gu
 GmKtWI4yhXTek5hB1gHRwyIGZhE2blsqNdD5s93OKcBvw1kMyG5BsEJvcgOKXFskR6n+uy722+U
 4HOIm2CHfba6Ug08DzYyFDh12r3ez3EjWZJoV2RLOtirqDiLtiO3YSaxIqAH8tPHitVEpr4aWyl
 4kfWzMgvqtHYdXdnFPhxT1/37lkkRnzdZQZtZnjqePG32Fsis4a8U5p2t1h6vO9c059PPh6qcZQ
 t4zGoSeDcgriXDrRLUJTi+CW2Wl1JMEY1B9F3AnVtKf3ot8Co+8m3ehQNL72kb4dMvsh6i55etD
 V45x7/d5dGBFzbM7wv5dK+G00i9eM9ZRnpc3ZXNBq/DYxkaJ/GVhM4VdDkmg5bTkorakC5xO4+d
 p3nrwxFH3HIMoVzqvvBExqBYRBj0/07C3j6zi57+TGhhhnsasH9fxml1508zYIwlh3U6M=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 00CAD1FB4C
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Add ioctl_ficlone04 test
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

This test verifies that ioctl() FICLONE/FICLONERANGE feature raises
the right error according with bad file descriptors.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This testing suite is testing ioctl() FICLONE and FICLONERANGE
functionalities. In particular, file clone and error codes.
---
Changes in v5:
- ioctl_ficlone04: TINFO on skip message, fix mail between <>
- Link to v4: https://lore.kernel.org/r/20240726-ioctl_ficlone-v4-1-710ed71bee70@suse.com

Changes in v4:
- ioctl_ficlone04: add EPERM and EOPNOTSUP
- Link to v3: https://lore.kernel.org/r/20240724-ioctl_ficlone-v3-1-bdf7551380ee@suse.com

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
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c | 52 +++++++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index 000000000..1dcf4f05c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
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
+#include "lapi/ficlone.h"
+
+static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
+{
+	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
+		tst_res(TINFO, "Skipping file: SUCCESS");
+		return;
+	}
+
+	int exp_errnos[] = {
+		EOPNOTSUPP,
+		EPERM,
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
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240529-ioctl_ficlone-95c603f71d53

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
