Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FD7C5B552
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 12:46:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1963CAD06
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 14:46:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B913CA503
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 14:45:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 21ED8600354
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 14:45:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E54602118B;
 Mon,  9 Jun 2025 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749473118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JdDLGcqDzSgKOhvwZuPla2WmVpLPi9E5us1VpWm0LH4=;
 b=mBOGDGSkirBmlTbPvKvcsnDiPCT804CdueS0Ho0smKsbxLzSboSL8MTQrL/LP0HeqfBOWc
 BSld0Iy/AiLZ9W4zCkZtMVvVNyDQKZmZAi8qIM9wo18d52tlROGPxQqLFMVQYLwJztK8fL
 jJh7PMTy8yz0/uvIOw/FqpWI/30+q5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749473118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JdDLGcqDzSgKOhvwZuPla2WmVpLPi9E5us1VpWm0LH4=;
 b=xWfShy3h3A3i2Ser6X1+taoGxYz8dRlsHRalD1ig2e3VYFZlXEdI8TFXHM6gmBPz/5UW2N
 y2t9aYXqUUd7gyDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ynAaBFHt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="t/Dm0kdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749473117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JdDLGcqDzSgKOhvwZuPla2WmVpLPi9E5us1VpWm0LH4=;
 b=ynAaBFHtc2r2V0mmY+8BcMbN8kCOy5m3LUktnXnG9A+dgp/XuRRrFni2zd00FtfuO0MfRV
 QdE//a2Zzhmqfp9Cwz87mq0BJrElqWzyM60HT4S0RCgRYxT4igyEAeTCnsAixo6bdeYK6Y
 SIbtGIRqVJsPdMBTtMJK2CbT9rtlZr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749473117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JdDLGcqDzSgKOhvwZuPla2WmVpLPi9E5us1VpWm0LH4=;
 b=t/Dm0kdFm2/IqGGdgZTiez719f7sdm4Z09gGXz2BzdlFyjS/VsNzHm9ZNCszZQYYcG5GX3
 Yoie3oWwBfNDUXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C059913A85;
 Mon,  9 Jun 2025 12:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJvcLV3XRmiQUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Jun 2025 12:45:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 Jun 2025 14:45:01 +0200
Message-ID: <20250609124506.1454420-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E54602118B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] shell loader rewrite to support TST_SETUP
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

Hi Cyril, all,

Link to v2:
https://patchwork.ozlabs.org/project/ltp/list/?series=454866&state=*
https://lore.kernel.org/ltp/20250430130417.43523-1-pvorel@suse.cz/

Link to v1:
https://patchwork.ozlabs.org/project/ltp/list/?series=446566&state=*
https://lore.kernel.org/ltp/20250228172439.3276777-1-pvorel@suse.cz/

Changes v2->v3
* Create tst_run.sh
simplification asked by Cyril https://lore.kernel.org/ltp/aBSSF8bPjoKz8Umx@yuki.lan/

* Fixes failure on an old Ubuntu Bionic
We discussed about full PATH
https://lore.kernel.org/ltp/aBSHoimhpmTj1l_A@yuki.lan/, but in the end
it was missing quoting which fails in old dash 0.5.8-2.10:

https://productionresultssa8.blob.core.windows.net/actions-results/9f7016e0-4f86-42b1-bece-346740e3837c/workflow-job-run-301c527f-be9e-5180-ae5c-c845d75794a8/logs/job/job-logs.txt?rsct=text%2Fplain&se=2025-06-09T11%3A43%3A38Z&sig=S1txTtKxNtqGDD0PGi7vswaNxWqaemKfMV9KUJo%2F9n4%3D&ske=2025-06-09T20%3A28%3A00Z&skoid=ca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=b&skt=2025-06-09T08%3A28%3A00Z&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skv=2025-05-05&sp=r&spr=https&sr=b&st=2025-06-09T11%3A33%3A33Z&sv=2025-05-05

 *** Running 'shell_loader_all_filesystems.sh' (exp: TPASS) ***
 tst_tmpdir.c:317: TINFO: Using /tmp/LTP_sheiFmNGP as tmpdir (overlayfs filesystem)
 tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
 tst_test.c:1953: TINFO: LTP version: 20250530
 tst_test.c:1956: TINFO: Tested kernel: 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64
 tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.11.0-1015-azure'
 tst_test.c:1776: TINFO: Overall timeout per run is 0h 00m 30s
 tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
 tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
 tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
 tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
 tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
 tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
 tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
 tst_supported_fs_types.c:58: TINFO: mkfs.xfs does not exist
 tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
 tst_supported_fs_types.c:58: TINFO: mkfs.btrfs does not exist
 tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
 tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
 tst_supported_fs_types.c:58: TINFO: mkfs.vfat does not exist
 tst_supported_fs_types.c:128: TINFO: Filesystem exfat is not supported
 tst_supported_fs_types.c:128: TINFO: Filesystem ntfs is not supported
 tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
 tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
 tst_test.c:1888: TINFO: === Testing on ext2 ===
 tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
 mke2fs 1.44.1 (24-Mar-2018)
 tst_test.c:1230: TINFO: Mounting /dev/loop0 to /tmp/LTP_sheiFmNGP/ltp_mntpoint fstyp=ext2 flags=0
 /__w/ltp/ltp/testcases/lib/tests//shell_loader_all_filesystems.sh: 20: local: /tmp/LTP_sheiFmNGP/ltp_mntpoint: bad variable name

