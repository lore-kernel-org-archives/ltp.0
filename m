Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB54C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58C593C9898
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:01:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 544E23C989E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:00:23 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A0E691BD98AF
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:00:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 058B81F395;
 Mon, 24 Feb 2025 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740391219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4qAVHA9R/+JxhSsGOiJOvoHkh0KmvNSn3YXEsQM9mto=;
 b=PxQBqNBWIe7GE0vhLwUP+wQX8ca7U3Qtfu/DIsGFBu7aytmFz52p4EAf7THAtZDxuREgbC
 efG20zYd5KILNC15GAOPVJ7m7hwxxlQJSFiqH2pErqoblR+rf7V7sPIVpRxqxl8AYhHKZ4
 f14XnzUAZkC+FAnx/+wdCwq6VuXngd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740391219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4qAVHA9R/+JxhSsGOiJOvoHkh0KmvNSn3YXEsQM9mto=;
 b=EA2Z4ShCHdjZHQG0QVVWCwz4Lb+iyA/ssudEsa6ZiSqIqIiFiw9FWFPqbR/oaM6bpaFM2o
 cMvIYMpKUsbhCmCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PxQBqNBW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EA2Z4ShC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740391219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4qAVHA9R/+JxhSsGOiJOvoHkh0KmvNSn3YXEsQM9mto=;
 b=PxQBqNBWIe7GE0vhLwUP+wQX8ca7U3Qtfu/DIsGFBu7aytmFz52p4EAf7THAtZDxuREgbC
 efG20zYd5KILNC15GAOPVJ7m7hwxxlQJSFiqH2pErqoblR+rf7V7sPIVpRxqxl8AYhHKZ4
 f14XnzUAZkC+FAnx/+wdCwq6VuXngd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740391219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4qAVHA9R/+JxhSsGOiJOvoHkh0KmvNSn3YXEsQM9mto=;
 b=EA2Z4ShCHdjZHQG0QVVWCwz4Lb+iyA/ssudEsa6ZiSqIqIiFiw9FWFPqbR/oaM6bpaFM2o
 cMvIYMpKUsbhCmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC44513707;
 Mon, 24 Feb 2025 10:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dPqeMDJDvGfQbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Feb 2025 10:00:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Feb 2025 11:00:14 +0100
Message-ID: <20250224100016.2857704-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 058B81F395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

Allow to test only single struct tst_test->test_variants.
This is a similar feature to $LTP_SINGLE_FS_TYPE.

Value is ignored when test does not specify test_variants.
When value is higher than test_variants value lastest variant is used.

	# LTP_SINGLE_VARIANT=0 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
	..
	tst_test.c:1918: TINFO: WARNING: testing only variant 0 of 3
	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
	tst_test.c:1834: TINFO: === Testing on ext4 ===
	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
	mke2fs 1.47.2 (1-Jan-2025)
	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getx2HrGH/mntpoint fstyp=ext4 flags=0
	getdents.h:148: TINFO: Testing the SYS_getdents syscall
	tst_buffers.c:57: TINFO: Test is using guarded buffers
	getdents02.c:77: TPASS: fd=-5 dirp=0x7f0587803ee9 size=279 : EBADF (9)
	getdents02.c:77: TPASS: fd=3 dirp=0x5641617a31e8 size=1 : EINVAL (22)
	getdents02.c:77: TPASS: fd=4 dirp=0x7f0587803ee9 size=279 : ENOTDIR (20)
	getdents02.c:77: TPASS: fd=5 dirp=0x7f0587803ee9 size=279 : ENOENT (2)
	getdents02.c:77: TPASS: fd=3 dirp=0x7f0587802000 size=279 : EFAULT (14)

	# LTP_SINGLE_VARIANT=2 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
	...
	tst_test.c:1918: TINFO: WARNING: testing only variant 2 of 3
	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
	tst_test.c:1834: TINFO: === Testing on ext4 ===
	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
	mke2fs 1.47.2 (1-Jan-2025)
	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getWtBnGE/mntpoint fstyp=ext4 flags=0
	getdents.h:157: TCONF: libc getdents() is not implemented

	# LTP_SINGLE_VARIANT=99 LTP_SINGLE_FS_TYPE=ext4 ./getdents02 # higher value is max value
	tst_test.c:1918: TINFO: WARNING: testing only variant 3 of 3
	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
	tst_test.c:1834: TINFO: === Testing on ext4 ===
	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
	mke2fs 1.47.2 (1-Jan-2025)
	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_get1fX70n/mntpoint fstyp=ext4 flags=0
	getdents.h:162: TINFO: Testing libc getdents64()
	tst_buffers.c:57: TINFO: Test is using guarded buffers
	getdents02.c:77: TPASS: fd=-5 dirp=0x7fcf140f3ee8 size=280 : EBADF (9)
	getdents02.c:77: TPASS: fd=3 dirp=0x55a76e4531e8 size=1 : EINVAL (22)
	getdents02.c:77: TPASS: fd=4 dirp=0x7fcf140f3ee8 size=280 : ENOTDIR (20)
	getdents02.c:77: TPASS: fd=5 dirp=0x7fcf140f3ee8 size=280 : ENOENT (2)
	getdents02.c:77: TPASS: fd=3 dirp=0x7fcf140f2000 size=280 : EFAULT (14)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

Andrea wanted to run only single variant.

Kind regards,
Petr

 lib/tst_test.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3823ea109e..6edc310209 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -581,6 +581,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
+	fprintf(stderr, "LTP_SINGLE_VARIANT   Testing only - specifies tst_variant to be run\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
@@ -1887,6 +1888,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	int ret = 0;
 	unsigned int test_variants = 1;
 	struct utsname uval;
+	const char *only_variant;
 
 	lib_pid = getpid();
 	tst_test = self;
@@ -1899,7 +1901,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_res(TINFO, "LTP version: "LTP_VERSION);
 
-
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
@@ -1908,10 +1909,20 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	set_overall_timeout();
 
-	if (tst_test->test_variants)
+	if (tst_test->test_variants) {
 		test_variants = tst_test->test_variants;
+		only_variant = getenv("LTP_SINGLE_VARIANT");
+		if (only_variant && only_variant[0] != '\0') {
+			tst_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
+							  test_variants - 1);
+			tst_res(TINFO, "WARNING: testing only variant %d of %d",
+					tst_variant, test_variants - 1);
+			test_variants = tst_variant + 1;
+		}
+	}
+
+	for (; tst_variant < test_variants; tst_variant++) {
 
-	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
 		if (tst_test->all_filesystems || count_fs_descs() > 1)
 			ret |= run_tcases_per_fs();
 		else
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
