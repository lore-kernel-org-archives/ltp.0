Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89405C3DA70
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:13:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FEFA3D1CCC
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:13:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E47203CBC79
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:13:09 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 75F80601018
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:13:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0743521A77;
 Fri, 26 Jul 2024 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721999587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96Hs2fXQ3M3zdlXtMDXm8+9g53nnhcKBs6HQu0Q86YU=;
 b=bZrwkptWKIJCh/+89pJo7jt39EP+nT3rHpatnW6DOphXGR/qIOYxazBG71u/nXelcOjcqw
 QUytIj8SsJlXGPtmcxqtloDS2u0tZEBz6ueottf9i5ixYZTXrCN3vDln07y7usFihe+rVg
 UjnPBS7Z9KI99CcRgOEL9uLa5o14VW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721999587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96Hs2fXQ3M3zdlXtMDXm8+9g53nnhcKBs6HQu0Q86YU=;
 b=3xyeGOzIA6w1il1f+HXA4EFnDrcASvKaExzXuGJBDKOqMu8kpnII92zaHDLp/rVmecM1R2
 5pr+1L1lAAishVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721999586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96Hs2fXQ3M3zdlXtMDXm8+9g53nnhcKBs6HQu0Q86YU=;
 b=hkX1txL5ifKWHhu5htsPcSGnRTICFe7r/QALkj673hMLqqVdXQSgmuhL4vquAvn5iaQ7Mk
 wGEHN7raaCZJxYQIktvhs5hsMeyO1ZvIGanoAj8osaFHdrWW/9lYwb19O8wsQfIdEJMPS7
 r+DR/PUFL/hkmnVGjWRY4LHXhQ2V6rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721999586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96Hs2fXQ3M3zdlXtMDXm8+9g53nnhcKBs6HQu0Q86YU=;
 b=QzADByWGlJJPpH/K03RJVWkXnzfpBFVOibjd/SLn9lw3bRSLGrQQZ6HfUzgRewKFDeQhsQ
 6vWaeW9j90eGT6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D66D9138A7;
 Fri, 26 Jul 2024 13:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4hCaMeGgo2Z1CgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 26 Jul 2024 13:13:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 26 Jul 2024 15:12:39 +0200
MIME-Version: 1.0
Message-Id: <20240726-ioctl_ficlone-v4-1-710ed71bee70@suse.com>
X-B4-Tracking: v=1; b=H4sIAMago2YC/13M0QqCMBTG8VeRXbc423Euu+o9IkLnWQ7KxWZSi
 O/elCDx8vvg9x9ZpOAosmM2skCDi853aeS7jJm26m7EXZM2kyBzULLkzpv+frXO3H1HvFSmALR
 aNApZMs9A1r2X3vmSduti78NnyQ9ifn8lhE1pEBy4rcrCgm7AmuoUX5H2xj/YHBrkH2uJWywTR
 gSt6toIoe0G4xrnW4xc8LqxWimBByBa4WmavpyyehMjAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=5YKl8nEnKrMe2JZqoKIh9ZIH8Xwjq1J9vsOd2m4MiiM=;
 b=kA0DAAgBy8wasiCz5kYByyZiAGajoMijC2RbAq4Ps+zgbb4bFR4cFjQeSfhR+4j3oNjyyALGw
 okBswQAAQgAHRYhBPXKwXNQpFbSwhvf2MvMGrIgs+ZGBQJmo6DIAAoJEMvMGrIgs+ZG0lgL/3tH
 680A1aPXADHbt+ZMj3oJxF5dPGJuzpKnNhQIM4aGj026AEAaJGsmfKhhPLZPmAFNbe0woWiDINn
 Mu3+WSa7Oq+cZd8EvtRuDYmClXIw1b03qwrqrN9FOdgCAtWKy8CsTNeH6zsppfrWN3uj+TogVWr
 KZcFxStoMt4XD6nqS73JxjehP9NSg1k1fGqnkTHa0/hRcrxMzqEg6+kKl0tzmhXLsvUsXoniKOY
 He7qBj0rvICXJTTSSZD2shHSfofSmWX3tn/d14DABMj/EPYvqf3QwmSlaONsl6UMjrfucWaKLc5
 1AYC2KlqvqXPeZNsaSs6vkwa0W9EY4wqQyAMgrtObgBkYomG/zg9eSYXEnaXDeo+FfXogZlVtb0
 ChgOb35aEQTiLxiga6h28mdBxZe6875ogZkZzJmbQRua2wqIOamylmlKfN1ryYVPZ6rPHEIXtyW
 tOBUu/AyuTiU2lflcNQPICfnrijvNPsJaYMQjtnTUvFv3CGmdeGQRRJLRiQw==
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add ioctl_ficlone04 test
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
index 000000000..b7711ac30
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -0,0 +1,52 @@
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
+#include "lapi/ficlone.h"
+
+static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
+{
+	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
+		tst_res(TCONF, "Skipping file: SUCCESS");
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
base-commit: eee3b2dd6d9dae6120646bc14c30e460989d7df6
change-id: 20240529-ioctl_ficlone-95c603f71d53

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