Which was simply fixed:
-	local mounted=$(grep $mntpath /proc/mounts)
+	local mounted="$(grep $mntpath /proc/mounts)"

But maybe we should document or even check somewhere if the PATH is full
path.

Tested:
https://github.com/pevik/ltp/actions/runs/15534603740

Hopefully this is a final version which can be merged.

Kind regards,
Petr

Cyril Hrubis (1):
  shell lib: Add support for test cleanup

Petr Vorel (3):
  shell: Move shell code into functions
  shell lib: Add basic support for test setup
  shell: Add shell_loader_setup_cleanup.sh test

 testcases/kernel/mem/vma/vma05.sh             | 45 ++++++++++---------
 testcases/lib/run_tests.sh                    |  5 ++-
 testcases/lib/tests/shell_loader.sh           | 19 +++++---
 .../lib/tests/shell_loader_all_filesystems.sh | 26 ++++++-----
 .../lib/tests/shell_loader_brk_cleanup.sh     | 25 +++++++++++
 testcases/lib/tests/shell_loader_c_child.sh   | 15 ++++---
 testcases/lib/tests/shell_loader_cleanup.sh   | 25 +++++++++++
 .../lib/tests/shell_loader_filesystems.sh     | 23 ++++++----
 .../lib/tests/shell_loader_invalid_block.sh   |  7 ++-
 .../tests/shell_loader_invalid_metadata.sh    |  7 ++-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  7 ++-
 .../lib/tests/shell_loader_no_metadata.sh     |  7 ++-
 .../lib/tests/shell_loader_setup_cleanup.sh   | 31 +++++++++++++
 .../lib/tests/shell_loader_supported_archs.sh |  7 ++-
 testcases/lib/tests/shell_loader_tags.sh      |  7 ++-
 testcases/lib/tests/shell_loader_tcnt.sh      |  7 ++-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  7 ++-
 testcases/lib/tst_env.sh                      |  5 ---
 testcases/lib/tst_run.sh                      | 16 +++++++
 19 files changed, 226 insertions(+), 65 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh
 create mode 100644 testcases/lib/tst_run.sh

Diff v2->v3:
diff --git testcases/kernel/mem/vma/vma05.sh testcases/kernel/mem/vma/vma05.sh
index e7780e8957..c560eecbcd 100755
--- testcases/kernel/mem/vma/vma05.sh
+++ testcases/kernel/mem/vma/vma05.sh
@@ -39,7 +39,7 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
@@ -71,4 +71,4 @@ tst_test()
 	fi
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader.sh testcases/lib/tests/shell_loader.sh
index 01acf6d352..78dba06b25 100755
--- testcases/lib/tests/shell_loader.sh
+++ testcases/lib/tests/shell_loader.sh
@@ -14,7 +14,7 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
@@ -27,4 +27,4 @@ tst_test()
 	esac
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_all_filesystems.sh testcases/lib/tests/shell_loader_all_filesystems.sh
index 1a54b2d81c..3c3978f51c 100755
--- testcases/lib/tests/shell_loader_all_filesystems.sh
+++ testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -12,12 +12,12 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
-	local mntpath=$(realpath ltp_mntpoint)
-	local mounted=$(grep $mntpath /proc/mounts)
+	local mntpath="$(realpath ltp_mntpoint)"
+	local mounted="$(grep $mntpath /proc/mounts)"
 	local device path
 
 	tst_res TINFO "In shell"
@@ -32,4 +32,4 @@ tst_test()
 	fi
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_brk_cleanup.sh testcases/lib/tests/shell_loader_brk_cleanup.sh
index 95303d6409..4e8ce4f737 100755
--- testcases/lib/tests/shell_loader_brk_cleanup.sh
+++ testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -10,7 +10,7 @@
 
 TST_CLEANUP=cleanup
 
