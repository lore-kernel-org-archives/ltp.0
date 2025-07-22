Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0190C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 06:57:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6785D3CCC53
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:57:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94E4D3CCC4A
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B27C410001FE
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43FBB1F852;
 Tue, 22 Jul 2025 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x32f+6L53Ke/h8U6Ayc1rWud+XnWPiHtjUvZV6wYftA=;
 b=AItLTrRZsxI6SPHe11ta5O4+RB1ums2X2vUiB0436hdBVjM1NBrWJ+JRStroOkCWa32geP
 WbWCUJ55IVkbSi5BcFaHhg0xQBcRf2UGVnGuEFw+ujw+5XTiN+aeWve+ibTUzGxhaGSpUM
 XavJP+Kwp8lSsHaf5k0d1QNTSV6nmww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x32f+6L53Ke/h8U6Ayc1rWud+XnWPiHtjUvZV6wYftA=;
 b=YKILRSotfYGh6qkND2nw93q6QTa8Dn4Dli7ieRAPCBrp2xXJROakFoDqWTH5JdW/mH2fKv
 6cFTaelTNSZ2sYAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AItLTrRZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YKILRSot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x32f+6L53Ke/h8U6Ayc1rWud+XnWPiHtjUvZV6wYftA=;
 b=AItLTrRZsxI6SPHe11ta5O4+RB1ums2X2vUiB0436hdBVjM1NBrWJ+JRStroOkCWa32geP
 WbWCUJ55IVkbSi5BcFaHhg0xQBcRf2UGVnGuEFw+ujw+5XTiN+aeWve+ibTUzGxhaGSpUM
 XavJP+Kwp8lSsHaf5k0d1QNTSV6nmww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x32f+6L53Ke/h8U6Ayc1rWud+XnWPiHtjUvZV6wYftA=;
 b=YKILRSotfYGh6qkND2nw93q6QTa8Dn4Dli7ieRAPCBrp2xXJROakFoDqWTH5JdW/mH2fKv
 6cFTaelTNSZ2sYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261B313A7E;
 Tue, 22 Jul 2025 06:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +G6bByw2f2iKcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 22 Jul 2025 06:56:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 22 Jul 2025 08:55:57 +0200
MIME-Version: 1.0
Message-Id: <20250722-xattr_bug_repr-v4-2-4be1e52e97c6@suse.com>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
In-Reply-To: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753167403; l=4808;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fzXAJne7XKK1q74A8tWyrJ6QhI9x1ZQjajspIZFNgQ0=;
 b=5PAQFjE6BTp9AZYNchdMMjb5qCzNvn6PiDe2jnvM1W0rcnZ2QbHTrl4vHXXJOO22K80Cnb+cE
 t6kMNEOERhrAYfdtMYe/QvaGb6GeXjQih/n16IJJIaX8lzfIiPPwHm1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 43FBB1F852
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] Add listxattr04 reproducer
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

Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
simple_xattr_list to always include security.* xattrs").

Bug can be reproduced when SELinux and ACL are activated on inodes as
following:

    $ touch testfile
    $ setfacl -m u:myuser:rwx testfile
    $ getfattr -dm. /tmp/testfile
    Segmentation fault (core dumped)

The reason why this happens is that simple_xattr_list() always includes
security.* xattrs without resetting error flag after
security_inode_listsecurity(). This results into an incorrect length of the
returned xattr name if POSIX ACL is also applied on the inode.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
 testcases/kernel/syscalls/listxattr/Makefile      |   2 +
 testcases/kernel/syscalls/listxattr/listxattr04.c | 108 ++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
index be0675a6df0080d176d53d70194442bbc9ed376c..0d672b6ea5eec03aab37ee89316c56e24356c1d9 100644
--- a/testcases/kernel/syscalls/listxattr/.gitignore
+++ b/testcases/kernel/syscalls/listxattr/.gitignore
@@ -1,3 +1,4 @@
 /listxattr01
 /listxattr02
 /listxattr03
+/listxattr04
diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
index c2f84b1590fc24a7a98f890ea7706771d944aa79..e96bb3fa4c2c6b14b8d2bc8fd4c475e4789d72fe 100644
--- a/testcases/kernel/syscalls/listxattr/Makefile
+++ b/testcases/kernel/syscalls/listxattr/Makefile
@@ -6,4 +6,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+listxattr04: LDLIBS	+= $(ACL_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/listxattr/listxattr04.c b/testcases/kernel/syscalls/listxattr/listxattr04.c
new file mode 100644
index 0000000000000000000000000000000000000000..473ed45b5c2da8ff8e49c513eeb82158ec2dc066
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
+ * simple_xattr_list to always include security.* xattrs").
+ *
+ * Bug can be reproduced when SELinux and ACL are activated on inodes as
+ * following:
+ *
+ *     $ touch testfile
+ *     $ setfacl -m u:myuser:rwx testfile
+ *     $ getfattr -dm. /tmp/testfile
+ *     Segmentation fault (core dumped)
+ *
+ * The reason why this happens is that simple_xattr_list() always includes
+ * security.* xattrs without resetting error flag after
+ * security_inode_listsecurity(). This results into an incorrect length of the
+ * returned xattr name if POSIX ACL is also applied on the inode.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
+
+#include <pwd.h>
+#include <sys/acl.h>
+#include <sys/xattr.h>
+
+#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
+#define TEST_FILE       "test.bin"
+
+static acl_t acl;
+
+static void verify_xattr(const int size)
+{
+	char buf[size];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (listxattr(TEST_FILE, buf, size) == -1) {
+		if (errno != ERANGE)
+			tst_brk(TBROK | TERRNO, "listxattr() error");
+
+		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
+		return;
+	}
+
+	tst_res(TPASS, "listxattr() correctly read attributes length");
+}
+
+static void run(void)
+{
+	int size;
+
+	size = listxattr(TEST_FILE, NULL, 0);
+	if (size == -1)
+		tst_brk(TBROK | TERRNO, "listxattr() error");
+
+	verify_xattr(size);
+}
+
+static void setup(void)
+{
+	int res;
+
+	if (!tst_selinux_enabled())
+		tst_brk(TCONF, "SELinux is not enabled");
+
+	SAFE_TOUCH(TEST_FILE, 0644, NULL);
+
+	acl = acl_from_text(ACL_PERM);
+	if (!acl)
+		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
+
+	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
+	if (res == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF | TERRNO, "acl_set_file()");
+
+		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
+	}
+}
+
+static void cleanup(void)
+{
+	if (acl)
+		acl_free(acl);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "800d0b9b6a8b"},
+		{}
+	}
+};
+
+#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
+	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
+#endif

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
