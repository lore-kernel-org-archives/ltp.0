Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB40C27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:41:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FA713D09A3
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 16:41:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B350D3D0982
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:18 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 099CE201169
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 896B21F825;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=umM9K0eHzLdNCoZaO2vMhQYswDJ/1lAklSOK6hTih5GmWgSjF6HZHIWvF/nHEE5+f1qsQK
 BIHDLcFeaIjvas1cuZyC1DepFURMv7DmR9OR3MS86Y8udwP39MNY2O8SFTP5LBuxfj7a8R
 P1lGmPYbzSCHoYWA8r7JvmdjFDdsK/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=Wdt6VSIonujpEJ1LMNYuMHzf4g/N/PUybGj8+UzZrjpEp7L+5G4078urgNJy7vgTDid5Nl
 9RHwpuJypxNaKcDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=eJJt2O6SjLj3htGk8vP8HeEyz7kphg84c2oxcmoUThsoPyHcDBG3+MTQXOGxC7pq7MiXtB
 EyX9WXuEeiWXavDYLltWLaiM9fAu6qM4lfkZ/BALGTZrxoo8mh5Keg+S7jQ+l7bIChE3Zn
 5BN/86IZ7prvEG5snHeF2tdFVrQ/4a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=6AUeeqyLNaGifPO9kt5UacRGQZM4+m4lHY1yB23uDaUdvmPyfBJCCl9lhQSzGLKBb51pAS
 I/S7Pe/9VjfR/MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE2A13A99;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aGSIGQt5YGY/NwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Jun 2024 14:41:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Jun 2024 16:40:39 +0200
MIME-Version: 1.0
Message-Id: <20240605-unlink09-v2-2-bfa0bbdc8753@suse.com>
References: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
In-Reply-To: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=0oFVU3Zed+tKZVs6LpNgxrPXnWT4ukMfqZ9kVTbqd0I=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYHkLtvsHqosJL420s+Q8g8JaKsPETWB7cAJpz
 oMubhzzsreJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmB5CwAKCRDLzBqyILPm
 RnQCDACytD1WTiMX167dJqNC6kT+gjDNafhLSEu314Sj0x6fGpnWD+G1fD+IUxKtSe8C1+TtZ9Y
 aqbaytCyXprAvUpCIVbNSWst+kxyoKSLhYI1dHlR4Z4sgbewgmFEiJDOha64/jOwZdIZxbeb9Xx
 6A9pX5SJQZ6ySzeb0Lq75U3iYRTOs/byrfZ24RdWZg+u41qsGT+9gGLOa9890mQKK+BqPkC77q/
 5Et8DWk+6MxJcnug6EJRGCz6wNxB5Hg/+pisJJfMDncRzwmt0sopAZ+uOpAAjtOxLnZFvotWia/
 ZfrLVUeqQ6LbALPN60ARaqv//aJJyjwEJ40XUveWustAmb6+M0mZaKaAd5L1K7So5fRkhHA49UQ
 Bi2QZQkEYwOvm/8BOl41xl9Wm9t9ZJVNsMracC3xVBMidC8Wet9YxV7rPKyD5JQQxZNC6LkO8ab
 VI2Dnduaak8J78+0l6IumXSfAKVfqOJ4ESg/6jZYUZQw1KmIvq4uI03miJ/GpNIuL+h5Y=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Add unlink10 test
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

This test verifies that unlink(2) fails with EROFS when target file
is on a read-only filesystem.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/unlink/.gitignore |  1 +
 testcases/kernel/syscalls/unlink/unlink10.c | 33 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..b59b64314 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1655,6 +1655,7 @@ unlink05 unlink05
 unlink07 unlink07
 unlink08 unlink08
 unlink09 unlink09
+unlink10 unlink10
 
 #unlinkat test cases
 unlinkat01 unlinkat01
diff --git a/testcases/kernel/syscalls/unlink/.gitignore b/testcases/kernel/syscalls/unlink/.gitignore
index 6038cc29d..4fc24059a 100644
--- a/testcases/kernel/syscalls/unlink/.gitignore
+++ b/testcases/kernel/syscalls/unlink/.gitignore
@@ -2,3 +2,4 @@
 /unlink07
 /unlink08
 /unlink09
+/unlink10
diff --git a/testcases/kernel/syscalls/unlink/unlink10.c b/testcases/kernel/syscalls/unlink/unlink10.c
new file mode 100644
index 000000000..861f24a50
--- /dev/null
+++ b/testcases/kernel/syscalls/unlink/unlink10.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that unlink(2) fails with EROFS when target file is on a read-only
+ * filesystem.
+ */
+
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "erofs"
+#define FILENAME MNTPOINT"/file"
+
+static void run(void)
+{
+	TST_EXP_FAIL(unlink(FILENAME), EROFS,
+		"%s", "target file in read-only filesystem");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_rofs = 1,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
