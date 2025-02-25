Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DED0C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 11:44:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B990F3C9B0F
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 12:44:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EADC13C9AF6
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:44:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 31E711BEBE93
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:44:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E90E1F455;
 Tue, 25 Feb 2025 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740483864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+1kpfaXtp68DitAgjASbrTxRLaK41MbeQ/iJD1kDz4=;
 b=X7NdHikTTsY3xtKYyT/pr4qJheouqAU6khPEOq8g7ux2PfAwCk9vb12ZwZJuIupPexe3MS
 QIeqRXDuSudOZbzcBQrLTTDradK1CwAmKBJvqbwNDpvNsM6/C0AqzLq660ZunXJsmsJzwl
 5i/jq4Ja9INJ2TEANKMeZCD5r0OBQfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740483864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+1kpfaXtp68DitAgjASbrTxRLaK41MbeQ/iJD1kDz4=;
 b=IfsM01lU0ZoLv/k3fynfQUWCjaVd4ePtaQpx1QYc9EWQxv3Eo7/QIrdd0okGzhIe5iW3Ok
 PCOjcQ5VIRKmtlCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X7NdHikT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IfsM01lU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740483864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+1kpfaXtp68DitAgjASbrTxRLaK41MbeQ/iJD1kDz4=;
 b=X7NdHikTTsY3xtKYyT/pr4qJheouqAU6khPEOq8g7ux2PfAwCk9vb12ZwZJuIupPexe3MS
 QIeqRXDuSudOZbzcBQrLTTDradK1CwAmKBJvqbwNDpvNsM6/C0AqzLq660ZunXJsmsJzwl
 5i/jq4Ja9INJ2TEANKMeZCD5r0OBQfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740483864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+1kpfaXtp68DitAgjASbrTxRLaK41MbeQ/iJD1kDz4=;
 b=IfsM01lU0ZoLv/k3fynfQUWCjaVd4ePtaQpx1QYc9EWQxv3Eo7/QIrdd0okGzhIe5iW3Ok
 PCOjcQ5VIRKmtlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5277B13332;
 Tue, 25 Feb 2025 11:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1zjdEhitvWe2QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Feb 2025 11:44:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Feb 2025 12:44:17 +0100
Message-ID: <20250225114418.2940134-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7E90E1F455
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
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
Variant counting starts with 0, latest value is test_variants - 1
(C array like counting).
When value is higher than test_variants value lastest variant is used.

    # LTP_SINGLE_VARIANT=0 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
    ...
    tst_test.c:1904: TINFO: WARNING: testing only variant 0 of 3
    tst_test.c:1937: TINFO: ===== Testing tst_variant: 0 =====
    tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
    tst_test.c:1834: TINFO: === Testing on ext4 ===
    tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
    mke2fs 1.47.2 (1-Jan-2025)
    tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getrQ7dbE/mntpoint fstyp=ext4 flags=0
    getdents.h:148: TINFO: Testing the SYS_getdents syscall
    tst_buffers.c:57: TINFO: Test is using guarded buffers
    getdents02.c:77: TPASS: fd=-5 dirp=0x7fdf76897ee9 size=279 : EBADF (9)
    getdents02.c:77: TPASS: fd=3 dirp=0x557a810581e8 size=1 : EINVAL (22)
    getdents02.c:77: TPASS: fd=4 dirp=0x7fdf76897ee9 size=279 : ENOTDIR (20)
    getdents02.c:77: TPASS: fd=5 dirp=0x7fdf76897ee9 size=279 : ENOENT (2)
    getdents02.c:77: TPASS: fd=3 dirp=0x7fdf76896000 size=279 : EFAULT (14)

    # LTP_SINGLE_VARIANT=2 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
    ...
    tst_test.c:1904: TINFO: WARNING: testing only variant 2 of 3
    tst_test.c:1937: TINFO: ===== Testing tst_variant: 2 =====
    tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
    tst_test.c:1834: TINFO: === Testing on ext4 ===
    tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
    mke2fs 1.47.2 (1-Jan-2025)
    tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_gethBuDHc/mntpoint fstyp=ext4 flags=0
    getdents.h:157: TCONF: libc getdents() is not implemented

    # LTP_SINGLE_VARIANT=99 LTP_SINGLE_FS_TYPE=ext4 ./getdents02 # higher value is max value
    ...
    tst_test.c:1904: TINFO: WARNING: testing only variant 3 of 3
    tst_test.c:1937: TINFO: ===== Testing tst_variant: 3 =====
    tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
    tst_test.c:1834: TINFO: === Testing on ext4 ===
    tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
    mke2fs 1.47.2 (1-Jan-2025)
    tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getnfis4f/mntpoint fstyp=ext4 flags=0
    getdents.h:162: TINFO: Testing libc getdents64()
    tst_buffers.c:57: TINFO: Test is using guarded buffers
    getdents02.c:77: TPASS: fd=-5 dirp=0x7f1b029b2ee8 size=280 : EBADF (9)
    getdents02.c:77: TPASS: fd=3 dirp=0x55fbc55661e8 size=1 : EINVAL (22)
    getdents02.c:77: TPASS: fd=4 dirp=0x7f1b029b2ee8 size=280 : ENOTDIR (20)
    getdents02.c:77: TPASS: fd=5 dirp=0x7f1b029b2ee8 size=280 : ENOENT (2)
    getdents02.c:77: TPASS: fd=3 dirp=0x7f1b029b1000 size=280 : EFAULT (14)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add a function that would set two integer variables, first_variant and
