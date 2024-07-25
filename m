Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1685CC3DA7E
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:43:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80FE03D1C9C
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:43:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01ECC3D0FA8
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:43:31 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01A8521A0A1
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:43:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3239A1F7EB
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721900609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yh0bBbYnzBwocNHiJt9C7xjxGx431n/8fC4Ixhf+2sk=;
 b=YtsF5JSOZYqDcIs83xcTaWUZG9SU3uJJzR4QnK44JuV1/1OttZ8neJilE5cY0BhgIRrIJi
 qTSDOunWD6dXUPzQdrnlknntMNwrpypiObIxboyM6u4CfsvVoRs9FrcNNZynUPWxbZCtlj
 PMd8/kMurcyf7An+cn5e9W+5DRKprwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721900609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yh0bBbYnzBwocNHiJt9C7xjxGx431n/8fC4Ixhf+2sk=;
 b=nr7exFjsvdAeiPpXvzj8jd0plI37T0CEegxAX9htJbs17CyXm4kW3/4Kz91R59gG39GTuK
 CGGjA/dY7ogcPeAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YtsF5JSO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nr7exFjs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721900609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yh0bBbYnzBwocNHiJt9C7xjxGx431n/8fC4Ixhf+2sk=;
 b=YtsF5JSOZYqDcIs83xcTaWUZG9SU3uJJzR4QnK44JuV1/1OttZ8neJilE5cY0BhgIRrIJi
 qTSDOunWD6dXUPzQdrnlknntMNwrpypiObIxboyM6u4CfsvVoRs9FrcNNZynUPWxbZCtlj
 PMd8/kMurcyf7An+cn5e9W+5DRKprwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721900609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yh0bBbYnzBwocNHiJt9C7xjxGx431n/8fC4Ixhf+2sk=;
 b=nr7exFjsvdAeiPpXvzj8jd0plI37T0CEegxAX9htJbs17CyXm4kW3/4Kz91R59gG39GTuK
 CGGjA/dY7ogcPeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A36F1368A
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nHUJBUEeoma0PAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:43:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Jul 2024 11:43:00 +0200
Message-ID: <20240725094300.16080-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3239A1F7EB
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi: Split ficlone fallbacks from fs.h
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

In the end splitting the ficlone fallbacks from fs.h is the easiest
solution we can do.

Fixes: 3acc96d4b3fa8 ("Add fallback definitions for lapi/fs.h")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

Passes the CI https://github.com/metan-ucw/ltp/actions/runs/10091715692/job/27903833146

 include/lapi/ficlone.h                        | 35 +++++++++++++++++++
 include/lapi/fs.h                             | 18 ----------
 .../kernel/syscalls/ioctl/ioctl_ficlone01.c   |  2 +-
 .../kernel/syscalls/ioctl/ioctl_ficlone02.c   |  2 +-
 .../kernel/syscalls/ioctl/ioctl_ficlone03.c   |  2 +-
 .../syscalls/ioctl/ioctl_ficlonerange01.c     |  2 +-
 .../syscalls/ioctl/ioctl_ficlonerange02.c     |  2 +-
 7 files changed, 40 insertions(+), 23 deletions(-)
 create mode 100644 include/lapi/ficlone.h

diff --git a/include/lapi/ficlone.h b/include/lapi/ficlone.h
new file mode 100644
index 000000000..a973a8b21
--- /dev/null
+++ b/include/lapi/ficlone.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ * Copyright (C) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef LAPI_FICLONE_H__
+#define LAPI_FICLONE_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_FS_H
+# include <linux/fs.h>
+#endif
+
+#include <stdint.h>
+
+#ifndef HAVE_STRUCT_FILE_CLONE_RANGE
+struct file_clone_range {
+	int64_t src_fd;
+	uint64_t src_offset;
+	uint64_t src_length;
+	uint64_t dest_offset;
+};
+#endif
+
+#ifndef FICLONE
+# define FICLONE		_IOW(0x94, 9, int)
+#endif
+
+#ifndef FICLONERANGE
+# define FICLONERANGE		_IOW(0x94, 13, struct file_clone_range)
+#endif
+
+#endif /* LAPI_FICLONE_H__ */
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index bea81aea1..635979b02 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -18,18 +18,8 @@
 
 #include <sys/user.h>
 #include <limits.h>
-#include <stdint.h>
 #include "lapi/abisize.h"
 
-#ifndef HAVE_STRUCT_FILE_CLONE_RANGE
-struct file_clone_range {
-	int64_t src_fd;
-	uint64_t src_offset;
-	uint64_t src_length;
-	uint64_t dest_offset;
-};
-#endif
-
 #ifndef FS_IOC_GETFLAGS
 # define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
 #endif
@@ -58,14 +48,6 @@ struct file_clone_range {
 # define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
 #endif
 
-#ifndef FICLONE
-# define FICLONE		_IOW(0x94, 9, int)
-#endif
-
-#ifndef FICLONERANGE
-# define FICLONERANGE		_IOW(0x94, 13, struct file_clone_range)
-#endif
-
 /*
  * Helper function to get MAX_LFS_FILESIZE.
  * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index bb3dc8c6c..57fdab374 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -19,7 +19,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/fs.h"
+#include "lapi/ficlone.h"
 
 #define MNTPOINT "mnt"
 #define SRCPATH MNTPOINT "/file0"
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index f6d492026..be3b01c29 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -12,7 +12,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/fs.h"
+#include "lapi/ficlone.h"
 
 #define MNTPOINT "mnt"
 #define SRCPATH MNTPOINT "/file0"
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index 406b64cca..cd5cc6938 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -11,7 +11,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/fs.h"
+#include "lapi/ficlone.h"
 
 #define MNTPOINT "mnt"
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index 78cf4bfea..cf7602a9a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -19,7 +19,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/fs.h"
+#include "lapi/ficlone.h"
 
 #define MNTPOINT "mnt"
 #define SRCPATH MNTPOINT "/file0"
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index 70dc46aa1..df9849b34 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -13,7 +13,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/fs.h"
+#include "lapi/ficlone.h"
 
 #define MNTPOINT "mnt"
 #define SRCPATH MNTPOINT "/file0"
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
