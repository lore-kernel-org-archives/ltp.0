Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C488C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:09:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832A33C2C9C
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:09:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7EEA3C0558
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CEBC22A133
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C31AC21125
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Dy6Z68xceJjsCwiKi/WG511JNdfnVvL8oZMRBUgDw=;
 b=H/eien5ABdVoYdu3Z4lKyVJcxQfMb5MXzmJmi3lIqiZfjPY++/uXoPHTnnSOAV7/gexNy1
 ewXFqVFQZQJ4UNSSRrR+zr8sF3QiMx8jnYg/bPNuV8yrrZeyKlWgtt8nryZihkh6E8hK2x
 utv2ZsY81/z2qBLPeENGaoLY2YtPMio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Dy6Z68xceJjsCwiKi/WG511JNdfnVvL8oZMRBUgDw=;
 b=rgv0GMy97Az/A2yFXpTCgxpfzl2i/fkdk9lwGui6sjSkQg/y/sZu05iW/B8iTnv9ymj+Tt
 5qSAi5oQ3PfXcNAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="H/eien5A";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rgv0GMy9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Dy6Z68xceJjsCwiKi/WG511JNdfnVvL8oZMRBUgDw=;
 b=H/eien5ABdVoYdu3Z4lKyVJcxQfMb5MXzmJmi3lIqiZfjPY++/uXoPHTnnSOAV7/gexNy1
 ewXFqVFQZQJ4UNSSRrR+zr8sF3QiMx8jnYg/bPNuV8yrrZeyKlWgtt8nryZihkh6E8hK2x
 utv2ZsY81/z2qBLPeENGaoLY2YtPMio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7Dy6Z68xceJjsCwiKi/WG511JNdfnVvL8oZMRBUgDw=;
 b=rgv0GMy97Az/A2yFXpTCgxpfzl2i/fkdk9lwGui6sjSkQg/y/sZu05iW/B8iTnv9ymj+Tt
 5qSAi5oQ3PfXcNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AABB313AAD
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMvfJ1uTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:22 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-4-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=4177;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=UQQtpJyuy90jA8awtdGCT1dB7/X7WnceiNBgtwxNx2o=;
 b=Mj6xBDDgEFB8YLrJFaY3B0wwkif7dVtfLxJySKu/FTZHgr3+eXZ3JtP4kukVqVHU2ErU15IIu
 CWHnsLarxCzDLIGdHvpI+gWWATkHoGkOcBBiWgrpASBcD9uiMTv5CtZ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: C31AC21125
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/8] setxattr02: add setxattrat variant
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
 testcases/kernel/syscalls/setxattr/setxattr02.c | 71 ++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 18afc031b495570c803dcc2dfc5207c6e8308bf4..a61fcedf447633179946f8e33c12c6ce71f0d5b9 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -36,6 +36,9 @@
 # include <sys/xattr.h>
 #endif
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/xattr.h"
+#include "lapi/fcntl.h"
 
 #ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
@@ -51,6 +54,8 @@
 #define BLK      "setxattr02blk"
 #define SOCK     "setxattr02sock"
 
+static int tmpdir_fd = -1;
+
 struct test_case {
 	char *fname;
 	char *key;
@@ -122,39 +127,59 @@ static struct test_case tc[] = {
 
 static void verify_setxattr(unsigned int i)
 {
+	char *sysname;
+
 	/* some tests might require existing keys for each iteration */
 	if (tc[i].needskeyset) {
 		SAFE_SETXATTR(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
-				XATTR_CREATE);
+			XATTR_CREATE);
 	}
 
-	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
-			tc[i].flags));
+	if (tst_variant) {
+		sysname = "setxattrat";
+
+		struct xattr_args args = {
+			.value = tc[i].value,
+			.size = tc[i].size,
+			.flags = tc[i].flags,
+		};
+
+		int at_flags = tc[i].needskeyset ? 0 : AT_SYMLINK_NOFOLLOW;
+
+		TEST(tst_syscall(__NR_setxattrat,
+			tmpdir_fd, tc[i].fname, at_flags,
+			tc[i].key, &args, sizeof(args)));
+	} else {
+		sysname = "setxattr";
+
+		TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
+				tc[i].flags));
+	}
 
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "setxattr(2) not supported");
+		tst_brk(TCONF, "%s(2) not supported", sysname);
 
 	/* success */
 
 	if (!tc[i].exp_err) {
 		if (TST_RET) {
 			tst_res(TFAIL | TTERRNO,
-				"setxattr(2) on %s failed with %li",
-				tc[i].fname + OFFSET, TST_RET);
+				"%s(2) on %s failed with %li",
+				sysname, tc[i].fname + OFFSET, TST_RET);
 			return;
 		}
 
 		/* this is needed for subsequent iterations */
 		SAFE_REMOVEXATTR(tc[i].fname, tc[i].key);
 
-		tst_res(TPASS, "setxattr(2) on %s passed",
-				tc[i].fname + OFFSET);
+		tst_res(TPASS, "%s(2) on %s passed",
+				sysname, tc[i].fname + OFFSET);
 		return;
 	}
 
 	if (TST_RET == 0) {
-		tst_res(TFAIL, "setxattr(2) on %s passed unexpectedly",
-				tc[i].fname + OFFSET);
+		tst_res(TFAIL, "%s(2) on %s passed unexpectedly",
+				sysname, tc[i].fname + OFFSET);
 		return;
 	}
 
@@ -162,8 +187,8 @@ static void verify_setxattr(unsigned int i)
 
 	if (tc[i].exp_err != TST_ERR) {
 		tst_res(TFAIL | TTERRNO,
-				"setxattr(2) on %s should have failed with %s",
-				tc[i].fname + OFFSET,
+				"%s(2) on %s should have failed with %s",
+				sysname, tc[i].fname + OFFSET,
 				tst_strerrno(tc[i].exp_err));
 		return;
 	}
@@ -172,8 +197,8 @@ static void verify_setxattr(unsigned int i)
 	if (tc[i].needskeyset)
 		SAFE_REMOVEXATTR(tc[i].fname, tc[i].key);
 
-	tst_res(TPASS | TTERRNO, "setxattr(2) on %s failed",
-			tc[i].fname + OFFSET);
+	tst_res(TPASS | TTERRNO, "%s(2) on %s failed",
+			sysname, tc[i].fname + OFFSET);
 }
 
 static void setup(void)
@@ -187,12 +212,30 @@ static void setup(void)
 	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
 	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
 	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
+
+	tmpdir_fd = SAFE_OPEN(tst_tmpdir_path(), O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
+	SAFE_UNLINK(FILENAME);
+	SAFE_RMDIR(DIRNAME);
+	SAFE_UNLINK(SYMLINK);
+	SAFE_UNLINK(FIFO);
+	SAFE_UNLINK(CHR);
+	SAFE_UNLINK(BLK);
+	SAFE_UNLINK(SOCK);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.test = verify_setxattr,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = 2,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 };

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
