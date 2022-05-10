Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFF4C433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BD6F3CA961
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 17:55:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033493CA932
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6981D20076F
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2EAC1F8B5;
 Tue, 10 May 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652198082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbnw5z+t3cDTDSn/gWXqUfm1orHUE00fqickNCsNOM4=;
 b=feJyIxIbbXBUN1bvZPKamQp6ZL/L5snBfB5DBjqVdxgDtbLi+WuXOm2jQYeNSknnk1l6zk
 8CmM10M7Z/Wk0EKlb74OEq1pbNhBBTQBftjwuoQ/b11Il0wlWlxNkW4zoaP3ewJFtWXDLU
 qk7fx+FbzTtb5dTefHa3QQ0/4vk6rQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652198082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbnw5z+t3cDTDSn/gWXqUfm1orHUE00fqickNCsNOM4=;
 b=5uCYQPBmqlGtW7WthHSxYKtovzS3+xxnGKZg8GlU/K/WVacx+gBcUhCuExMcHMERheSYRH
 zdNaQHPtGBlir/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94C8613AA5;
 Tue, 10 May 2022 15:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4NQ8IsKKemIScwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 15:54:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 May 2022 17:54:35 +0200
Message-Id: <20220510155438.15754-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510155438.15754-1-pvorel@suse.cz>
References: <20220510155438.15754-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] tst_test.sh: Add $TST_MOUNT_DEVICE
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt    |  2 ++
 testcases/lib/tst_test.sh | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index df5ebbdf0..65444541e 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -214,6 +214,8 @@ simply by setting right '$TST_FOO'.
                              https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem].
 | 'TST_MNT_PARAMS'         | Extra mount params for 'tst_mount', see
                              https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem].
+| 'TST_MOUNT_DEVICE'       | Mount device, see
+                             https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#mounting-and-unmounting-filesystems[Mounting and unmounting filesystems].
 | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
                              Alternatively the 'tst_require_root' command can be used.
 | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 28b7d12ba..1fe77d50d 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -41,6 +41,10 @@ _tst_do_exit()
 		fi
 	fi
 
+	if [ "$TST_MOUNT_DEVICE" = 1 -a "$TST_MOUNT_FLAG" = 1 ]; then
+		tst_umount
+	fi
+
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
 		if ! tst_device release "$TST_DEVICE"; then
 			tst_res TWARN "Failed to release device '$TST_DEVICE'"
@@ -632,7 +636,7 @@ tst_run()
 			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
-			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE);;
+			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -666,6 +670,7 @@ tst_run()
 
 	_tst_setup_timer
 
+	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
 	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
@@ -702,6 +707,11 @@ tst_run()
 		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
 	fi
 
+	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
+		tst_mount
+		TST_MOUNT_FLAG=1
+	fi
+
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	if [ -n "$TST_SETUP" ]; then
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
