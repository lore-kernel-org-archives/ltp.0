Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C79C87FCB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:11:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E62853CCFDD
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:11:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6B343CCFB8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2AA5D6006F5
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1020F21A96;
 Mon,  4 Aug 2025 18:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=ziPDmW4S4mwGAF8jEbgO+LbS/AbIwmXo2ROEkolaCUmDIQMUAk9Qr4Mv+28Q7luSFiHSrd
 A4cdUXssK6S85p/SB/5oTvZel02frpzbmfKoVkCe+9VpOuDQZctcZ/O4KpE/L81v8vhnUe
 kMG2rd9d95y11jlxzEVYZfweV1B+L2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=LNj1Ci8iThnhm6SG+VI/9xY1lBx/1kYbWkbj39ho5g9Op6ETTjun9IpOxg8OYi/4XMlMjL
 k+pkt8nudKg4V7Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ziPDmW4S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LNj1Ci8i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=ziPDmW4S4mwGAF8jEbgO+LbS/AbIwmXo2ROEkolaCUmDIQMUAk9Qr4Mv+28Q7luSFiHSrd
 A4cdUXssK6S85p/SB/5oTvZel02frpzbmfKoVkCe+9VpOuDQZctcZ/O4KpE/L81v8vhnUe
 kMG2rd9d95y11jlxzEVYZfweV1B+L2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=LNj1Ci8iThnhm6SG+VI/9xY1lBx/1kYbWkbj39ho5g9Op6ETTjun9IpOxg8OYi/4XMlMjL
 k+pkt8nudKg4V7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC69D133D1;
 Mon,  4 Aug 2025 18:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2KMPM1j3kGjyJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:09:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:09:24 +0200
MIME-Version: 1.0
Message-Id: <20250804-file_setattr_getattr-v1-6-6a43c3962c87@suse.com>
References: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
In-Reply-To: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754330967; l=3686;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=u3ao1eikKUsufts+U2g6t27tkno62ZwdcIMy2JJ9oD0=;
 b=IqbYrgDq/OxmtnK78uChPFQZgEMxoTvti7dn0ZUspB7AX7MxaRPG4d6wz+x8v+Jfdie+FECOT
 sKlhSbMUOR2BPb+hGn4xWFzCwJf4UGSlxXqnffeY8egkh0sT46iZAN0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 1020F21A96
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] Add file_attr03 test
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

Verify that `file_setattr` is correctly setting filesystems additional
attributes. We are running test on XFS only, since it's the only filesystem
currently implementing the features we need.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr03.c | 81 +++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b69e474a6a596359bb1ace30312b55d6bf2b65cc..c33987328d3d6ec96660260aaee4f9ca8c4f0aee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -248,6 +248,7 @@ fsetxattr02 fsetxattr02
 
 file_attr01 file_attr01
 file_attr02 file_attr02
+file_attr03 file_attr03
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index afe9c2fc9a4218dc032f044c1d317355a784a525..b79a340b733f7407dc135c5c3b0a9cd0e003e6c9 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -1,2 +1,3 @@
 file_attr01
 file_attr02
+file_attr03
diff --git a/testcases/kernel/syscalls/file_attr/file_attr03.c b/testcases/kernel/syscalls/file_attr/file_attr03.c
new file mode 100644
index 0000000000000000000000000000000000000000..3ee97377db402ef09e6bcd04d482428f9f13deb1
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr03.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_setattr` is correctly setting filesystems additional
+ * attributes. We are running test on XFS only, since it's the only filesystem
+ * currently implementing the features we need.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include <linux/fs.h>
+
+#define MNTPOINT "mntpoint"
+#define FILENAME "ltp_file"
+#define BLOCKS 1024
+#define PROJID 16
+
+static int fd = -1;
+static int dfd = -1;
+static int block_size;
+static struct fsxattr xattr;
+static struct file_attr *attr;
+
+static void run(void)
+{
+	dfd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
+	fd = SAFE_CREAT(MNTPOINT "/" FILENAME, 0777);
+
+	TST_EXP_PASS(file_setattr(dfd, FILENAME, attr, FILE_ATTR_SIZE_LATEST, 0));
+	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
+	SAFE_CLOSE(dfd);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_EQ_LI(xattr.fsx_xflags & FS_XFLAG_EXTSIZE, FS_XFLAG_EXTSIZE);
+	TST_EXP_EQ_LI(xattr.fsx_xflags & FS_XFLAG_COWEXTSIZE, FS_XFLAG_COWEXTSIZE);
+	TST_EXP_EQ_LI(xattr.fsx_extsize, BLOCKS * block_size);
+	TST_EXP_EQ_LI(xattr.fsx_cowextsize, BLOCKS * block_size);
+	TST_EXP_EQ_LI(xattr.fsx_projid, PROJID);
+
+	SAFE_UNLINK(MNTPOINT "/" FILENAME);
+}
+
+static void setup(void)
+{
+	block_size = tst_dev_block_size(MNTPOINT);
+
+	attr->fa_xflags |= FS_XFLAG_EXTSIZE;
+	attr->fa_xflags |= FS_XFLAG_COWEXTSIZE;
+	attr->fa_extsize = BLOCKS * block_size;
+	attr->fa_cowextsize = BLOCKS * block_size;
+	attr->fa_projid = PROJID;
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	if (dfd != -1)
+		SAFE_CLOSE(dfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.filesystems = (struct tst_fs []) {
+		{.type = "xfs"},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
