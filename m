Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9876CCD184
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:49:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AD123CE3A2
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:49:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4ACA3CE187
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 42911600824
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 086F51F7B4;
 Tue,  7 Oct 2025 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XNRnbcuSBvk5rGjlMAC4jL5NExR4BoCDB/Ew2b2cqA=;
 b=Lebe5Rfcz9LsHUePvabeFyt/gSKduCKQPviyuHtN0zlSbPBwDFAr+FYIiDpT0SVNsc02yn
 Bjhgacqksp8tt4OAkkFUx7RYFBzFIMb1ZXHyDWYLGoE0I44Xi7VuGX7EIefyJ750meWZ/3
 joqd4C/nQBG3/5bnFq1XrimhQ0C4JmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XNRnbcuSBvk5rGjlMAC4jL5NExR4BoCDB/Ew2b2cqA=;
 b=XsuRJEC72wJzx5Z6f4cYfnTSiLiSgxbPXuR8Y6HX92uKP9NzoOu8sGocK75oai+uTNRALu
 eyd3Ky9Qdx7OfrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XNRnbcuSBvk5rGjlMAC4jL5NExR4BoCDB/Ew2b2cqA=;
 b=Lebe5Rfcz9LsHUePvabeFyt/gSKduCKQPviyuHtN0zlSbPBwDFAr+FYIiDpT0SVNsc02yn
 Bjhgacqksp8tt4OAkkFUx7RYFBzFIMb1ZXHyDWYLGoE0I44Xi7VuGX7EIefyJ750meWZ/3
 joqd4C/nQBG3/5bnFq1XrimhQ0C4JmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XNRnbcuSBvk5rGjlMAC4jL5NExR4BoCDB/Ew2b2cqA=;
 b=XsuRJEC72wJzx5Z6f4cYfnTSiLiSgxbPXuR8Y6HX92uKP9NzoOu8sGocK75oai+uTNRALu
 eyd3Ky9Qdx7OfrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BCD13AAC;
 Tue,  7 Oct 2025 06:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKDpBW+35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:56 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-4-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=4461;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=oEZLSD98+Ukqv7Dl3jt+EtC5ExA2B8QPJDDv0d4KHhY=;
 b=sMmD88NTWrTNRNRlk2HYiHmbXo/lzme3b+i+d/2Do1hh49OKP3/fd3d4IgpHL2zC+R3LqyKOd
 M/tqUEhx3Z9Dus5xuboVOai6cUDKto1LxxzXqm+8BYL8vAeEeaVPu7f
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/10] setxattr02: add setxattrat variant
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
 testcases/kernel/syscalls/setxattr/setxattr02.c | 79 +++++++++++++++++++------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 9f5f998da..b5042a0df 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -19,6 +19,10 @@
  */
 
 #include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
@@ -30,12 +34,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
-#include "tst_test.h"
+#include "lapi/xattr.h"
+#include "lapi/fcntl.h"
+#include <sys/xattr.h>
 
-#ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
@@ -49,6 +51,8 @@
 #define BLK      "setxattr02blk"
 #define SOCK     "setxattr02sock"
 
+static int tmpdir_fd = -1;
+
 struct test_case {
 	char *fname;
 	char *key;
@@ -120,39 +124,58 @@ static struct test_case tc[] = {
 
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
+			.value = (uint64_t)tc[i].value,
+			.size = tc[i].size,
+			.flags = tc[i].flags,
+		};
+
+		int at_flags = tc[i].needskeyset ? 0 : AT_SYMLINK_NOFOLLOW;
+
+		TEST(setxattrat(tmpdir_fd, tc[i].fname, at_flags,
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
 
@@ -160,8 +183,8 @@ static void verify_setxattr(unsigned int i)
 
 	if (tc[i].exp_err != TST_ERR) {
 		tst_res(TFAIL | TTERRNO,
-				"setxattr(2) on %s should have failed with %s",
-				tc[i].fname + OFFSET,
+				"%s(2) on %s should have failed with %s",
+				sysname, tc[i].fname + OFFSET,
 				tst_strerrno(tc[i].exp_err));
 		return;
 	}
@@ -170,8 +193,8 @@ static void verify_setxattr(unsigned int i)
 	if (tc[i].needskeyset)
 		SAFE_REMOVEXATTR(tc[i].fname, tc[i].key);
 
-	tst_res(TPASS | TTERRNO, "setxattr(2) on %s failed",
-			tc[i].fname + OFFSET);
+	tst_res(TPASS | TTERRNO, "%s(2) on %s failed",
+			sysname, tc[i].fname + OFFSET);
 }
 
 static void setup(void)
@@ -185,12 +208,30 @@ static void setup(void)
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
