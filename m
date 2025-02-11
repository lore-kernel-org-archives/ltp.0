Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BC9C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 20:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1573D3C9995
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:58:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 663B33C769D
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:57:40 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F18D205CF5
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:57:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07765336A9;
 Tue, 11 Feb 2025 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739307457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NbHOf2hh4pZfD6uP3ZhFPeuiB6mdoR499zz2rT4nQ2E=;
 b=G3ZqwtgycoxER43GeTnhKbBPFuhphI/1cC4S+pckabjxKHsEiT3uAaQAObEJ5gW26A7rVO
 +EFfsV7fU9ArTzFd/Z4W0nad+eTvUr3NHfveHYNeXCwP2YKW05v2K1wz0l1puwlvnWnYdb
 HSME85rJUOiZDJU+Oqnp2ToEzvSs5/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739307457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NbHOf2hh4pZfD6uP3ZhFPeuiB6mdoR499zz2rT4nQ2E=;
 b=EusRzXSLW9k+/zefHusI7RvfkXL146h821esGlHfbBiBVWvBtR5qDOKJZ2G7pKjutRvgG1
 433yqFqZJ/pu9sAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739307457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NbHOf2hh4pZfD6uP3ZhFPeuiB6mdoR499zz2rT4nQ2E=;
 b=G3ZqwtgycoxER43GeTnhKbBPFuhphI/1cC4S+pckabjxKHsEiT3uAaQAObEJ5gW26A7rVO
 +EFfsV7fU9ArTzFd/Z4W0nad+eTvUr3NHfveHYNeXCwP2YKW05v2K1wz0l1puwlvnWnYdb
 HSME85rJUOiZDJU+Oqnp2ToEzvSs5/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739307457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NbHOf2hh4pZfD6uP3ZhFPeuiB6mdoR499zz2rT4nQ2E=;
 b=EusRzXSLW9k+/zefHusI7RvfkXL146h821esGlHfbBiBVWvBtR5qDOKJZ2G7pKjutRvgG1
 433yqFqZJ/pu9sAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF7013782;
 Tue, 11 Feb 2025 20:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K0guLMC5q2doSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 20:57:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 21:57:33 +0100
Message-ID: <20250211205734.1932275-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_test.sh: Fix TBROK => TWARN evaluation in
 tst_brk()
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

From: Petr Vorel <petr.vorel@gmail.com>

This partly reverts commit 55bfa08e179de16773f19b703de70262896383ea
and setting TST_DO_EXIT=1 before _tst_do_cleanup() and unset it
afterwards inside of the _tst_run_iterations().

Also rename variable to be more descriptive: TST_DO_EXIT => TST_TBROK_TO_TWARN.