-. tst_env.sh
+. tst_loader.sh
 
 cleanup()
 {
@@ -22,4 +22,4 @@ tst_test()
 	tst_brk TBROK "Test exits"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_c_child.sh testcases/lib/tests/shell_loader_c_child.sh
index c33decb1df..13480968f9 100755
--- testcases/lib/tests/shell_loader_c_child.sh
+++ testcases/lib/tests/shell_loader_c_child.sh
@@ -13,7 +13,7 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
@@ -25,4 +25,4 @@ tst_test()
 	shell_c_child
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_cleanup.sh testcases/lib/tests/shell_loader_cleanup.sh
index 4918df5ff2..91071a5a75 100755
--- testcases/lib/tests/shell_loader_cleanup.sh
+++ testcases/lib/tests/shell_loader_cleanup.sh
@@ -10,7 +10,7 @@
 
 TST_CLEANUP=do_cleanup
 
-. tst_env.sh
+. tst_loader.sh
 
 do_cleanup()
 {
@@ -22,4 +22,4 @@ tst_test()
 	tst_res TPASS "Test is executed"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_filesystems.sh testcases/lib/tests/shell_loader_filesystems.sh
index 98466b918c..d584503adb 100755
--- testcases/lib/tests/shell_loader_filesystems.sh
+++ testcases/lib/tests/shell_loader_filesystems.sh
@@ -22,7 +22,7 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
@@ -40,4 +40,4 @@ tst_test()
 	fi
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_invalid_block.sh testcases/lib/tests/shell_loader_invalid_block.sh
index d2f5dc564f..be45303d79 100755
--- testcases/lib/tests/shell_loader_invalid_block.sh
+++ testcases/lib/tests/shell_loader_invalid_block.sh
@@ -20,11 +20,11 @@
 # This is an invalid block that breaks the test.
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TPASS "This should pass!"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_invalid_metadata.sh testcases/lib/tests/shell_loader_invalid_metadata.sh
index 52b3e69695..c4c7579243 100755
--- testcases/lib/tests/shell_loader_invalid_metadata.sh
+++ testcases/lib/tests/shell_loader_invalid_metadata.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_kconfigs.sh testcases/lib/tests/shell_loader_kconfigs.sh
index 61222ba115..d03bc99cac 100755
--- testcases/lib/tests/shell_loader_kconfigs.sh
+++ testcases/lib/tests/shell_loader_kconfigs.sh
@@ -9,11 +9,11 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TPASS "Shell loader works fine!"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_no_metadata.sh testcases/lib/tests/shell_loader_no_metadata.sh
index 77c4420964..2ad458ef8d 100755
--- testcases/lib/tests/shell_loader_no_metadata.sh
+++ testcases/lib/tests/shell_loader_no_metadata.sh
@@ -5,11 +5,11 @@
 # This test has no metadata and should not be executed
 #
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_setup_cleanup.sh testcases/lib/tests/shell_loader_setup_cleanup.sh
index fd149cedb0..8184278313 100755
--- testcases/lib/tests/shell_loader_setup_cleanup.sh
+++ testcases/lib/tests/shell_loader_setup_cleanup.sh
@@ -11,7 +11,7 @@
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 
-. tst_env.sh
+. tst_loader.sh
 
 setup()
 {
@@ -28,4 +28,4 @@ tst_test()
 	tst_res TPASS "Test is executed"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_supported_archs.sh testcases/lib/tests/shell_loader_supported_archs.sh
index eda243003b..a45cc59b7d 100755
--- testcases/lib/tests/shell_loader_supported_archs.sh
+++ testcases/lib/tests/shell_loader_supported_archs.sh
@@ -9,11 +9,11 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TPASS "We are running on supported architecture"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_tags.sh testcases/lib/tests/shell_loader_tags.sh
index 91e5a2ab2c..56eadaf7a2 100755
--- testcases/lib/tests/shell_loader_tags.sh
+++ testcases/lib/tests/shell_loader_tags.sh
@@ -12,11 +12,11 @@
 # }
 # ---
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TFAIL "Fails the test so that tags are shown."
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_tcnt.sh testcases/lib/tests/shell_loader_tcnt.sh
index bfdc6b7576..cf2a0b74ec 100755
--- testcases/lib/tests/shell_loader_tcnt.sh
+++ testcases/lib/tests/shell_loader_tcnt.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TPASS "Iteration $1"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tests/shell_loader_wrong_metadata.sh testcases/lib/tests/shell_loader_wrong_metadata.sh
index 7ac4f348ee..35c535beed 100755
--- testcases/lib/tests/shell_loader_wrong_metadata.sh
+++ testcases/lib/tests/shell_loader_wrong_metadata.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_env.sh
+. tst_loader.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-. tst_loader.sh
+. tst_run.sh
diff --git testcases/lib/tst_loader.sh testcases/lib/tst_loader.sh
index ba6961353c..62c9cc6d8f 100644
--- testcases/lib/tst_loader.sh
+++ testcases/lib/tst_loader.sh
@@ -3,20 +3,11 @@
 # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
 #
 # This is a loader for shell tests that use the C test library.
+#
 
 if [ -z "$LTP_IPC_PATH" ]; then
 	tst_run_shell $(basename "$0") "$@"
 	exit $?
+else
+	. tst_env.sh
 fi
-
-. tst_env.sh
-
-if [ -n "$TST_CLEANUP" ]; then
-	trap $TST_CLEANUP EXIT
-fi
-
-if [ -n "$TST_SETUP" ]; then
-    $TST_SETUP
-fi
-
-tst_test
diff --git testcases/lib/tst_run.sh testcases/lib/tst_run.sh
new file mode 100644
index 0000000000..ded2cd2099
--- /dev/null
+++ testcases/lib/tst_run.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+
+. tst_env.sh
+
+if [ -n "$TST_CLEANUP" ]; then
+	trap $TST_CLEANUP EXIT
+fi
+
+if [ -n "$TST_SETUP" ]; then
+    $TST_SETUP
+fi
+
+tst_test

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
