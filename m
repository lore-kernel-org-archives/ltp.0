Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384DCCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4833CE33B
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:50:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B512B3CE2CF
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B19891A007FD
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1361F789;
 Tue,  7 Oct 2025 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCft9HLV8aIZHQtSwH3pZRxU3OZ1zthE2sKm1iyEPH0=;
 b=O5JoZaHgoZtMjuG3+niWp6hkncdyNxsdBRgogypXK8e2aTDBTQkf9ksfpbxPgP4nynkIC6
 sEeOXjvwJ3zgRLPMxIhn6UvtB1CwxeoqKusoka90bB5cHtvrq6I6hxBCY0z1g6BDFJlVZ9
 YtOhFs3UMx1rZ2DAmvcZuynefHA/3Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCft9HLV8aIZHQtSwH3pZRxU3OZ1zthE2sKm1iyEPH0=;
 b=SqE+0Yb01/8pTK0cxt3XmGpHT1pSC1pg1aKuIU/F3eprAT8qa/rwaGW0/szbp3/PDEg8tf
 hpGuVqItFEs3+1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCft9HLV8aIZHQtSwH3pZRxU3OZ1zthE2sKm1iyEPH0=;
 b=O5JoZaHgoZtMjuG3+niWp6hkncdyNxsdBRgogypXK8e2aTDBTQkf9ksfpbxPgP4nynkIC6
 sEeOXjvwJ3zgRLPMxIhn6UvtB1CwxeoqKusoka90bB5cHtvrq6I6hxBCY0z1g6BDFJlVZ9
 YtOhFs3UMx1rZ2DAmvcZuynefHA/3Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCft9HLV8aIZHQtSwH3pZRxU3OZ1zthE2sKm1iyEPH0=;
 b=SqE+0Yb01/8pTK0cxt3XmGpHT1pSC1pg1aKuIU/F3eprAT8qa/rwaGW0/szbp3/PDEg8tf
 hpGuVqItFEs3+1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5309013AAC;
 Tue,  7 Oct 2025 06:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BJRCHC35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:57 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-5-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=2466;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=x26N36qcvMOVwqwJ9qEH7fT7/LcHo5acj6KWImN/s/A=;
 b=jerTbaiPSiX3+2ziUL2vXyBtSLwNo9PT/6BZEm14yx1SoO53nFtHDIerFQowUnSDSss0Kv/dZ
 ijcnCaw40aGBkk00Lv5B4QZ2WNyX7deTrmvSN5YGmzRf0rf3F3IBBz5
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/10] setxattr03: add setxattrat variant
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
 testcases/kernel/syscalls/setxattr/setxattr03.c | 35 +++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index 0b5b48a55..2465edd69 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -12,7 +12,12 @@
  */
 
 #define _GNU_SOURCE
+
 #include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -24,14 +29,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
 #include "lapi/fs.h"
+#include "lapi/xattr.h"
+#include <sys/xattr.h>
 
-#include "tst_test.h"
-
-#if defined HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -76,11 +77,23 @@ static struct test_case tc[] = {
 
 static int immu_fd;
 static int append_fd;
+static int tmpdir_fd = -1;
 
 static void verify_setxattr(unsigned int i)
 {
-	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
-			tc[i].flags));
+	if (tst_variant) {
+		struct xattr_args args = {
+			.value = (uint64_t)tc[i].value,
+			.size = tc[i].size,
+			.flags = tc[i].flags,
+		};
+
+		TEST(setxattrat(tmpdir_fd, tc[i].fname, AT_SYMLINK_NOFOLLOW,
+			tc[i].key, &args, sizeof(args)));
+	} else {
+		TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
+				tc[i].flags));
+	}
 
 	if (!TST_RET) {
 		tst_res(TFAIL, "%s succeeded unexpectedly", tc[i].desc);
@@ -143,10 +156,15 @@ static void setup(void)
 	if (set_append_on(append_fd))
 		tst_brk(TBROK | TERRNO, "Set %s append-only failed",
 			APPEND_FILE);
+
+	tmpdir_fd = SAFE_OPEN(tst_tmpdir_path(), O_DIRECTORY);
 }
 
 static void cleanup(void)
 {
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
 	if ((immu_fd > 0) && set_immutable_off(immu_fd))
 		tst_res(TWARN | TERRNO, "Unset %s immutable failed",
 			 IMMU_FILE);
@@ -167,6 +185,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
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
