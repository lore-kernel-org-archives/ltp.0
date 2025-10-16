Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB52CCCD194
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 10:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D606E3CEDF3
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 12:08:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 535173C840D
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 12:08:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 901506009CD
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 12:08:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 149A421E38;
 Thu, 16 Oct 2025 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760609283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WOMsoQWoomkIMt5Hb9CL/oLHm/yzL14dFeH93KM2lJg=;
 b=mn4qsB9D905oqnqT2ANggLGNC/pdDAxDarB+u9MkpPbyeOn/q+tiQh0GPDz1GtXR+lyiNb
 9Fp1KWWRnZObG7DSUeFcD9ldxrgHhC8F8GqJMh3hOXO1Faik8R6cDpti0msXAUaA8SNU5i
 nSGAONoM6S2m5WIdXTR7GGyPH/QSQiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760609283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WOMsoQWoomkIMt5Hb9CL/oLHm/yzL14dFeH93KM2lJg=;
 b=UDT3e7rD/eODcC0v5DSnDeAI8swDaEAkQkus2ttGR/iN3Gm6KjJ+vGgagAxA7eu6ErV4cu
 aFOfLOnBreuNw+BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mn4qsB9D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UDT3e7rD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760609283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WOMsoQWoomkIMt5Hb9CL/oLHm/yzL14dFeH93KM2lJg=;
 b=mn4qsB9D905oqnqT2ANggLGNC/pdDAxDarB+u9MkpPbyeOn/q+tiQh0GPDz1GtXR+lyiNb
 9Fp1KWWRnZObG7DSUeFcD9ldxrgHhC8F8GqJMh3hOXO1Faik8R6cDpti0msXAUaA8SNU5i
 nSGAONoM6S2m5WIdXTR7GGyPH/QSQiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760609283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WOMsoQWoomkIMt5Hb9CL/oLHm/yzL14dFeH93KM2lJg=;
 b=UDT3e7rD/eODcC0v5DSnDeAI8swDaEAkQkus2ttGR/iN3Gm6KjJ+vGgagAxA7eu6ErV4cu
 aFOfLOnBreuNw+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB13A1340C;
 Thu, 16 Oct 2025 10:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p3Y/NALE8GineQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 10:08:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Oct 2025 12:08:00 +0200
Message-ID: <20251016100800.270043-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 149A421E38
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:mid, suse.cz:dkim]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] prepare_lvm.sh: Use $TMPDIR as a default for
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

Scripts use LVM_DIR environment for LVM backing files which defaults to
/tmp. Reuse TMPDIR environment variable as it's default, fallback to
/tmp. This allows users to reuse well establised TMPDIR, but yet still
allow to use a different directory for LVM (LVM backing files are huge,
it might makes sense to use different path).

Fixes: 0838220f25 ("prepare_lvm.sh: Allow to define tmp directory")
Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* keep LVM_DIR (Martin)

Link to v1:
https://lore.kernel.org/ltp/20251016083534.262078-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20251016083534.262078-1-pvorel@suse.cz/

NOTE: I was thinking to even document LVM_DIR via $TST_USAGE, but that's
done for getopt not for variables (there would be 2 sections for
variables), thus ignored it.

Kind regards,
Petr

 testcases/misc/lvm/cleanup_lvm.sh          | 3 ++-
 testcases/misc/lvm/generate_lvm_runfile.sh | 3 ++-
 testcases/misc/lvm/prepare_lvm.sh          | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
index f05289f008..059f6aa94c 100755
--- a/testcases/misc/lvm/cleanup_lvm.sh
+++ b/testcases/misc/lvm/cleanup_lvm.sh
@@ -8,7 +8,8 @@ TST_TESTFUNC=cleanup_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="losetup umount vgremove"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_DIR="${LVM_DIR:-$TMPDIR}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
 LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
 
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 7f7e149d94..01b879666f 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -9,7 +9,8 @@ TST_TESTFUNC=generate_runfile
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sed"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_DIR="${LVM_DIR:-$TMPDIR}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
 
 generate_runfile()
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index 29f386df83..334c7ac134 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -8,7 +8,8 @@ TST_TESTFUNC=prepare_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
 
-LVM_DIR="${LVM_DIR:-/tmp}"
+TMPDIR="${TMPDIR:-/tmp}"
+LVM_DIR="${LVM_DIR:-$TMPDIR}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
 LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
