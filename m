Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D059C433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 15:33:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2903C9D7D
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 16:33:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32BE3C13E0
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 16:32:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D8F31A01976
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 16:32:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63B0D21709;
 Wed, 23 Feb 2022 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645630377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oaydoYorqUdGd6DvvhElyIBIrvSumENJrBXVW5KQtw=;
 b=HH3CO/lVNCjLExLXhq+JIwDPlRZHShcubpahMJQFoYZsVNsaupoX/EZwwabI125j1SmPsG
 4O5DbrcyA1w/ed238Px6R6B4hgqqYMvST97+6+kt+pZWqL9SEQ1J3X4CXr2G4qoMJfvly7
 yvIe+7FYoANr7TZPhlAg2jK8pPkc2M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645630377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oaydoYorqUdGd6DvvhElyIBIrvSumENJrBXVW5KQtw=;
 b=bzrm0QBhbMytEQoXHT9XULBOuGtRTv4lgb4sO55lQrm31xvaHYLudzlMrcrg2/BPFvblnu
 g1T+iJIKvOaXftBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3287F13D88;
 Wed, 23 Feb 2022 15:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OGziCqlTFmKZawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Feb 2022 15:32:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 23 Feb 2022 16:32:41 +0100
Message-Id: <20220223153243.317-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223153243.317-1-pvorel@suse.cz>
References: <20220223153243.317-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] quotactl: Move do_mount() to header
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

This allows do_mount() to be reusable in quotactl08.c and quotactl09.c.

Add inline keyword to it and to the other two functions (to follow LTP
convention).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/quotactl/quotactl04.c     | 25 ++-----------------
 .../syscalls/quotactl/quotactl_syscall_var.h  | 25 +++++++++++++++++--
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 55da282705..f45ee43960 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -25,7 +25,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <sys/mount.h>
 #include "tst_test.h"
 #include "quotactl_syscall_var.h"
 
@@ -95,28 +94,6 @@ static struct tcase {
 
 };
 
-static void do_mount(const char *source, const char *target,
-	const char *filesystemtype, unsigned long mountflags,
-	const void *data)
-{
-	TEST(mount(source, target, filesystemtype, mountflags, data));
-
-	if (TST_RET == -1 && TST_ERR == ESRCH)
-		tst_brk(TCONF, "Kernel or device does not support FS quotas");
-
-	if (TST_RET == -1) {
-		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
-			source, target, filesystemtype, mountflags, data);
-	}
-
-	if (TST_RET) {
-		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
-			source, target, filesystemtype, mountflags, data);
-	}
-
-	mount_flag = 1;
-}
-
 static void setup(void)
 {
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
@@ -124,6 +101,8 @@ static void setup(void)
 	quotactl_info();
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	mount_flag = 1;
+
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 }
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
index 3d1a2c8f5a..ba25fd9936 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
@@ -7,6 +7,7 @@
 #ifndef LTP_QUOTACTL_SYSCALL_VAR_H
 #define LTP_QUOTACTL_SYSCALL_VAR_H
 
+#include <sys/mount.h>
 #include "lapi/quotactl.h"
 
 #define QUOTACTL_SYSCALL_VARIANTS 2
@@ -14,14 +15,14 @@
 
 static int fd = -1;
 
-static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
+static inline int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
 {
 	if (tst_variant == 0)
 		return quotactl(cmd, special, id, addr);
 	return quotactl_fd(fd, cmd, id, addr);
 }
 
-static void quotactl_info(void)
+static inline void quotactl_info(void)
 {
 	if (tst_variant == 0)
 		tst_res(TINFO, "Test quotactl()");
@@ -29,4 +30,24 @@ static void quotactl_info(void)
 		tst_res(TINFO, "Test quotactl_fd()");
 }
 
+static inline void do_mount(const char *source, const char *target,
+	const char *filesystemtype, unsigned long mountflags,
+	const void *data)
+{
+	TEST(mount(source, target, filesystemtype, mountflags, data));
+
+	if (TST_RET == -1 && TST_ERR == ESRCH)
+		tst_brk(TCONF, "Kernel or device does not support FS quotas");
+
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
+			source, target, filesystemtype, mountflags, data);
+	}
+}
+
 #endif /* LTP_QUOTACTL_SYSCALL_VAR_H */
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
