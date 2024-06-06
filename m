Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11F4C27C55
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155ED3D0A78
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:24:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3AB23D0987
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E09C7608A78
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF3651FB49;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaikiUQJ2ghx+P8Ac+C6ui9PnHQQrdkNLugVspCYyaM=;
 b=PnjCUfV7Nbaz/5sYIVorNiOhtG4oLp02YGNXjPyFOMMp1bZVj0Ys/5Wx6Vf3JvCeiryNQ1
 okYdFfxKsJ8bn1fRfIqa3yuLclBCTTrHTwNQ61sXgcoQFuAvrBuymWzLiukDWAof1Hw/OP
 4Ix0MQE0ixDYM75W9+W/Ow2jkkVPxes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaikiUQJ2ghx+P8Ac+C6ui9PnHQQrdkNLugVspCYyaM=;
 b=HkcUYTjHbiA84qTHaCvd2LXc+6VuQq4+V+IFxZxggIFjgLwSXeE9+/uBmojThbAH0HrUI2
 hCseDKFv4khanbBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaikiUQJ2ghx+P8Ac+C6ui9PnHQQrdkNLugVspCYyaM=;
 b=PnjCUfV7Nbaz/5sYIVorNiOhtG4oLp02YGNXjPyFOMMp1bZVj0Ys/5Wx6Vf3JvCeiryNQ1
 okYdFfxKsJ8bn1fRfIqa3yuLclBCTTrHTwNQ61sXgcoQFuAvrBuymWzLiukDWAof1Hw/OP
 4Ix0MQE0ixDYM75W9+W/Ow2jkkVPxes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaikiUQJ2ghx+P8Ac+C6ui9PnHQQrdkNLugVspCYyaM=;
 b=HkcUYTjHbiA84qTHaCvd2LXc+6VuQq4+V+IFxZxggIFjgLwSXeE9+/uBmojThbAH0HrUI2
 hCseDKFv4khanbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E8113A96;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLMYK7XwYWaNFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Jun 2024 17:24:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Jun 2024 19:23:38 +0200
MIME-Version: 1.0
Message-Id: <20240606-unlink09-v3-1-37cc612ce0fd@suse.com>
References: <20240606-unlink09-v3-0-37cc612ce0fd@suse.com>
In-Reply-To: <20240606-unlink09-v3-0-37cc612ce0fd@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=uS0T4SpIa4HKxfAFIr/6QCrQ/zAzPZaP1Y82oMI8zIQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYfC1Co49dCfvz0h7XjLDP2lJ+9SBULGNJxyNP
 s7oGWYQLgeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmHwtQAKCRDLzBqyILPm
 RhpBC/9qKfqdKBuu0592tGyVYokhhrlrFQjHE5GC66gQ3mx4FPbLS9l8/psqD7LqanFcRwKpBNu
 H0iabP0XYOnl8TRd4Ernpcdl7YnNgHpU6Wqc0uqFmk/ZxMi2nDr/ezArQgddVbvYrWc0v6/XnSQ
 k9kvYVcdyUIXh62fq6U09uBllCvoIiV5haWRE0CR7xwio4EsQB87fsf0g//gPpG0hU4Xy1p5aZ7
 ZfvMg63Rw8PaBOPEZwXj6GOJkxq0HTuoEf1o6eKWj1WKT/7eFkrQyxx+mjNOfLnXB3tBVy4pvxO
 9wMuv+Sjcw7JFgVM/zMV9bhDwzkS1W8ruXSUAzoy4ly7JR1Onoi+EdU4lSLTXvx64V8OzopiWD1
 3mQSIJmnncaRltjTiec/tihURK4HNU4mcO2U20CcQQ1QQ/B2tRhTyGmPGUk6fQ7JiH6vE17DClz
 y+4A6QdO1JsudqrfOFIhGmEAh1ZMqQRGJTikGyjkAAhf53iBVlehErwdXf4h3274kh8a0=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Fix unlink09 test
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

This patch will fix unlink09 test by checking for filesystems which
are not supporting inode attributes. At the same time, it removes the
read-only filesystem unlink() check in order to add .all_filesystems
support.

Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/unlink/unlink09.c | 106 ++++++++++++++++------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..40dbc6e19 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -2,92 +2,103 @@
 /*
  * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
  * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
  * [Description]
  *
- * Verify that unlink(2) fails with
- *
- * - EPERM when target file is marked as immutable or append-only
- * - EROFS when target file is on a read-only filesystem.
+ * Verify that unlink(2) fails with EPERM when target file is marked as
+ * immutable or append-only.
  */
 
 #include <sys/ioctl.h>
 #include "tst_test.h"
 #include "lapi/fs.h"
 
