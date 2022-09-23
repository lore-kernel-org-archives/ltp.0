Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D97EECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:56:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7183CAD99
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:56:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9EDF3CAD6B
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53E141000944
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A88EA21A0B;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663930559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEyD2lDKA+8oDWinzN04qy4bWjf9fDAn0XhkuEG8qjk=;
 b=pxw8dF0hdax9zEoIrAQEtwH/q5OmRymu1w816p5kTEy2fNN5mRZUJJ9PZ39Ns3s4MQL/9j
 +Q82IakxkrmwxEPs26YfyjRAi454ByvvIKT8gGdYBZfvRDH7RHm2795Vry6zxwdxEeJ2hL
 esbhpe//UlhaOtYpEoTyaOcMBtQfW6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663930559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEyD2lDKA+8oDWinzN04qy4bWjf9fDAn0XhkuEG8qjk=;
 b=scmDqdDxkOrplVptXLxMvLQz6oOF62a8UoEwGfWfM96CnpNPHkR8tDyR+T0ixxDph0YYgB
 X/dCINcSE4rbwABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A0C13AA5;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2G8TGL+QLWMBSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 10:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Sep 2022 12:55:52 +0200
Message-Id: <20220923105554.28942-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923105554.28942-1-pvorel@suse.cz>
References: <20220923105554.28942-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_test.sh: cd to $LTPROOT before umount
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

It's safer not to expect tests go away from the mountpoint
before trying to unmount it, because tests can cd to $TST_MNTPOINT
if they use TST_MOUNT_DEVICE=1. Also better to handle it in the library
than in all tests which may need it.

This fix ima_keys.sh and other following IMA/EVM tests which fail on
systems with tmpfs on $TMPDIR since 1f6bd6e66:

        ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
        tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

        Usage:
        tst_device acquire [size [filename]]
        tst_device release /path/to/device
        tst_device clear /path/to/device

        ima_keys 1 TWARN: Failed to release device '/dev/loop0'
        rm: cannot remove '/tmp/LTP_ima_keys.YArl935DCg/mntpoint': Device or resource busy

Fixme: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 01c01b79b..7ec744cac 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -29,6 +29,7 @@ _tst_do_exit()
 	local ret=0
 	TST_DO_EXIT=1
 
+	cd "$LTPROOT"
 	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
@@ -38,7 +39,6 @@ _tst_do_exit()
 	fi
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 -a -n "$TST_TMPDIR" ]; then
-		cd "$LTPROOT"
 		rm -r "$TST_TMPDIR"
 		[ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
 	fi
@@ -794,6 +794,7 @@ _tst_run_iterations()
 	fi
 
 	if [ "$TST_MOUNT_FLAG" = 1 ]; then
+		cd "$LTPROOT"
 		tst_umount
 		TST_MOUNT_FLAG=
 	fi
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
