Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F12CAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 415C73CE340
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:49:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12C113CE1DE
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FC3F20096B
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE1441F7A8;
 Tue,  7 Oct 2025 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWhXnkxWXF9e7ui8TAd0K8GokYu1WUkz0X6s6OKn+QM=;
 b=bfEIangOcPrMlGq2LBxV+AejTA0Z9DBB4RHCM+7G8DzOW9O/I42TCQUhxNTdiL5q0788ww
 16msmCcI+6UNy+ohsJgC+RBQNHLr1cjqTJPVCvEoaC7pimw/DcMER3DhfLuThJ7vKJshhM
 mB8jH9Y/lGcITzduQ3/qW1gyir90lO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWhXnkxWXF9e7ui8TAd0K8GokYu1WUkz0X6s6OKn+QM=;
 b=DmNv9GJ83F/n0DHuX8byrk5HkkQW5N46zGf/MAUWcx36wRbDD9ZjkuqR74mpC9c3l6l0Th
 q1zEEBDU2aEJESAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L6ApMCIM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9BcsW5VR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWhXnkxWXF9e7ui8TAd0K8GokYu1WUkz0X6s6OKn+QM=;
 b=L6ApMCIMC0/ba4k7Xjp9y5uKFEc89BqWRhlqkxg+rB+KA8wuid7NXTXTabuywq4zQsOerd
 rhZuO4yVXLQtG0upeDzToGuKCgMJxS/DcW9l6XNp/j+Ib2hmWy0CitXr/IPqjmmZ08B+p2
 oCi89GotqsB1Ah79HdN0WgyNsr5k6qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWhXnkxWXF9e7ui8TAd0K8GokYu1WUkz0X6s6OKn+QM=;
 b=9BcsW5VRdEj/kHa1zhMQuUop6GpGE54/BfxNdsTbTIpPPRBOiz9XhUylDE17xTO4eFTwQk
 ZhOv3tGxhxVG1PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B61B13AAC;
 Tue,  7 Oct 2025 06:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMU7BG635Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:55 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-3-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=4004;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=W/4LpRoxh/p7yA7zgwPTCGmagbelal2WTurTWtobBr8=;
 b=HUDHGaCI91Qe2qhv0Pfe3FHzqaBpZxE03Lb/cCncH5xrJ4K82oIftL0pHQ/X7XQjgAMFI5Wlk
 btLBGpbO3eXCNqjeCjZ3MOm6p8LELfzYWt5pe6HeHVPqzaje5ogjq22
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EE1441F7A8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/10] setxattr01: add setxattrat variant
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
 testcases/kernel/syscalls/setxattr/setxattr01.c | 61 +++++++++++++++++++------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index a405bf42e..ade405f37 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -20,6 +20,10 @@
  */
 
 #include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -30,12 +34,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
-#include "tst_test.h"
+#include "lapi/xattr.h"
+#include <sys/xattr.h>
 
-#ifdef HAVE_SYS_XATTR_H
 #define XATTR_NAME_MAX 255
 #define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
 #define XATTR_SIZE_MAX 65536
@@ -43,11 +44,13 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 #define MNTPOINT "mntpoint"
-#define FNAME MNTPOINT"/setxattr01testfile"
+#define FNAME_REL "setxattr01testfile"
+#define FNAME MNTPOINT"/"FNAME_REL
 
 static char long_key[XATTR_NAME_LEN];
 static char *long_value;
 static char *xattr_value = XATTR_TEST_VALUE;
+static int mnt_fd = -1;
 
 struct test_case {
 	char *key;
@@ -126,44 +129,64 @@ struct test_case tc[] = {
 
 static void verify_setxattr(unsigned int i)
 {
+	char *sysname;
+
 	/* some tests might require existing keys for each iteration */
 	if (tc[i].keyneeded) {
 		SAFE_SETXATTR(FNAME, tc[i].key, *tc[i].value, tc[i].size,
 				XATTR_CREATE);
 	}
 
-	TEST(setxattr(FNAME, tc[i].key, *tc[i].value, tc[i].size, tc[i].flags));
+	if (tst_variant) {
+		sysname = "setxattrat";
+
+		struct xattr_args args = {
+			.value = (uint64_t)tc[i].value,
+			.size = tc[i].size,
+			.flags = tc[i].flags,
+		};
+
+		TEST(setxattrat(mnt_fd, FNAME_REL, AT_SYMLINK_NOFOLLOW,
+			tc[i].key, &args, sizeof(args)));
+	} else {
+		sysname = "setxattr";
+
+		TEST(setxattr(
+			FNAME,
+			tc[i].key, *tc[i].value, tc[i].size,
+			tc[i].flags));
+	}
 
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "setxattr(2) not supported");
+		tst_brk(TCONF, "%s(2) not supported", sysname);
 
 	/* success */
 
 	if (!tc[i].exp_err) {
 		if (TST_RET) {
 			tst_res(TFAIL | TTERRNO,
-				"setxattr(2) failed with %li", TST_RET);
+				"%s(2) failed with %li", sysname, TST_RET);
 			return;
 		}
 
 		/* this is needed for subsequent iterations */
 		SAFE_REMOVEXATTR(FNAME, tc[i].key);
 
-		tst_res(TPASS, "setxattr(2) passed");
+		tst_res(TPASS, "%s(2) passed", sysname);
 
 		return;
 	}
 
 	if (TST_RET == 0) {
-		tst_res(TFAIL, "setxattr(2) passed unexpectedly");
+		tst_res(TFAIL, "%s(2) passed unexpectedly", sysname);
 		return;
 	}
 
 	/* error */
 
 	if (tc[i].exp_err != TST_ERR) {
-		tst_res(TFAIL | TTERRNO, "setxattr(2) should fail with %s",
-			tst_strerrno(tc[i].exp_err));
+		tst_res(TFAIL | TTERRNO, "%s(2) should fail with %s",
+			sysname, tst_strerrno(tc[i].exp_err));
 		return;
 	}
 
@@ -171,7 +194,7 @@ static void verify_setxattr(unsigned int i)
 	if (tc[i].keyneeded)
 		SAFE_REMOVEXATTR(FNAME, tc[i].key);
 
-	tst_res(TPASS | TTERRNO, "setxattr(2) failed");
+	tst_res(TPASS | TTERRNO, "%s(2) failed", sysname);
 }
 
 static void setup(void)
@@ -192,12 +215,22 @@ static void setup(void)
 		if (!tc[i].key)
 			tc[i].key = tst_get_bad_addr(NULL);
 	}
+
+	mnt_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	if (mnt_fd != -1)
+		SAFE_CLOSE(mnt_fd);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.test = verify_setxattr,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = 2,
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
