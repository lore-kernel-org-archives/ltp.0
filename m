Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D79CCD183
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 08:36:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D96943CEDDF
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 10:36:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D3AA3CCD3E
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 10:35:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2EADA10009FC
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 10:35:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B915222047;
 Thu, 16 Oct 2025 08:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760603742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MSuzhYGRun6UE+5EH47tSUf/kS14UlMciOhjlMICrGc=;
 b=xBLw4jlrH2tLHmmUCBiQ0jELLEZoVq9SB0M9iYIbvaHCBQVtyRSAFqcG/GUZ3ldwGor3BJ
 NQ0GOWIAW/6I5iMhaqu/FUcAfvbYKsnIS05L1wnfKxTcOU+KghDm1buZLI8ppalS16QTy5
 H4HV1mpS7QQz7Ti46HgtUga75F37SlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760603742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MSuzhYGRun6UE+5EH47tSUf/kS14UlMciOhjlMICrGc=;
 b=HdKw559UTQxVGhb19Bc+D7TFOuBmYvwGBJ7LOwZiza11Nfr4sJFUZGVmgF71AdrSar0+z0
 HxjkyV5dV4bHAkBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760603742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MSuzhYGRun6UE+5EH47tSUf/kS14UlMciOhjlMICrGc=;
 b=xBLw4jlrH2tLHmmUCBiQ0jELLEZoVq9SB0M9iYIbvaHCBQVtyRSAFqcG/GUZ3ldwGor3BJ
 NQ0GOWIAW/6I5iMhaqu/FUcAfvbYKsnIS05L1wnfKxTcOU+KghDm1buZLI8ppalS16QTy5
 H4HV1mpS7QQz7Ti46HgtUga75F37SlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760603742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MSuzhYGRun6UE+5EH47tSUf/kS14UlMciOhjlMICrGc=;
 b=HdKw559UTQxVGhb19Bc+D7TFOuBmYvwGBJ7LOwZiza11Nfr4sJFUZGVmgF71AdrSar0+z0
 HxjkyV5dV4bHAkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F8321376E;
 Thu, 16 Oct 2025 08:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NCElAF6u8Gi6HQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 08:35:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Oct 2025 10:35:34 +0200
Message-ID: <20251016083534.262078-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] prepare_lvm.sh: Use $TMPDIR instead of custom
 $LVM_DIR
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

Allow users to reuse TMPDIR environment variable instead of forcing them
to export LVM_DIR, which would behave the same as TMPDIR.

LVM_DIR is undocumented users expect TMPDIR.

Fixes: 0838220f25 ("prepare_lvm.sh: Allow to define tmp directory")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

it was me who introduced LVM_DIR, but thinking about it twice it was not
a good idea.

Kind regards,
Petr

 testcases/misc/lvm/cleanup_lvm.sh          | 8 ++++----
 testcases/misc/lvm/generate_lvm_runfile.sh | 4 ++--
 testcases/misc/lvm/prepare_lvm.sh          | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
index f05289f008..b098359e1a 100755
--- a/testcases/misc/lvm/cleanup_lvm.sh
+++ b/testcases/misc/lvm/cleanup_lvm.sh
@@ -8,9 +8,9 @@ TST_TESTFUNC=cleanup_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="losetup umount vgremove"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
-LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
-LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_TMPDIR="$TMPDIR/ltp/growfiles"
+LVM_IMGDIR="$TMPDIR/ltp/imgfiles"
 
 cleanup_lvm()
 {
@@ -27,7 +27,7 @@ cleanup_lvm()
 		ROD tst_device release $devname
 	done
 
-	rm -rf $LVM_DIR/ltp
+	rm -rf $TMPDIR/ltp
 	tst_res TPASS "LVM configuration for LTP removed successfully."
 }
 
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 7f7e149d94..c95c4b880e 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -9,8 +9,8 @@ TST_TESTFUNC=generate_runfile
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sed"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
-LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_TMPDIR="$TMPDIR/ltp/growfiles"
 
 generate_runfile()
 {
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index 29f386df83..2ac844b0db 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -8,9 +8,9 @@ TST_TESTFUNC=prepare_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
-LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
-LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_TMPDIR="$TMPDIR/ltp/growfiles"
+LVM_IMGDIR="$TMPDIR/ltp/imgfiles"
 
 error_check()
 {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