This fixes e.g. problem with not exiting test on too small $TMPDIR.
Before the fix:

    # ./nfs10.sh -v 3 -t udp

    nfs10 1 TINFO: Running: nfs10.sh -v 3 -t udp
    ...
    nfs10 1 TINFO: Using /tmp/LTP_nfs10.LWDMqeJ74S as tmpdir (tmpfs filesystem)
    tst_device.c:299: TWARN: Failed to create test_dev.img: ENOSPC (28)

    Usage:
    tst_device acquire [size [filename]]
    tst_device release /path/to/device
    tst_device clear /path/to/device

    nfs10 1 TWARN: Failed to acquire device
    tst_supported_fs_types.c:169: TINFO: Skipping ext2 as requested by the test
    tst_supported_fs_types.c:169: TINFO: Skipping ext3 as requested by the test
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    ...
    nfs10 1 TINFO: === Testing on ext4 ===
    tst_device.c:389: TWARN: Failed to clear 512k block on

    Usage:
    tst_device acquire [size [filename]]
    tst_device release /path/to/device
    tst_device clear /path/to/device

    nfs10 1 TINFO: Formatting ext4 with opts=''
    Usage: mkfs.ext4 [-c|-l filename] [-b block-size] [-C cluster-size]
	    [-i bytes-per-inode] [-I inode-size] [-J journal-options]
	    [-G flex-group-size] [-N number-of-inodes] [-d root-directory]
	    [-m reserved-blocks-percentage] [-o creator-os]
	    [-g blocks-per-group] [-L volume-label] [-M last-mounted-directory]
	    [-O feature[,...]] [-r fs-revision] [-E extended-option[,...]]
	    [-t fs-type] [-T usage-type ] [-U UUID] [-e errors_behavior][-z undo_file]
	    [-jnqvDFSV] device [blocks-count]
    nfs10 1 TWARN: mkfs.ext4 failed
    nfs10 1 TINFO: Mounting device: mount -t ext4  /tmp/LTP_nfs10.LWDMqeJ74S/mntpoint
    mount: /tmp/LTP_nfs10.LWDMqeJ74S/mntpoint: can't find in /etc/fstab.
    nfs10 1 TWARN: Failed to mount device ext4 type: mount exit = 1
    nfs10 1 TINFO: timeout per run is 0h 11m 0s
    nfs10 1 TCONF: rpc.mountd not running
    nfs10 1 TINFO: Cleaning up testcase
    nfs10 1 TINFO: The '/tmp/LTP_nfs10.LWDMqeJ74S/mntpoint' is not mounted, skipping umount
    tst_device.c:281: TWARN: open() failed: ENOENT (2)

    Usage:
    tst_device acquire [size [filename]]
    tst_device release /path/to/device
    tst_device clear /path/to/device

    nfs10 1 TWARN: Failed to release device ''
    nfs10 1 TINFO: AppArmor enabled, this may affect test results
    nfs10 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
    nfs10 1 TINFO: loaded AppArmor profiles: none

After the fix:

    # ./nfs10.sh -v 3 -t udp
    nfs10 1 TINFO: Running: nfs10.sh -v 3 -t udp
    ...
    nfs10 1 TINFO: Using /tmp/LTP_nfs10.34K5E5pjxY as tmpdir (tmpfs filesystem)
    tst_device.c:299: TWARN: Failed to create test_dev.img: ENOSPC (28)

    Usage:
    tst_device acquire [size [filename]]
    tst_device release /path/to/device
    tst_device clear /path/to/device

    nfs10 1 TBROK: Failed to acquire device
    nfs10 1 TINFO: AppArmor enabled, this may affect test results
    nfs10 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
    nfs10 1 TINFO: loaded AppArmor profiles: none

Fixes: 55bfa08e17 ("tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v1: https://patchwork.ozlabs.org/project/ltp/patch/20241211001418.392890-1-pvorel@suse.cz/
Changes v1-v2:
* set guarder in _tst_do_cleanup() (Cyril)
* rename variable (Cyril)

 testcases/lib/tst_test.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2b797705e3..5a6e34473f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,7 +28,6 @@ _tst_do_cleanup()
 {
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
 		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
-			TST_DO_CLEANUP=
 			$TST_CLEANUP
 		else
 			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
@@ -40,7 +39,7 @@ _tst_do_cleanup()
 _tst_do_exit()
 {
 	local ret=0
-	TST_DO_EXIT=1
+	TST_TBROK_TO_TWARN=1
 
 	_tst_do_cleanup
 
@@ -127,15 +126,11 @@ tst_brk()
 	local res=$1
 	shift
 
-	# TBROK => TWARN on cleanup or exit
-	if [ "$res" = TBROK ] && [ "$TST_DO_EXIT" = 1 -o -z "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" ]; then
-		tst_res TWARN "$@"
-		TST_DO_CLEANUP=
-		return
-	fi
-
 	if [ "$res" != TBROK -a "$res" != TCONF ]; then
 		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res)"
+	elif [ "$TST_TBROK_TO_TWARN" = 1 ]; then
+		tst_res TWARN "$@"
+		return
 	else
 		tst_res "$res" "$@"
 	fi
@@ -820,7 +815,9 @@ _tst_run_iterations()
 		_tst_i=$((_tst_i-1))
 	done
 
+	TST_TBROK_TO_TWARN=1
 	_tst_do_cleanup
+	unset TST_TBROK_TO_TWARN
 
 	if [ "$TST_MOUNT_FLAG" = 1 ]; then
 		cd "$LTPROOT"
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
