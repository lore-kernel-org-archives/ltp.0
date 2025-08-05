Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E723C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 07:04:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F3983C7423
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:04:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B340E3C19EB
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:02:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FE451000D22
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBF9E1F441;
 Tue,  5 Aug 2025 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=kHNknxVXOYk7i0RrIuD3lzpu0F25kkgzoAwNvuupTEg8EJMrZC7jKdUht9AH+T0tEEVn4Y
 hkv6doy1o1FVcvLl6KHJX6rk5f3epIi2wCaGa/T8hnVYd/P++033PiKuzYRbIti5RjxT/P
 YRMeQthlc1skhOsMdMPSrybg+yOnVtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=/LjwLrk4Eo3jAI+Ga3r8YP6IM2gRxRT9huE8wBnPJBrqP2a9UJv60nb/RLJ3TBZhO9CQa8
 8yyb99ZvQaOkNEDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=kHNknxVXOYk7i0RrIuD3lzpu0F25kkgzoAwNvuupTEg8EJMrZC7jKdUht9AH+T0tEEVn4Y
 hkv6doy1o1FVcvLl6KHJX6rk5f3epIi2wCaGa/T8hnVYd/P++033PiKuzYRbIti5RjxT/P
 YRMeQthlc1skhOsMdMPSrybg+yOnVtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTyj4ok+Fqqd0ELrJMpsI/LJlWwTUtZypHVBJK5lLx8=;
 b=/LjwLrk4Eo3jAI+Ga3r8YP6IM2gRxRT9huE8wBnPJBrqP2a9UJv60nb/RLJ3TBZhO9CQa8
 8yyb99ZvQaOkNEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB59413A84;
 Tue,  5 Aug 2025 07:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CONgJ2CskWgiGgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 07:01:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 09:01:54 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v3-6-67a7747d226c@suse.com>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754377311; l=3686;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=u3ao1eikKUsufts+U2g6t27tkno62ZwdcIMy2JJ9oD0=;
 b=Ob7OeB9S+J1paAvoY22b1dYJgc5LPPPgat9gaKjFIGPcLGeS/1S9ca4EygkPgwQDZ6EPWnrG9
 LVnCEf+SdHXDfojqx3m3JDbeX8VkT9WZuwWHqdHLncOhVj1rIGV3TyC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/6] Add file_attr03 test
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