-#define TEST_EPERM_IMMUTABLE "test_eperm_immutable"
-#define TEST_EPERM_APPEND_ONLY "test_eperm_append_only"
-#define DIR_EROFS "erofs"
-#define TEST_EROFS "erofs/test_erofs"
+#define MNTPOINT "mnt"
+#define TEST_EPERM_IMMUTABLE MNTPOINT"/test_eperm_immutable"
+#define TEST_EPERM_APPEND_ONLY MNTPOINT"/test_eperm_append_only"
 
-static int fd_immutable;
-static int fd_append_only;
+static int fd_immutable = -1;
+static int fd_append_only = -1;
 
 static struct test_case_t {
 	char *filename;
 	int *fd;
 	int flag;
-	int expected_errno;
 	char *desc;
 } tcases[] = {
-	{TEST_EPERM_IMMUTABLE, &fd_immutable, FS_IMMUTABLE_FL, EPERM,
+	{TEST_EPERM_IMMUTABLE, &fd_immutable, FS_IMMUTABLE_FL,
 		"target file is immutable"},
-	{TEST_EPERM_APPEND_ONLY, &fd_append_only, FS_APPEND_FL, EPERM,
+	{TEST_EPERM_APPEND_ONLY, &fd_append_only, FS_APPEND_FL,
 		"target file is append-only"},
-	{TEST_EROFS, NULL, 0, EROFS, "target file in read-only filesystem"},
 };
 
+static void setup_inode_flag(const int fd, const int flag, const int reset)
+{
+	int attr;
+
+	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+
+	if (reset)
+		attr &= ~flag;
+	else
+		attr |= flag;
+
+	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+}
+
 static void setup(void)
 {
 	int attr;
 
-	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	/* inode attributes in tmpfs are supported from kernel 6.0
+	 * https://lore.kernel.org/all/20220715015912.2560575-1-tytso@mit.edu/
+	 */
+	if (!strcmp(tst_device->fs_type, "tmpfs") && tst_kvercmp(6, 0, 0) < 0)
+		tst_brk(TCONF, "FS_IOC_GETFLAGS on tmpfs not supported for kernel<6.0");
+
+	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
+	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
+
+	if (TST_RET == -1 && TST_ERR == ENOTTY) {
+		SAFE_CLOSE(fd_immutable);
+
+		tst_brk(TBROK, "Inode attributes not supported by '%s'",
+			tst_device->fs_type);
+	}
+
 	attr |= FS_IMMUTABLE_FL;
 	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
 
-	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
-	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
-	attr |= FS_APPEND_FL;
-	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
+	setup_inode_flag(fd_append_only, FS_APPEND_FL, 0);
 }
 
 static void cleanup(void)
 {
-	int attr;
-
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_IMMUTABLE_FL;
-	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_immutable);
+	if (fd_immutable != -1) {
+		setup_inode_flag(fd_immutable, FS_IMMUTABLE_FL, 1);
+		SAFE_CLOSE(fd_immutable);
+	}
 
-	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_APPEND_FL;
-	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_append_only);
+	if (fd_append_only != -1) {
+		setup_inode_flag(fd_append_only, FS_APPEND_FL, 1);
+		SAFE_CLOSE(fd_append_only);
+	}
 }
 
 static void verify_unlink(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
-	int attr;
 
-	TST_EXP_FAIL(unlink(tc->filename), tc->expected_errno, "%s", tc->desc);
+	TST_EXP_FAIL(unlink(tc->filename), EPERM, "%s", tc->desc);
 
 	/* If unlink() succeeded unexpectedly, test file should be restored. */
 	if (!TST_RET) {
-		if (tc->fd) {
-			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
-			if (tc->flag) {
-				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
-				attr |= tc->flag;
-				SAFE_IOCTL(*(tc->fd), FS_IOC_SETFLAGS, &attr);
-			}
-		} else {
-			SAFE_TOUCH(tc->filename, 0600, 0);
-		}
+		*(tc->fd) = SAFE_CREAT(tc->filename, 0600);
+		setup_inode_flag(*(tc->fd), tc->flag, 0);
 	}
 }
 
@@ -96,7 +107,14 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.cleanup = cleanup,
 	.test = verify_unlink,
-	.needs_rofs = 1,
-	.mntpoint = DIR_EROFS,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
+	.format_device = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"vfat",
+		"ntfs",
+		NULL
+	},
 };

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
