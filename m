Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705BCC2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB1E3C9836
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:45:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1CB3C98CE
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:44:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7779F1000362
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:44:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B849B33928
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660635895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XRwTZUJABvLttJNy3XCQAMBevJeAxqDTqpZPnCVzhVk=;
 b=B7M2toa7D2E4pNzyhhTgKg+PA5e17kfeOlfxdNNFxyNgdH7a/Rui+R1hH8he0uWUarw46t
 icZWYjgUy5AsuaZ3LXD9kSV04LPEy2lD+zfkhevTpDtwICrL0obw3rmKky/kE2EwqcMDGS
 M1WJco8jOiL6oVN6bsFiAk5fY3EU7uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660635895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XRwTZUJABvLttJNy3XCQAMBevJeAxqDTqpZPnCVzhVk=;
 b=daMGnvsGXIAz3guz9/xBCaC+oVwONGcP7V2oAldXREreGAvm4FaeX5iAaYf+xlZzinT1+v
 lCUumZjNM9I4JNCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B9CE1345B
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7G9vAPdK+2KBSwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:44:55 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 16 Aug 2022 13:14:49 +0530
Message-Id: <20220816074449.30861-2-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] stat03: cleanup, use TST_EXP_FAIL macro
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

- update copyright
- turn comment into docparse format
- remove redundant headers
- make check fix: change to static
- use TST_EXP_FAIL with expected errno code

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/stat/stat03.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 20d4c772f..369e6d79f 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -2,15 +2,16 @@
 /* Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 John George
  *		-Ported
+ * Copyright (c) Linux Test Project, 2002-2022
+ */
+
+/*\
+ * [Description]
  *
  * check stat() with various error conditions that should produce
  * EACCES, EFAULT, ENAMETOOLONG,  ENOENT, ENOTDIR, ELOOP
  */
 
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <pwd.h>
 #include "tst_test.h"
 
@@ -23,7 +24,7 @@
 #define MODE_RW	        0666
 #define DIR_MODE        0755
 
-struct passwd *ltpuser;
+static struct passwd *ltpuser;
 
 static char long_dir[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
 static char loop_dir[PATH_MAX] = ".";
@@ -45,19 +46,7 @@ static void verify_stat(unsigned int n)
 	struct tcase *tc = TC + n;
 	struct stat stat_buf;
 
-	TEST(stat(tc->pathname, &stat_buf));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "stat() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "stat() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"stat() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, tst_strerrno(tc->exp_errno));
-	}
+	TST_EXP_FAIL(stat(tc->pathname, &stat_buf), tc->exp_errno);
 }
 
 static void setup(void)
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