last variant (Cyril). NOTE: I'm not sure if the implementation is really
better than the previous one.
* Add documentation into setup_tests.rst.

 doc/users/setup_tests.rst |  3 +++
 lib/tst_test.c            | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 2766ed719c..78e1098917 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -46,6 +46,9 @@ users.
      - Testing only - specifies filesystem instead all supported
        (for tests with ``.all_filesystems``).
 
+   * - LTP_SINGLE_VARIANT
+     - Testing only - specifies tst_variant to be run.
+
    * - LTP_DEV_FS_TYPE
      - Filesystem used for testing (default: ``ext2``).
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3823ea109e..ddeacfb228 100644
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
@@ -1882,10 +1883,33 @@ static int run_tcases_per_fs(void)
 
 unsigned int tst_variant;
 
+static void setup_variants(unsigned int *first_variant, unsigned int *last_variant)
+{
+	const char *only_variant;
+	*first_variant = 0;
+	*last_variant = 1;
+
+	if (!tst_test->test_variants)
+		return;
+
+	*last_variant = tst_test->test_variants;
+
+	only_variant = getenv("LTP_SINGLE_VARIANT");
+	if (!only_variant || only_variant[0] == '\0')
+		return;
+
+	*first_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
+					  *last_variant - 1);
+
+	tst_res(TINFO, "WARNING: testing only variant %d of %d",
+			*first_variant, *last_variant - 1);
+	*last_variant = *first_variant + 1;
+}
+
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
 	int ret = 0;
-	unsigned int test_variants = 1;
+	unsigned int first_variant, last_variant;
 	struct utsname uval;
 
 	lib_pid = getpid();
@@ -1899,7 +1923,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_res(TINFO, "LTP version: "LTP_VERSION);
 
-
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
@@ -1908,10 +1931,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	set_overall_timeout();
 
-	if (tst_test->test_variants)
-		test_variants = tst_test->test_variants;
+	setup_variants(&first_variant, &last_variant);
 
-	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
+	for (tst_variant = first_variant; tst_variant < last_variant; tst_variant++) {
+		tst_res(TINFO, "===== Testing tst_variant: %d =====", tst_variant);
 		if (tst_test->all_filesystems || count_fs_descs() > 1)
 			ret |= run_tcases_per_fs();
 		else
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
