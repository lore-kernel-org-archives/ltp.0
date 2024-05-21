Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB25C25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:17:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 469A53CFF4A
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:17:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 636C93CEDDC
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C490A1400778
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7926D5BEEB;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyrMOFlKOdeytNlvRxf1+eDf6+eLjF+rcIcvEO7Dcag=;
 b=qwVGx5og4bEkrHOTUSLRMRFRSZYYDitmZtHnSuD/YKcy2XrdTRze++bRCb8AUA7OoDc/Jd
 SeC5D6p9Slk4vVDw2/uSHiFwWhyQICu8maj7pgNFkE9AY2SApxgCN5baDNC/p2TKAq9EOF
 Z33tJ6lgbqtBAmZyEEiJ06RGYDHeVvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyrMOFlKOdeytNlvRxf1+eDf6+eLjF+rcIcvEO7Dcag=;
 b=IcY10Z0/7n5WfW2jI2QyltMC2kk0qOV8YwvI3uUSn9B+YQi/bfR5lIyI/Vx+b3ePsUwecS
 Sh6OE90Iel9FzHDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qwVGx5og;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="IcY10Z0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyrMOFlKOdeytNlvRxf1+eDf6+eLjF+rcIcvEO7Dcag=;
 b=qwVGx5og4bEkrHOTUSLRMRFRSZYYDitmZtHnSuD/YKcy2XrdTRze++bRCb8AUA7OoDc/Jd
 SeC5D6p9Slk4vVDw2/uSHiFwWhyQICu8maj7pgNFkE9AY2SApxgCN5baDNC/p2TKAq9EOF
 Z33tJ6lgbqtBAmZyEEiJ06RGYDHeVvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyrMOFlKOdeytNlvRxf1+eDf6+eLjF+rcIcvEO7Dcag=;
 b=IcY10Z0/7n5WfW2jI2QyltMC2kk0qOV8YwvI3uUSn9B+YQi/bfR5lIyI/Vx+b3ePsUwecS
 Sh6OE90Iel9FzHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52A3613A79;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sGq1EUE8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:30 +0200
MIME-Version: 1.0
Message-Id: <20240521-fchmodat2-v1-4-191b4a986202@suse.com>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
In-Reply-To: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=QOXs+czhnKiaEX/+G+LkPrCvkA2ON3azBKAqBuOhaNw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDxAH5geqj6lb5dXxrkIHkVUetq4kfmgl0Osc
 ZrcSQ53yFCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8QAAKCRDLzBqyILPm
 Ri4VC/sHyKbva8HZv6QaWKGIhMXinKF4xsp7uULlA60Cz5q0z6J/2ld7uEts3dBoiVdhp1QhHfB
 OFy9q+386drNrIitI6bQ9jnkLwdHHu+aRwLFT2Bi9+XqguFAr0yt8CcfoXVfSgwZ9Hoxm/rzjdj
 sJiOb4PvDRZxslbYMXVPqnxkio6CWLuWUSYHHizp9DAUE/55VQr7vO5NER1t/2XX5jkQV7nGCZn
 mWGGMFlfGz12h/hOY3yk4ZiBaCUx5CEGjeVG6Xnlz7ebBckv7XyN+816y3N/IIX3latJRbSfLG6
 1k8TU24KMpSwryOt8wzDFDbrDIETTSmG6DO8ShMc9OBUxkxL6v0TtoE0kTuFUpMeuG9HRq+b8YR
 Yo/BE4+J6ujjU3mu26Z2KZzC0Ss9eicK6V/9s/8izkuR295HBisK5pvgu9qxYzRgeLUUQqeIfpH
 KK2w0LM0uvzgPpkKpRybP+3IyG4EW7ICOp0+yYxIlpvlnVKBzkC/DNDdE3YXLQDRpztCs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7926D5BEEB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add fchmodat2_02 test
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

This test verifies that fchmodat2() syscall is properly working with
AT_SYMLINK_NOFOLLOW on symbolic links.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c | 63 ++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 0a28530ed..c3712da36 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -265,6 +265,7 @@ fchmodat01 fchmodat01
 fchmodat02 fchmodat02
 
 fchmodat2_01 fchmodat2_01
+fchmodat2_02 fchmodat2_02
 
 fchown01 fchown01
 fchown01_16 fchown01_16
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
index 47d5e2427..9f713198c 100644
--- a/testcases/kernel/syscalls/fchmodat2/.gitignore
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -1 +1,2 @@
 fchmodat2_01
+fchmodat2_02
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
new file mode 100644
index 000000000..4afe7f3f9
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall is properly working with
+ * AT_SYMLINK_NOFOLLOW on symbolic links.
+ */
+
+#include "fchmodat2.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mntpoint"
+#define FNAME "myfile"
+#define SNAME "symlink"
+
+static int fd_dir = -1;
+
+static void run(void)
+{
+	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0700, 0));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
+}
+
+static void setup(void)
+{
+	fd_dir = SAFE_OPEN(MNTPOINT, O_PATH | O_DIRECTORY, 0640);
+
+	SAFE_TOUCH(MNTPOINT"/"FNAME, 0640, NULL);
+	SAFE_SYMLINKAT(FNAME, fd_dir, SNAME);
+}
+
+static void cleanup(void)
+{
+	SAFE_UNLINKAT(fd_dir, SNAME, 0);
+
+	if (fd_dir != -1)
+		SAFE_CLOSE(fd_dir);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.6",
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
