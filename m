Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACC4C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:28:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D0283C9EF6
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:28:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27E8D3C9E45
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 639C1600F70
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E02F31F399;
 Thu, 10 Feb 2022 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BC9Iz6ON8XkX+j9vqBr89stuV43ZZGCbwDcetTtBuo=;
 b=1V10vUqnzS17E4WSm+jK8r1pCF+D/UkmYx6fTxIc1Eb15PEr5KBT/8vZgvg83biZp3VU3V
 lPtXZl3KjLonpJBJrqDScR5xuiDwxOQKPN4OX0GiOH4PGfRVZ9b+gLaPxT316vNL/DOkJ5
 Xoy2/CNsaolQ4QjYPa437HXybu8PGtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BC9Iz6ON8XkX+j9vqBr89stuV43ZZGCbwDcetTtBuo=;
 b=f0XxdEYyNNNyuqpQmbHcgxZ1ulox3DQxTgEPVCup07Ud1kG2OpC9UjKhkSut8rW9fJZZcA
 LmrpP4+h3liPafCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E46F13BC1;
 Thu, 10 Feb 2022 16:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uDlEJP88BWJAMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:27:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:27:34 +0100
Message-Id: <20220210162739.30159-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210162739.30159-1-pvorel@suse.cz>
References: <20220210162739.30159-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] tst_test.sh: Properly init $TST_FS_TYPE
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

to sync with C API init $TST_FS_TYPE with $LTP_DEV_FS_TYPE, when
defined. That's equivalent of the .dev_fs_type in the tst_test
structure:

    if (tst_test->dev_fs_type)
	    tdev.fs_type = tst_test->dev_fs_type;
    else
	    tdev.fs_type = tst_dev_fs_type();

    (And the tst_dev_fs_type() returns either $LTP_DEV_FS_TYPE or "ext2"
    if it's not defined.)

Now, when $TST_FS_TYPE properly defined, tst_mkfs() can rely on it
(thus define the check).

Also use the variable in df01.sh, mkfs01.sh (the only shell tests which
works with filesystems).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/df/df01.sh     | 2 --
 testcases/commands/mkfs/mkfs01.sh | 2 +-
 testcases/lib/tst_test.sh         | 8 ++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index b821452e60..e70f33c9b0 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -28,8 +28,6 @@ OPTIONS
 EOF
 }
 
-TST_FS_TYPE=ext2
-
 parse_args()
 {
 	TST_FS_TYPE="$2"
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 17c7fb9e4a..a3ff027a6d 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -45,7 +45,7 @@ setup()
 mkfs_verify_type()
 {
 	if [ -z "$1" ]; then
-		blkid $2 -t TYPE="ext2" >/dev/null
+		blkid $2 -t TYPE="$TST_FS_TYPE" >/dev/null
 	else
 		if [ "$1" = "msdos" ]; then
 			blkid $2 -t TYPE="vfat" >/dev/null
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 30614974c3..fa4c90f787 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,10 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+if [ -z "$TST_FS_TYPE" ]; then
+	export TST_FS_TYPE="${LTP_DEV_FS_TYPE:-ext2}"
+fi
+
 . tst_ansi_color.sh
 . tst_security.sh
 
@@ -343,10 +347,6 @@ tst_mkfs()
 	[ $# -ge 1 ] && shift
 	local fs_opts="$@"
 
-	if [ -z "$fs_type" ]; then
-		tst_brk TBROK "No fs_type specified"
-	fi
-
 	if [ -z "$device" ]; then
 		tst_brk TBROK "No device specified"
 	fi
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
