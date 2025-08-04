Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D050C87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:10:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19D953CCFD8
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:10:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 898E33C8EB8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE9DF100076C
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 575EE219B9;
 Mon,  4 Aug 2025 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU5O/aFEenumt7VAyU38P+8fR2o+mmnVrscHWn6/Y+c=;
 b=S6tLaFLfRzAGmG9KWT2nSvt1ELrpefeMgMXRJIb3rrz649BfDmbGEca0cMffwxEi7BpHUm
 Q7iv7wyfIX1lFSJzetY9njTRSTtuL8vObxNdRfjeJQ6xbwrvJHI3lZ72eov+J1UAoIzr2L
 o9ObZ9N+vqwURf7d/bF4icoYch/6m80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU5O/aFEenumt7VAyU38P+8fR2o+mmnVrscHWn6/Y+c=;
 b=UT/VlfxKA3dR5X7ekt5pt0IAAEKnumswDspgGFbevUPaXa9TNwcZwrOlbKmbqBUhfVsgi+
 nnp18x9OQlReH/AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S6tLaFLf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UT/VlfxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU5O/aFEenumt7VAyU38P+8fR2o+mmnVrscHWn6/Y+c=;
 b=S6tLaFLfRzAGmG9KWT2nSvt1ELrpefeMgMXRJIb3rrz649BfDmbGEca0cMffwxEi7BpHUm
 Q7iv7wyfIX1lFSJzetY9njTRSTtuL8vObxNdRfjeJQ6xbwrvJHI3lZ72eov+J1UAoIzr2L
 o9ObZ9N+vqwURf7d/bF4icoYch/6m80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU5O/aFEenumt7VAyU38P+8fR2o+mmnVrscHWn6/Y+c=;
 b=UT/VlfxKA3dR5X7ekt5pt0IAAEKnumswDspgGFbevUPaXa9TNwcZwrOlbKmbqBUhfVsgi+
 nnp18x9OQlReH/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F57013A83;
 Mon,  4 Aug 2025 18:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLbQCFj3kGjyJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:09:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:09:21 +0200
MIME-Version: 1.0
Message-Id: <20250804-file_setattr_getattr-v1-3-6a43c3962c87@suse.com>
References: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
In-Reply-To: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754330967; l=4376;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=qlYEJH7c/fJAbJ3hp+erGAFNsw81cIR1A3HqxjjFqN4=;
 b=CUbYo8kALJjhRKq/G6MSYd9jspT1j92Aa5lIoh6d2MTcqQ6dExNVuarnsxFceq+LCdBHR0/fO
 dGH3IDVVoanCRhhlPx8wUO8M4A3z+9sx6FdiNbmKtGFXk2Td8LTqvtt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 575EE219B9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] fs: add file_setattr/file_getattr fallback
 definitions
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 compile_flags.txt                               |  5 +++
 configure.ac                                    |  1 +
 include/lapi/fs.h                               | 32 +++++++++++++++
 testcases/kernel/syscalls/getxattr/getxattr06.c | 53 +++++++++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/compile_flags.txt b/compile_flags.txt
new file mode 100644
index 0000000000000000000000000000000000000000..21b8cc301c9958663d74909396aa5dd21e45e911
--- /dev/null
+++ b/compile_flags.txt
@@ -0,0 +1,5 @@
+-Iinclude/
+-Iinclude/old
+-Itestcases/kernel/syscalls/utils
+-Itestcases/kernel/mem/hugetlb/lib
+-Itestcases/kernel/mem/include
diff --git a/configure.ac b/configure.ac
index 9bd139f602b9f174e5314171f8f03338c06f3df4..3ddea62b57270662fe8f24d52d697874ee8768ef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,6 +263,7 @@ AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
+AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 23b58edf9621726f94727cc6286b9b4b67226035..e0a55d1ab963c07e1bd7a6dc9d92097af90018e1 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -14,10 +14,13 @@
 # include <linux/fs.h>
 #endif
 
+#include <stddef.h>
 #include <stdint.h>
 #include <sys/user.h>
 #include <limits.h>
+#include "tst_test.h"
 #include "lapi/abisize.h"
+#include "lapi/syscalls.h"
 
 #ifndef HAVE_STRUCT_FSXATTR
 struct fsxattr {
@@ -88,4 +91,33 @@ static inline long long tst_max_lfs_filesize(void)
 #endif
 }
 
+#ifndef HAVE_STRUCT_FILE_ATTR
+struct file_attr {
+	uint64_t fa_xflags;	/* xflags field value (get/set) */
+	uint32_t fa_extsize;	/* extsize field value (get/set)*/
+	uint32_t fa_nextents;	/* nextents field value (get)   */
+	uint32_t fa_projid;	/* project identifier (get/set) */
+	uint32_t fa_cowextsize;	/* CoW extsize field value (get/set) */
+};
+#endif
+
+#define FILE_ATTR_SIZE_VER0 24
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+
+static inline int file_getattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_getattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+
+static inline int file_setattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_setattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+
 #endif /* LAPI_FS_H__ */
diff --git a/testcases/kernel/syscalls/getxattr/getxattr06.c b/testcases/kernel/syscalls/getxattr/getxattr06.c
new file mode 100644
index 0000000000000000000000000000000000000000..e1f7bb6aae5335b6bb22cba61eb826aa829b14a8
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/getxattr06.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012  Red Hat, Inc.
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
+ */
+
+/*\
+ * An empty buffer of size zero can be passed into getxattr(2) to
+ * return the current size of the named extended attribute.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#include <sys/xattr.h>
+#include "tst_safe_macros.h"
+
+#define MNTPOINT "mntpoint"
+#define FNAME MNTPOINT"/getxattr03testfile"
+#define XATTR_TEST_KEY "user.testkey"
+#define XATTR_TEST_VALUE "test value"
+#define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
+
+static void run(void)
+{
+	TST_EXP_VAL(getxattr(FNAME, XATTR_TEST_KEY, NULL, 0),
+				XATTR_TEST_VALUE_SIZE);
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(FNAME, 0644, NULL);
+	SAFE_SETXATTR(FNAME, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+		     XATTR_TEST_VALUE_SIZE, XATTR_CREATE);
+}
+
+static struct tst_test test = {
+	.timeout = 14,
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.skip_filesystems = (const char *const []) {
+			"exfat",
+			"tmpfs",
+			"ramfs",
+			"nfs",
+			"vfat",
+			NULL
+	},
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
