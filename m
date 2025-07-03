Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2CAC77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 13:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F2543C98B4
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 15:51:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFBFC3C7679
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 15:51:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9BC2A60011A
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 15:51:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1647D1F7B0;
 Thu,  3 Jul 2025 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751550698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+xW6WjdM6dihv7oCDh2En78GWjlZN/OX9VG+O0sOjE=;
 b=Yq2VV71t8ufGDcMJkHD+cyNLEq5p+Ccsb70WxdpUnSU9p635sadoCs7LL+d8qx/Gl02rcC
 L9gBBi6RyOcgtPl5yK/fvjGii2pGeVvJ39z/WRwwQ3oGEAcG7P7umov9VmrMyL2MGFdv6n
 IeR9Loraq8Ft4rySEgPxjNyB0ZiEQm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751550698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+xW6WjdM6dihv7oCDh2En78GWjlZN/OX9VG+O0sOjE=;
 b=akQECoUTWaIQIfbzc1NtenwLLQSH8/+ifuMZDsBMMf2DMTGKkXzCNkzebjIxPgczJN8EWY
 mI/WrFzi7mQjYWCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751550697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+xW6WjdM6dihv7oCDh2En78GWjlZN/OX9VG+O0sOjE=;
 b=LyZZejW+vFpzRSMsvcjCMmmPpa7SmgEy4291HyJWOGDPtRBXqDfuSpbJKeCNKnUHFPfCRq
 gCIz+9PwlYzquZy/e4O7NCm+mLc89GlWTXJEeWdfTKsfr1z4HQzBjxnEtn8+eIf4/ajvEN
 ftp1MLX3DGpCZWxrgfEr2iyp7q2gzF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751550697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+xW6WjdM6dihv7oCDh2En78GWjlZN/OX9VG+O0sOjE=;
 b=npedKFED+FRjXYfYQ9GvmLPSE19VdHQqOj7nq0ZCLieQTQEfYqTqTSkLkbulBB5QDqi7/N
 tYhL2lMAcT33XSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBF9413721;
 Thu,  3 Jul 2025 13:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fZ2PK+iKZmhrWAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Jul 2025 13:51:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Jul 2025 15:51:33 +0200
MIME-Version: 1.0
Message-Id: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
X-B4-Tracking: v=1; b=H4sIAOSKZmgC/13MQQ6CMBCF4auQWVtDi7XVlfcwhNB2gC6kZAoEQ
 3p3K4kbl/9L3rdDRPIY4V7sQLj66MOYQ5wKsEM79si8yw2iFLJUpWBbO8/UmKVvCCdiUqvK6Iu
 6ic5APk2End8O8FnnHnycA70Pf+Xf9UdV/9TKGWfS2U46h9pc+SMuEc82vKBOKX0A4tuzLKsAA
 AA=
X-Change-ID: 20250702-xattr_bug_repr-5873b84792fb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751550696; l=5652;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rk1TX0yERBmDXkA8EDyb1T0US3t4GdQoFf1xm9cCI98=;
 b=EUnA1rG/lQJNjhVmjX3eC94OlEz7Gd3acdk/1Ol34YNPp0v0GInjLQznzggGI1AYnKisiQFia
 3ZOzXHRIFq/AMfRLlIMNDU+AQMHmJOkJoM6FHpIJ3O2oce5LdWEPDUm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add listxattr04 reproducer
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
Reproducer for https://lore.kernel.org/linux-fsdevel/m1wm9qund4.fsf@gmail.com/T/
---
Changes in v2:
- only check if SELinux is up and running
- Link to v1: https://lore.kernel.org/r/20250703-xattr_bug_repr-v1-1-5dcf5dde8b61@suse.com
---
 testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
 testcases/kernel/syscalls/listxattr/Makefile      |   2 +
 testcases/kernel/syscalls/listxattr/listxattr04.c | 133 ++++++++++++++++++++++
 3 files changed, 136 insertions(+)

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
index 0000000000000000000000000000000000000000..af80e0c609d5931132b3bf16b28805577b2a853d
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
@@ -0,0 +1,133 @@
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
+#include "lapi/lsm.h"
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
+static int selinux_enabled(void)
+{
+	uint32_t lsm_num;
+	uint64_t ids[32];
+	uint32_t page_size;
+	int available = 0;
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	lsm_num = lsm_list_modules(ids, &page_size, 0);
+	if (!lsm_num)
+		return 0;
+
+	for (uint32_t i = 0; i < lsm_num; i++) {
+		if (ids[i] == LSM_ID_SELINUX) {
+			available = 1;
+			break;
+		}
+	}
+
+	return available;
+}
+
+static void setup(void)
+{
+	int res;
+
+	if (!selinux_enabled())
+		tst_brk(TCONF, "SELinux is not running");
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

---
base-commit: a908cff70f9389c2dd2bf535976cb179bfa8f340
change-id: 20250702-xattr_bug_repr-5873b84792fb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
