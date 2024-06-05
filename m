Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B936BC27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:42:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 576C23D0982
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 16:42:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89D7D3D098C
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:19 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81F8A617628
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:41:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 670E521A75;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOmRNEVuwzKDd1Tx+UOLVSI3MALcJMZc0Vplej1TQDw=;
 b=TYStl2+fEzu82XR1wfUjkKQJXIMB0sIVhfJOyc5h5qX2VJdyfiC+0E6EDP/oUMS1LfZrXJ
 PivkBnyLQIN6PEXCwBDaJ6x4S3ezWoR+wQpiRsLnKCT+qzC76yvu4kid3ZRIUHWOeq5HYP
 /yXt/QHLQ9LKZTNhNsc0By1/qampO28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOmRNEVuwzKDd1Tx+UOLVSI3MALcJMZc0Vplej1TQDw=;
 b=bBRoht55siKRLMbZ7nsi7SIb7G6QVdltwytempwsD8DxQcuhliuW5CAy8bRjT3Qrjr0q8J
 9rGfmnjK8kf+nYCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717598475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOmRNEVuwzKDd1Tx+UOLVSI3MALcJMZc0Vplej1TQDw=;
 b=GoDWnqUa+xRampL6rtKhxntcs7lsCdNuer3CxuhpoBRUpmxz+XM+KQNYf1fBl1y0g5a8Z8
 ylSnXZ4gyZ2WKZjLbeXmlXOHxaoqYOdgfVf7G4uT0f9xkDVyNCCE6tsXbPDU3qQtiQccK3
 WxPiWg+Cytfcx2PmLAwYLCcUXBo3mmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717598475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOmRNEVuwzKDd1Tx+UOLVSI3MALcJMZc0Vplej1TQDw=;
 b=ZuCj+ehV4sEsAZKXtkXDsYBTorXtPv44H/FjnlyqZiFYje4w9uIJzqgMjTjhPKxVBc25tQ
 XO96pzRsVlpG87Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521E313A98;
 Wed,  5 Jun 2024 14:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OADEEgt5YGY/NwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Jun 2024 14:41:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Jun 2024 16:40:38 +0200
MIME-Version: 1.0
Message-Id: <20240605-unlink09-v2-1-bfa0bbdc8753@suse.com>
References: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
In-Reply-To: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5110;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=8HGsittp+KpE8+ISq44BGK7LJCgVY4WEeXYwvlotGJo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYHkLQM5u0ECRfvnPcnDNAACWuuxm/hgtB2ja8
 xZODJzM5HWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmB5CwAKCRDLzBqyILPm
 RkaqDACdCVLCBW2GOFr/IVrqG1bG83/xIbxJX4t4aHkzx3WfAMJ6T6BaYEKW+dfHtVAHLdTZ7cw
 yp0CFAD/NYDQ9BKr8ikNbDq7P//XsWYUbjsGCOvtDLnpH7cY/VcjCuZPstuzzxDHsfjelJyYmN5
 NxmvQ1oMOsCWArbe7Qpl7ux/52tG+PXNgbOJqAWO7m6KULxBIuXz3q3I7eBYviW3CatqrpNtPwi
 eAg0Yx9Ehzfvjb/MqkU5SDZIerlDK4L0fLnWBwve8m+KJ4Eozxh0JZdDVtp7dB4tulyQk42aefS
 jaGQgmaPpmf0oQag5lidT0Kbbt80/7TfQNBZA/iCxe701zGIjerRB5WmgRHGln45xtMKlyco95Q
 uCLVqxjuArFRnQIC6ALUdzP8pbjBllcpSX+H3QAwoKPtd/J8Zjwx3MbRahECPTREWWx9TCc+vJt
 cxY/oq4krHztywbxs0t3bDTcNUS7W9UAfIxQpcMbWtEuuMfqfBs2hYIDWmd7SV5brI2kQ=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 fujitsu.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Fix unlink09 test
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
 testcases/kernel/syscalls/unlink/unlink09.c | 94 +++++++++++++++--------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..220a810cf 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -2,92 +2,97 @@
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
 
@@ -96,7 +101,8 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.cleanup = cleanup,
 	.test = verify_unlink,
-	.needs_rofs = 1,
-	.mntpoint = DIR_EROFS,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
+	.all_filesystems = 1,
+	.format_device = 1,
 };

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
