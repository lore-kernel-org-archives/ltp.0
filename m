Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AD3C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:56:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A713A3CAD86
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:56:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FFDE3CAA78
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A952B60111D
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F07401FA44;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663930559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anHbnOalArQL+l+DWGRYGH9zCEdfllvLDTEwuAvz4r0=;
 b=JfVKHQJTZWcB2wmFEhB0Hrq29UNtnCdQMlq0YndbbyCXjL0Cs6k/QLurGd+ZKo7O5dfbY9
 jHM+4XUIThgyaF7QnAj6iic68dC2nffj4KHycXIGG3K+EcH3oCJilq2YUW9Pcskk/lNA4Y
 1hius+jp4tf/Q2OmBisqMgSK5vAD75A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663930559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anHbnOalArQL+l+DWGRYGH9zCEdfllvLDTEwuAvz4r0=;
 b=bI2GcwaKN4zF1M33x6+/g+fwSl1FWcBo0oXTicnlgL/1gSh33Yejb0zFnHL0BPr699aSX1
 JDHM0xjaCMD2OYCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B330913AA5;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAALKr+QLWMBSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 10:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Sep 2022 12:55:53 +0200
Message-Id: <20220923105554.28942-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923105554.28942-1-pvorel@suse.cz>
References: <20220923105554.28942-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ima_setup.sh: Use TST_MOUNT_DEVICE
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

Use TST_MOUNT_DEVICE instead of mounting loop device manually.

Also move unset TST_NEEDS_DEVICE before loading tst_test.sh, as it's not
a good idea to modify the API variables after loading tst_test.sh.

NOTE: removed cd before umount as it has been resolved in the shell API
(tst_test.sh) in the previous commit.

Fixes: 04021637f ("tst_test.sh: Cleanup getopts usage")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_setup.sh | 29 +++++--------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index a626aae44..055701aff 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -10,8 +10,9 @@ TST_SETUP="ima_setup"
 TST_CLEANUP_CALLER="$TST_CLEANUP"
 TST_CLEANUP="ima_cleanup"
 TST_NEEDS_ROOT=1
+TST_MOUNT_DEVICE=1
 
-# TST_NEEDS_DEVICE can be unset, therefore specify explicitly
+# TST_MOUNT_DEVICE can be unset, therefore specify explicitly
 TST_NEEDS_TMPDIR=1
 
 SYSFS="/sys"
@@ -142,15 +143,6 @@ mount_helper()
 	echo $default_dir
 }
 
-mount_loop_device()
-{
-	local ret
-
-	tst_mkfs
-	tst_mount
-	cd $TST_MNTPOINT
-}
-
 print_ima_config()
 {
 	local config="${KCONFIG_PATH:-/boot/config-$(uname -r)}"
@@ -183,9 +175,9 @@ ima_setup()
 
 	print_ima_config
 
-	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
+	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
-		mount_loop_device
+		cd "$TST_MNTPOINT"
 	fi
 
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
@@ -200,11 +192,6 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
-
-	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
-		cd $TST_TMPDIR
-		tst_umount
-	fi
 }
 
 set_digest_index()
@@ -348,10 +335,10 @@ require_evmctl()
 	fi
 }
 
-. tst_test.sh
-
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
-if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
-	unset TST_NEEDS_DEVICE
+if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_MOUNT_DEVICE" ]; then
+	unset TST_MOUNT_DEVICE
 fi
+
+. tst_test.sh
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
