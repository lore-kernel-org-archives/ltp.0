Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA0C3F6B0
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:20:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5098E3C9468
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:20:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6177B3C9423
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DDCB6600634
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 84FFE20FBC;
 Thu,  4 Aug 2022 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApEyE+xesiVk9QbzJaMXMiOp0Dtrs6FcSSRMqodDgag=;
 b=dPRyDXxkAx0hv6IVoqZH2nBCN0IB+s8O8vBM14wm57FbdZrKiZWcl+wCAaZyOAZuzYdPNd
 22+vjR8OSNYb92XSGu5uWaSrRDcsYq40MH6pnI40qPXyTw8WvsXA3c/jzzwm5oY9/EBkYn
 NiYvXPw+KXoCn7Rpv1pprbCl3EVIehU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApEyE+xesiVk9QbzJaMXMiOp0Dtrs6FcSSRMqodDgag=;
 b=yfJmPoGcvQzhaOUD3k6TzA1WpiYVFIZhO8sZw0r08MKYh/frFE06A69/OxaM4dZozS5Ckd
 Ykp9fgj5ZwSKqrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01EAA13A94;
 Thu,  4 Aug 2022 12:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2HwwOWq562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:43 +0200
Message-Id: <20220804121946.19564-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/10] shell: Add $TST_SKIP_FILESYSTEMS + tests
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

C API struct tst_test skip_filesystems member equivalent.

Now only running on single filesystem (will be improved in the next
commit)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 doc/shell-test-api.txt                        |  1 +
 .../shell/tst_skip_filesystems.sh             | 34 +++++++++++++++++++
 .../shell/tst_skip_filesystems_skip.sh        | 16 +++++++++
 testcases/lib/tst_test.sh                     |  6 ++++
 4 files changed, 57 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 65444541e..0961dc5ef 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -229,6 +229,7 @@ simply by setting right '$TST_FOO'.
 | 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
 | 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
                              default value is comma, it only supports single character.
+| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped.
 | 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
                              or -1 (special value to disable timeout), default is 300.
                              Variable is meant be set in tests, not by user.
diff --git a/lib/newlib_tests/shell/tst_skip_filesystems.sh b/lib/newlib_tests/shell/tst_skip_filesystems.sh
new file mode 100755
index 000000000..dd57d6b42
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_skip_filesystems.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_FS_TYPE=ext4
+TST_TESTFUNC=test
+TST_SKIP_FILESYSTEMS="btrfs,ext2,ext3,xfs,vfat,exfat,ntfs,tmpfs"
+TST_CNT=3
+
+test1()
+{
+	EXPECT_PASS "cd $TST_MNTPOINT"
+}
+
+test2()
+{
+	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
+}
+
+test3()
+{
+	local fs fs_skip
+
+	fs=$(grep "$TST_MNTPOINT $TST_FS_TYPE" /proc/mounts | cut -d ' ' -f3)
+	EXPECT_PASS "[ '$fs' = '$TST_FS_TYPE' ]"
+
+	for fs_skip in $TST_SKIP_FILESYSTEMS; do
+		EXPECT_FAIL "[ $fs = $fs_skip ]"
+	done
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
new file mode 100755
index 000000000..0d291a0a0
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_FS_TYPE=ext4
+TST_TESTFUNC=test
+TST_SKIP_FILESYSTEMS="ext4"
+
+test()
+{
+	tst_res TFAIL "test should be skipped with TCONF"
+}
+
+. tst_test.sh
+tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 3494f7786..926053357 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -626,6 +626,7 @@ tst_run()
 	local _tst_max
 	local _tst_name
 	local _tst_pattern='[='\''"} \t\/:`$\;].*'
+	local ret
 
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
@@ -644,6 +645,7 @@ tst_run()
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
+			SKIP_FILESYSTEMS);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -675,6 +677,10 @@ tst_run()
 			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
 	fi
 
+	tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
+	ret=$?
+	[ $ret -ne 0 ] && return $ret
+
 	_tst_setup_timer
 
 	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
