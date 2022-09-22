Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C9ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 21:09:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE9B43CAD86
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 23:09:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20C2A3C93EF
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DDB7200C88
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5D331F86A;
 Thu, 22 Sep 2022 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663880980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJRMDrcz5ZXJjyzoi0tLVgHtc1uZ5VANQAhZInIGe7M=;
 b=JwtwLCff5ADV2tj9mDccWAhlZxK2qe52sQHp2RBDu98p0zj43XrfMs+pmFuBB81q49yLzj
 HywqkYL/H+waMszKOwU+fUIWSqtfvlP5ptRgyxlW3jZsb7EKlhc0g/s2MK55B0E7PN6ZJ9
 CQuWxSeNvDV4UOfLfDz5VgT6Wj8KqCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663880980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJRMDrcz5ZXJjyzoi0tLVgHtc1uZ5VANQAhZInIGe7M=;
 b=L/hGVuvZbrZV3t+n6Q55GqMIYxGp1DrYXhvjtE09ZCsS5u1/BF0UpZSPAkxcOE483+dVYY
 K6ySxF/5q5Hx7FAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EF241346B;
 Thu, 22 Sep 2022 21:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gIfAGRTPLGMYKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 21:09:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Sep 2022 23:09:31 +0200
Message-Id: <20220922210931.23982-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922210931.23982-1-pvorel@suse.cz>
References: <20220922210931.23982-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3 v2] tst_test.sh: Fix filesystem support detection
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

Filesystem detection of locally used filesystem was broken on tests
which did not use TST_ALL_FILESYSTEMS as it 1) expected used filesystem
is $TST_FS_TYPE 2) this variable was not yet set.

Also this check makes sense only if test defines TST_SKIP_FILESYSTEMS
(to align with the condition in do_test_setup() in C API).

Move filesystem check after (optional) cd "$TST_TMPDIR" (TMPDIR can have
different filesystem).

Remove tst_skip_filesystems_skip.sh test, as filesystem on tmpfs would
have to be detected before.

Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../shell/tst_skip_filesystems_skip.sh          | 17 -----------------
 testcases/lib/tst_test.sh                       | 14 ++++++++------
 2 files changed, 8 insertions(+), 23 deletions(-)
 delete mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

diff --git a/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
deleted file mode 100755
index 6748d021d..000000000
--- a/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
-
-TST_MOUNT_DEVICE=1
-TST_NEEDS_ROOT=1
-TST_FS_TYPE=ext4
-TST_TESTFUNC=test
-TST_SKIP_FILESYSTEMS="ext4"
-
-test()
-{
-	tst_res TFAIL "test should be skipped with TCONF"
-}
-
-. tst_test.sh
-tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 33aadea91..01c01b79b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -702,12 +702,6 @@ tst_run()
 	[ "$TST_FORMAT_DEVICE" = 1 -o "$TST_ALL_FILESYSTEMS" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
-	if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
-		if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE > /dev/null; then
-			tst_brk TCONF "$TST_FS_TYPE is skipped by the test"
-		fi
-	fi
-
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		TST_DEVICE=$(tst_device acquire)
 
@@ -735,6 +729,14 @@ tst_run()
 		cd "$TST_TMPDIR"
 	fi
 
+	if [ "$TST_ALL_FILESYSTEMS" != 1 -a "$TST_SKIP_FILESYSTEMS" ]; then
+		if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" -d . > /dev/null; then
+			tst_brk TCONF "filesystem is not supported by the test"
+		fi
+
+		tst_res TINFO "filesystem is supported by the test"
+	fi
+
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
