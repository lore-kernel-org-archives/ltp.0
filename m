Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD651C47DA9
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 09:22:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0B623CE112
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 10:22:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4150A3CC020
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:22:39 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A67E20650E
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:22:37 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED5831F7D8;
 Mon, 29 Jan 2024 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706520157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=siBEeiF60dnzKv0UKtH4eikc6F4oB2U0kG2P25QF/p4=;
 b=WMoaWnSHMmhQWPf27ZCNQ2gemO7zVFZ9gd4iOR9TFs3vlybbM2YDIzg8pOQV2bFqo6dpLQ
 XF92ywlaEa7ZbBRLQTfF0oB4elN67+Vx/DG/8s7GHZYtUrV/agNjoT81KaUSp71zTINhwK
 I+bD00uS+mNEp7nmkJgOZg0IYlzhwhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706520157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=siBEeiF60dnzKv0UKtH4eikc6F4oB2U0kG2P25QF/p4=;
 b=lri/9g4K2ewdQLD9B+eq5Q0Ys2o1DRQ7SMesJ9gdPwXouixxLwUj8kb+2CvIHdnMqB6JTB
 yZbl96U4STPwsBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706520155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=siBEeiF60dnzKv0UKtH4eikc6F4oB2U0kG2P25QF/p4=;
 b=hLafyL9BPQjke+U950emDCRB9hsHT3m5VXSwQpaFus79LRPIGSRdfgMdi0AylZPdxbCMEL
 BU9bQBDP7OgiyPbimL7B5Q4zK3K1D9DhuE+rLyNy1BRAOn04XIF+5udFjeGqIWe2AF9UsP
 TwIv55HL25QznZLCyoHxX9fB5YKAVmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706520155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=siBEeiF60dnzKv0UKtH4eikc6F4oB2U0kG2P25QF/p4=;
 b=6d1Jq4dt02p0Lsfflh7vxm9gCqZgRtYWdQmZasCII9LYQHCquJaXjIMnllFMeknt6N2M5g
 XRdMTK9zDg43DhAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD5F13911;
 Mon, 29 Jan 2024 09:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id m1FSJltut2U/QgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 09:22:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jan 2024 10:22:32 +0100
Message-ID: <20240129092232.599010-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hLafyL9B;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6d1Jq4dt
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 TAGGED_RCPT(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED5831F7D8
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] isofs.sh: Test genisoimage,
 xorriso and mksisofs
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>

Run test an all 3 tools: genisoimage, xorriso and mksisofs.

mkisofs, genisoimage and xorriso tools are present as separate tools in
some distros while in others they are symlinks to one another. Tests are
skipped on symlinks.

mkisofs supports only -hfs option
genisoimage supports both -hfs and -hfsplus options
xorrisofs supports only -hfsplus option

This actually fixes xorrisofs on CentOS which is a symlink to mkisofs
and because it does not supports -hfs test IMHO fails.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Co-Authored-By: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@Cyril unless you ack this, it will be merged after the release.

Also, I consider to implement test variants for shell API, because it
would be better to use tests variants for this (and test variants would
be useful to be used here and for ping tests.

Kind regards,
Petr

 testcases/kernel/fs/iso9660/isofs.sh | 49 ++++++++++++++++++----------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index dfa4ac73d..06f97a64f 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines Corp., 2003
-# Copyright (c) Linux Test Project, 2016-2021
+# Copyright (c) Linux Test Project, 2016-2024
 # Written by Prakash Narayana (prakashn@us.ibm.com)
 # and Michael Reed (mreed10@us.ibm.com)
 #
@@ -11,23 +11,12 @@
 
 TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
-TST_SETUP=setup
 TST_TESTFUNC=do_test
+TST_CNT=3
 
 MAX_DEPTH=3
 MAX_DIRS=4
 
-setup()
-{
-	if tst_cmd_available mkisofs; then
-		MKISOFS_CMD="mkisofs"
-	elif tst_cmd_available genisoimage; then
-		MKISOFS_CMD="genisoimage"
-	else
-		tst_brk TCONF "please install mkisofs or genisoimage"
-	fi
-}
-
 gen_fs_tree()
 {
 	local cur_path="$1"
@@ -50,10 +39,33 @@ do_test()
 	local make_file_sys_dir="$PWD/files"
 	local mkisofs_opt mount_opt
 
+	case $1 in
+		1) MKISOFS_CMD="mkisofs"
+			HFSOPT="-hfs -D"
+			GREPOPT="mkisofs";;
+		2) MKISOFS_CMD="genisoimage"
+			HFSOPT="-hfsplus -D -hfs -D"
+			GREPOPT="genisoimage";;
+		3) MKISOFS_CMD="xorrisofs"
+			HFSOPT="-hfsplus -D"
+			GREPOPT="xorriso";;
+	esac
+
+	tst_res TINFO "Testing $MKISOFS_CMD"
+
+	if ! tst_cmd_available $MKISOFS_CMD; then
+		tst_res TCONF "Missing '$MKISOFS_CMD'"
+		return
+	fi
+
+	if ! $MKISOFS_CMD 2>&1 | head -n 2 | grep -q "$GREPOPT"; then
+		tst_res TCONF "'$MKISOFS_CMD' is a symlink to another tool"
+		return
+	fi
+
 	mkdir -p -m 777 $mnt_point
 	mkdir -p $make_file_sys_dir
 
-	# Generated directories and files
 	mkdir -p $make_file_sys_dir
 	gen_fs_tree "$make_file_sys_dir" 1
 
@@ -62,15 +74,16 @@ do_test()
 	for mkisofs_opt in \
 		" " \
 		"-J" \
-		"-hfs -D" \
+		"$HFSOPT" \
 		" -R " \
 		"-R -J" \
 		"-f -l -D -J -allow-leading-dots -R" \
-		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
+		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J \
+			-allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
-			|| continue
+		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt \
+			$make_file_sys_dir 2\> /dev/null || continue
 
 		for mount_opt in \
 			"loop" \
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
