Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E5CC433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 09:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E80073CAE8D
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 11:00:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 965403C0FBC
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 10:59:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 02DAA600670
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 10:59:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2C84218D5;
 Mon, 10 Oct 2022 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665392390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=368aSTC7/50N6sJ7VJ5/tzE4ryg0nGQCMEhKdTsWaI4=;
 b=T1Fw9rgeU/vdUlKD3zS3PGe5fevcZ3thxCl9Q/E9aKup0sMheu3Wb0qMkTzW3Jnhq34U/r
 nnpOlIY/FGr7dHssPly2zM/fzvcK4KXneulTYs4cWHRshAnavujkv3WRnG4VdFq1qrE56N
 0J0liCaoPNkrqJq574dqG+RQSHkac3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665392390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=368aSTC7/50N6sJ7VJ5/tzE4ryg0nGQCMEhKdTsWaI4=;
 b=5RbXcjwo+dJOBmaDAcQQIHmJ9PnDTBhNravZYdFxPveMo2Xd9t3w4i7lwekthoFJJc2znz
 j4DMYDuM3ZW3eLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67FBF13479;
 Mon, 10 Oct 2022 08:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5gNNFwbfQ2O2fQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Oct 2022 08:59:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 10:59:44 +0200
Message-Id: <20221010085944.26814-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.sh: Create (again) loop device in
 $TST_TMPDIR
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

Before 1f6bd6e66 loop device for testing test_dev.img was created in
shell API after cd to $TST_TMPDIR, therefore automatically removed
during the cleanup in _tst_do_exit(). This got broken in 1f6bd6e66,
fix it.

Although it'd be good not relying on this order (full path could be kept
and then pass to rm), it's better to have all LTP temporary files under
$TST_TMPDIR, thus just restore the order.

Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I'm sorry for introducing yet another regression in
$TST_ALL_FILESYSTEMS.

Kind regards,
Petr

 testcases/lib/tst_test.sh | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 033491b08..5af345938 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -716,6 +716,20 @@ tst_run()
 	[ "$TST_FORMAT_DEVICE" = 1 -o "$TST_ALL_FILESYSTEMS" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
+	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
+		if [ -z "$TMPDIR" ]; then
+			export TMPDIR="/tmp"
+		fi
+
+		TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")
+
+		chmod 777 "$TST_TMPDIR"
+
+		TST_STARTWD=$(pwd)
+		cd "$TST_TMPDIR"
+	fi
+
+	# needs to be after cd $TST_TMPDIR to keep test_dev.img under $TST_TMPDIR
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		TST_DEVICE=$(tst_device acquire)
 
@@ -730,19 +744,6 @@ tst_run()
 		fi
 	fi
 
-	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
-		if [ -z "$TMPDIR" ]; then
-			export TMPDIR="/tmp"
-		fi
-
-		TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")
-
-		chmod 777 "$TST_TMPDIR"
-
-		TST_STARTWD=$(pwd)
-		cd "$TST_TMPDIR"
-	fi
-
 	if [ "$TST_ALL_FILESYSTEMS" != 1 -a "$TST_SKIP_FILESYSTEMS" ]; then
 		if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" -d . > /dev/null; then
 			tst_brk TCONF "filesystem is not supported by the test"
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
