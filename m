Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6684C32771
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 10:27:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 503753CAD5D
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 12:27:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31D93C1B85
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 12:27:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0F69A1000F46
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 12:27:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B8011F7AB;
 Wed, 21 Sep 2022 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663756020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYGwlpSuc2vcucjqzvSUpugrnRPQtbplfqtW6gZGq7M=;
 b=ICYOiURBZMuHa7OmLjT1wG7PeRNY38PQLWJarD68iXY2IInZESqdgXP9MrQ3zqVFW9m7kc
 U0HShYiKU683FbcrFjqZOKeB6AGnVFTZbZwpv95kTE5M7J5G0DB1Rnw8M0uywEpBMCGKWq
 okHohaqlTNFfbkfHeTilrfyYIzzqlPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663756020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYGwlpSuc2vcucjqzvSUpugrnRPQtbplfqtW6gZGq7M=;
 b=uXmxku9cl9yb+W95mIj49Lpf7SW8TpgMrhuhCvxrBZoQ6VglK9FZH+fgO/1uYUjcfsbN/W
 mtu1R4odXyjVNdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0B1C13A89;
 Wed, 21 Sep 2022 10:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QOk2LPPmKmOYYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Sep 2022 10:26:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 21 Sep 2022 12:26:55 +0200
Message-Id: <20220921102655.31156-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Fix filesystem support detection
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

Not printing extra TINFO "$_tst_fs is supported by the test" (which is
printed in C API) when test is supported, because there is already
similar TINFO from testcases/lib/tst_supported_fs.c:
tst_supported_fs.c:104: TINFO: btrfs is not skipped

Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
First, sorry for introducing a regression.

I don't like df and tail dependency. Also df output is stable (even on
busybox), but I'd prefer to use code from do_test_setup() in lib/tst_test.c:

	long fs_type = tst_fs_type(".");
	const char *fs_name = tst_fs_type_name(fs_type);

Instead adding yet another binary, I wonder if we could add extra getopt
parameter to ask for current filesystem.

i.e. to replace:
-tst_supported_fs -s skip_list fs_type
+tst_supported_fs -s skip_list -d DIR

Because 'tst_supported_fs -s skip_list fs_type' mode is used only in
tst_test.sh.

Whole help would be:

$ ./testcases/lib/tst_supported_fs -h
* all filesystems
tst_supported_fs [-s skip_list]
   print the list of supported filesystems
   if fs_type is supported and not in skip_list (optional),
   print list of supported filesystems and return 0
   if fs_type isn't supported or in skip_list, return 1

* single filesystem
tst_supported_fs fs_type
   if fs_type is supported, return 0 otherwise return 1

-tst_supported_fs -s skip_list fs_type
+tst_supported_fs -s skip_list -d DIR
   if fs_type is in skip_list, return 1 otherwise return 0

fs_type - a specified filesystem type
skip_list - filesystems to skip, delimiter: ','

 testcases/lib/tst_test.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 229317713..1691846ae 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -703,12 +703,6 @@ tst_run()
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
 
@@ -736,6 +730,15 @@ tst_run()
 		cd "$TST_TMPDIR"
 	fi
 
+	if [ "$TST_ALL_FILESYSTEMS" != 1 -a "$TST_SKIP_FILESYSTEMS" ]; then
+		tst_require_cmds df tail
+		_tst_fs="$(df -T . | tail -1 | awk '{print $2}')"
+		[ "$_tst_fs" ] || tst_brk TBROK "failed to detect filesystem for $PWD"
+		if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $_tst_fs > /dev/null; then
+			tst_brk TCONF "$_tst_fs is not supported by the test"
+		fi
+	fi
+
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
